* 1. На лекции мы познакомились с node_exporter......

* Ответ: 

#####  root@vagrant# vim /etc/systemd/system/node_exporter.service

##### [Unit]
##### Description=Node Exporter
##### Wants=network-online.target
##### After=network-online.target

##### [Service]
##### EnvironmentFile=/opt/node_exporter/node_exporter_options
##### ExecStart=/opt/node_exporter/node_exporter $OPTIONS

##### [Install]
##### WantedBy=multi-user.target

##### root@vagrant# vim /opt/node_exporter/node_exporter_options
##### OPTIONS="--web.listen-address=":9100""

* root@vagrant# systemctl enable node_exporter
##### Created symlink /etc/systemd/system/multi-user.target.wants/node_exporter.service → /etc/systemd/system/node_exporter.service

* root@vagrant# systemctl start node_exporter
* root@vagrant# systemctl status node_exporter

##### node_exporter.service - Node Exporter
#####     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
#####     Active: active (running) since Sun 2023-01-04 07:42:59 UTC; 6min ago
#####   Main PID: 1611 (node_exporter)
#####      Tasks: 4 (limit: 1107)
#####     Memory: 2.4M
#####     CGroup: /system.slice/node_exporter.service
#####             └─1611 /opt/node_exporter/node_exporter --web.listen-address=:9100
         
* root@vagrant# systemctl stop node_exporter
* root@vagrant# systemctl status node_exporter

* node_exporter.service - Node Exporter
#####     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
#####     Active: inactive (dead) since Sun 2023-01-04 07:50:30 UTC; 2s ago
#####    Process: 1611 ExecStart=/opt/node_exporter/node_exporter $OPTIONS (code=killed, signal=TERM)
#####   Main PID: 1611 (code=killed, signal=TERM)

##### Jan 04 07:42:59 vagrant node_exporter[1611]: ts=2023-01-04T07:42:59.674Z caller=node_exporter.go:115 level=info collector=udp_queues
##### Jan 04 07:42:59 vagrant node_exporter[1611]: ts=2023-01-04T07:42:59.674Z caller=node_exporter.go:115 level=info collector=uname
##### Jan 04 07:42:59 vagrant node_exporter[1611]: ts=2023-01-04T07:42:59.674Z caller=node_exporter.go:115 level=info collector=vmstat
##### Jan 04 07:42:59 vagrant node_exporter[1611]: ts=2023-01-04T07:42:59.674Z caller=node_exporter.go:115 level=info collector=xfs
##### Jan 04 07:42:59 vagrant node_exporter[1611]: ts=2023-01-04T07:42:59.674Z caller=node_exporter.go:115 level=info collector=zfs
##### Jan 04 07:42:59 vagrant node_exporter[1611]: ts=2023-01-04T07:42:59.675Z caller=node_exporter.go:199 level=info msg="Listening on" address=:9100
##### Jan 04 07:42:59 vagrant node_exporter[1611]: ts=2023-01-04T07:42:59.675Z caller=tls_config.go:195 level=info msg="TLS is disabled." http2=false
##### Jan 04 07:50:30 vagrant systemd[1]: Stopping Node Exporter...
##### Jan 04 07:50:30 vagrant systemd[1]: node_exporter.service: Succeeded.
##### Jan 04 07:50:30 vagrant systemd[1]: Stopped Node Exporter.

* 2 Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

* Ответ: 

##### CPU:
   - node_cpu_seconds_total{*};
   - process_cpu_seconds_total;
##### Memory:
   - node_memory_MemAvailable_bytes;
   - node_memory_MemTotal_bytes;
   - node_vmstat_pgmajfault;
##### Disk:
   - node_disk_read_bytes_total{*};
   - node_disk_written_bytes_total{*};
   - node_filesystem_size_bytes{*};
   - node_filesystem_avail_bytes{*};
   - node_filesystem_files_free{*};
   - node_disk_read_time_seconds_total{*};
   - node_disk_write_time_seconds_total{*};
###### Network:
   - node_network_receive_bytes_total{*};
   - node_network_transmit_bytes_total{*};
   - node_network_receive_errs_total{*};
   - node_network_transmit_errs_total{*};
   - node_network_transmit_drop_total{*};
   - node_network_receive_drop_total{*};

* 3 Установите в свою виртуальную машину Netdata......

* Ответ:

* vagrant@vagrant:~$ systemctl status netdata.service
* ● netdata.service - netdata - Real-time performance monitoring
#####     Loaded: loaded (/lib/systemd/system/netdata.service; enabled; vendor preset: enabled)
#####     Active: active (running) since Mon 2023-01-02 13:50:06 UTC; 1 day 15h ago
#####       Docs: man:netdata
#####             file:///usr/share/doc/netdata/html/index.html
#####             https://github.com/netdata/netdata
#####   Main PID: 637 (netdata)
#####      Tasks: 22 (limit: 1066)
#####     Memory: 117.2M
#####     CGroup: /system.slice/netdata.service
#####             ├─ 637 /usr/sbin/netdata -D
#####             ├─7019 bash /usr/lib/netdata/plugins.d/tc-qos-helper.sh 1
#####             ├─7267 /usr/lib/netdata/plugins.d/apps.plugin 1
#####             └─7271 /usr/lib/netdata/plugins.d/nfacct.plugin 1

##### Jan 02 13:50:06 vagrant systemd[1]: Started netdata - Real-time performance monitoring.
##### Jan 02 13:50:06 vagrant netdata[637]: SIGNAL: Not enabling reaper
##### Jan 02 13:50:06 vagrant netdata[637]: 2023-01-02 13:50:06: netdata INFO  : MAIN : SIGNAL: Not enabling reaper


+ vagrant@vagrant:~$ ss -tulpn | grep 19999
###### tcp   LISTEN  0       4096          127.0.0.1:19999        0.0.0.0:*
+ vagrant@vagrant:~$


* 4. Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

* Ответ: да, можно
+  vagrant@vagrant:~$ dmesg -T | grep virt
##### [Mon Jan  2 13:49:56 2023] CPU MTRRs all blank - virtualized system.
##### [Mon Jan  2 13:49:56 2023] Booting paravirtualized kernel on KVM
##### [Mon Jan  2 13:49:59 2023] systemd[1]: Detected virtualization oracle.

* 5 Как настроен sysctl fs.nr_open на системе по-умолчанию? Определите, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?

* Ответ:
 + vagrant@vagrant:~$ sysctl -n fs.nr_open
- 1048576
- ulimit -aH    
- open files                     (-n) 1048576


* 6 Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.

* Ответ: root@vagrant:~# ps -e |grep sleep
#####  1723 pts/2    00:00:00 sleep
* root@vagrant:~# nsenter --target 1723 --pid --mount
* root@vagrant:/# ps
#####    PID TTY          TIME CMD
#####      2 pts/0    00:00:00 bash
#####     11 pts/0    00:00:00 ps

* 7 Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось)......

* Ответ:

+ :(){ :|:& };: - так называемая fork бомба, функция, которая параллельно пускает два своих экземпляра. Каждый пускает ещё по два и т.д. 
- При отсутствии лимита на число процессов машина быстро исчерпывает физическую память и уходит в своп.
- Сработал oomkiller
