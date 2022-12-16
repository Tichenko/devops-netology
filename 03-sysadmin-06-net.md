* 1.Работа c HTTP через телнет
* Ответ: vagrant@vagrant:~$ telnet stackoverflow.com 80
 Trying 151.101.129.69...
 Connected to stackoverflow.com.
 Escape character is '^]'.
 GET /questions HTTP/1.0
 HOST: stackoverflow.com

 HTTP/1.1 301 Moved Permanently
 cache-control: no-cache, no-store, must-revalidate
location: https://stackoverflow.com/questions
.....

 HTTP 301 Moved Permanently. Запрошенный ресурс был перещен (в данном случае в https://stackoverflow.com/questions).

* 2.Повторите задание 1 в браузере
* Ответ: укажите в ответе полученный HTTP код – 200 (успешно выполнен)
         проверьте время загрузки страницы, какой запрос обрабатывался дольше всего 
	 - https://stackoverflow.com/ 308 мс
	 приложите скриншот консоли браузера в ответ. ( приложен отдельным файлом)

* 3.Какой IP адрес у вас в интернете?
* Ответ: 46.241.x.x

* 4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois

* Ответ:

   route:          46.241.0.0/17
   netname:        RU-ZSTTK-20101223
   origin:         AS21127

 Провайдер -JSC Zap-Sib TransTeleCom JSC Zap-Sib TransTeleCom AS21127 ZSTTKAS

* 5.Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute

* Ответ: vagrant@vagrant:~$ sudo traceroute -n 8.8.8.8
     AS21127 – ZSTTK
     AS20485 - TRANSTELECOM
     AS15169 – Google

* 6. Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?
* Ответ:  Наибольшая средняя задержка (delay) на последнем хопе – 55 мс
   
   .....
   21.dns.google         0.0%   216   54.7   55.4  54.1   0.4


* 7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? Воспользуйтесь утилитой dig

* Ответ: vagrant@vagrant:~$ dig dns.google
      ;; ANSWER SECTION:
   dns.google.          626     IN      A       8.8.4.4
  dns.google.          626     IN      A       8.8.8.8


* 8 Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? Воспользуйтесь утилитой dig
 В качестве ответов на вопросы приложите лог выполнения команд в консоли или скриншот полученных результатов.

* Ответ: vagrant@vagrant:~$ dig -x 8.8.4.4
   ;; ANSWER SECTION:
   4.4.8.8.in-addr.arpa.       7057    IN      PTR     dns.google.
   dig -x 8.8.8.8

   ;; ANSWER SECTION:
   8.8.8.8.in-addr.arpa.       7127    IN      PTR     dns.google.


* В задании прописано: " В качестве ответов на вопросы можно приложите лог выполнения команд в консоли или скриншот полученных результатов." Прикладываю файл со скринами.


