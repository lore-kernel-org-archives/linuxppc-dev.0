Return-Path: <zhonglei@RCS-9000.COM>
Date: Tue, 30 Nov 2004 10:32:22 +0800
Message-Id: <200411301032.AA40894774@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "zhonglei" <zhonglei@RCS-9000.COM>
To: <Linuxppc-embedded@ozlabs.org>
Subject: problems on USB
Reply-To: zhonglei@RCS-9000.COM
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi
   My system is Lite5200 with DENX Embedded Linux running on it.When I tried to enable my USB port to use my u-disk, 

the problem occured.
   I have enabled USB support with 'make xconfig'. The reports are as follows:
********************************************************************
  U-Boot 1.1.2 (Nov 12 2004 - 11:46:06)

CPU:   MPC5200 v1.2 at 462 MHz
       Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
Board: Motorola MPC5200 (IceCube)
I2C:   85 kHz, ready
DRAM:  64 MB
FLASH: 16 MB
PCI:   Bus Dev VenId DevId Class Int
        00  1a  1057  5803  0680  00
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET
IDE:   Bus 0: OK
  Device 0: Model: Flash Card Firm: 2N3-0925 Ser#: CF00000000
            Type: Removable Hard Disk
            Capacity: 123.0 MB = 0.1 GB (251904 x 512)
  Device 1: not available

Autostarting.Press any key to abort..

Hit any key to stop autoboot:  0
Using FEC ETHERNET device
TFTP from server 198.87.102.60; our IP address is 198.87.102.210
Filename 'MPC5200/uImage'.
Load address: 0x100000
Loading: #################################################################
###############################################################
######################################
done
Bytes transferred = 857559 (d15d7 hex)
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.25
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    857495 Bytes = 837.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.25 (root@198.87.102.60.netdial.caribe.net) (gcc version 3.2.24
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=198.87.102.60:/home/zl/ELDK/ppc_8f
Calibrating delay loop... 307.20 BogoMIPS
Memory: 62212k available (1500k kernel code, 464k data, 76k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 00:1a.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
pty: 256 Unix98 ptys configured
ttyS0 on PSC1
ttyS1 on PSC2
ttyS2 on PSC3
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Port Config is: 0x11050004
ipb=132MHz, set clock period to 7
GPIO config: 11050004
ATA invalid: 01000000
ATA hostcnf: 03000000
ATA pio1   : 100a0a00
ATA pio2   : 02040600
XLB Arb cnf: 0000a366
mpc5xxx_ide: Setting up IDE interface ide0...
ATA DMA task: 5
Probing IDE interface ide0...
hda: Flash Card, CFA DISK drive
ide0 at 0xf0003a60-0xf0003a67,0xf0003a5c on irq 45
hda: attached ide-disk driver.
hda: 251904 sectors (129 MB) w/0KiB Cache, CHS=984/16/16
Partition check:
 hda: hda1
Icecube Bank 0: Found 1 x8 devices at 0x0 in 8-bit mode
Icecube Bank 0: Found 1 x8 devices at 0x800000 in 8-bit mode
 Amd/Fujitsu Extended Query Table at 0x0040
Icecube Bank 0: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 2
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Icecube flash bank 0: Using static image partition definition
Creating 5 MTD partitions on "Icecube Bank 0":
0x00000000-0x00800000 : "Spare"
0x00800000-0x00900000 : "kernel"
0x00900000-0x00c00000 : "initrd"
0x00c00000-0x00f00000 : "jffs"
0x00f00000-0x01000000 : "Firmware"
usb.c: registered new driver hub
host/usb-ohci.c: USB OHCI at membase 0xf0001000, IRQ 44
host/usb-ohci.c: usb-0, Built-In ohci
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 1 port detected
NET4: Linux TCP/IP 1.0 for NET4.0
eth0: Phy @ 0x0, type LXT971 (0x001378e2)
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
eth0: Waiting for the link to be up...
eth0: status: link up, 100 Mbps Full Duplex, auto-negotiation complete.
IP-Config: Complete:
      device=eth0, addr=198.87.102.210, mask=255.0.0.0, gw=198.87.102.60,
     host=icecube, domain=, nis-domain=(none),
     bootserver=198.87.102.60, rootserver=198.87.102.60, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 198.87.102.60
Looking up port of RPC 100005/1 on 198.87.102.60
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 76k init
INIT: version 2.84 booting
                Welcome to DENX Embedded Linux Environment
                Press 'I' to enter interactive startup.
Building the cache [  OK  ]
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
RTC_RD_TIME: Invalid argument
ioctl() to /dev/rtc to read the time failed.
Setting clock : Wed Dec 31 19:00:09 EST 1969 [  OK  ]
Setting hostname icecube:  [  OK  ]
Mounting USB filesystem:  mount: mount point /proc/bus/usb does not exist
[FAILED]
Activating swap partitions:  [  OK  ]
Checking filesystems
[  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling swap space:  [  OK  ]
modprobe: Can't open dependencies file /lib/modules/2.4.25/modules.dep (No such)
INIT: Entering runlevel: 3
Entering non-interactive startup
Setting network parameters:  [  OK  ]
Bringing up loopback interface:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Initializing random number generator:  [  OK  ]
Starting portmapper: [  OK  ]
Mounting NFS filesystems:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting xinetd: [  OK  ]

icecube login: root
Last login: Wed Dec 31 19:02:11 on console
bash-2.05b# 
****************************************************************

It seems that the USB port has been detected.But the filesystem mounted unsuccessfully!(Mounting USB filesystem:  

mount: mount point /proc/bus/usb does not exist)

Please give a hand! Thanks in advance!!!!!

BestRegards
zhonglei
