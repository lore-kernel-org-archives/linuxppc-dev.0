Return-Path: <sydneymartin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.198])
	by ozlabs.org (Postfix) with ESMTP id BA6CC2BF16
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 15:03:40 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 69so143647wra
	for <linuxppc-dev@ozlabs.org>; Mon, 03 Jan 2005 20:03:39 -0800 (PST)
Message-ID: <855e88d0050103200337efc719@mail.gmail.com>
Date: Mon, 3 Jan 2005 23:03:39 -0500
From: Mike Martin <sydneymartin@gmail.com>
To: Philippe Guyot <pguyot@cvf.fr>
In-Reply-To: <200501031530.54487.pguyot@cvf.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_334_3401558.1104811419513"
References: <20050101150055.GA15400@pegasos>
	<855e88d0050103060766b09bd0@mail.gmail.com>
	<20050103143015.GB9197@pegasos> <200501031530.54487.pguyot@cvf.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
Reply-To: mikemartin@linux.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_334_3401558.1104811419513
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Re-posting with shorter attachment to please the list gods. Sorry)

> If there is such a deadline, why not consider to install first a woody (many
> successes exist) then upgrading to sarge after ?

Ok... trying again with Leigh Brown's boot image and a woody root
floppy and a woody CD.

The console capture is below. Leigh's kernel boots up great, asks for
a root floppy and then ...

VFS: Insert root floppy and press ENTER

FAT: bogus logical sector size 1981
FAT: bogus logical sector size 1981
read_super_block: can't find a reiserfs filesystem on (dev 02:00,
block 64, size 1024)
read_super_block: can't find a reiserfs filesystem on (dev 02:00,
block 8, size 1024)
Kernel panic: VFS: Unable to mount root fs on 02:00

Reiserfs? Huh? I tried it twice, two different floppies. Both written
as follows (as suggested in Debian manual):
sudo dd if=root.bin of=/dev/fd0 bs=1024 conv=sync ; sync
\1440+0 records in
1440+0 records out
1474560 bytes transferred in 120.042950 seconds (12284 bytes/sec)

I can however boot the installation I made earlier using Leigh's
image. I have completed the installation and it runs ... for a short
period of time. After about 5 minutes or so it stops responding to the
console and to pings.

MikeMartin

------=_Part_334_3401558.1104811419513
Content-Type: text/plain; name="43pflo~1.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="43pflo~1.txt"

RS/6000 RS/6000 RS/6000 RS/6000 RS/6000 RS/6000 RS/6000 RS/6000 RS/6000 RS/=
6000

     memory      keyboard     network      scsi      speaker       ok
0 > boot floppy=20

loaded at:     00600400 00734EC8
relocated to:  00800100 00934BC8
board data at: 00231370 00237D7C
relocated to:  0092B02C 00931A38
zimage at:     00805B90 0092AA9D
avail ram:     00400000 00800000

Linux/PPC load: console=3DttyS0,9600 root=3D/dev/fd0
Uncompressing Linux...done.
Now booting the kernel
Memory BAT mapping: BAT2=3D256Mb, BAT3=3D0Mb, residual: 0Mb
Total memory =3D 256MB; using 512kB for hash table (at c0300000)
Linux version 2.4.19 (leigh@micro.solinno.co.uk) (gcc version 2.96 20000731=
 (Red Hat Linux 7.1 2.96-81)) #3 Sun Aug 4 08:28:30 BST 2002
PReP architecture
IBM planar ID: 000000d5
PReP boot cpu: 0
MPIC at 0xfddc0000 (0x3ddc0000), length 0x00040000 mapped to 0xeffc0000
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=3DttyS0,9600 root=3D/dev/fd0
OpenPIC Version 1.0 (4 CPUs and 16 IRQ sources) at effc0000
time_init: decrementer frequency =3D 16.617869 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 331.77 BogoMIPS
Memory: 255552k available (1944k kernel code, 880k data, 160k init, 0k high=
mem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Bridge 00:17.0 resource 2 was deactivated by firmware
Setting PCI interrupts for a "IBM 43P-140 (Tiger1)"
PCI: Cannot allocate resource region 0 of PCI bridge 1
PCI: bridge 1 resource 0 moved to 7ff000..7fffff
PCI: Cannot allocate resource region 0 of device 00:0b.0
PCI: Cannot allocate resource region 0 of device 00:0c.0
PCI: Cannot allocate resource region 0 of device 00:10.0
PCI: Cannot allocate resource region 0 of device 00:12.0
PCI: Cannot allocate resource region 0 of device 01:03.0
PCI: moved device 00:0b.0 resource 0 (101) to 1000
PCI: moved device 00:0c.0 resource 0 (101) to 1020
PCI: moved device 00:10.0 resource 0 (101) to 1400
PCI: moved device 00:12.0 resource 0 (101) to 1040
PCI: moved device 01:03.0 resource 0 (101) to 7ff000
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
IBM_E15: initializing
IBM_E15: could not find S3 864 in system
initialize_kbd: Keyboard reset failed, no ACK
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Floppy drive(s): fd0 is 2.88M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
PCI: Enabling device 00:0c.0 (0000 -> 0003)
pcnet32: PCnet/PCI II 79C970A at 0x1020, 00 06 29 ba 40 05 assigned IRQ 22.
eth0: registered as PCnet/PCI II 79C970A
pcnet32: 1 cards_found.
SCSI subsystem driver Revision: 1.00
PCI: Enabling device 00:10.0 (0010 -> 0013)
ncr53c8xx: at PCI bus 0, device 16, function 0
ncr53c8xx: setting PCI_COMMAND_MASTER...(fix-up)
ncr53c8xx: 53c825a detected=20
ncr53c825a-0: rev 0x13 on pci bus 0 device 16 function 0 irq 23
ncr53c825a-0: ID 7, Fast-10, Parity Checking
scsi0 : ncr53c8xx-3.4.3b-20010512
  Vendor: IBM       Model: CDRM00203     !K  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
ncr53c825a-0-<4,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 8)
  Vendor: IBM       Model: DCHS09U           Rev: 6363
  Type:   Direct-Access                      ANSI SCSI revision: 02
ncr53c825a-0-<5,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 8)
  Vendor: IBM       Model: DPSS-318350N      Rev: S96F
  Type:   Direct-Access                      ANSI SCSI revision: 03
Attached scsi disk sda at scsi0, channel 0, id 4, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 5, lun 0
SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
Partition check:
 sda: sda1
sdb: Spinning up disk..............ready
SCSI device sdb: 35548320 512-byte hdwr sectors (18201 MB)
 sdb: sdb1 sdb2 < sdb5 >
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
ncr53c825a-0-<3,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Macintosh non-volatile memory driver v1.0
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Insert root floppy and press ENTER
FAT: bogus logical sector size 1981
FAT: bogus logical sector size 1981
read_super_block: can't find a reiserfs filesystem on (dev 02:00, block 64,=
 size 1024)
read_super_block: can't find a reiserfs filesystem on (dev 02:00, block 8, =
size 1024)
Kernel panic: VFS: Unable to mount root fs on 02:00
 <0>Rebooting in 180 seconds..

------=_Part_334_3401558.1104811419513--
