### Задача 1

Перед выполнением задания ознакомьтесь с документацией по администрированию MongoDB.

Пользователь (разработчик) написал в канал поддержки, что у него уже 3 минуты происходит CRUD-операция в MongoDB и её нужно прервать.

Вы как инженер поддержки решили произвести эту операцию:

* напишите список операций, которые вы будете производить для остановки запроса пользователя;

Необходимо найти операцию с помощью команды db.currentOp()

```
db.currentOp({ "active" : true, "secs_running" : { "$gt" : 180 }})
{
    "inprog" : [
        {
            //...
            "opid" : 12345
            //...
        }
    ]
}

```
А затем завершить операцию по opid: db.killOp()
db.killOp(<opId>)

```
db.killOp(12345)

```
* предложите вариант решения проблемы с долгими (зависающими) запросами в MongoDB

1.Используя Database Profiler, отловить медленные операции. С помощью executionStats проанализировать. Попробовать оптимизировать: добавить/удалить индексы, настроить шардинг.

2.Применить метод maxTimeMS() для установки предела исполнения по времени операций.

### Задача 2

Перед выполнением задания познакомьтесь с документацией по Redis latency troobleshooting.

Вы запустили инстанс Redis для использования совместно с сервисом, который использует механизм TTL. Причем отношение количества записанных key-value значений к количеству истёкших значений есть величина постоянная и увеличивается пропорционально количеству реплик сервиса.

При масштабировании сервиса до N реплик вы увидели, что:

сначала рост отношения записанных значений к истекшим
Redis блокирует операции записи
Как вы думаете, в чем может быть проблема?

* Ответ:

Предполагаю, проблема в методе удаления ключей с истекшим сроком действия. По умолчанию Redis запускает 20 ACTIVE_EXPIRE_CYCLE_LOOKUPS_PER_LOOP 10 раз в секунду. То есть алгоритм удаляет 200 ключей в секунду. Если Redis блокирует операции записи, значит в базе появилось большое количество ключей, которые истекают в одно время (их количество больше 25% от текущей совокупности ключей с истекшим сроком действия).

### Эадача 3

Вы подняли базу данных MySQL для использования в гис-системе. При росте количества записей, в таблицах базы, пользователи начали жаловаться на ошибки вида:

```

InterfaceError: (InterfaceError) 2013: Lost connection to MySQL server during query u'SELECT..... '

```

Как вы думаете, почему это начало происходить и как локализовать проблему?
Какие пути решения данной проблемы вы можете предложить?

* Ответ:


- Сетевые проблемы. Необходимо проверить подключение. Также необходимо выполнить команду 
SHOW GLOBAL STATUS LIKE 'Aborted_connects'. Если его значение увеличивается (оно увеличивается 
при каждом прерыванни соединения со стороны сервера), то необходимо увеличить параметр connect_timeout
- Большой запрос, который не успевает отработать за net_read_timeout (30 секунд по умолчанию). 
Увеличить данный параметр
- Если в ошибке есть ER_NET_PACKET_TOO_LARGE, то вероятно проблема в превышении размера сообщения. 
Необходимо увеличить параметр max_allowed_packet

### Задача 4

Вы решили перевести гис-систему из задачи 3 на PostgreSQL, так как прочитали в документации, что эта СУБД работает с большим объемом данных лучше, чем MySQL.

После запуска пользователи начали жаловаться, что СУБД время от времени становится недоступной. В dmesg вы видите, что:

```
postmaster invoked oom-killer

```
Как вы думаете, что происходит?

Как бы вы решили данную проблему?

* Ответ:
Сообщение `postmaster invoked oom-killer` означает, что процесс postmaster был убит ядром из-за нехватки памяти в системе. Это может происходить из-за того, что СУБД использует слишком много памяти или из-за того, что другие процессы на сервере также используют много памяти.

Чтобы исправить эту проблему, можно попробовать следующее:

1. Увеличить объем памяти на сервере.

2. Оптимизировать конфигурацию СУБД, чтобы она использовала меньше памяти.

3. Ограничить использование памяти других процессов на сервере.

4. Разделить работу СУБД на несколько серверов, чтобы уменьшить нагрузку на каждый из них.

5. Использовать инструменты мониторинга и оптимизации для выявления и устранения утечек памяти в СУБД.

6. Проверить логи СУБД на наличие ошибок и проблем с работой.

* Настройка PostgreSQL:
  
![Screenshot_1](https://github.com/Tichenko/devops-netology/assets/116817153/2e25ca59-72a9-4a66-ad2d-e25cc0916cc7)
![Screenshot_2](https://github.com/Tichenko/devops-netology/assets/116817153/b510a494-18f5-47ab-aa77-27d13629e75b)
![Screenshot_4](https://github.com/Tichenko/devops-netology/assets/116817153/30b441f7-cab7-4b37-ab39-f55bb6e90560)

Дополнительно, выставила лимит на использование памяти сервисом постгрес, чтобы избежать срабатывания oom-killera. По сути, этого достаточно, тк в этом случае постгрес будет тормозить, но в падать с ошибкой перестанет (1-3 скриншоты).
2й вариант - выставить параметр ядра vm.overcommit_memory=2 (скрины 4 и 5), означает, что ядро будет использовать жёсткие лимиты на память для процессов, и может не выдать дополнительную память, даже если у системы она есть, из-за этого не будет срабатывать oom-killer.
Эти 2 варианта можно использовать как раздельно, так и совместно, рекомендуемым вариантом является просто выставление vm.overcommit_memory=2

![image](https://github.com/Tichenko/devops-netology/assets/116817153/3a68c977-932d-4353-9be7-0f77a8e54a98)
![image](https://github.com/Tichenko/devops-netology/assets/116817153/68723679-45f9-42a6-b9af-2af3b45157d3)
![image](https://github.com/Tichenko/devops-netology/assets/116817153/36e988f9-0b54-4c74-b7a8-dca2b804cdf3)
![image](https://github.com/Tichenko/devops-netology/assets/116817153/cb914b57-e6c2-417d-adff-e7fefc803f76)
![image](https://github.com/Tichenko/devops-netology/assets/116817153/a7f5db45-0bf8-4dc0-b5ef-91838a1d0d56)

Программные варианты решения: 

1. Установить лимиты по памяти для postgresql модификацией файла postgresql.conf:
   В файле /etc/postgresql/12/main/postgresql.conf необходимо задать значения параметров shared_buffers и work_mem.
    Мы видим, что значение параметра max_conections = 100, поэтому использование оперативной памяти не превысит 512 + 4 * 100 = 912MB
2. Установка жесткого лимита на использование оперативной памяти процессами для всей системы командой ulimit (не рекомендуется, но может сработать)
3. Командой systemctl set-property задать лимит на использование оперативной памяти сервисом postgresql
Третий вариант аналогичен решению, которое присыно ранее. Альтернативной является создание файла вручную и указание в нем параметра MemoryLimit, где имя файла такое, как на скриншоте, или же override.conf (создается вручную или генерируется командой systemctl edit postgresql.service)
Существуют разные варианты решения проблемы, рекомендуемый - первый, можно использовать 1 и 3 вместе. 2й не рекомендуется, тк он затрагивает всю систему целиком, а не только postgres.
Также в вариантах 1 и 3 понадобится перезагрузка сервиса командой systemctl restart postgresql.service
![Screenshot_32](https://github.com/Tichenko/devops-netology/assets/116817153/f555fe53-2b69-45e9-9c0f-5c2712aa5c87)
![Screenshot_33](https://github.com/Tichenko/devops-netology/assets/116817153/05006d08-9934-47e3-a807-af428c7a7603)
![Screenshot_31](https://github.com/Tichenko/devops-netology/assets/116817153/46daa692-77f0-40bd-ba4a-5dbcaeb5e9ef)

![image](https://github.com/Tichenko/devops-netology/assets/116817153/8f419b98-3b8d-44d9-bc93-dce4d29464b9)

![image](https://github.com/Tichenko/devops-netology/assets/116817153/95600e6d-98ee-4723-b4c5-ba5d9bf8c85c)









