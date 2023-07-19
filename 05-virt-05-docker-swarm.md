
### Задача 1

 1. Дайте письменые ответы на вопросы:

 В чём отличие режимов работы сервисов в Docker Swarm-кластере: replication и global?

Ответ:

- Replicated services - можно указать количество выполненных задач.
- Global services - можно запустить одну и ту же задачу на каждом узле. Нет необходимости указывать количество заданий заранее

2. Какой алгоритм выбора лидера используется в Docker Swarm-кластере?

Ответ: Используется алгоритм поддержания распределенного консенсуса RAft. Отказоустойчивость сервиса достигается 
в том числе засчет того, что в кластере могут работать несколько управляющих нод, которые могут в любой момент заменить вышедшео из строя лидера. 

3. Что такое Overlay Network?

Ответ: Драйвер оверлейной сети создает распределенную сеть между несколькими узлами демона Docker. Эта сеть находится поверх (перекрывает) сети,
специфичные для хоста, позволяя контейнерам, подключенным к ней (включая контейнеры службы swarm), безопасно обмениваться данными при включенном шифровании.

### Задача 2

Создать ваш первый Docker Swarm кластер в Яндекс.Облаке

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:

```
docker node ls

````
скрин

https://docs.google.com/document/d/1AjF62hv9I_FRrtgdMF8b4xtu-ogdT5b1EE7JE6Q0C1g/edit

### Задача 3

Создайте ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.

Чтобы получить зачёт, предоставьте скриншот из терминала (консоли), с выводом команды:

```
docker service ls

````

скрин

https://docs.google.com/document/d/1AjF62hv9I_FRrtgdMF8b4xtu-ogdT5b1EE7JE6Q0C1g/edit