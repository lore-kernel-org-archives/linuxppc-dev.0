MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Netconsole on 8260
Date: Thu, 1 Jul 2004 17:17:01 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DB1C@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
I am trying to get netconsole up and running on a 8260 kernel (2.6.7)

My problem is that the netconsile driver seems to start (and abort) way
too eraly for the 8260. The FCC ethernet drivcer is not initialized yet,
so the netconsiole driver aborts because it cannot find the ethernet
device.

Anybody know how to delay the startup of the netconsole driver to after
FCC ethernets are up?

Linux version 2.6.7 (runet@ernie.innovsys.com) (gcc version 3.2.2
20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1)) #21 Thu Jul 1 16:50:54
 CDT 2004
Innovative Systems LLC AP2 port
Using IDMA1 for MPC8260 device erratum PCI 9 workaround
On node 0 totalpages: 131072
  DMA zone: 131072 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: netconsole=6665@172.23.11.125/eth1,@172.23.14.39/
root=/dev/hda3 rw ip=172.23.11.125:172.23.14.39:172.23.8.150:
255.255.248.0:gold4_cpu1:eth1:none
netconsole: local port 6665
netconsole: local IP 172.23.11.125
netconsole: interface eth1
netconsole: remote port 6666
netconsole: remote IP 172.23.14.39
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
PID hash table entries: 4096 (order 12: 32768 bytes)
Warning: real time clock seems stuck!
Memory: 517248k available (1724k kernel code, 448k data, 268k init, 0k
highmem)
Calibrating delay loop... 192.00 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
PCI: Cannot allocate resource region 1 of device 0000:00:00.0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
netconsole: eth1 doesn't exist, aborting.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
