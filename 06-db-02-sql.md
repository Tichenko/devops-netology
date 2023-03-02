### Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose-манифест.

* Ответ:
```
vagrant@server1:~$ docker volume ls
DRIVER    VOLUME NAME
local     vol-1-pg-base
local     vol-2-pg-backup

```

```
vagrant@server1:~$ sudo docker pull postgres:12
12: Pulling from library/postgres
bb263680fed1: Pull complete
75a54e59e691: Pull complete
3ce7f8df2b36: Pull complete
f30287ef02b9: Pull complete
dc1f0e9024d8: Pull complete
7f0a68628bce: Pull complete
32b11818cae3: Pull complete
48111fe612c1: Pull complete
f80b16d65234: Pull complete
f19fad3d1049: Pull complete
bf8102184052: Pull complete
a3b314ffacae: Pull complete
2ee35dbe1779: Pull complete
Digest: sha256:43b752e182ad5fd6b12d468f369853257fc88b3ab3494a55bacb60dc7af00c6d
Status: Downloaded newer image for postgres:12
docker.io/library/postgres:12

```
vagrant@server1:~$ docker image ls
REPOSITORY                 TAG       IMAGE ID       CREATED         SIZE
postgres                   12        2c278af658a7   2 weeks ago     373MB
tilchenko/nginx            latest    f7308dac1d9b   4 weeks ago     142MB

```
```


postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

```

### Задача 2

В БД из задачи 1:

* Cоздайте пользователя test-admin-user и БД test_db;

```
postgres=# CREATE DATABASE test_db;
CREATE DATABASE
postgres=# CREATE ROLE "test-admin-user" SUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
CREATE ROLE

```
* В БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже);

```

postgres=# create table orders (id integer, name text, price integer, PRIMARY KEY (id));
CREATE TABLE
postgres=# create table clients (id integer PRIMARY KEY, lastname text, country text, booking integer, FOREIGN KEY (booking) REFERENCES orders (Id));
CREATE TABLE
postgres=# \dt
          List of relations
 Schema |  Name   | Type  |  Owner
--------+---------+-------+----------
 public | clients | table | postgres
 public | orders  | table | postgres
(2 rows)

```
* Предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db;

```
postgres=# grant all on public.orders to "test-admin-user";
GRANT
postgres=# grant all on public.clients to "test-admin-user";
GRANT

```
* Cоздайте пользователя test-simple-user;

``` 
postgres=# create role "test-simple-user";
CREATE ROLE

```
* Предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE этих таблиц БД test_db.

```
postgres=# grant select on table public.clients to "test-simple-user";
GRANT
postgres=# grant insert on table public.clients to "test-simple-user";
GRANT
postgres=# grant update on table public.clients to "test-simple-user";
GRANT
postgres=# grant delete on table public.clients to "test-simple-user";
GRANT
postgres=# grant select on table public.orders to "test-simple-user";
GRANT
postgres=# grant insert on table public.orders to "test-simple-user";
GRANT
postgres=# grant update on table public.orders to "test-simple-user";
GRANT
postgres=# grant delete on table public.orders to "test-simple-user";
GRANT

```
* итоговый список БД после выполнения пунктов выше;

```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
(4 rows)

```
* описание таблиц (describe);

```
postgres=# \d "clients"
               Table "public.clients"
  Column  |  Type   | Collation | Nullable | Default
----------+---------+-----------+----------+---------
 id       | integer |           | not null |
 lastname | text    |           |          |
 country  | text    |           |          |
 booking  | integer |           |          |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "clients_booking_fkey" FOREIGN KEY (booking) REFERENCES orders(id)

postgres=# \d "orders"
               Table "public.orders"
 Column |  Type   | Collation | Nullable | Default
--------+---------+-----------+----------+---------
 id     | integer |           | not null |
 name   | text    |           |          |
 price  | integer |           |          |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_booking_fkey" FOREIGN KEY (booking) REFERENCES orders(id)
   
```
* SQL-запрос для выдачи списка пользователей с правами над таблицами test_db;

```
postgres=# select * from INFORMATION_SCHEMA.TABLE_PRIVILEGES where grantee in ('test-admin-user', 'test-simple-user');
 grantor  |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_granta
ble | with_hierarchy
----------+------------------+---------------+--------------+------------+----------------+----------
----+----------------
 postgres | test-admin-user  | postgres      | public       | clients    | INSERT         | YES
    | NO
 postgres | test-admin-user  | postgres      | public       | clients    | SELECT         | YES
    | YES
 postgres | test-admin-user  | postgres      | public       | clients    | UPDATE         | YES
    | NO
 postgres | test-admin-user  | postgres      | public       | clients    | DELETE         | YES
    | NO
 postgres | test-admin-user  | postgres      | public       | clients    | TRUNCATE       | YES
    | NO
 postgres | test-admin-user  | postgres      | public       | clients    | REFERENCES     | YES
    | NO
 postgres | test-admin-user  | postgres      | public       | clients    | TRIGGER        | YES
    | NO
 postgres | test-simple-user | postgres      | public       | clients    | INSERT         | NO
    | NO
 postgres | test-simple-user | postgres      | public       | clients    | SELECT         | NO
    | YES
 postgres | test-simple-user | postgres      | public       | clients    | UPDATE         | NO
    | NO
 postgres | test-simple-user | postgres      | public       | clients    | DELETE         | NO
    | NO
 postgres | test-admin-user  | postgres      | public       | orders     | INSERT         | YES
    | NO
 postgres | test-admin-user  | postgres      | public       | orders     | SELECT         | YES
    | YES
 postgres | test-admin-user  | postgres      | public       | orders     | UPDATE         | YES
    | NO
 postgres | test-admin-user  | postgres      | public       | orders     | DELETE         | YES
    | NO
 postgres | test-admin-user  | postgres      | public       | orders     | TRUNCATE       | YES
    | NO
 postgres | test-admin-user  | postgres      | public       | orders     | REFERENCES     | YES
    | NO
 postgres | test-admin-user  | postgres      | public       | orders     | TRIGGER        | YES
    | NO
 postgres | test-simple-user | postgres      | public       | orders     | INSERT         | NO
    | NO
 postgres | test-simple-user | postgres      | public       | orders     | SELECT         | NO
    | YES
 postgres | test-simple-user | postgres      | public       | orders     | UPDATE         | NO
    | NO
 postgres | test-simple-user | postgres      | public       | orders     | DELETE         | NO
    | NO
(22 rows)

```
* список пользователей с правами над таблицами test_db.

```
postgres=# \du
                                       List of roles
    Role name     |                         Attributes                         | Member of
------------------+------------------------------------------------------------+-----------
 postgres         | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 test-admin-user  | Superuser, No inheritance                                  | {}
 test-simple-user | Cannot login

```
### Задача 3

Используя SQL-синтаксис, наполните таблицы следующими тестовыми данными:

Таблица orders:

```
postgres=# insert into orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
INSERT 0 5
postgres=# select * from orders;
 id |  name   | price
----+---------+-------
  1 | Шоколад |    10
  2 | Принтер |  3000
  3 | Книга   |   500
  4 | Монитор |  7000
  5 | Гитара  |  4000
(5 rows)

```
Таблица clients

```
postgres=# insert into clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
INSERT 0 5
postgres=# select * from clients;
 id |       lastname       | country | booking
----+----------------------+---------+---------
  1 | Иванов Иван Иванович | USA     |
  2 | Петров Петр Петрович | Canada  |
  3 | Иоганн Себастьян Бах | Japan   |
  4 | Ронни Джеймс Дио     | Russia  |
  5 | Ritchie Blackmore    | Russia  |
(5 rows)

```
Используя SQL синтаксис вычислите количество записей для каждой таблицы
приведите в ответе:
* запросы
* результаты их выполнения.


```

postgres=# select count (*) from orders;
 count
-------
     5
(1 row)

postgres=# select count (*) from clients;
 count
-------
     5
(1 row)

postgres=#

```

### Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders

- Приведите SQL-запросы для выполнения этих операций.

 -Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод этого запроса.

- Подсказка: используйте директиву UPDATE.

* Иванов Иван Иванович приобретает книгу;
* Петров Петр Петрович - монитор;
* Иоганн Себастьян Бах - гитару.

```
postgres=# update  clients set booking = 3 where id = 1;
UPDATE 1
postgres=# update  clients set booking = 4 where id = 2;
UPDATE 1
postgres=# update  clients set booking = 5 where id = 3;
UPDATE 1
postgres=#

```
postgres=# select * from clients as c where  exists (select id from orders as o where c.booking = o.i
d);
 id |       lastname       | country | booking
----+----------------------+---------+---------
  1 | Иванов Иван Иванович | USA     |       3
  2 | Петров Петр Петрович | Canada  |       4
  3 | Иоганн Себастьян Бах | Japan   |       5
(3 rows)

```

### Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).

Приведите получившийся результат и объясните, что значат полученные значения.

```

postgres=# explain select * from clients where booking is not null;
                        QUERY PLAN
-----------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)
   Filter: (booking IS NOT NULL)
(2 rows)

```

* cost - затратность операции

* 0.00 — затраты на получение первой строки.

* 18.10 — затраты на получение всех строк.

* rows — приблизительное количество возвращаемых строк при выполнении операции Seq Scan.

* width — средний размер одной строки в байтах.

### Задача 6

* Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. задачу 1).


```
postgres=# \q
root@e0a5f36bba87:/# pg_dump -U postgres test_db -f /var/lib/postgresql/backup/dump_test_db.sql

``

* Остановите контейнер с PostgreSQL, но не удаляйте volumes.

```

root@server1:~# docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED        STATUS        PORTS                                       NAMES
e0a5f36bba87   postgres:12   "docker-entrypoint.s…"   24 hours ago   Up 24 hours   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   pg_docker
root@server1:~# docker container stop e0a5f36bba87
e0a5f36bba87
root@server1:~# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
root@server1:~#

```

* Поднимите новый пустой контейнер с PostgreSQL.

```

root@server1:~# docker run -d --name pg-netology-2 -e POSTGRES_PASSWORD=postgres -p 5432:5432 -v vol-1-pg-base:/var/lib/postgresql/data -v vol-2-pg-backup:/var/lib/postgresql/backup postgres:12
pg-netology-2
2cecef2042c26333a404aa8aa0516fee5350b510d48db72121dce0b7266ac3dc
root@server1:~# docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                                       NAMES
2cecef2042c2   postgres:12   "docker-entrypoint.s…"   33 seconds ago   Up 30 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   vagrant-netology-2
root@server1:~#

```

* Восстановите БД test_db в новом контейнере.

```
root@server1:~# docker exec -it pg-netology-2 bash 
root@2cecef2042c2:/# psql -U postgres
psql (12.14 (Debian 12.14-1.pgdg110+1))
Type "help" for help.


postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test1     | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
(6 rows)


```

* Приведите список операций, который вы применяли для бэкапа данных и восстановления.

```
postgres=# drop database test_db;
DROP DATABASE
postgres=# create database test_db;
CREATE DATABASE
postgres=# \q
root@2cecef2042c2:/# psql -U vagrant -d test_db -f /var/lib/postgresql/data/dump_test.sql;
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
root@2cecef2042c2:/# psql -U postgres
psql (12.14 (Debian 12.14-1.pgdg110+1))
Type "help" for help.
postgres=# \l (  результаты есть выше) 


```


