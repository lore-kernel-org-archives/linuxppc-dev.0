Date: Wed, 7 Feb 2001 07:54:04 +0100
From: Olaf Hering <olh@suse.de>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MESH not found with 2.4.1 on 7500
Message-ID: <20010207075404.G14283@suse.de>
References: <20010206173709.A17234@suse.de> <20010206112148.0c9b60d3.toe@unlserve.unl.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
In-Reply-To: <20010206112148.0c9b60d3.toe@unlserve.unl.edu>; from toe@unlserve.unl.edu on Tue, Feb 06, 2001 at 11:21:48AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, Takashi Oe wrote:

> On Tue, 6 Feb 2001 17:37:09 +0100, Olaf Hering <olh@suse.de> wrote:
>
> >
> > Hi,
> >
> > the current 2.4.1 can not found the mesh scsi controller on my 7500/100.
> > It doesnt work with bootx and boot fd:vmlinux.coff.
> >
> > Any ideas how to fix it?
>
> As far as I can tell, your kernel is not getting that far.  Before MESH
> message output, you should have something like:
>
> SCSI subsystem driver Revision: 1.00
>
> which is missing.  On my system, there is IDE related messages immediately
> following the loop device message, and it's followed by (old) adb mouse
> driver and PPP device message.  SCSI is after all of those.

Yeah, 2.4 changed the detection order.
And that loop device ... I guess I have to change the subject.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="peach_241crash.txt"

mem_pieces_remove: [352000,41326a) not in any region
Total memory = 72MB; using 512kB for hash table (at c0480000)
Linux version 2.4.1 (root@PowerPC.suse.de) (gcc version 2.95.2 19991024 (release)) #1 Fri Feb 2 07:49:31 GMT 2001
Cache coherency enabled for bandit/PSX at f2000000
Found Bandit PCI host bridge at 0xf2000000. Firmware bus number: 0->0
Found Chaos PCI host bridge at 0xf0000000. Firmware bus number: 1->1
On node 0 totalpages: 18432
zone(0): 18432 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ramdisk_size=8192 root=/dev/fd0 ramdisk_size=128000 console=ttyS0,38400
System has 32 possible interrupts
GMT Delta read from XPRAM: 60 minutes, DST: off
Console: colour dummy device 80x25
Calibrating delay loop... 99.53 BogoMIPS
Memory: 67684k available (2024k kernel code, 1072k data, 320k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Fixup mem res, dev: 0.10, res_start: f3000000->f3000000
PCI: Resource f3000000-f301ffff (f=200, d=0, p=0)
Macintosh CUDA driver v0.5 for Unified ADB.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
clgen: Driver for Cirrus Logic based graphic boards, v1.9.8
 Couldn't find PCI device
controlfb: Memory bank 1 present, bank 2 absent, total VRAM 2MB
Monitor sense value = 0x60b, using video mode 13 and color mode 2.
Console: switching to colour frame buffer device 104x39
fb0: control display adapter
MacOS display is /chaos/control
input0: Macintosh mouse button emulation
PowerMac Z8530 serial driver version 2.0
ttyS0 at 0xfd9d2020 (irq = 15) is a Z8530 ESCC, port = modem
ttyS1 at 0xfd9cf000 (irq = 16) is a Z8530 ESCC, port = printer
pty: 256 Unix98 ptys configured
block: queued sectors max/low 44741kB/14913kB, 192 slots per queue
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
fd0: SWIM3 floppy controller
Unable to get major 2 for floppy
NET4: Frame Diverter 0.46
RAMDISK: Compressed image found at block 0
Uncompressing.......................................................done.
Freeing initrd memory: 4194300k freed
Machine check in kernel mode.
Caused by (from SRR1=1030): Unknown values in msr
mem_pieces_remove: [352000,41326a) not in any region
Total memory = 72MB; using 512kB for hash table (at c0480000)
Linux version 2.4.1 (root@PowerPC.suse.de) (gcc version 2.95.2 19991024 (release)) #1 Fri Feb 2 07:49:31 GMT 2001
Cache coherency enabled for bandit/PSX at f2000000
Found Bandit PCI host bridge at 0xf2000000. Firmware bus number: 0->0
Found Chaos PCI host bridge at 0xf0000000. Firmware bus number: 1->1
On node 0 totalpages: 18432
zone(0): 18432 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ramdisk_size=8192 root=/dev/fd0 ramdisk_size=50000 console=ttyS0,38400
System has 32 possible interrupts
GMT Delta read from XPRAM: 60 minutes, DST: off
Console: colour dummy device 80x25
Calibrating delay loop... 99.53 BogoMIPS
Memory: 67684k available (2024k kernel code, 1072k data, 320k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Fixup mem res, dev: 0.10, res_start: f3000000->f3000000
PCI: Resource f3000000-f301ffff (f=200, d=0, p=0)
Macintosh CUDA driver v0.5 for Unified ADB.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
clgen: Driver for Cirrus Logic based graphic boards, v1.9.8
 Couldn't find PCI device
controlfb: Memory bank 1 present, bank 2 absent, total VRAM 2MB
Monitor sense value = 0x60b, using video mode 13 and color mode 2.
Console: switching to colour frame buffer device 104x39
fb0: control display adapter
MacOS display is /chaos/control
input0: Macintosh mouse button emulation
PowerMac Z8530 serial driver version 2.0
ttyS0 at 0xfd9d2020 (irq = 15) is a Z8530 ESCC, port = modem
ttyS1 at 0xfd9cf000 (irq = 16) is a Z8530 ESCC, port = printer
pty: 256 Unix98 ptys configured
block: queued sectors max/low 44741kB/14913kB, 192 slots per queue
RAMDISK driver initialized: 16 RAM disks of 50000K size 1024 blocksize
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
fd0: SWIM3 floppy controller
Unable to get major 2 for floppy
NET4: Frame Diverter 0.46
RAMDISK: Compressed image found at block 0
Uncompressing.......................................................done.
Freeing initrd memory: 4194300k freed
Machine check in kernel mode.
Caused by (from SRR1=1030): Unknown values in msr
device tree used 641712 bytes
Total memory = 72MB; using 512kB for hash table (at c0380000)
Linux version 2.2.18 (root@PowerMacintosh.suse.de) (gcc version 2.95.2 19991024 (release)) #1 Fri Feb 2 08:11:30 GMT 2001
PCI bus 0 controlled by bandit at f2000000
Cache coherency enabled for bandit/PSX at f2000000
PCI bus 1 controlled by chaos at f0000000
pmac nvram is core99: 0
System has 32 possible interrupts
GMT Delta read from XPRAM: 60 minutes, DST: off
Console: colour dummy device 80x25
Calibrating delay loop... 99.53 BogoMIPS
Memory: 68924k available (1804k kernel code, 2232k data, 172k init) [c0000000,c4800000]
Dentry hash table entries: 16384 (order 5, 128k)
Buffer cache hash table entries: 131072 (order 7, 512k)
Page cache hash table entries: 32768 (order 5, 128k)
Inode hash table entries: 16384 (128k), inode-max: 9216
VFS: Diskquotas version dquot_6.4.0 initialized
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 131072 bhash 65536)
NET4: AppleTalk 0.18 for Linux NET4.0
Initializing RT netlink socket
Starting kswapd v 1.5
MacOS display is /chaos/control
Monitor sense value = 0x60b, using video mode 13 and color mode 2.
Console: switching to colour frame buffer device 104x39
fb0: control display adapter
input0: Macintosh mouse button emulation
PowerMac Z8530 serial driver version 2.0
ttyS0 at 0xf3013020 (irq = 15) is a Z8530 ESCC, port = modem
ttyS1 at 0xf3013000 (irq = 16) is a Z8530 ESCC, port = printer
pty: 256 Unix98 ptys configured
Macintosh non-volatile memory driver v1.0
RAM disk driver initialized:  16 RAM disks of 128000K size
loop: registered device at major 7
fd0: SWIM3 floppy controller
md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
raid5: measuring checksumming speed
   8regs     :    88.011 MB/sec
   32regs    :    74.676 MB/sec
using fastest function: 8regs (88.011 MB/sec)
scsi0 : MESH
scsi1 : 53C94
scsi : 2 hosts.
mesh: target 0 synchronous at 5.0 MB/s
  Vendor: QUANTUM   Model: FIREBALL_TM1280S  Rev: 300L
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
mesh: target 1 synchronous at 5.0 MB/s
  Vendor: IBM       Model: DCAS-32160        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
mesh: target 3 synchronous at 5.0 MB/s
  Vendor: MATSHITA  Model: CD-ROM CR-8005A   Rev: 4.0i
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
scsi : detected 1 SCSI cdrom 2 SCSI disks total.
Uniform CD-ROM driver Revision: 3.11
SCSI device sda: hdwr sector= 512 bytes. Sectors= 2503872 [1222 MB] [1.2 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 4226725 [2063 MB] [2.1 GB]
eth0: MACE at 00:05:02:c4:db:82, chip revision 9.64
Partition check:
 sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10
 sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7 sdb8 sdb9
md.c: sizeof(mdp_super_t) = 4104
RAMDISK: Compressed image found at block 0
Uncompressing................................................done.
ADB keyboard at 2, handler set to 3
Detected ADB keyboard, type ISO, swapping keys.
input1: ADB HID on ID 2:2.05
ADB mouse at 3, handler set to 2
input2: ADB HID on ID 3:3.01
usb.c: registered new driver hid
keybdev.c: Adding keyboard: input1
mouse0: PS/2 mouse device for input2
mouse1: PS/2 mouse device for input0
mice: PS/2 mouse device common for all mice
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
VFS: Mounted root (ext2 filesystem).
>>> SuSE installation program v1.1.18 (c) 1996-2001 SuSE GmbH <<<

--jI8keyz6grp/JLjh--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
