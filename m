Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (imap.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 13FF42BF0E
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 22:34:04 +1100 (EST)
From: Marc Dietrich <marvin24@gmx.de>
To: sheutlin@gmx.de
Date: Wed, 5 Jan 2005 12:33:25 +0100
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200501041504.57588.marvin24@gmx.de>
	<1104850036.6164.25.camel@weizen.left.earth>
In-Reply-To: <1104850036.6164.25.camel@weizen.left.earth>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FC92B62BObB5Mc5"
Message-Id: <200501051233.25622.marvin24@gmx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Boundary-00=_FC92B62BObB5Mc5
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hallo Sebastian,

Am Dienstag, 4. Januar 2005 15:47 schrieb Sebastian Heutling:
> Hello again Marc,
>
> > > >Can you put a working zImage.prep somewhere on the web (<1.44 MB, so I
> > > > can write it to a floppy disk)?
> > >
> (...)
> It is on: http://sengor.ath.cx/~sheutlin/prep/zImage.prep

hehe! It is booting!!!

Different to your setup, I get no timeouts here (boot.log is attached) - this 
makes me wondering if there are different board revisions out there.

Another thing is,  I tried to compile a stock 2.6.8 kernel with your config 
from "/proc/config.gz" and the modified irq tables in prep_pci.c (I guess you 
also did this modification). This kernel does not boot! It even doesn't show 
the boot loader - it just hangs after finished loading the kernel from floppy 
disk. Either a) I have a corrupt kernel tree, b) my compiler (gcc 3.3.4, 
debian/sarge) has problems or c) you changed something else in your kernel. 

I check a) and I think it is ok.
for b) I'm currently downloading the 3.3.5 compile from unstable debian (the 
you you are using I guess), and will try it again.
c) how does you prep_pci.c looks like, any other changes?

I have to leave this machine alone tomorrow, so I won't be able to do any 
testing further. From what we have now here, it seems that something is 
broken for kernels >2.6.8. It would be nice, if someone can double check 
this.

Best wishes

Marc




--Boundary-00=_FC92B62BObB5Mc5
Content-Type: text/plain; charset="iso-8859-15"; name="dmsg-2.6.8-Sebastian"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmsg-2.6.8-Sebastian"

Total memory = 128MB; using 256kB for hash table (at c0340000)
Linux version 2.6.8 (root@sengor) (gcc version 3.3.5 (Debian 1:3.3.5-5)) #10 Tue Jan 4 13:03:42 CET 2005
PReP architecture
On node 0 totalpages: 32768
  DMA zone: 32768 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=/dev/sda3 console=tty0 video=clgen:mode:640x480
PID hash table entries: 1024 (order 10: 8192 bytes)
time_init: decrementer frequency = 16.657984 MHz
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 126208k available (1932k kernel code, 1060k data, 156k init, 0k highmem)
Calibrating delay loop... 398.33 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
NET: Registered protocol family 16
PCI: Probing PCI hardware
Setting PCI interrupts for a "Utah (Powerstack II Pro4000)"
PCI: Cannot allocate resource region 5 of device 0000:00:01.1
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
 RAM (1024 kB) at 0xxc0000000, Cirrus Logic chipset on PCI bus
cirrusfb: Driver for Cirrus Logic based graphic boards, v2.0-pre2
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
cirrusfb: This board has 1048576 bytes of DRAM memory
cirrusfb: This board has 1048576 bytes of DRAM memory
Console: switching to colour frame buffer device 80x30
Macintosh non-volatile memory driver v1.1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
W82C105: IDE controller at PCI slot 0000:00:01.1
PCI: Enabling device 0000:00:01.1 (0000 -> 0001)
W82C105: chipset revision 5
W82C105: 100% native mode on irq 14
W82C105: dma_base is invalid (0x0000)
ide0: W82C105 Bus-Master DMA disabled (BIOS)
W82C105: dma_base is invalid (0x0000)
ide1: W82C105 Bus-Master DMA disabled (BIOS)
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
PCI: Enabling device 0000:00:02.0 (0000 -> 0003)
sym0: <825a> rev 0x13 at pci 0000:00:02.0 irq 15
sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
Using anticipatory io scheduler
  Vendor: SEAGATE   Model: ST34573W          Rev: 5764
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:1:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:1:0): Beginning Domain Validation
sym0:1: wide asynchronous.
sym0:1: FAST-10 WIDE SCSI 20.0 MB/s ST (100.0 ns, offset 8)
scsi(0:0:1:0): Domain Validation skipping write tests
scsi(0:0:1:0): Ending Domain Validation
  Vendor: NEC       Model: CD-ROM DRIVE:463  Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi(0:0:3:0): Beginning Domain Validation
sym0:3: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 8)
scsi(0:0:3:0): Domain Validation skipping write tests
scsi(0:0:3:0): Ending Domain Validation
st: Version 20040403, fixed bufsize 32768, s/g segs 256
SCSI device sda: 8888924 512-byte hdwr sectors (4551 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 3, lun 0,  type 5
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 156k init 36k pmac 4k chrp 4k openfirmware
Adding 262252k swap on /dev/sda2.  Priority:-1 extents:1
EXT3 FS on sda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
cirrusfb: This board has 1048576 bytes of DRAM memory
cirrusfb: This board has 1048576 bytes of DRAM memory
cirrusfb: This board has 1048576 bytes of DRAM memory
cirrusfb: This board has 1048576 bytes of DRAM memory
cirrusfb: This board has 1048576 bytes of DRAM memory
cirrusfb: This board has 1048576 bytes of DRAM memory
cirrusfb: This board has 1048576 bytes of DRAM memory
cirrusfb: This board has 1048576 bytes of DRAM memory

--Boundary-00=_FC92B62BObB5Mc5--
