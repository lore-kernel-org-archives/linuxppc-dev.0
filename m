Message-ID: <003101c13bc9$b09b0820$2000a8c0@private>
From: =?ks_c_5601-1987?B?wLG1v7yu?= <manulsan@daintelecom.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Sandpoint8240 Linux porting
Date: Thu, 13 Sep 2001 05:29:54 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear

I am working custom 8240Board. I started with Sandpoint8240 LSP at HHL2.0
I faced problem with OpenPIC interrupt setting. At Sandpoint8240 LSP use 8259
but I don't use 8259 interrupt controller so I want to remove the codes.
Could you let me know  how to map Interrupt controller ?
I would like to use external Intterrupt like followings

INT#0 : not useed
INT#1 : Ethernet Dec21... chip
INT#2 : Not Used
INT#3 : Not Used
INT#4 : Serial Console

I am attatching Serial Console Output

== Output ==
it any key to stop autoboot:  0
eth0: DC21143 Ethernet adapter(bus=0, device=13, func=0)
DEC Ethernet iobase=0x80000000
ARP broadcast 1
TFTP from server 192.168.0.39; our IP address is 192.168.0.118
Filename 'vmlinux.img'.
Load address: 0x900000
Loading: #######################################################################
#################################
done
Bytes transferred = 530707 (81913 hex)
eth_halt
## Booting image at 00900000 ...
   Image Name:   vmlinux.bin.gz
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    530643 Bytes = 518 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
7ffec0  0  0  7fff00
id mach(): doneMMU:enterMMU:hash inithash:enterhash:find piecehash:doneMMU:mapin
MMU:setbatMMU:exitsetup_arch: enterinitial cmd_line
====
copied  cmd_line
console=ttyS0,115200 ip=192.168.0.118:192.168.0.39:192.168.0.5:255.255.255.0:mou
sse:eth0: root=/dev/nfs rw nfsroot=/opt/hardhat/devkit/ppc/82xx/target, timeout=
200, retrans=500 nfsaddrs=192.168.0.118:192.168.0.39 ====
setup_arch: bootmemmpc10x:entermpc10x:exitarch: exitopenpic enterOpenPIC Addr =
f7fd0000
1.2openpic timeropenpic extopenpic spuriousopenpic exitTotal memory = 64MB; usin
g 0kB for hash table (at 00000000)
Linux version 2.4.2_hhl20 (root@localhost.localdomain) (gcc version 2.95.3 20010
315 (release/MontaVista)) #325 수 9월 12 17:06:44 KST 2001
Motorola SPS Sandpoint Test Platform
Sandpoint port (C) 2000, 2001 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,115200 ip=192.168.0.118:192.168.0.39:192.168.
0.5:255.255.255.0:mousse:eth0: root=/dev/nfs rw nfsroot=/opt/hardhat/devkit/ppc/
82xx/target, timeout=200, retrans=500 nfsaddrs=192.168.0.118:192.168.0.39
 sandpoint_init_IRQ
OpenPIC Version 1.2 (1 CPUs and 24 IRQ sources) at f7fd0000
setup_irq() at irq.c  required irq = 11
time_init: decrementer frequency = 16.501597 MHz
 sandpint_get_irq  = 7f
do_IRQ : irq.c   irq = ffffffff
Calibrating delay loop... 131.89 BogoMIPS
Memory: 62924k available (964k kernel code, 400k data, 72k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
 pci_init function
             sandpoint_init2()    Skipped....        (dsyoon)
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
block: queued sectors max/low 41749kB/13916kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ena
bled
ttyS00 at 0x1e08080 (irq = 4) is a ST16650
Linux Tulip driver version 0.9.13a (January 20, 2001)
eth0: Digital DS21143 Tulip rev 65 at 0xbfff80, EEPROM not present, 00:4C:69:6E:
75:79, IRQ 16.
eth0:  Missing EEPROM, this interface may not work correctly!
eth0:  MII transceiver #0 config 3000 status 7829 advertising 01e1.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
setup_irq() at irq.c  required irq = 10
 sandpint_get_irq  = 11
do_IRQ : irq.c   irq = 7
 sandpint_get_irq  = 11
do_IRQ : irq.c   irq = 7
ppc_irq_dispatcher_handler ,,,,,,,,,, NR_IRQS = 100
 no action


=================


E-mail  : manulsan@daintelecom.com
Mobil   : 016-208-9568
Fax     : 82-2-581-2805

인생의 바다, 우린 작은 돗단배를 타고 여행을 한다
아직 항구에  정박 중인 배, 서로 경쟁하며 거센 파도
헤치고 나아가는 배. 갈길 몰라 방황하는 배..........
당신은 어느 배를 타고 있나요  ?



를

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
