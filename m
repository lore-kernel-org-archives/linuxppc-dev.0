Message-ID: <3A64B297.8B23FDC0@talknet.de>
Date: Tue, 16 Jan 2001 21:44:07 +0100
From: Alois Fertl <alois_fertl@talknet.de>
MIME-Version: 1.0
To: LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: ncr810 problem on powerstack
Content-Type: multipart/mixed;
 boundary="------------2DECD1FE660AD27E829EC759"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------2DECD1FE660AD27E829EC759
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I tried the recent 2.4.1-pre1 kernel on a powerstack but the ncr810 based
SCSI code does not work. The driver complains about CACHE INCORRECTLY CONFIGURED.

Anybody knows what this comes from. Attached if the full boot log of the system.

Alois
--------------2DECD1FE660AD27E829EC759
Content-Type: text/plain; charset=iso-8859-1;
 name="boot.log"
Content-Disposition: inline;
 filename="boot.log"
Content-Transfer-Encoding: quoted-printable

loaded at:     00005400 0001A220
relocated to:  00800000 00814E20
board data at: 03F78000 03F7EA0C
relocated to:  0080E314 00814D20
zimage at:     00010400 000F1A5D
relocated to:  00815000 008F665D
avail ram:     00400000 00800000

Linux/PPC load: console=3DttyS0,9600 console=3Dtty0 root=3D/dev/sda1
Uncompressing Linux...done.
Now booting the kernel
Total memory =3D 64MB; using 0kB for hash table (at 00000000)
Linux version 2.4.1-pre1 (alois@localhost) (gcc version 2.95.2 19991024 (=
release)) #6 Sun Jan 14 12:03:19 CET 2001
PReP architecture
Boot arguments: console=3DttyS0,9600 console=3Dtty0 root=3D/dev/sda1
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=3DttyS0,9600 console=3Dtty0 root=3D/dev/sda1=

time_init: decrementer frequency =3D 16.663082 MHz
Console: colour VGA+ 80x25
Calibrating delay loop... 133.12 BogoMIPS
Memory: 61980k available (1448k kernel code, 696k data, 236k init, 0k hig=
hmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Fixup IO res, dev: 0.2, res_start: ffffff0->8ffffff0
Fixup IO res, dev: 0.2, res_start: fffffec->8fffffec
Fixup IO res, dev: 0.2, res_start: fffffe0->8fffffe0
Fixup IO res, dev: 0.2, res_start: fffffdc->8fffffdc
Fixup IO res, dev: 0.2, res_start: fffffc0->8fffffc0
Fixup IO res, dev: 0.6, res_start: ffffe00->8ffffe00
Fixup mem res, dev: 0.6, res_start: 3bfffe00->fbfffe00
Fixup IO res, dev: 0.7, res_start: ffffd80->8ffffd80
Fixup mem res, dev: 0.7, res_start: 3bfff800->fbfff800
Fixup mem res, dev: 0.7, res_start: fffc0000->bffc0000
Fixup mem res, dev: 0.8, res_start: ffff8000->bfff8000
Setting PCI interrupts for a "Omaha (PowerStack II Pro3000)"
Relocating PCI address 8ffffff0 -> 1fffff0
Relocating PCI address 8fffffec -> 1ffffec
Relocating PCI address 8fffffe0 -> 1ffffe0
Relocating PCI address 8fffffdc -> 1ffffdc
Relocating PCI address 8fffffc0 -> 1ffffc0
Relocating PCI address 8ffffe00 -> 1fffe00
Relocating PCI address 8ffffd80 -> 1fffd80
PCI: Resource 01fffff0-01fffff7 (f=3D101, d=3D0, p=3D0)
PCI: Resource 01ffffec-01ffffef (f=3D10d, d=3D0, p=3D0)
PCI: Resource 01ffffe0-01ffffe7 (f=3D101, d=3D0, p=3D0)
PCI: Resource 01ffffdc-01ffffdf (f=3D10d, d=3D0, p=3D0)
PCI: Resource 01ffffc0-01ffffcf (f=3D101, d=3D0, p=3D0)
PCI: Resource 01fffe00-01fffeff (f=3D101, d=3D0, p=3D0)
PCI: Resource fbfffe00-fbfffeff (f=3D200, d=3D0, p=3D0)
PCI: Resource 01fffd80-01fffdff (f=3D101, d=3D0, p=3D0)
PCI: Resource fbfff800-fbfffbff (f=3D200, d=3D0, p=3D0)
  got res[10000000:10ffffff] for resource 0 of Cirrus Logic GD 5446
  got res[11000000:1103ffff] for resource 6 of Digital Equipment Corporat=
ion DECchip 21142/43
  got res[11040000:11047fff] for resource 6 of Cirrus Logic GD 5446
PCI enable device: (PCI device 1014:0037 (IBM))
  cmd reg 0x106
PCI enable device: (Intel Corporation 82378IB [SIO ISA Bridge])
  cmd reg 0xf
PCI enable device: (Symphony Labs SL82c105)
  cmd reg 0x5
PCI enable device: (Symbios Logic Inc. (formerly NCR) 53c810)
  cmd reg 0x7
PCI enable device: (Digital Equipment Corporation DECchip 21142/43)
  cmd reg 0x7
PCI enable device: (Cirrus Logic GD 5446)
  cmd reg 0x7
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
W82C105: IDE controller on PCI bus 00 dev 10
W82C105: chipset revision 6
W82C105: 100% native mode on irq 14
    ide0: BM-DMA at 0x1ffffc0-0x1ffffc7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1ffffc8-0x1ffffcf, BIOS settings: hdc:pio, hdd:pio
hdc: MATSHITA CR-583, ATAPI CDROM drive
ide1 at 0x1ffffe0-0x1ffffe7,0x1ffffde on irq 14
hdc: request sense failure: status=3D0x51 { DriveReady SeekComplete Error=
 }
hdc: request sense failure: error=3D0x24
hdc: request sense failure: status=3D0x51 { DriveReady SeekComplete Error=
 }
hdc: request sense failure: error=3D0x24
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 2.88M
FDC 0 is a National Semiconductor PC87306
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_=
PCI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Linux Tulip driver version 0.9.13 (January 2, 2001)
eth0: Digital DS21143 Tulip rev 65 at 0x1fffd80, 00:48:54:12:09:26, IRQ 1=
1.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.=

eth0:  MII transceiver #1 config 3000 status 7869 advertising 01e1.
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
SCSI subsystem driver Revision: 1.00
ncr53c8xx: at PCI bus 0, device 6, function 0
ncr53c8xx: 53c810 detected =

ncr53c810-0: rev 0x2 on pci bus 0 device 6 function 0 irq 9
ncr53c810-0: ID 7, Fast-10, Parity Checking
CACHE TEST FAILED: script execution failed.
start=3D80391414, pc=3D80391420, end=3D80391440
CACHE INCORRECTLY CONFIGURED.
ncr53c810-0: detaching...
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Macintosh non-volatile memory driver v1.0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
request_module[block-major-8]: Root fs not mounted
VFS: Cannot open root device "sda1" or 08:01
Please append a correct "root=3D" boot option
Kernel panic: VFS: Unable to mount root fs on 08:01
Rebooting in 180 seconds..~[dino].=07Connected.

--------------2DECD1FE660AD27E829EC759--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
