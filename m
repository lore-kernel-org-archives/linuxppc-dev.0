Message-ID: <408E1ED0.4050404@fh-landshut.de>
Date: Tue, 27 Apr 2004 10:50:24 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: Marius Groeger <mgroeger@sysgo.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Initrd and PPCbug, can it work?
References: <Pine.LNX.4.58.0404211503050.20798@ppcproject1> <20040426220944.GI19246@smtp.west.cox.net> <408E000A.6040303@fh-landshut.de> <Pine.LNX.4.56.0404270913230.2035@mag.sysgo.com>
In-Reply-To: <Pine.LNX.4.56.0404270913230.2035@mag.sysgo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marius Groeger wrote:
>
> Please do so. We're booting initrd images from PPC-Bug fine over here
> (MVME2700), so I'd be interested in potential catches.
>
> Regards,
> Marius
>

Marius, would you be so kind to share with me, how you configured your
board, so that it boots from initrd? My problem seems to be a
configuration error, at least until proven otherwise...

My bootup with PPCbug is given below (look at the kernel commandline,
perhaps this is wrong, but I do not know how to set it reasonably).

The initrd image was made with ext2, copied over to
arch/ppc/boot/images/ramdisk.image.gz, and I made make zImage.initrd


With kind regards,
Oliver Korpilla

After entering NBO, it looks like this (NBO is set to load the
zImage.initrd):

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&1276607, Bytes Loaded =&1276607
Bytes/Second   =&638303, Elapsed Time =2 Second(s)

Residual-Data Located at: $01F5511C
loaded at:     00005400 0013E5BC
relocated to:  00800000 009391BC
zimage at:     008058A0 008B7749
initrd at:     008B8000 009356B8
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 root=/dev/ram0
Uncompressing Linux...done.
Now booting the kernel
Memory BAT mapping: BAT2=32Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.25 (korpo@ppcproject1) (gcc version 2.95.3 20010315
(release)) #18 Tue Apr 27 10:38:09 CEST 2004
Platform: Motorola MVME2100

On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 root=/dev/ram0
OpenPIC Version 1.2 (1 CPUs and 16 IRQ sources) at f7fd0000
OpenPIC timer frequency is 8.333344 MHz
time_init: decrementer frequency = 16.666754 MHz
Calibrating delay loop... 133.12 BogoMIPS
Memory: 30488k available (1180k kernel code, 452k data, 252k init, 0k
highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)

Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0xffe10000 (irq = 25) is a 16550A

Generic RTC Driver v1.07
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #8 config 1000 status 7809 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 0xbfffec00, 00:01:AF:02:93:8C, IRQ 16.
pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cramfs: wrong magic
Kernel panic: VFS: Unable to mount root fs on 01:00
  <0>Rebooting in 180 seconds..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
