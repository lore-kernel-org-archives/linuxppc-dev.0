Message-ID: <903E17B6FF22A24C96B4E28C2C0214D70146BE0E@sr-bng-exc01.int.tsbu.net>
From: "Hegde, Ashok" <Ashok.Hegde@fci.com>
To: "'invictus rm'" <invictus_rm@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: SMP support problem with NFS mounting
Date: Thu, 1 Jan 2004 10:59:40 +0530 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks again,
Sorry for limited description.

	I am facing problem while making root file system on NFS.
I am able to boot when I download file system in to ram(In this case root
file system will reside in ram).
And even able to mount NFS manually once it boot's up.

Need to take care of SMP in nfsroot.c file????????

Here is the dump, where it hang.

PowerBoot>  go 1000000
GO at address 0xMemory BAT mapping: BAT2=256Mb, BAT3=256Mb, residual: 0Mb
Total memory = 512MB; using 1024kB for hash table (at c0300000)
Linux version 2.4.18_mvl30 (ashok@idc_linux_bld01.in.fci.com) (gcc version
3.2.1
 20020930 (MontaVista)) #4 SMP Wed Dec 31 11:31:05 IST 2003
Force PPMC280 Development Board
Board Version: A/B.0
Force PPMC280 Development Board
On node 0 totalpages: 131072
zone(0): 131072 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,115200 root=/dev/nfs rw ip=on
mtdparts=0:3072
k(kernel),22528k(Ramdisk),39680k(JFFS2),-(VPD)
time_init: decrementer frequency = 33.250000 MHz
Calibrating delay loop... 996.14 BogoMIPS
Memory: 512228k available (1440k kernel code, 656k data, 188k init, 0k
highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
POSIX conformance testing by UNIFIX
Entering SMP Mode...
smp_ppmc280_CPU_two : Kicking CPU 1...done
Bats cpu1:
f200002a
f2000006
f100002a
f100001e
00000012
c0001ffe
10000012
d0001ffe
cpu1- SPRN_L2CR 80000000
cpu1- SPRN_L3CR 00000000
cpu1- SPRN_HID0 8490c0bc
cpu1- SPRN_HID1 80002080
cpu1- SPRN_MSSCR0 00108000
cpu1- SPRN_MSSSR0 00000000
cpu1- SPRN_ICTRL 00000000
cpu1- SPRN_LDSTR 00000000
cpu1- SPRN_ICTC 00000000
cpu1- SPRN_SDR1 0030000f
Ticks per Jifa = 332500
Processor 1 found.
Bats cpu0:
f200002a
f2000006
f100002a
f100001e
00000012
c0001ffe
10000012
d0001ffe
cpu0- SPRN_L2CR 80000000
cpu0- SPRN_L3CR 00000000
cpu0- SPRN_HID0 8490c0bc
cpu0- SPRN_HID1 80002080
cpu0- SPRN_MSSCR0 00108000
cpu0- SPRN_MSSSR0 00000000
cpu0- SPRN_ICTRL 00000000
cpu0- SPRN_LDSTR 00000000
cpu0- SPRN_ICTC 00000000
cpu0- SPRN_SDR1 0030000f
Ticks per Jifa = 332500
smp_software_tb_sync: 4 passes, final offset: 6
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 4 of device 00:00.0
PCI: Cannot allocate resource region 4 of device 00:00.1
PCI: Cannot allocate resource region 0 of device 00:00.2
PCI: Cannot allocate resource region 2 of device 00:00.2
PCI: Cannot allocate resource region 4 of device 00:00.3
PCI: Cannot allocate resource region 5 of device 00:00.4
PCI: Cannot allocate resource region 0 of device 00:08.0
PCI: Cannot allocate resource region 4 of device 00:08.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis
Communications
 AB.
i2c-core.o: i2c core module version 2.6.2 (20011118)
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 4.3.2-k1
Copyright (c) 1999-2002 Intel Corporation.
boardflash: 0x2000000 at 0xa0000000
boardflash: 0x2000000 at 0xa2000000
Concatenating MTD devices:
(0): "PPMC280 flash 1"
(1): "PPMC280 flash 2"
into device "PPMC280 Flash Banks #0 and #1"
Using command line partition definition
Creating 4 MTD partitions on "PPMC280 Flash Banks #0 and #1":
0x00000000-0x00300000 : "kernel"
0x00300000-0x01900000 : "Ramdisk"
0x01900000-0x03fc0000 : "JFFS2"
0x03fc0000-0x04000000 : "VPD"
 bootflash: 0x800000 at 0xff800000
Found: AMD AM29LV008BB
PPMC280 bootflash: Found 1 x8 devices at 0x0 in 8-bit mode
number of JEDEC chips: 1
i2c-algo-mv64360: I2C MV64360 Module
AT24C64 EEPROM detected.
Intializing AT24CXX eeprom driver.
Initializing MAX9600 RTC driver.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
mv64360_eth_open : Assigned IRQ 32 to MV64360_eth0
mv64360_eth_open : Assigned IRQ 76 to MV64360_eth0
eth0: Ethernet port changed link status to DOWN
eth0: Ethernet port changed link status to DOWN
Finished opening device
eth0: Device exited promiscuous mode
eth0: Device exited promiscuous mode
mv64360_eth_open : Assigned IRQ 33 to MV64360_eth1
mv64360_eth_open : Assigned IRQ 77 to MV64360_eth1
eth0: Ethernet port changed link status to DOWN
eth1: Ethernet port changed link status to DOWN
eth1: Ethernet port changed link status to DOWN
Finished opening device
eth1: Device exited promiscuous mode
eth1: Device exited promiscuous mode
Sending DHCP requests .<5>eth0: Ethernet status : Link up, Full Duplex,
Speed 10
0 Mbps
eth0: Ethernet status : Link up, Full Duplex, Speed 100 Mbps
., OK
IP-Config: Got DHCP answer from 10.208.17.11, my address is 10.208.17.3
eth1: Device exited promiscuous mode
eth1: Clearing previously allocated TX queues... Done
eth1: Clearing previously allocated RX queues... Done
eth0: Device exited promiscuous mode
IP-Config: Complete:
      device=eth0, addr=10.208.17.3, mask=255.255.255.0, gw=255.255.255.255,
     host=10.208.17.3, domain=, nis-domain=(none),
     bootserver=10.208.17.11, rootserver=10.208.17.11,
rootpath=/home/ashok/ramd
isk/
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.208.17.11
Looking up port of RPC 100005/1 on 10.208.17.11
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 188k init
INIT: version 2.78 booting
Activating swap...
Calculating module dependencies... depmod: Can't open
/lib/modules/2.4.18_mvl30/
modules.dep for writing
done.
Loading modules:
modprobe: Can't open dependencies file /lib/modules/2.4.18_mvl30/modules.dep
(No
 such file or directory)
Checking all file systems...
Parallelizing fsck version 1.18 (11-Nov-1999)
Setting kernel variables.
Loading the saved-state of the serial devices...
Mounting local filesystems...
shm on /var/shm type shm (rw)
Running dns-clean.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces: done.
Starting portmap daemon: portmap.
Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... done.

--------------------------
Thanks,
Ashok

-----Original Message-----
From: invictus rm [mailto:invictus_rm@hotmail.com]
Sent: Wednesday, December 31, 2003 2:42 PM
Subject: RE: SMP support problem with NFS mounting

Just a shot in the dark.
   Ur limited description points to the cache / TLB related issues .

    What happens if you do cache flushing / TLB invalidation on each
task switch ?
    Does Moto claims it be working for SMP kernels ?

>From: "Hegde, Ashok" <Ashok.Hegde@fci.com>
>Subject: RE: SMP support problem with NFS mounting
>Date: Wed, 31 Dec 2003 11:38:51 +0530
>
>Thanks a lot for your instant reply. I turned off Altivec Support,
>Still same problem. Any thing else to look in to??
>
>-----Original Message-----
>From: invictus rm [mailto:invictus_rm@hotmail.com]
>Sent: Tuesday, December 30, 2003 6:58 PM
>Subject: RE: SMP support problem with NFS mounting
>
>Can u try turning off the Altivec Support ?
> >From: "Hegde, Ashok" <Ashok.Hegde@fci.com>
> >Subject: SMP support problem with NFS mounting
> >Date: Tue, 30 Dec 2003 16:48:02 +0530
> >
> >  There is a problem with supporting NFS mounting in SMP(Symmetric
> >MultiProcessor) mode for MPC 7447 processor(with controller MV 64360)
> >based PMC board(We tried with Kernel.org-2.4.20 and MontaVista-2.4.18
> >flavours). It will hang after giving message "Initializing random
> >number generator... done."
> >
> >   { It works fine Without NFS support and Single CPU with NFS }
> >
> >  What I need to look into?????

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
