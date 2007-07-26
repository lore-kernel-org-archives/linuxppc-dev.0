Return-Path: <ma.harounansari@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 7D204DDE10
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jul 2007 16:56:06 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 9F97F8780E4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jul 2007 23:55:50 -0700 (PDT)
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id CF3E2878078
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jul 2007 23:55:49 -0700 (PDT)
Message-ID: <000801c7cf51$f98ebb90$9503a8c0@Ansari>
From: "Ansari" <ma.harounansari@gdatech.co.in>
To: <linuxppc-embedded@ozlabs.org>
Subject: Reboot Command Makes kernel to hang (MPC8560)
Date: Thu, 26 Jul 2007 12:25:38 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0005_01C7CF80.1308DD20"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C7CF80.1308DD20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

Processor (MPC8560)

Whenever reboot command is given in the linux console. The processor =
gets reset and it loads bootloader , kernel and when uncompressing the =
ramdisk it gets hang. The sample log is given below. Any u please tell =
me what are the factors that can makes this to happen.

Log=20
----

070500 U-Boot 1.1.2 (May 30 2007 - 20:20:09)

Motorola PowerPC ProcessorID=3D00000000 Rev. PVR=3D80200020
Board: XXX MPC8560 [PowerQUICC III]
        CPU: 660 MHz
        CCB: 330 MHz
        DDR: 165 MHz
Performing version scanning
I2C:   ready
DRAM:  Configuring UPM for NAND
Configuring UPM for MSC8122 DSI Port
Initializing DRAM
    DDR: 256 MB
Relocating POST functions.
FLASH: 16 MB
L2 cache enabled: 256KB
In:    serial
Out:   serial
Err:   serial
Net:   MOTO ENET0: PHY is Intel LXT971A (1378e2)
MOTO ENET1: PHY is Intel LXT971A (1378e2)
MOTO ENET0, MOTO ENET1
POST I: Before relocation. <DEL> to start...   1=20
POST II: After relocation. <DEL> to start...   1=20
Micro Controller version 75
Hit any key to stop autoboot:  0=20
## Booting image at ffd00000 ...
   Image Name:   070500 Linux-cscpp
   Created:      2007-05-30  14:49:24 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    938254 Bytes =3D 916.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at ff000000 ...
   Image Name:   070500 cscpp-REL_7_5
   Created:      2007-05-30  14:51:09 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3543240 Bytes =3D  3.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0fc4e000, end 0ffaf0c8 ... OK
Memory CAM mapping: CAM0=3D256Mb, CAM1=3D0Mb, CAM2=3D0Mb residual: 0Mb
Linux version 2.4.20_mvlcge31-cscpp-7.5 (root@turing) (gcc version 3.3.1 =
(MontaVista 3.3.1-3.0.10.0300532 2003-12-24)) #1 Wed May 30 20:14:43 IST =
2007
max_pfn =3D 8192
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/ram rw console=3DttyS0,115200 ip=3Doff
OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) at fdf80000
time_init: decrementer frequency =3D 41.250000 MHz
hr_time_init: arch_to_nsec =3D 50840048, nsec_to_arch =3D 177167400
Calibrating delay loop... 658.63 BogoMIPS
Memory: 253056k available (1696k kernel code, 760k data, 68k init, 0k =
highmem)
RMON - kernel resource monitoring
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
LSP Revision 14
ikconfig 0.5 with /proc/ikconfig
Starting kswapd
Journalled Block Device driver loaded
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis =
Communications AB.
CPM UART driver version 0.01
ttyS0 on SCC1 at 0x8000, BRG1
pty: 256 Unix98 ptys configured
eth0: FCC ENET Version 0.3, 02:e0:0c:80:31:03
eth0: RMON initialized
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
eth1: Gianfar Ethernet Controller Version 1.0, 02:e0:0c:00:31:03=20
eth1: Running with NAPI disabled
eth1: 64/64 RX/TX BD ring size
eth1: RMON initialized
eth2: Gianfar Ethernet Controller Version 1.0, 02:e0:0c:00:31:02=20
eth2: Running with NAPI disabled
eth2: 64/64 RX/TX BD ring size
eth2: RMON initialized
network device driver for LKCD registered
Crash dump driver initialized.
CSC flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Creating 7 MTD partitions on "CSC flash":
0x00f80000-0x01000000 : "uboot"
0x00d00000-0x00e00000 : "kernel0"
0x00e00000-0x00f00000 : "kernel1"
0x00700000-0x00d00000 : "app"
0x00000000-0x00380000 : "root0"
0x00380000-0x00700000 : "root1"
0x00f00000-0x00f80000 : "env"
Creating 2 MTD partitions on "CSC NVRAM":
0x00000000-0x00010000 : "applog"
0x00010000-0x00020000 : "kernellog"
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xca (Unknown NAND 256MiB =
3,3V 16-bit)
Scanning device for bad blocks
Bad eraseblock 1780 at 0x0de80000
Creating 1 MTD partitions on "NAND 256MiB 3,3V 16-bit":
0x00000000-0x10000000 : "NAND Partition"
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (2048 buckets, 16384 max) - 296 bytes per =
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Event Broker Driver (C) 2001,2002 MontaVista Software =
(source@mvista.com)
Done starting sysfs
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 3460k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 68k init

Welcome to Linux Group

Starting system...
Mounting /proc: done.
Brining up loopback interface: done.
Mounting /tmp: done.
Starting syslogd: done.
Starting klogd: done.
Starting telnetd: done.

MC-I2C DRIVER Successfully Installed
mcc: mcc_dev_siram_entries_config: siram config: start entry: 0, start =
channel: 128, count: 64
mcc: mcc_dev_siram_entries_config: siram config: start entry: 128, start =
channel: 192, count: 64
mcc: mcc_dev_iopin_init: IO port init done
mcc: mcc_dev_clock_mux_init: clock mux init done 0x88
mcc: mcc_dev_init: Board specific init done.
mcc: mcc_dev_init: BDs init done
mcc: mcc_dev_init: global param init done
mcc: mcc_dev_init: extra channel param init done
mcc: mcc_dev_init: channel param init done
[: 1: unknown operand

DSP-7116: Driver registered.=20
DSP MSC 7116 Driver for HDI Interface May 30 2007  20:19:35
DSP-7116: Insmoded Successfully Default Status & Control Register 426 =
6618

MSC8122_DSI driver registered.=20
MSC8122_DSI Driver for DSI Interface May 30 2007  20:19:35DSI init...[2]
loading LSCL module...May 30 2007 ,20:19:36
scc  at 0x8100
sccp 0xd2575a20
priv size 176
dev name lscl0
scc1 clk 0x000100b2
device lscl0=20
lscl module loaded
Setting the LSCL address & IP address
setting slot id 0x0021
bonding.c:v2.2.5 (May 22, 2003)
bonding_init(): eth1 primary device specified but has no effect in =
fault-tolerance (broadcast) mode
bond0 registered with MII link monitoring set to 200 ms, in =
fault-tolerance (broadcast) mode.
bond0 registered without ARP monitoring
eth1: PHY is Intel LXT971A (1378e2)
eth1: No link detected
bond0: enslaving eth1 as an active interface with a down link.
eth1: Auto-negotiation done
eth1: Full Duplex
eth1: Speed 100BT
eth1: Link is up
eth2: PHY is Intel LXT971A (1378e2)
eth2: No link detected
bond0: enslaving eth2 as an active interface with a down link.
eth2: Auto-negotiation done
eth2: Full Duplex
eth2: Speed 100BT
eth2: Link is up
Setting system time from hardware clock.
yaffs: dev is 7945 name is "1f:09"
bond0: link status definitely up for interface eth2.
bond0: link status definitely up for interface eth1.
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000: =
0xd355 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000004: =
0xcf85 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000008: =
0x435c instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000000c: =
0xc451 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000010: =
0xb677 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000014: =
0x15f5 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000018: =
0xfbfb instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000001c: =
0x4491 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000020: =
0x543a instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000024: =
0x1193 instead
Further such events for this erase block will not be printed
Cowardly refusing to erase blocks on filesystem with no valid JFFS2 =
nodes
empty_blocks 0, bad_blocks 0, c->nr_blocks 16
mount: Mounting /dev/mtdblock7 on /mnt/app-nvram failed: Invalid =
argument
Punching Microcontroller.=20
Creating TSI LOCK fileDone
Starting the xxx agent

                 =3D=3D=3D=3D=3D=3D SYSTEM STARTED =3D=3D=3D=3D=3D=3D


System started

  _____  _   _  _    _      __ _       _                    =20
 / ____|| \ | || |  | |    / /| |     (_)                   =20
| |  __ |  \| || |  | |   / / | |      _  _ __   _   _ __  __
| | |_ || .   || |  | |  / /  | |     | || '_ \ | | | |\ \/ /
| |__| || |\  || |__| | / /   | |____ | || | | || |_| | >  <=20
 \_____||_| \_| \____/ /_/    |______||_||_| |_| \__,_|/_/\_\

(none) login: root


BusyBox v1.1.0 (2006.03.23-09:02+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

[root@(none) /root]# reboot

The system is going down NOW !!
Sending SIGTERM to all processeExiting Syslogd!
Sending SIGKILL to all processes.
Please stand by while rebooting the system.
Restarting systemste?

070500 U-Boot 1.1.2 (May 30 2007 - 20:20:09)

Motorola PowerPC ProcessorID=3D00000000 Rev. PVR=3D80200020
Board: XXX MPC8560 [PowerQUICC III]
        CPU: 660 MHz
        CCB: 330 MHz
        DDR: 165 MHz
Performing version scanning
I2C:   ready
DRAM:  Configuring UPM for NAND
Configuring UPM for MSC8122 DSI Port
Initializing DRAM
    DDR: 256 MB
Relocating POST functions.
FLASH: 16 MB
L2 cache enabled: 256KB
In:    serial
Out:   serial
Err:   serial
Net:   MOTO ENET0: PHY is Intel LXT971A (1378e2)
MOTO ENET1: PHY is Intel LXT971A (1378e2)
MOTO ENET0, MOTO ENET1
POST I: Before relocation. <DEL> to start...   1=20
POST II: After relocation. <DEL> to start...   1=20
Micro Controller version 75
Hit any key to stop autoboot:  0=20
## Booting image at ffd00000 ...
   Image Name:   070500 Linux-cscpp
   Created:      2007-05-30  14:49:24 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    938254 Bytes =3D 916.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at ff000000 ...
   Image Name:   070500 cscpp-REL_7_5
   Created:      2007-05-30  14:51:09 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3543240 Bytes =3D  3.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0fc4e000, end 0ffaf0c8 ... OK
Memory CAM mapping: CAM0=3D256Mb, CAM1=3D0Mb, CAM2=3D0Mb residual: 0Mb
Linux version 2.4.20_mvlcge31-cscpp-7.5 (root@turing) (gcc version 3.3.1 =
(MontaVista 3.3.1-3.0.10.0300532 2003-12-24)) #1 Wed May 30 20:14:43 IST =
2007
max_pfn =3D 8192
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/ram rw console=3DttyS0,115200 ip=3Doff
OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) at fdf80000
time_init: decrementer frequency =3D 41.250000 MHz
hr_time_init: arch_to_nsec =3D 50840048, nsec_to_arch =3D 177167400
Calibrating delay loop... 658.63 BogoMIPS
Memory: 253056k available (1696k kernel code, 760k data, 68k init, 0k =
highmem)
RMON - kernel resource monitoring
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
LSP Revision 14
ikconfig 0.5 with /proc/ikconfig
Starting kswapd
Journalled Block Device driver loaded
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis =
Communications AB.
CPM UART driver version 0.01
ttyS0 on SCC1 at 0x8000, BRG1
pty: 256 Unix98 ptys configured
eth0: FCC ENET Version 0.3, 02:e0:0c:80:31:03
eth0: RMON initialized
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
eth1: Gianfar Ethernet Controller Version 1.0, 02:e0:0c:00:31:03=20
eth1: Running with NAPI disabled
eth1: 64/64 RX/TX BD ring size
eth1: RMON initialized
eth2: Gianfar Ethernet Controller Version 1.0, 02:e0:0c:00:31:02=20
eth2: Running with NAPI disabled
eth2: 64/64 RX/TX BD ring size
eth2: RMON initialized
network device driver for LKCD registered
Crash dump driver initialized.
CSC flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Creating 7 MTD partitions on "CSC flash":
0x00f80000-0x01000000 : "uboot"
0x00d00000-0x00e00000 : "kernel0"
0x00e00000-0x00f00000 : "kernel1"
0x00700000-0x00d00000 : "app"
0x00000000-0x00380000 : "root0"
0x00380000-0x00700000 : "root1"
0x00f00000-0x00f80000 : "env"
Creating 2 MTD partitions on "CSC NVRAM":
0x00000000-0x00010000 : "applog"
0x00010000-0x00020000 : "kernellog"
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xca (Unknown NAND 256MiB =
3,3V 16-bit)
Scanning device for bad blocks
Bad eraseblock 1780 at 0x0de80000
Creating 1 MTD partitions on "NAND 256MiB 3,3V 16-bit":
0x00000000-0x10000000 : "NAND Partition"
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (2048 buckets, 16384 max) - 296 bytes per =
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Event Broker Driver (C) 2001,2002 MontaVista Software =
(source@mvista.com)
Done starting sysfs
RAMDISK: Compressed image found at block 0
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Ha=
ngs Here>>>>>>>>>>>>>>>>>>>>>>


Thanks in advance

Haroun Ansari M A


------=_NextPart_000_0005_01C7CF80.1308DD20
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16481" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi all,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Processor (MPC8560)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Whenever reboot command is given in the =
linux=20
console. The processor gets reset and it loads bootloader , kernel and =
when=20
uncompressing the ramdisk it gets hang. The sample log is given below. =
Any u=20
please tell me what are the factors that can makes this to =
happen.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Log <BR>----</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>070500 U-Boot 1.1.2 (May 30 2007 -=20
20:20:09)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Motorola PowerPC ProcessorID=3D00000000 =
Rev.=20
PVR=3D80200020<BR>Board: XXX MPC8560 [PowerQUICC=20
III]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU: 660=20
MHz<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CCB: 330=20
MHz<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DDR: 165 =
MHz<BR>Performing=20
version scanning<BR>I2C:&nbsp;&nbsp; ready<BR>DRAM:&nbsp; Configuring =
UPM for=20
NAND<BR>Configuring UPM for MSC8122 DSI Port<BR>Initializing=20
DRAM<BR>&nbsp;&nbsp;&nbsp; DDR: 256 MB<BR>Relocating POST =
functions.<BR>FLASH:=20
16 MB<BR>L2 cache enabled: 256KB<BR>In:&nbsp;&nbsp;&nbsp;=20
serial<BR>Out:&nbsp;&nbsp; serial<BR>Err:&nbsp;&nbsp; =
serial<BR>Net:&nbsp;&nbsp;=20
MOTO ENET0: PHY is Intel LXT971A (1378e2)<BR>MOTO ENET1: PHY is Intel =
LXT971A=20
(1378e2)<BR>MOTO ENET0, MOTO ENET1<BR>POST I: Before relocation. =
&lt;DEL&gt; to=20
start...&nbsp;&nbsp; 1 <BR>POST II: After relocation. &lt;DEL&gt; to=20
start...&nbsp;&nbsp; 1 <BR>Micro Controller version 75<BR>Hit any key to =
stop=20
autoboot:&nbsp; 0 <BR>## Booting image at ffd00000 ...<BR>&nbsp;&nbsp; =
Image=20
Name:&nbsp;&nbsp; 070500 Linux-cscpp<BR>&nbsp;&nbsp;=20
Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2007-05-30&nbsp; 14:49:24=20
UTC<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image =
(gzip=20
compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 938254 Bytes =
=3D 916.3=20
kB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry =
Point:&nbsp;=20
00000000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp; =
Uncompressing=20
Kernel Image ... OK<BR>## Loading RAMDisk Image at ff000000 =
...<BR>&nbsp;&nbsp;=20
Image Name:&nbsp;&nbsp; 070500 cscpp-REL_7_5<BR>&nbsp;&nbsp;=20
Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2007-05-30&nbsp; 14:51:09=20
UTC<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image =
(gzip=20
compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 3543240 Bytes =
=3D&nbsp;=20
3.4 MB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry =
Point:&nbsp;=20
00000000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp; =
Loading=20
Ramdisk to 0fc4e000, end 0ffaf0c8 ... OK<BR>Memory CAM mapping: =
CAM0=3D256Mb,=20
CAM1=3D0Mb, CAM2=3D0Mb residual: 0Mb<BR>Linux version =
2.4.20_mvlcge31-cscpp-7.5 (<A=20
href=3D"mailto:root@turing">root@turing</A>) (gcc version 3.3.1 =
(MontaVista=20
3.3.1-3.0.10.0300532 2003-12-24)) #1 Wed May 30 20:14:43 IST =
2007<BR>max_pfn =3D=20
8192<BR>On node 0 totalpages: 65536<BR>zone(0): 65536 pages.<BR>zone(1): =
0=20
pages.<BR>zone(2): 0 pages.<BR>Kernel command line: root=3D/dev/ram rw=20
console=3DttyS0,115200 ip=3Doff<BR>OpenPIC Version 1.2 (1 CPUs and 44 =
IRQ sources)=20
at fdf80000<BR>time_init: decrementer frequency =3D 41.250000 =
MHz<BR>hr_time_init:=20
arch_to_nsec =3D 50840048, nsec_to_arch =3D 177167400<BR>Calibrating =
delay loop...=20
658.63 BogoMIPS<BR>Memory: 253056k available (1696k kernel code, 760k =
data, 68k=20
init, 0k highmem)<BR>RMON - kernel resource monitoring<BR>Dentry cache =
hash=20
table entries: 32768 (order: 6, 262144 bytes)<BR>Inode cache hash table =
entries:=20
16384 (order: 5, 131072 bytes)<BR>Mount-cache hash table entries: 4096 =
(order:=20
3, 32768 bytes)<BR>Buffer-cache hash table entries: 16384 (order: 4, =
65536=20
bytes)<BR>Page-cache hash table entries: 65536 (order: 6, 262144 =
bytes)<BR>POSIX=20
conformance testing by UNIFIX<BR>Linux NET4.0 for Linux 2.4<BR>Based =
upon=20
Swansea University Computer Society NET3.039<BR>Initializing RT netlink=20
socket<BR>LSP Revision 14<BR>ikconfig 0.5 with =
/proc/ikconfig<BR>Starting=20
kswapd<BR>Journalled Block Device driver loaded<BR>JFFS version 1.0, (C) =
1999,=20
2000&nbsp; Axis Communications AB<BR>JFFS2 version 2.1. (C) 2001, 2002 =
Red Hat,=20
Inc., designed by Axis Communications AB.<BR>CPM UART driver version=20
0.01<BR>ttyS0 on SCC1 at 0x8000, BRG1<BR>pty: 256 Unix98 ptys=20
configured<BR>eth0: FCC ENET Version 0.3, 02:e0:0c:80:31:03<BR>eth0: =
RMON=20
initialized<BR>RAMDISK driver initialized: 16 RAM disks of 32768K size =
1024=20
blocksize<BR>loop: loaded (max 8 devices)<BR>eth1: Gianfar Ethernet =
Controller=20
Version 1.0, 02:e0:0c:00:31:03 <BR>eth1: Running with NAPI =
disabled<BR>eth1:=20
64/64 RX/TX BD ring size<BR>eth1: RMON initialized<BR>eth2: Gianfar =
Ethernet=20
Controller Version 1.0, 02:e0:0c:00:31:02 <BR>eth2: Running with NAPI=20
disabled<BR>eth2: 64/64 RX/TX BD ring size<BR>eth2: RMON =
initialized<BR>network=20
device driver for LKCD registered<BR>Crash dump driver =
initialized.<BR>CSC=20
flash: Found 1 x16 devices at 0x0 in 16-bit bank<BR>&nbsp;Intel/Sharp =
Extended=20
Query Table at 0x0031<BR>Using buffer write method<BR>cfi_cmdset_0001: =
Erase=20
suspend on write enabled<BR>Creating 7 MTD partitions on "CSC=20
flash":<BR>0x00f80000-0x01000000 : "uboot"<BR>0x00d00000-0x00e00000 :=20
"kernel0"<BR>0x00e00000-0x00f00000 : "kernel1"<BR>0x00700000-0x00d00000 =
:=20
"app"<BR>0x00000000-0x00380000 : "root0"<BR>0x00380000-0x00700000 :=20
"root1"<BR>0x00f00000-0x00f80000 : "env"<BR>Creating 2 MTD partitions on =
"CSC=20
NVRAM":<BR>0x00000000-0x00010000 : "applog"<BR>0x00010000-0x00020000 :=20
"kernellog"<BR>NAND device: Manufacturer ID: 0x2c, Chip ID: 0xca =
(Unknown NAND=20
256MiB 3,3V 16-bit)<BR>Scanning device for bad blocks<BR>Bad eraseblock =
1780 at=20
0x0de80000<BR>Creating 1 MTD partitions on "NAND 256MiB 3,3V=20
16-bit":<BR>0x00000000-0x10000000 : "NAND Partition"<BR>NET4: Linux =
TCP/IP 1.0=20
for NET4.0<BR>IP Protocols: ICMP, UDP, TCP, IGMP<BR>IP: routing cache =
hash table=20
of 2048 buckets, 16Kbytes<BR>TCP: Hash tables configured (established =
16384 bind=20
32768)<BR>ip_conntrack version 2.1 (2048 buckets, 16384 max) - 296 bytes =
per=20
conntrack<BR>ip_tables: (C) 2000-2002 Netfilter core team<BR>NET4: Unix =
domain=20
sockets 1.0/SMP for Linux NET4.0.<BR>Event Broker Driver (C) 2001,2002=20
MontaVista Software (<A=20
href=3D"mailto:source@mvista.com">source@mvista.com</A>)<BR>Done =
starting=20
sysfs<BR>RAMDISK: Compressed image found at block 0<BR>Freeing initrd =
memory:=20
3460k freed<BR>VFS: Mounted root (ext2 filesystem).<BR>Freeing unused =
kernel=20
memory: 68k init</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Welcome to Linux Group</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Starting system...<BR>Mounting /proc:=20
done.<BR>Brining up loopback interface: done.<BR>Mounting /tmp:=20
done.<BR>Starting syslogd: done.<BR>Starting klogd: done.<BR>Starting =
telnetd:=20
done.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>MC-I2C DRIVER Successfully =
Installed<BR>mcc:=20
mcc_dev_siram_entries_config: siram config: start entry: 0, start =
channel: 128,=20
count: 64<BR>mcc: mcc_dev_siram_entries_config: siram config: start =
entry: 128,=20
start channel: 192, count: 64<BR>mcc: mcc_dev_iopin_init: IO port init=20
done<BR>mcc: mcc_dev_clock_mux_init: clock mux init done 0x88<BR>mcc:=20
mcc_dev_init: Board specific init done.<BR>mcc: mcc_dev_init: BDs init=20
done<BR>mcc: mcc_dev_init: global param init done<BR>mcc: mcc_dev_init: =
extra=20
channel param init done<BR>mcc: mcc_dev_init: channel param init =
done<BR>[: 1:=20
unknown operand</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>DSP-7116: Driver registered. <BR>DSP =
MSC 7116=20
Driver for HDI Interface May 30 2007&nbsp; 20:19:35<BR>DSP-7116: =
Insmoded=20
Successfully Default Status &amp; Control Register 426 6618</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>MSC8122_DSI driver registered. =
<BR>MSC8122_DSI=20
Driver for DSI Interface May 30 2007&nbsp; 20:19:35DSI =
init...[2]<BR>loading=20
LSCL module...May 30 2007 ,20:19:36<BR>scc&nbsp; at 0x8100<BR>sccp=20
0xd2575a20<BR>priv size 176<BR>dev name lscl0<BR>scc1 clk =
0x000100b2<BR>device=20
lscl0 <BR>lscl module loaded<BR>Setting the LSCL address &amp; IP=20
address<BR>setting slot id 0x0021<BR>bonding.c:v2.2.5 (May 22,=20
2003)<BR>bonding_init(): eth1 primary device specified but has no effect =
in=20
fault-tolerance (broadcast) mode<BR>bond0 registered with MII link =
monitoring=20
set to 200 ms, in fault-tolerance (broadcast) mode.<BR>bond0 registered =
without=20
ARP monitoring<BR>eth1: PHY is Intel LXT971A (1378e2)<BR>eth1: No link=20
detected<BR>bond0: enslaving eth1 as an active interface with a down=20
link.<BR>eth1: Auto-negotiation done<BR>eth1: Full Duplex<BR>eth1: Speed =

100BT<BR>eth1: Link is up<BR>eth2: PHY is Intel LXT971A =
(1378e2)<BR>eth2: No=20
link detected<BR>bond0: enslaving eth2 as an active interface with a =
down=20
link.<BR>eth2: Auto-negotiation done<BR>eth2: Full Duplex<BR>eth2: Speed =

100BT<BR>eth2: Link is up<BR>Setting system time from hardware =
clock.<BR>yaffs:=20
dev is 7945 name is "1f:09"<BR>bond0: link status definitely up for =
interface=20
eth2.<BR>bond0: link status definitely up for interface=20
eth1.<BR>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at =
0x00000000:=20
0xd355 instead<BR>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not =
found at=20
0x00000004: 0xcf85 instead<BR>jffs2_scan_eraseblock(): Magic bitmask =
0x1985 not=20
found at 0x00000008: 0x435c instead<BR>jffs2_scan_eraseblock(): Magic =
bitmask=20
0x1985 not found at 0x0000000c: 0xc451 =
instead<BR>jffs2_scan_eraseblock(): Magic=20
bitmask 0x1985 not found at 0x00000010: 0xb677=20
instead<BR>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at=20
0x00000014: 0x15f5 instead<BR>jffs2_scan_eraseblock(): Magic bitmask =
0x1985 not=20
found at 0x00000018: 0xfbfb instead<BR>jffs2_scan_eraseblock(): Magic =
bitmask=20
0x1985 not found at 0x0000001c: 0x4491 =
instead<BR>jffs2_scan_eraseblock(): Magic=20
bitmask 0x1985 not found at 0x00000020: 0x543a=20
instead<BR>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at=20
0x00000024: 0x1193 instead<BR>Further such events for this erase block =
will not=20
be printed<BR>Cowardly refusing to erase blocks on filesystem with no =
valid=20
JFFS2 nodes<BR>empty_blocks 0, bad_blocks 0, c-&gt;nr_blocks =
16<BR>mount:=20
Mounting /dev/mtdblock7 on /mnt/app-nvram failed: Invalid =
argument<BR>Punching=20
Microcontroller. <BR>Creating TSI LOCK fileDone<BR>Starting the xxx=20
agent</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
=3D=3D=3D=3D=3D=3D SYSTEM STARTED =3D=3D=3D=3D=3D=3D</FONT></DIV>
<DIV>&nbsp;</DIV><FONT face=3DArial size=3D2>
<DIV><BR>System started</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; _____&nbsp; _&nbsp;&nbsp; _&nbsp; _&nbsp;&nbsp;&nbsp;=20
_&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ _&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

_&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>&nbsp;/ ____|| \ | || |&nbsp; | |&nbsp;&nbsp;&nbsp; / /|=20
|&nbsp;&nbsp;&nbsp;&nbsp;=20
(_)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>| |&nbsp; __ |&nbsp; \| || |&nbsp; | |&nbsp;&nbsp; / / |=20
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _&nbsp; _ __&nbsp;&nbsp; _&nbsp;&nbsp; _ =

__&nbsp; __<BR>| | |_ || .&nbsp;&nbsp; || |&nbsp; | |&nbsp; / /&nbsp; |=20
|&nbsp;&nbsp;&nbsp;&nbsp; | || '_ \ | | | |\ \/ /<BR>| |__| || |\&nbsp; =
|| |__|=20
| / /&nbsp;&nbsp; | |____ | || | | || |_| | &gt;&nbsp; &lt; =
<BR>&nbsp;\_____||_|=20
\_| \____/ /_/&nbsp;&nbsp;&nbsp; |______||_||_| |_| \__,_|/_/\_\</DIV>
<DIV>&nbsp;</DIV>
<DIV>(none) login: root</DIV>
<DIV>&nbsp;</DIV>
<DIV><BR>BusyBox v1.1.0 (2006.03.23-09:02+0000) Built-in shell =
(ash)<BR>Enter=20
'help' for a list of built-in commands.</DIV>
<DIV>&nbsp;</DIV>
<DIV>[root@(none) /root]# reboot</DIV>
<DIV>&nbsp;</DIV>
<DIV>The system is going down NOW !!<BR>Sending SIGTERM to all =
processeExiting=20
Syslogd!<BR>Sending SIGKILL to all processes.<BR>Please stand by while =
rebooting=20
the system.<BR>Restarting systemste?</DIV>
<DIV>&nbsp;</DIV>
<DIV>070500 U-Boot 1.1.2 (May 30 2007 - 20:20:09)</DIV>
<DIV>&nbsp;</DIV>
<DIV>Motorola PowerPC ProcessorID=3D00000000 Rev. =
PVR=3D80200020<BR>Board: XXX=20
MPC8560 [PowerQUICC III]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CPU: 660=20
MHz<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CCB: 330=20
MHz<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DDR: 165 =
MHz<BR>Performing=20
version scanning<BR>I2C:&nbsp;&nbsp; ready<BR>DRAM:&nbsp; Configuring =
UPM for=20
NAND<BR>Configuring UPM for MSC8122 DSI Port<BR>Initializing=20
DRAM<BR>&nbsp;&nbsp;&nbsp; DDR: 256 MB<BR>Relocating POST =
functions.<BR>FLASH:=20
16 MB<BR>L2 cache enabled: 256KB<BR>In:&nbsp;&nbsp;&nbsp;=20
serial<BR>Out:&nbsp;&nbsp; serial<BR>Err:&nbsp;&nbsp; =
serial<BR>Net:&nbsp;&nbsp;=20
MOTO ENET0: PHY is Intel LXT971A (1378e2)<BR>MOTO ENET1: PHY is Intel =
LXT971A=20
(1378e2)<BR>MOTO ENET0, MOTO ENET1<BR>POST I: Before relocation. =
&lt;DEL&gt; to=20
start...&nbsp;&nbsp; 1 <BR>POST II: After relocation. &lt;DEL&gt; to=20
start...&nbsp;&nbsp; 1 <BR>Micro Controller version 75<BR>Hit any key to =
stop=20
autoboot:&nbsp; 0 <BR>## Booting image at ffd00000 ...<BR>&nbsp;&nbsp; =
Image=20
Name:&nbsp;&nbsp; 070500 Linux-cscpp<BR>&nbsp;&nbsp;=20
Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2007-05-30&nbsp; 14:49:24=20
UTC<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image =
(gzip=20
compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 938254 Bytes =
=3D 916.3=20
kB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry =
Point:&nbsp;=20
00000000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp; =
Uncompressing=20
Kernel Image ... OK<BR>## Loading RAMDisk Image at ff000000 =
...<BR>&nbsp;&nbsp;=20
Image Name:&nbsp;&nbsp; 070500 cscpp-REL_7_5<BR>&nbsp;&nbsp;=20
Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2007-05-30&nbsp; 14:51:09=20
UTC<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image =
(gzip=20
compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 3543240 Bytes =
=3D&nbsp;=20
3.4 MB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry =
Point:&nbsp;=20
00000000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp; =
Loading=20
Ramdisk to 0fc4e000, end 0ffaf0c8 ... OK<BR>Memory CAM mapping: =
CAM0=3D256Mb,=20
CAM1=3D0Mb, CAM2=3D0Mb residual: 0Mb<BR>Linux version =
2.4.20_mvlcge31-cscpp-7.5 (<A=20
href=3D"mailto:root@turing">root@turing</A>) (gcc version 3.3.1 =
(MontaVista=20
3.3.1-3.0.10.0300532 2003-12-24)) #1 Wed May 30 20:14:43 IST =
2007<BR>max_pfn =3D=20
8192<BR>On node 0 totalpages: 65536<BR>zone(0): 65536 pages.<BR>zone(1): =
0=20
pages.<BR>zone(2): 0 pages.<BR>Kernel command line: root=3D/dev/ram rw=20
console=3DttyS0,115200 ip=3Doff<BR>OpenPIC Version 1.2 (1 CPUs and 44 =
IRQ sources)=20
at fdf80000<BR>time_init: decrementer frequency =3D 41.250000 =
MHz<BR>hr_time_init:=20
arch_to_nsec =3D 50840048, nsec_to_arch =3D 177167400<BR>Calibrating =
delay loop...=20
658.63 BogoMIPS<BR>Memory: 253056k available (1696k kernel code, 760k =
data, 68k=20
init, 0k highmem)<BR>RMON - kernel resource monitoring<BR>Dentry cache =
hash=20
table entries: 32768 (order: 6, 262144 bytes)<BR>Inode cache hash table =
entries:=20
16384 (order: 5, 131072 bytes)<BR>Mount-cache hash table entries: 4096 =
(order:=20
3, 32768 bytes)<BR>Buffer-cache hash table entries: 16384 (order: 4, =
65536=20
bytes)<BR>Page-cache hash table entries: 65536 (order: 6, 262144 =
bytes)<BR>POSIX=20
conformance testing by UNIFIX<BR>Linux NET4.0 for Linux 2.4<BR>Based =
upon=20
Swansea University Computer Society NET3.039<BR>Initializing RT netlink=20
socket<BR>LSP Revision 14<BR>ikconfig 0.5 with =
/proc/ikconfig<BR>Starting=20
kswapd<BR>Journalled Block Device driver loaded<BR>JFFS version 1.0, (C) =
1999,=20
2000&nbsp; Axis Communications AB<BR>JFFS2 version 2.1. (C) 2001, 2002 =
Red Hat,=20
Inc., designed by Axis Communications AB.<BR>CPM UART driver version=20
0.01<BR>ttyS0 on SCC1 at 0x8000, BRG1<BR>pty: 256 Unix98 ptys=20
configured<BR>eth0: FCC ENET Version 0.3, 02:e0:0c:80:31:03<BR>eth0: =
RMON=20
initialized<BR>RAMDISK driver initialized: 16 RAM disks of 32768K size =
1024=20
blocksize<BR>loop: loaded (max 8 devices)<BR>eth1: Gianfar Ethernet =
Controller=20
Version 1.0, 02:e0:0c:00:31:03 <BR>eth1: Running with NAPI =
disabled<BR>eth1:=20
64/64 RX/TX BD ring size<BR>eth1: RMON initialized<BR>eth2: Gianfar =
Ethernet=20
Controller Version 1.0, 02:e0:0c:00:31:02 <BR>eth2: Running with NAPI=20
disabled<BR>eth2: 64/64 RX/TX BD ring size<BR>eth2: RMON =
initialized<BR>network=20
device driver for LKCD registered<BR>Crash dump driver =
initialized.<BR>CSC=20
flash: Found 1 x16 devices at 0x0 in 16-bit bank<BR>&nbsp;Intel/Sharp =
Extended=20
Query Table at 0x0031<BR>Using buffer write method<BR>cfi_cmdset_0001: =
Erase=20
suspend on write enabled<BR>Creating 7 MTD partitions on "CSC=20
flash":<BR>0x00f80000-0x01000000 : "uboot"<BR>0x00d00000-0x00e00000 :=20
"kernel0"<BR>0x00e00000-0x00f00000 : "kernel1"<BR>0x00700000-0x00d00000 =
:=20
"app"<BR>0x00000000-0x00380000 : "root0"<BR>0x00380000-0x00700000 :=20
"root1"<BR>0x00f00000-0x00f80000 : "env"<BR>Creating 2 MTD partitions on =
"CSC=20
NVRAM":<BR>0x00000000-0x00010000 : "applog"<BR>0x00010000-0x00020000 :=20
"kernellog"<BR>NAND device: Manufacturer ID: 0x2c, Chip ID: 0xca =
(Unknown NAND=20
256MiB 3,3V 16-bit)<BR>Scanning device for bad blocks<BR>Bad eraseblock =
1780 at=20
0x0de80000<BR>Creating 1 MTD partitions on "NAND 256MiB 3,3V=20
16-bit":<BR>0x00000000-0x10000000 : "NAND Partition"<BR>NET4: Linux =
TCP/IP 1.0=20
for NET4.0<BR>IP Protocols: ICMP, UDP, TCP, IGMP<BR>IP: routing cache =
hash table=20
of 2048 buckets, 16Kbytes<BR>TCP: Hash tables configured (established =
16384 bind=20
32768)<BR>ip_conntrack version 2.1 (2048 buckets, 16384 max) - 296 bytes =
per=20
conntrack<BR>ip_tables: (C) 2000-2002 Netfilter core team<BR>NET4: Unix =
domain=20
sockets 1.0/SMP for Linux NET4.0.<BR>Event Broker Driver (C) 2001,2002=20
MontaVista Software (<A=20
href=3D"mailto:source@mvista.com">source@mvista.com</A>)<BR>Done =
starting=20
sysfs<BR>RAMDISK: Compressed image found at block=20
0<BR>&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;=
&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&=
lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&l=
t;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;Han=
gs=20
Here&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&=
gt;&gt;&gt;&gt;&gt;</DIV>
<DIV>&nbsp;</DIV>
<DIV><BR>Thanks in advance</DIV>
<DIV>&nbsp;</DIV>
<DIV>Haroun Ansari M A</DIV>
<DIV>&nbsp;</DIV>
<DIV></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0005_01C7CF80.1308DD20--
