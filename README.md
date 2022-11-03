# devops-netology

выполнение дз

* **/.terraform*
Исключить соседние файлы перед каталогом terraform и  файл после

* *.tfstate
Исключить  файл из tfstat

* *.tfstate.*
исключить файл перед tfstate и последующий за ним

* crash.log
* crash.*.log

crash.log пропускаем, исключить файл между crash и log

* override.tf
* override.tf.json
* *_override.tf
*_override.tf.json

* Файлы override.tf и  override.tf.json не трогаем, пропускаем, а исключаем *_override.tf и *_override.tf.json

* Ignore CLI configuration files
.terraformrc
terraform.rc
