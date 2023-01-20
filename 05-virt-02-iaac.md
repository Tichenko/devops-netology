### Задача 1

##### Опишите своими словами основные преимущества применения на практике IaaC паттернов.

Ответ:

* Ускоряет процесс разворачивания необходимой инфраструктуры;

* Позволяет избежать ситуаций недокументированных изменений, быстрый откат изменений и деплой новых;

* Дает возможность быстро производить доставку кода для непрерывной его интеграции в продукте, а так же провести тестирование;

##### Какой из принципов IaaC является основополагающим?

Ответ:

* Идемпотентность

### Задача 2

##### Чем Ansible выгодно отличается от других систем управление конфигурациями?

Ответ:

* Скорость, простота,расширяемость;

* Разработкой занимается крупная компания - RedHat;

* Не требует агентов на управляемых хостах - доступ по ssh;

##### Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

* Ответ: Pull, т.к. отсутствует единая точка отказа и хранения данных для доступа.

### Задача 3 

##### Установить на личный компьютер:

* VirtualBox 

``` 
$ vboxmanage --version
7.0.4r154605

```

* Vagrant

``` 
$ vagrant --version 
Vagrant 2.3.3

```
* Ansible


```
vagrant@server1:~$ ansible --version
ansible 2.9.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/vagrant/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Mar 15 2022, 12:22:08) [GCC 9.4.0]

  ``` 
### Задача 4 (*)

* Воспроизвести практическую часть лекции самостоятельно.

Создать виртуальную машину.
Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды

```
vagrant@server1:~$ docker -v
Docker version 20.10.23, build 7155243

```
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@server1:~$

```

