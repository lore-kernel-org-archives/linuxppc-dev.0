Return-Path: <david.hagood@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 247A7B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Sep 2010 07:30:30 +1000 (EST)
Received: by iwn4 with SMTP id 4so1579114iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 14:30:28 -0700 (PDT)
Message-ID: <af75f13d9ed8beb29470dffe56d295f5.squirrel@localhost>
In-Reply-To: <4CA2FDA3.20704@windriver.com>
References: <2bef2051c143a8d6e619519b222016f9.squirrel@localhost>
	<20100928153153.GA22485@ovro.caltech.edu>
	<20100928134554.323667e5@udp111988uds.am.freescale.net>
	<4CA2FDA3.20704@windriver.com>
Date: Wed, 29 Sep 2010 16:24:47 -0500
Subject: Re: Parsing a bus fault message?
From: david.hagood@gmail.com
To: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Scott Wood <scottwood@freescale.com>, david.hagood@gmail.com,
	linuxppc-dev@lists.ozlabs.org, "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Scott Wood wrote:
> I also meet machine check exception if configure LAW improperly for PCI.
> (i.e.
> unmatched PCIe controller id.)
>
> From you log looks 0xexxxxxxx should be your PCI space. So you can check
> if that
>  fall into appropriate LAW configuration. Maybe you can post your boot log
> and
> error log here.

Using EP8641A machine description
Total memory = 1024MB; using 2048kB for hash table (at cfa00000)
Linux version 2.6.26.2-ep1.10 (SRWhite@WIC-102333) (gcc version 4.0.0
(DENX ELDK 4.1 4.0.0)) #269 SMP PREEMPT Tue Sep 28 15:48:43 CDT 2010
Found initrd at 0xcfdfa000:0xcffa9663
Found legacy serial port 0 for /soc8641@e0000000/serial@4500
  mem=e0004500, taddr=e0004500, irq=0, clk=500000000, speed=0
Found legacy serial port 1 for /soc8641@e0000000/serial@4600
  mem=e0004600, taddr=e0004600, irq=0, clk=500000000, speed=0
CPU maps initialized for 1 thread per core
 (thread shift is 0)
console [udbg0] enabled
Entering add_active_range(0, 0, 262144) 0 entries of 256 used
EP8641A board from Embedded Planet
Top of RAM: 0x40000000, Total RAM: 0x40000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA             0 ->   196608
  Normal     196608 ->   196608
  HighMem    196608 ->   262144
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   262144
On node 0 totalpages: 262144
  DMA zone: 1536 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 195072 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
  HighMem zone: 512 pages used for memmap
  HighMem zone: 65024 pages, LIFO batch:15
  Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
Kernel command line: root=/dev/ram rw console=ttyS0,115200
ip=10.200.120.158:::255.255.0.0::eth0
mtdparts=physmap-flash.0:0x1300000(linux)ro,0x6bc0000(jffs),-(rsvd)ro
mpic: Setting up MPIC " MPIC     " version 1.2 at e0040000, max 2 CPUs
mpic: ISU size: 16, shift: 4, mask: f
mpic: Initializing for 80 sources
PID hash table entries: 4096 (order: 12, 16384 bytes)
time_init: decrementer frequency = 125.000000 MHz
time_init: processor frequency   = 1500.000000 MHz
clocksource: timebase mult[2000000] shift[22] registered
clockevent: decrementer mult[2000] shift[16] cpu[0]
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
High memory: 262144k
Memory: 1031248k/1048576k available (3064k kernel code, 16476k reserved,
84k data, 149k bss, 164k init)
Calibrating delay loop... 249.85 BogoMIPS (lpj=499712)
Mount-cache hash table entries: 512
mpic: requesting IPIs ...
Processor 1 found.
Synchronizing timebase
Got ack
score 299, offset 1000
score 299, offset 500
score 299, offset 250
score 299, offset 125
score 299, offset 62
score 297, offset 31
score -299, offset 15
score 297, offset 23
score 253, offset 19
score -299, offset 17
score -269, offset 18
Min 18 (score -269), Max 19 (score 253)
Final offset: 19 (269/300)
clockevent: decrementer mult[2000] shift[16] cpu[1]
Brought up 2 CPUs
net_namespace: 208 bytes
NET: Registered protocol family 16
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 1725k freed
setup_kcore: restrict size=3fffffff
of-fsl-dma e0021300.dma: Probe the Freescale DMA driver for
fsl,eloplus-dma controller at e0021300...
of-fsl-dma-channel e0021100.dma-channe: #0 (fsl,eloplus-dma-channel), irq 20
of-fsl-dma-channel e0021180.dma-channe: #1 (fsl,eloplus-dma-channel), irq 21
of-fsl-dma-channel e0021200.dma-channe: #2 (fsl,eloplus-dma-channel), irq 22
of-fsl-dma-channel e0021280.dma-channe: #3 (fsl,eloplus-dma-channel), irq 23
Setting up RapidIO peer-to-peer network /rapidio@e00c0000
fsl-of-rio e00c0000.rapidio: Of-device full name /rapidio@e00c0000
fsl-of-rio e00c0000.rapidio: Regs start 0xe00c0000 size 0x20000
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size
0x0000000020000000.
fsl-of-rio e00c0000.rapidio: bellirq: 50, txirq: 53, rxirq 54
fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial
fsl-of-rio e00c0000.rapidio: Hardware port width: 4
fsl-of-rio e00c0000.rapidio: Training connection status: Four-lane
fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
msgmni has been set to 1507
io scheduler noop registered (default)
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 42) is a 16550A
console handover: boot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 28) is a 16550A
brd: module loaded
loop: module loaded
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:10:ec:01:1a:d3
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 00:10:ec:81:1a:d3
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
eth2: Gianfar Ethernet Controller Version 1.2, 00:10:ec:41:1a:d3
eth2: Running with NAPI enabled
eth2: 256/256 RX/TX BD ring size
eth3: Gianfar Ethernet Controller Version 1.2, 00:10:ec:c1:1a:d3
eth3: Running with NAPI enabled
eth3: 256/256 RX/TX BD ring size
physmap platform flash device: 08000000 at f8000000
physmap-flash.0: Found 2 x16 devices at 0x0 in 32-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
physmap-flash.0: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
3 cmdlinepart partitions found on MTD device physmap-flash.0
Creating 3 MTD partitions on "physmap-flash.0":
0x00000000-0x01300000 : "linux"
0x01300000-0x07ec0000 : "jffs"
0x07ec0000-0x08000000 : "rsvd"
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
IP-Config: Complete:
     device=eth0, addr=10.200.120.158, mask=255.255.0.0, gw=255.255.255.255,
     host=10.200.120.158, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=255.255.255.255, rootpath=
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 164k init
PHY: e0024520:10 - Link is Up - 100/Full
RIO: discover master port 0, RIO0 mport
rionetlink_init: receive handler registration suceeded!!!!
rionetlink_init: rio_register_driver suceeded!!!!

Besides, in my setup, there are 2 LAWS programmed to point at the PEX: one
mapping A0000000 to BFFFFFFF to the PEX, and one mapping  E2000000 to
E2FFFFFF. My code directly scans the LAWS and picks the first one it sees
mapped to the PEX, so it is picking A00000000, and using that. Is there an
issue with having 2 LAWs mapping the same device to different locations?


Being unfortunately a man of many hats, I haven't had a lot of time today
to work on this particular fire. Hopefully in the next couple of days I
can get some more time to look into it more.

I do thank all of you for the pointers, and I'll look into them.

(BTW: Anybody near Wichita, and want to earn some extra $$$ helping me out?)
