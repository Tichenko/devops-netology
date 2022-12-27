* 1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP.

* Username: rviews
route-views> show ip route 46.241.9.2
Routing entry for 46.241.0.0/17
  Known via "bgp 6447", distance 20, metric 0
  Tag 6939, type external
  Last update from 64.71.137.241 3w5d ago
  Routing Descriptor Blocks:
  * 64.71.137.241, from 64.71.137.241, 3w5d ago
      Route metric is 0, traffic share count is 1
      AS Hops 3
      Route tag 6939
      MPLS label: none

 * route-views> show ip route | i 46.241.0.0
B        46.241.0.0/17 [20/0] via 64.71.137.241, 3w5d
B     146.241.0.0/16 [20/0] via 217.192.89.50, 5w6d

* route-views> show ip route | i 46.241.0.0
B        46.241.0.0/17 [20/0] via 64.71.137.241, 3w5d
B     146.241.0.0/16 [20/0] via 217.192.89.50, 5w6d
route-views>show bgp 46.241.9.2
BGP routing table entry for 46.241.0.0/17, version 2588539228
Paths: (22 available, best #21, table default)
  Not advertised to any peer
  Refresh Epoch 1
  3333 1273 20485 21127, (aggregated by 21127 10.7.54.252)
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 1273:12276 1273:30000 20485:10054 20485:65102
      path 7FE16FEDA620 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20912 3257 3356 20485 21127, (aggregated by 21127 10.7.54.252)
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 3257:8070 3257:30515 3257:50001 3257:53900 3257:53902 20912:65004
      path 7FE03EC83F68 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  53767 14315 174 1299 20485 21127, (aggregated by 21127 10.7.54.252)
    162.251.163.2 from 162.251.163.2 (162.251.162.3)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 14315:5000 53767:5000
      path 7FE0EB503488 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  19214 3257 3356 20485 21127, (aggregated by 21127 10.7.54.252)
    208.74.64.40 from 208.74.64.40 (208.74.64.40)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 3257:8108 3257:30048 3257:50002 3257:51200 3257:51203
      path 7FE1226D8A88 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  49788 12552 20485 21127, (aggregated by 21127 10.7.54.252)
    91.218.184.60 from 91.218.184.60 (91.218.184.60)
      Origin IGP, localpref 100, valid, external, atomic-aggregate
      Community: 12552:12000 12552:12600 12552:12601 12552:22000
      Extended Community: 0x43:100:0
      path 7FE0FFF93878 RPKI State valid
      rx pathid: 0, tx pathid: 0
 
* 2.Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

* Ответ: vagrant@vagrant:~$ sudo ip link add dummy0 tyre dummy
*        vagrant@vagrant:~$ sudo ip link set dummyo up
*        vagrant@vagrant:~$ sudo ip address add 192.168.100.1/24 dev dummyo
*        vagrant@vagrant:~$ ip link show
* 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
* 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:a2:6b:fd brd ff:ff:ff:ff:ff:ff
* vagrant@vagrant:~$ ip route show
default via 10.0.2.2 dev eth0 proto dhcp src 10.0.2.15 metric 100
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15
10.0.2.2 dev eth0 proto dhcp scope link src 10.0.2.15 metric 100
* vagrant@vagrant:~$


* 3.Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

* Ответ: vagrant@vagrant:~$ sudo ss -tulpn
Netid  State   Recv-Q  Send-Q    Local Address:Port      Peer Address:Port  Process
udp    UNCONN  0       0             127.0.0.1:8125           0.0.0.0:*      users:(("netdata",pid=1504,fd=15))
udp    UNCONN  0       0         127.0.0.53%lo:53             0.0.0.0:*      users:(("systemd-resolve",pid=612,fd=12))
udp    UNCONN  0       0        10.0.2.15%eth0:68             0.0.0.0:*      users:(("systemd-network",pid=610,fd=19))
tcp    LISTEN  0       4096          127.0.0.1:8125           0.0.0.0:*      users:(("netdata",pid=1504,fd=16))
tcp    LISTEN  0       4096          127.0.0.1:19999          0.0.0.0:*      users:(("netdata",pid=1504,fd=4))
tcp    LISTEN  0       4096      127.0.0.53%lo:53             0.0.0.0:*      users:(("systemd-resolve",pid=612,fd=13))
tcp    LISTEN  0       128             0.0.0.0:22             0.0.0.0:*      users:(("sshd",pid=696,fd=3))
tcp    LISTEN  0       128                [::]:22                [::]:*      users:(("sshd",pid=696,fd=4))

* vagrant@vagrant:~$ ss -t -a
State        Recv-Q       Send-Q              Local Address:Port                 Peer Address:Port        Process
LISTEN       0            4096                    127.0.0.1:8125                      0.0.0.0:*
LISTEN       0            4096                    127.0.0.1:19999                     0.0.0.0:*
LISTEN       0            4096                127.0.0.53%lo:domain                    0.0.0.0:*
LISTEN       0            128                       0.0.0.0:ssh                       0.0.0.0:*
ESTAB        0            0                       10.0.2.15:ssh                      10.0.2.2:62634
LISTEN       0            128                          [::]:ssh                          [::]:*

* SSH-22 порт
* DNS -53 порт

* 4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения ис* пользуют эти порты?

* Ответ: vagrant@vagrant:~$ ss -u -a
State        Recv-Q       Send-Q               Local Address:Port                 Peer Address:Port       Process
UNCONN       0            0                        127.0.0.1:8125                      0.0.0.0:*
UNCONN       0            0                    127.0.0.53%lo:domain                    0.0.0.0:*
UNCONN       0            0                   10.0.2.15%eth0:bootpc                    0.0.0.0:*

* 53 прт dns
* 68 порт bootpc

* 5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

* Ответ: https://docs.google.com/document/d/1-dRkRU14_Rk5DsnDkORWGgGXcclEiv7h7o7VV3mIlqA/edit

