
## Домашнее задание к занятию "Введение в Terraform"

### Задание 1

```

vagrant@server1:~$ terraform -v
Terraform v1.4.2
on linux_amd64

```

1. Перейдите в каталог src. Скачайте все необходимые зависимости, использованные в проекте.
2. Изучите файл .gitignore. В каком terraform файле допустимо сохранить личную, секретную информацию?

* Ответ: Личную информацию допустимо хранить в файле personal.auto.tfvars

3. Выполните код проекта. Найдите в State-файле секретное содержимое созданного ресурса random_password. Пришлите его в качестве ответа.

* Ответ: ilSJj9IUEXwHpP5Q
4. Раскомментируйте блок кода, примерно расположенный на строчках 29-42 файла main.tf. Выполните команду terraform -validate. Объясните в чем заключаются намеренно допущенные ошибки? Исправьте их.

* Ответ:

В блоке resource "docker_image" не хватает второго lable (локального), а в блоке resource "docker_container" "1nginx" lable могут начинаться только с символов латинского алфавита или с символа подчеркивания, имя может содержать буквы, двоеточие и тире.

```
resource "docker_image" {
  name         = "nginx:latest"
  keep_locally = true
}

```
```
resource "docker_container" "1nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

```
верно:

```

resource "docker_image" "nginx"{
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx"

```

5. Выполните код. В качестве ответа приложите вывод команды docker ps

* Ответ:

```
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                       NAMES
e5ef936fba85   904b8cb13b93   "/docker-entrypoint.…"   16 seconds ago   Up 14 seconds   0.0.0.0:8000->80/tcp        example_ilSJj9IUEXwHpP5Q 

```

6. Замените имя docker-контейнера в блоке кода на hello_world, выполните команду terraform apply -auto-approve. Объясните своими словами, в чем может быть опасность применения ключа -auto-approve ?

* Ответ: Если верно поняла, терраформ в данном случае удаляет без подтверждения, восстановить если только пересоздать заново, а время-это ценный ресурс.
terraform apply –auto-approve: создает или обновляет инфраструктуру; этап утверждения пользователем пропускается.


```
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                       NAMES
7a04fcec8a80   904b8cb13b93   "/docker-entrypoint.…"   38 seconds ago   Up 35 seconds   0.0.0.0:8000->80/tcp        Hello_world

```
7. Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.

```
{
  "version": 4,
  "terraform_version": "1.4.2",
  "serial": 11,
  "lineage": "4f7b5439-19bf-deff-e516-1f6bc8f4c6bb",
  "outputs": {},
  "resources": [],
  "check_results": null
}
---

```

8. Объясните, почему при этом не был удален docker образ nginx:latest ?(Ответ найдите в коде проекта или документации)
 
* Ответ: При удалении контейнера, образ не удаляется и может быть использован другим контейнером.
Опция keep_locally = true - не дает удалить образ.


