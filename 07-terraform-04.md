## Домашнее задание к занятию "Продвинутые методы работы с Terraform"

### Задание 1

Скриншот подключения к ВМ и вывод команды ```sudo nginx -t```:

![img1](https://github.com/Tichenko/devops-netology/assets/116817153/31e9280d-a54e-4c93-b9de-7fd60d85a9fb)


### Задание 2
Вывод команды ```terraform output```:

![img2](https://github.com/Tichenko/devops-netology/assets/116817153/958d7166-9665-432a-86de-f8ad531d412f)


Документация, сгенерированная к модулю при помощи ```terraform-docs```:

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.vpc_net](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.vpc_subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_cidr"></a> [default\_cidr](#input\_default\_cidr) | n/a | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `string` | `"vpc-net"` | no |
| <a name="input_vpc_subnet_name"></a> [vpc\_subnet\_name](#input\_vpc\_subnet\_name) | n/a | `string` | `"vpc-subnet"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |


### Задание 3 (вывод команд):

(К сожалению вследствие возникновления ошибки ```Error while requesting API to create network: ... rpc error: code = ResourceExhausted desc = Quota limit vpc.networks.count exceeded``` В данном задании модуль состоит только из подсети)

![img3](https://github.com/Tichenko/devops-netology/assets/116817153/8fa29567-1419-42b0-80fc-f815dc0d4198)

![img4](https://github.com/Tichenko/devops-netology/assets/116817153/20def169-aa85-47d0-a942-a9e01e3b1b08)

![img5](https://github.com/Tichenko/devops-netology/assets/116817153/4db85d8f-e7bf-405c-9317-c1a868a555da)


