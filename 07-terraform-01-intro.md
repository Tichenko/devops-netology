
### Задача 1. Выбор инструментов

Легенда
Через час совещание, на котором менеджер расскажет о новом проекте. Начать работу над проектом нужно будет уже сегодня. Сейчас известно, что это будет сервис, который ваша компания будет предоставлять внешним заказчикам. Первое время, скорее всего, будет один внешний клиент, со временем внешних клиентов станет больше.

Также по разговорам в компании есть вероятность, что техническое задание ещё не чёткое, что приведёт к большому количеству небольших релизов, тестирований интеграций, откатов, доработок, то есть скучно не будет.

Вам как DevOps-инженеру будет нужно принять решение об инструментах для организации инфраструктуры. В вашей компании уже используются следующие инструменты:

* остатки Сloud Formation,
* некоторые образы сделаны при помощи Packer,
* год назад начали активно использовать Terraform,
* разработчики привыкли использовать Docker,
* уже есть большая база Kubernetes-конфигураций,
* для автоматизации процессов используется Teamcity,
* также есть совсем немного Ansible-скриптов,
* ряд bash-скриптов для упрощения рутинных задач.

На совещании нужно будет выяснить подробности о проекте, чтобы определиться с инструментами:

1. Какой тип инфраструктуры будем использовать для этого проекта: изменяемый или не изменяемый?

-  По причине того, что планируется частое изменение конфигурации и релизы разрабатываемого ПО, при этом не меняя тестовые среды, то лучше использовать неизменямый тип.

2. Будет ли центральный сервер для управления инфраструктурой?

- Ansible и Terraform - централизованного сервера не требуют, поэтому без него.

3. Будут ли агенты на серверах?

- В связи с нашим выбором, они тоже не требуються.

4. Будут ли использованы средства для управления конфигурацией или инициализации ресурсов?

- Да, Ansible и Terraform, они указаны в легенде.

Так как проект стартует уже сегодня, на совещании нужно будет определиться со всеми этими вопросами.

Вам нужно:
1. Ответить на четыре вопроса из раздела «Легенда». ( ответила)
2. Решить, какие инструменты из уже используемых вы хотели бы применить для нового проекта.

- Все хорошо подходят: Packer, Terraform, Kubernetes, Ansible, docker, Teamcity.

3. Определиться, хотите ли рассмотреть возможность внедрения новых инструментов для этого проекта.

- Да, с целью попробовать новые интрументы, возможно они будут удобнее и т.к. нет четкого плана развития проекта. Возмлжно есть смысл добавить что-то из системы мониторинг.

Если для ответов на эти вопросы недостаточно информации, напишите, какие моменты уточните на совещании.

### Задача 2. Установка Terraform

Официальный сайт: https://www.terraform.io/

Установите терраформ при помощи менеджера пакетов используемого в вашей операционной системе. В виде результата этой задачи приложите вывод команды terraform --version.

```

vagrant@server1:~$ terraform -v
Terraform v1.4.2
on linux_amd64

```

### Задача 3. Поддержка legacy-кода

В какой-то момент вы обновили Terraform до новой версии, например с 0.12 до 0.13. Код одного из проектов настолько устарел, что не может работать с версией 0.13. Нужно сделать так, чтобы вы могли одновременно использовать последнюю версию Terraform, установленную при помощи штатного менеджера пакетов, и устаревшую версию 0.12.

В виде результата этой задачи приложите вывод --version двух версий Terraform, доступных на вашем компьютере или виртуальной машине.


```
vagrant@server1:~$ sudo docker run -i -t hashicorp/terraform:0.12.29 --version
Unable to find image 'hashicorp/terraform:0.12.29' locally
0.12.29: Pulling from hashicorp/terraform
df20fa9351a1: Pull complete
a10e80ac6f9e: Pull complete
201a8bc945ee: Pull complete
Digest: sha256:a55f6894766bed2becfb8717ca33b5d52e7c7863619f17227b931c2d2df104b5
Status: Downloaded newer image for hashicorp/terraform:0.12.29
Terraform v0.12.29

```

