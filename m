Return-Path: <jabir.kannath@wipro.com>
Received: from wip-ectls-mx1.wipro.com (wip-ectls-mx1.wipro.com
	[203.91.193.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-ectls-mx1.wipro.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8E34D67A45
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 May 2006 02:22:22 +1000 (EST)
Received: from wip-ectls-mx1.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id DCF2222002D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 May 2006 21:23:58 +0530 (IST)
Received: from blr-ec-bh01.wipro.com (blr-ec-bh01.wipro.com [10.201.50.91])
	by wip-ectls-mx1.wipro.com (Postfix) with ESMTP id D1B16220004
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 May 2006 21:23:58 +0530 (IST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: To connect USB Bluetooth Dongle with embedded linux platform MPC 5200
	Lite
Date: Fri, 19 May 2006 21:23:15 +0530
Message-ID: <41CB8F9678E6F0498DA096429793FA850D2379@blr-m3-msg.wipro.com>
From: <jabir.kannath@wipro.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,
=0D
We are in need of re-building Linux kernel 2.4.25 to support USB
Bluetooth Dongle for the embedded platform MPC 5200 Lite.
=0D
With the new kernel running and on connecting USB Bluetooth Dongle to
icecube (MPC5200 Lite EVM) running embedded Linux from Denx, error "USB
device not accepting new address". We would appreciate any kind of help
towards solving the issue.
=0D
We added USB and Bluetooth support with the configurations available in
the file icecube_5200_defconfig and rebuild the kernel using 'make
uImage'. For USB setting, we have referred  icecube_5200_CoralPdefconfig
file. Kindly help us in identifying the reason for the issue.
=0D
Please see the boot up log as follows:
=0D
........................................................................
..................
=0D
=0D
=0D

U-Boot 1.1.3 (May 20 2005 - 18:29:54)
=0D
=0D

=0D
CPU:   MPC5200 v1.2 at 396 MHz
=0D
       Bus 132 MHz, IPB 66 MHz, PCI 33 MHz
=0D
Board: Motorola MPC5200 (IceCube)
=0D
I2C:   85 kHz, ready
=0D
DRAM:  64 MB
=0D
FLASH: 16 MB
=0D
PCI:   Bus Dev VenId DevId Class Int
=0D
        00  1a  1057  5803  0680  00
=0D
In:    serial
=0D
Out:   serial
=0D
Err:   serial
=0D
Net:   FEC ETHERNET
=0D
IDE:   Bus 0: OK
=0D
  Device 0: Model: ST340015A Firm: 3.15 Ser#: 5LAMQLQ6
=0D
            Type: Hard Disk
=0D
            Capacity: 38166.6 MB =3D 37.2 GB (78165360 x 512)
=0D
  Device 1: not available
=0D
=0D

=0D
Type "run flash_nfs" to mount root filesystem over NFS
=0D
=0D

=0D
Hit any key to stop autoboot:  0
=0D
## Booting image at fff00000 ...
=0D
   Image Name:   Linux PPC MPC5200 2.4
=0D
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
=0D
   Data Size:    931083 Bytes =3D 909.3 kB
=0D
   Load Address: 00000000
=0D
   Entry Point:  00000000
=0D
   Verifying Checksum ... OK
=0D
   Uncompressing Kernel Image ... OK
=0D
Memory BAT mapping: BAT2=3D64Mb, BAT3=3D0Mb, residual: 0Mb
=0D
Linux version 2.4.25 (root@M4-110822) (gcc version 3.3.3 (DENX ELDK
3.1.1 3.3.3-10)) #1 Wed May 17 19:02:37 IST 2006
=0D
On node 0 totalpages: 16384
=0D
zone(0): 16384 pages.
=0D
zone(1): 0 pages.
=0D
zone(2): 0 pages.
=0D
Kernel command line: root=3D/dev/hda1 rw
ip=3D10.114.105.162:10.114.105.41:10.114.105.41:255.255.255.0:icecube:eth0
:off panic=3D1
=0D
Calibrating delay loop... 263.78 BogoMIPS
=0D
Memory: 62088k available (1564k kernel code, 524k data, 76k init, 0k
highmem)
=0D
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
=0D
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
=0D
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
=0D
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
=0D
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
=0D
POSIX conformance testing by UNIFIX
=0D
PCI: Probing PCI hardware
=0D
PCI: Cannot allocate resource region 0 of device 00:1a.0
=0D
Linux NET4.0 for Linux 2.4
=0D
Based upon Swansea University Computer Society NET3.039
=0D
Initializing RT netlink socket
=0D
Starting kswapd
=0D
Journalled Block Device driver loaded
=0D
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
=0D
pty: 256 Unix98 ptys configured
=0D
ttyS0 on PSC1
=0D
ttyS1 on PSC2
=0D
ttyS2 on PSC3
=0D
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
=0D
loop: loaded (max 8 devices)
=0D
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
=0D
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
=0D
Port Config is: 0x11050004
=0D
ipb=3D66MHz, set clock period to 15
=0D
GPIO config: 11050004
=0D
ATA invalid: 00800000
=0D
ATA hostcnf: 03000000
=0D
ATA pio1   : 100a0a00
=0D
ATA pio2   : 02040600
=0D
XLB Arb cnf: 0000a366
=0D
mpc5xxx_ide: Setting up IDE interface ide0...
=0D
ATA DMA task: 5
=0D
Probing IDE interface ide0...
=0D
hda: ST340015A, ATA DISK drive
=0D
hda: Setting UDMA 2 timings
=0D
hda: Setting PIO 4 timings
=0D
ide0 at 0xf0003a60-0xf0003a67,0xf0003a5c on irq 45
=0D
hda: attached ide-disk driver.
=0D
hda: host protected area =3D> 1
=0D
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=3D77545/16/63,
UDMA(33)
=0D
Partition check:
=0D
 hda:<7>Unhandled interrupt 1a, disabled
=0D
 hda1 hda2
=0D
Icecube Bank 0: Found 1 x8 devices at 0x0 in 8-bit mode
=0D
Icecube Bank 0: Found 1 x8 devices at 0x800000 in 8-bit mode
=0D
 Amd/Fujitsu Extended Query Table at 0x0040
=0D
Icecube Bank 0: CFI does not contain boot bank location. Assuming top.
=0D
number of CFI chips: 2
=0D
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
=0D
Icecube flash bank 0: Using static image partition definition
=0D
Creating 5 MTD partitions on "Icecube Bank 0":
=0D
0x00000000-0x00800000 : "Spare"
=0D
0x00800000-0x00900000 : "kernel"
=0D
0x00900000-0x00c00000 : "initrd"
=0D
0x00c00000-0x00f00000 : "jffs"
=0D
0x00f00000-0x01000000 : "Firmware"
=0D
usb.c: registered new driver usbdevfs
=0D
usb.c: registered new driver hub
=0D
host/usb-ohci.c: USB OHCI at membase 0xf0001000, IRQ 44
=0D
host/usb-ohci.c: usb-0, Built-In ohci
=0D
usb.c: new USB bus registered, assigned bus number 1
=0D
hub.c: USB hub found
=0D
hub.c: 2 ports detected
=0D
usb.c: registered new driver hiddev
=0D
usb.c: registered new driver hid
=0D
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
=0D
hid-core.c: USB HID support drivers
=0D
NET4: Linux TCP/IP 1.0 for NET4.0
=0D
eth0: Phy @ 0x0, type LXT971 (0x001378e2)
=0D
IP Protocols: ICMP, UDP, TCP, IGMP
=0D
IP: routing cache hash table of 512 buckets, 4Kbytes
=0D
TCP: Hash tables configured (established 4096 bind 8192)
=0D
eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
=0D
IP-Config: Complete:
=0D
      device=3Deth0, addr=3D10.114.105.162, mask=3D255.255.255.0,
gw=3D10.114.105.41,
=0D
     host=3Dicecube, domain=3D, nis-domain=3D(none),
=0D
     bootserver=3D10.114.105.41, rootserver=3D10.114.105.41, rootpath=3D
=0D
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
=0D
hub.c: new USB device 0-1, assigned address 2
=0D
usb.c: USB device not accepting new address=3D2 (error=3D-110)
=0D
hub.c: new USB device 0-1, assigned address 3
=0D
usb.c: USB device not accepting new address=3D3 (error=3D-110)
=0D
kjournald starting.  Commit interval 5 seconds
=0D
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
=0D
EXT3-fs: recovery complete.
=0D
EXT3-fs: mounted filesystem with ordered data mode.
=0D
VFS: Mounted root (ext3 filesystem).
=0D
Freeing unused kernel memory: 76k init
=0D
modprobe: Note: /etc/modules.conf is more recent than
/lib/modules/2.4.25/modules.dep
=0D
INIT: version 2.86 booting
=0D
eth0: status: link up, 100 Mbps Full Duplex, auto-negotiation complete.
=0D
Setting parameters of disc:hda: Setting UDMA 2 timings
=0D
hda: Setting PIO 4 timings
=0D
hda: DMA disabled
=0D
 /dev/hda.
=0D
Activating swap.
=0D
Unable to find swap-space signature
=0D
Checking root file system...
=0D
fsck 1.38 (30-Jun-2005)
=0D
/dev/hda1: clean, 58172/2011296 files, 376931/4015864 blocks
=0D
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
=0D
RTC_RD_TIME: Invalid argument
=0D
ioctl() to /dev/rtc to read the time failed.
=0D
System time was Thu Jan  1 00:00:07 UTC 1970.
=0D
Setting the System Clock using the Hardware Clock as reference...
=0D
RTC_RD_TIME: Invalid argument
=0D
ioctl() to /dev/rtc to read the time failed.
=0D
System Clock set. System local time is now Thu Jan  1 00:00:07 UTC 1970.
=0D
Calculating module dependencies...done.
=0D
Loading modules:
=0D
Note: /etc/modules.conf is more recent than
/lib/modules/2.4.25/modules.dep
=0D
modprobe: Can't locate module *
=0D
Checking all file systems...
=0D
fsck 1.38 (30-Jun-2005)
=0D
Setting kernel variables ...
=0D
... done.
=0D
Mounting local filesystems...
=0D
Unable to find swap-space signature
=0D
Cleaning /tmpfind: warning: you have specified the -maxdepth option
after a non-option argument -perm, but options are not p.

=0D
find: warning: you have specified the -depth option after a non-option
argument !, but options are not positional (-depth af.

=0D
find: warning: you have specified the -depth option after a non-option
argument !, but options are not positional (-depth af.

=0D
 /var/run /var/lock.
=0D
Running 0dns-down to make sure resolv.conf is ok...done.
=0D
Setting up networking...done.
=0D
Kernel hotplug support not enabled.
=0D
Setting up IP spoofing protection: rp_filter.
=0D
Configuring network interfaces...done.
=0D
Starting portmap daemon: portmap.
=0D
Loading the saved-state of the serial devices...
=0D
=0D

=0D
Setting the System Clock using the Hardware Clock as reference...
=0D
RTC_RD_TIME: Invalid argument
=0D
ioctl() to /dev/rtc to read the time failed.
=0D
System Clock set. Local time: Thu Jan  1 01:00:17 CET 1970
=0D
=0D

=0D
Running ntpdate to synchronize clockmodprobe: Note: /etc/modules.conf is
more recent than /lib/modules/2.4.25/modules.dep
=0D
modprobe: Note: /etc/modules.conf is more recent than
/lib/modules/2.4.25/modules.dep
=0D
.
=0D
Initializing random number generator...done.
=0D
Recovering nvi editor sessions... done.
=0D
Setting up X server socket directory /tmp/.X11-unix...done.
=0D
Setting up ICE socket directory /tmp/.ICE-unix...done.
=0D
INIT: Entering runlevel: 2
=0D
Starting system log daemon: syslogd.
=0D
Starting kernel log daemon: klogd.
=0D
Starting portmap daemon: portmap.
=0D
Starting automounter:.
=0D
Starting system message bus: dbus-1.
=0D
Starting internet superserver: inetd.
=0D
Starting printer spooler: lpd .
=0D
Starting PCMCIA services: Note: /etc/modules.conf is more recent than
/lib/modules/2.4.25/modules.dep
=0D
modprobe: Can't locate module pcmcia_core
=0D
Error: Failed to load pcmcia_core
=0D
Starting OpenBSD Secure Shell server: sshd.
=0D
Starting NFS common utilities: statd.
=0D
Starting NTP server: ntpd.
=0D
Starting bluez-utils: hcid sdpdBlueZ Core ver 2.3 Copyright (C)
2000,2001 Qualcomm Inc
=0D
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
=0D
Can't open RFCOMM control socket: No such file or directory
=0D
 rfcomm.
=0D
Starting deferred execution scheduler: atd.
=0D
Starting periodic command scheduler: cron.
=0D
=0D

=0D
Debian GNU/Linux testing/unstable lite5200revA_no2 ttyS0
=0D
=0D

=0D
lite5200revA_no2 login: =0D
=0D
=0D
=0D
........................................................................
.....................
=0D

=0D


The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and=
 may contain proprietary, confidential or privileged information. If you=
 are not the intended recipient, you should not disseminate, distribute or=
 copy this e-mail. Please notify the sender immediately and destroy all=
 copies of this message and any attachments.=0D

WARNING: Computer viruses can be transmitted via email. The recipient=
 should check this email and any attachments for the presence of viruses.=
 The company accepts no liability for any damage caused by any virus=
 transmitted by this email.
=0D
www.wipro.com
