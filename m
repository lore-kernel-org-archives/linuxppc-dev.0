Reply-To: <jwalden@digitalatlantic.com>
From: "Jerry Walden" <jwalden@digitalatlantic.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Unable to mount root fs on 01:00    
Date: Wed, 2 Apr 2003 13:27:28 -0500
Message-ID: <EGEGIJHKDKJGAJMGIDPNMEGKCKAA.jwalden@digitalatlantic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <742AC4678EF8464697DDDFE3B40F6ECD07E28F@SRV-MAILRND.azisa.co.za>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings:

I am trying to bring linux up on a custom 405GPr Board.
For a while I was getting the error:(RAMDISK: incomplete write (ramdisk too
small?) (-28!= 32768)
and then I discovered the my command line option ramdisk_size=8192 needs to
be
changed to ramdisk_size=16384.

Now I am past the ramdisk too small error, and I am getting the following
error (see complete trace below):

RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Tracer: Initialization complete
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 1473k freed
Kernel panic: VFS: Unable to mount root fs on 01:00

Any suggestions?

Thanks

Jerry Walden

bootm 0x100000 0x200000
## Booting image at 00100000 ...
Image Name:   Linux-2.4.18_mvl30-walnut
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    298672 Bytes = 291.7 kB
Load Address: 00000000
Entry Point:  00000000 Verifying Checksum ... OK
Uncompressing Kernel Image ... OK
## Current stack ends at 0x03F9EBE8 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF45
memstart    = 0x00000000
memsize     = 0x04000000
flashstart  = 0xFFF80000
flashsize   = 0x00080000
flashoffset = 0x00031000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0x001E8480
procfreq    = 266.666 MHz
b_busfreq = 133.333 MHz
pci_busfreq = 33.333 MHz
ethaddr     = 00:00:00:00:00:00
IP addr     = 0.0.0.0
baudrate    =   9600 bps
## Loading RAMDisk Image at 00200000 ...
Image Name:   DA Ramdisk Image
Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
Data Size:    1509352 Bytes =  1.4 MB
Load Address: 00000000
Entry Point:  00000000
Verifying Checksum ... OK
## initrd at 0x00200040 ... 0x00370827 (len=1509352=0x1707E8)
Loading Ramdisk to 03e2d000, end 03f9d7e8 ... OK
## Transferring control to Linux (at address 00000000) ...
Linux version 2.4.18_mvl30-walnut (root@hhl) (gcc version 3.2.1 20020930
(MontaVista)) #33 Tue Mar 25 15:30:00
<6>IBM Sycamore (IBM405GPr) Platform
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw ramdisk_size=16384
console=ttyS0,9600n8 console=tty0
Calibrating delay loop... 266.24 BogoMIPS[1;29r[29;1H
Memory: 62268k available (512k kernel code, 212k data, 32k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
OCP uart ver 1.2 init complete
Starting kswapd
Disabling the Out Of Memory Killer
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0x0000 (irq = 0) is a 16550A
ttyS01 at 0x0000 (irq = 1) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Tracer: Initialization complete
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 1473k freed
Kernel panic: VFS: Unable to mount root fs on 01:00


Jerry Walden


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
