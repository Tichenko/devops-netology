### Задача 1

* Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

```
vagrant@server1:~$ sudo docker pull mysql:8.0
vagrant@server1:~$~$ sudo docker volume create vol_mysql
vol_mysql
vagrant@server1:~$ sudo docker run --rm --name mysql-docker -e MYSQL_ROOT_PASSWORD=mysql -ti -p 3306:3306 -v vol_mysql:/etc/mysql/ mysql:8.0
vagrant@server1:~$ docker ps
WARNING: Error loading config file: /home/vagrant/.docker/config.json: open /home/vagrant/.docker/config.json: permission denied
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                                                  NAMES
53f90537ecdc   mysql:8.0     "docker-entrypoint.s…"   19 minutes ago   Up 18 minutes   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql-docker
2cecef2042c2   postgres:12   "docker-entrypoint.s…"   2 days ago       Up 2 days       0.0.0.0:5432->5432/tcp, :::5432->5432/tcp              vagrant-netology-2

```
* Изучите бэкап БД и восстановитесь из него.

* Перейдите в управляющую консоль mysql внутри контейнера.

* Используя команду \h получите список управляющих команд.

* Найдите команду для выдачи статуса БД и приведите в ответе из ее вывода версию сервера БД.

```
mysql> \s
--------------
mysql  Ver 8.0.32 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:          11
Current database:
Current user:           root@localhost
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         8.0.32 MySQL Community Server - GPL
Protocol version:       10
Connection:             Localhost via UNIX socket
Server characterset:    utf8mb4
Db     characterset:    utf8mb4
Client characterset:    latin1
Conn.  characterset:    latin1
UNIX socket:            /var/run/mysqld/mysqld.sock
Binary data as:         Hexadecimal
Uptime:                 35 min 50 sec

Threads: 2  Questions: 7  Slow queries: 0  Opens: 119  Flush tables: 4  Open tables: 0  Queries per second avg: 0.003
--------------

```

* Подключитесь к восстановленной БД и получите список таблиц из этой БД.

```
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)

```
* Приведите в ответе количество записей с price > 300.

```

mysql> SELECT * FROM orders WHERE `price` > 300;
+----+----------------+-------+
| id | title          | price |
+----+----------------+-------+
|  2 | My little pony |   500 |
+----+----------------+-------+
1 row in set (0.00 sec)

```
### Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:

- плагин авторизации mysql_native_password
- срок истечения пароля — 180 дней
- количество попыток авторизации — 3
- максимальное количество запросов в час — 100
- аттрибуты пользователя:
- Фамилия "Pretty"
- Имя "James".

```
mysql> CREATE USER 'test'@'localhost' IDENTIFIED BY 'test-pass';
Query OK, 0 rows affected (0.04 sec)

```
```
mysql> ALTER USER 'test'@'localhost' ATTRIBUTE '{"fname":"James", "lname":"Pretty"}';
Query OK, 0 rows affected (0.03 sec)

```

```
mysql> ALTER USER 'test'@'localhost'
    -> IDENTIFIED BY 'test-pass'
    -> WITH
    -> MAX_QUERIES_PER_HOUR 100
    -> PASSWORD EXPIRE INTERVAL 180 DAY
    -> FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2;
Query OK, 0 rows affected (0.05 sec)

```


* Предоставьте привелегии пользователю test на операции SELECT базы test_db.

```
mysql> GRANT Select ON test_db.orders TO 'test'@'localhost';
Query OK, 0 rows affected, 1 warning (0.04 sec)

```

* Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES, получите данные по пользователю test и приведите в ответе к задаче.

```
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
+------+-----------+---------------------------------------+
| USER | HOST      | ATTRIBUTE                             |
+------+-----------+---------------------------------------+
| test | localhost | {"fname": "James", "lname": "Pretty"} |
+------+-----------+---------------------------------------+
1 row in set (0.00 sec)

```
### Задача 3

* Установите профилирование SET profiling = 1. Изучите вывод профилирования команд SHOW PROFILES;.

```
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

```

```
mysql> show profiles;
+----------+------------+--------------------------------------------------------------+
| Query_ID | Duration   | Query                                                        |
+----------+------------+--------------------------------------------------------------+
|        1 | 0.00107175 | show tables                                                  |
|        2 | 0.00061125 | CREATE TABLE a1 (id int not null auto_increment)             |
|        3 | 0.20534300 | CREATE TABLE a1 (id int not null auto_increment primary key) |
+----------+------------+--------------------------------------------------------------+
3 rows in set, 1 warning (0.00 sec)

```

* Исследуйте, какой engine используется в таблице БД test_db и приведите в ответе.

```
mysql> SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc;
+------------+--------+------------+------------+-------------+--------------+
| TABLE_NAME | ENGINE | ROW_FORMAT | TABLE_ROWS | DATA_LENGTH | INDEX_LENGTH |
+------------+--------+------------+------------+-------------+--------------+
| orders     | InnoDB | Dynamic    |          5 |       16384 |            0 |
+------------+--------+------------+------------+-------------+--------------+
1 row in set (0.01 sec)

```

- engine используеться  InnoDB;

* Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе:

 - на MyISAM
 - на InnoDB

```
mysql> show profiles;
+----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query
                                    |
+----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|        1 | 0.00107175 | show tables
                                    |
|        2 | 0.00061125 | CREATE TABLE a1 (id int not null auto_increment)
                                    |
|        3 | 0.20534300 | CREATE TABLE a1 (id int not null auto_increment primary key)
                                    |
|        4 | 0.01335350 | SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc |
|        5 | 0.24582000 | ALTER TABLE orders ENGINE = MyISAM
                                    |
|        6 | 0.29624075 | ALTER TABLE orders ENGINE = InnoDB
                                    |
+----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
6 rows in set, 1 warning (0.00 sec)

```

### Задача 4

* Изучите файл my.cnf в директории /etc/mysql.

* Измените его согласно ТЗ (движок InnoDB):

- скорость IO важнее сохранности данных;
- нужна компрессия таблиц для экономии места на диске;
- размер буффера с незакомиченными транзакциями 1 Мб;
- буффер кеширования 30% от ОЗУ;
- размер файла логов операций 100 Мб.
- Приведите в ответе изменённый файл my.cnf.

```
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL
innodb_flush_method = O_DSYNC
innodb_flush_log_at_trx_commit = 2
innodb_file_per_table = 1
innodb_log_buffer_size = 1M
innodb_buffer_pool_size = 1220M
innodb_log_file_size = 100M
# Custom config should go here
!includedir /etc/mysql/conf.d/

```

