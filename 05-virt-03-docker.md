### Задача 1

##### Сценарий выполения задачи:

* создайте свой репозиторий на https://hub.docker.com;
* выберете любой образ, который содержит веб-сервер Nginx;
* создайте свой fork образа;
* реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:

```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>

```
* Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

##### Ответ : https://hub.docker.com/r/tilchenko/nginx

```
vagrant@server1:~$ curl 127.0.1:8080
<html> <head> Hey, Netology </head> <body> <h1>I’m DevOps Engineer!</h1> </body> </html>

```

### Задача 2 

##### Посмотрите на сценарий ниже и ответьте на вопрос: "Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

* Высоконагруженное монолитное java веб-приложение;

Ответ: Физическая машина, чтобы не расходовать ресурсы на виртуализацию и из-за монолитности не будет проблем с разворачиванием на разных машинах.

* Nodejs веб-приложение;

Ответ: Контейнеры т.к. удобно деплоить и будет являться частью микросервисной архитектуры. Docker.

* Мобильное приложение c версиями для Android и iOS

Ответ: Не походит, docker не является здесь целевым решением. Предположительно использование виртуальных машин, проще для тестирования, размещения на одной хостовой машине.

* Шина данных на базе Apache Kafka;

Ответ: исходя из документации лучшей практикой является размещение брокеров на виртуальных машинах.

* Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;

Ответ: Не подходит. При организации логгирования с использованием elk-стека есть несколько вопросов ответы на который позволяют определить что будет использовано: 1. Объём логов 2. Период хранения 3. скорость поиска - в случае высоконагруженных систем с большими объёмами и сроками хранения логов целесообразно использовать физические/виртуальные сервера, т.к. стек elk обычно хорошо утилизирует сервера.

* Мониторинг-стек на базе Prometheus и Grafana;

Ответ: Можно использовать контейнер или виртуальную машину для облегчения развёртывания и масштабирования.

* MongoDB, как основное хранилище данных для java-приложения;

Ответ: Физическая машина как наиболее надежное, отказоустойчивое решение. Либо виртуальный сервер.

* Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry

Ответ: Могут быть применены все варианты, в зависимости от наличия соответствующих ресурсов. Но для большей изолированности лучше использовать docker.

### Задача 3 

* Запустите первый контейнер из образа centos c любым тэгом в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;

```
vagrant@server1:~$ docker run -v /data:/data --name centos-container -d -t centos
Unable to find image 'centos:latest' locally
latest: Pulling from library/centos
a1d0c7532777: Pull complete
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
6085a4701af5937d1300d570c4fae6da64985e4cab9a6ceab8f69cd31e772523

``` 

* Запустите второй контейнер из образа debian в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;

```

vagrant@server1:~$ docker run -v /data:/data --name debian-container -d -t debian
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
bbeef03cda1f: Pull complete
Digest: sha256:534da5794e770279c889daa891f46f5a530b0c5de8bfbc5e40394a0164d9fa87
Status: Downloaded newer image for debian:latest
c96126b95a520adc263cd3d360c4f354903e6ad5660ba709c837a3fd70fed8a6

```

```
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED              STATUS              PORTS                                   NAMES
c96126b95a52   debian         "bash"                   41 seconds ago       Up 39 seconds                                               debian-container
6085a4701af5   centos         "/bin/bash"              About a minute ago   Up About a minute                                           centos-container

```
*  Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data;

```
vagrant@server1:~$ docker exec centos-container /bin/bash -c "echo test_message>/data/readme.md"

```
* Добавьте еще один файл в папку /data на хостовой машине;

```
$ sudo touch /data/readme_host.md
$ sudo vi /data/readme_host.md
  test_message2

```

* Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.

```

vagrant@server1:~$ docker exec -it debian-container /bin/bash
root@c96126b95a52:/# cd /data
root@c96126b95a52:/data# /data# ls -l
bash: /data#: No such file or directory
root@c96126b95a52:/data# ls -l
total 8
-rw-r--r-- 1 root root 13 Jan 28 15:50 readme.md
-rw-r--r-- 1 root root 14 Jan 28 15:51 readme_host.md

```


