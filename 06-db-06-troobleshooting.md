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

OOM Killer - процесс, который завершает приложение при нехватке памяти.
Заканчивается свободная оперативная память которую выжырает Postgres.

Для решения проблемы недостатка памяти необходимо:

- увеличить размер RAM на сервере
- настроить PostgreSQL и выделить достаточный объём памяти
- оптимизировать запросы и проверить наличие и состояние индексов
- секционировать большие таблицы (партиционирование)
- настроить swap на сервере (это немного замедлит работу, но поможет эффективно высвобождать ресурсы)

