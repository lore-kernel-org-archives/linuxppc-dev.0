Return-Path: <Leonid@a-k-a.net>
Received: from mis011-2.exch011.intermedia.net
	(mis011-2.exch011.intermedia.net [64.78.21.129])
	by ozlabs.org (Postfix) with ESMTP id 67409DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 05:37:07 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Help with a board similar to the Xilinx ML403
Date: Thu, 22 Feb 2007 10:37:01 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3C0108D8DA@ehost011-3.exch011.intermedia.net>
In-Reply-To: <45DD9F03.6060004@duolabs.com>
References: <45DD9F03.6060004@duolabs.com>
From: "Leonid" <Leonid@a-k-a.net>
To: <luca.manai@duolabs.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Can I see your xparameters.h and kernel .config files please? EDK =
project can help as well, or at least MHS & MSS files along with BSP TCL =
scripts - I think you use some Linux BSP, right?=20

Also how do you load kernel - using u-boot? If so, can you please define =
DEBUG in cmd_bootm.c file and send me output?

Thanks,

Leonid.=20

________________________________________
From: linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org =
[mailto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org] On =
Behalf Of Luca Manai
Sent: Thursday, February 22, 2007 5:48 AM
To: linuxppc-embedded@ozlabs.org
Subject: Help with a board similar to the Xilinx ML403

Hello.

I would need some help to understand what is the problem...
I am a bit lost...

The board is very similar to the Xilinx ML403 with a Virtex-4 and PPC =
405.

What can I provide to make the debugging easier?

Can the problem be the content of the initrd RAM disk?

Thanks for your help.

Luca.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=


loaded at:=A0=A0=A0=A0 00400000 0065213C
board data at: 00650124 0065013C
relocated to:=A0 0040408C 004040A4
zimage at:=A0=A0=A0=A0 00404E19 004F055F
initrd at:=A0=A0=A0=A0 004F1000 0064FE30
avail ram:=A0=A0=A0=A0 00653000 04000000

Linux/PPC load: console=3DttyS0,9600
Uncompressing Linux...done.
Now booting the kernel
[=A0=A0=A0 0.000000] Linux version 2.6.20 (rapax@localhost.localdomain) =
(gcc version 3.4.4) #24 Thu Feb 22 14:26:45 CET 2007
[=A0=A0=A0 0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[=A0=A0=A0 0.000000] Zone PFN ranges:
[=A0=A0=A0 0.000000]=A0=A0 DMA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =
->=A0=A0=A0 16384
[=A0=A0=A0 0.000000]=A0=A0 Normal=A0=A0=A0=A0=A0 16384 ->=A0=A0=A0 16384
[=A0=A0=A0 0.000000] early_node_map[1] active PFN ranges
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 0:=A0=A0=A0=A0=A0=A0=A0 0 ->=A0=A0=A0 =
16384
[=A0=A0=A0 0.000000] Built 1 zonelists.=A0 Total pages: 16256
[=A0=A0=A0 0.000000] Kernel command line: console=3DttyS0,9600
[=A0=A0=A0 0.000000] Xilinx INTC #0 at 0x05810000 mapped to 0xFDFFE000
[=A0=A0=A0 0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[=A0=A0=A0 0.000254] Console: colour dummy device 80x25
[=A0=A0=A0 0.001029] Dentry cache hash table entries: 8192 (order: 3, =
32768 bytes)
[=A0=A0=A0 0.002145] Inode-cache hash table entries: 4096 (order: 2, =
16384 bytes)
[=A0=A0=A0 0.022641] Memory: 61408k available (1560k kernel code, 432k =
data, 100k init, 0k highmem)
[=A0=A0=A0 0.208605] Mount-cache hash table entries: 512
[=A0=A0=A0 0.215183] NET: Registered protocol family 16
[=A0=A0=A0 0.240164] NET: Registered protocol family 2
[=A0=A0=A0 0.296652] IP route cache hash table entries: 1024 (order: 0, =
4096 bytes)
[=A0=A0=A0 0.297952] TCP established hash table entries: 2048 (order: 1, =
8192 bytes)
[=A0=A0=A0 0.298188] TCP bind hash table entries: 1024 (order: 0, 4096 =
bytes)
[=A0=A0=A0 0.298314] TCP: Hash tables configured (established 2048 bind =
1024)
[=A0=A0=A0 0.298347] TCP reno registered
[=A0=A0=A0 0.317702] checking if image is initramfs...it isn't (no cpio =
magic); looks like an initrd
[=A0=A0=A0 1.078167] Freeing initrd memory: 1403k freed
[=A0=A0=A0 1.085007] io scheduler noop registered
[=A0=A0=A0 1.085068] io scheduler anticipatory registered (default)
[=A0=A0=A0 1.085098] io scheduler deadline registered
[=A0=A0=A0 1.085303] io scheduler cfq registered
[=A0=A0=A0 1.158419] Serial: 8250/16550 driver $Revision: 1.90 $ 4 =
ports, IRQ sharing disabled
[=A0=A0=A0 1.166897] serial8250.0: ttyS0 at MMIO 0x6001003 (irq =3D 5) =
is a 16550A
[=A0=A0=A0 1.868935] RAMDISK driver initialized: 16 RAM disks of 65536K =
size 1024 blocksize
[=A0=A0=A0 1.901545] tun: Universal TUN/TAP device driver, 1.6
[=A0=A0=A0 1.921877] tun: (C) 1999-2004 Max Krasnyansky =
<maxk@qualcomm.com>
[=A0=A0=A0 1.948919] XTemac: using sgDMA mode.
[=A0=A0=A0 1.963764] XTemac: using TxDRE mode
[=A0=A0=A0 1.978133] XTemac: using RxDRE mode
[=A0=A0=A0 1.992471] XTemac: buffer descriptor size: 32768 (0x8000)
[=A0=A0=A0 2.015328] XTemac: (buffer_descriptor_init) phy: 0x610000, =
virt: 0xff100000, size: 0x8000
[=A0=A0=A0 2.055149] eth0: Dropping NETIF_F_SG since no checksum =
feature.
[=A0=A0=A0 2.080791] eth0: Xilinx TEMAC #0 at 0xFFE00000 mapped to =
0xC5000000, irq=3D4
[=A0=A0=A0 2.108767] eth0: XTemac id 1.0f, block id 5, type 8
[=A0=A0=A0 2.129728] mice: PS/2 mouse device common for all mice
[=A0=A0=A0 2.151097] TCP cubic registered
[=A0=A0=A0 2.164340] NET: Registered protocol family 1
[=A0=A0=A0 2.181936] NET: Registered protocol family 17
[=A0=A0=A0 2.201411] RAMDISK: Compressed image found at block 0
[=A0=A0=A0 3.229002] VFS: Mounted root (ext2 filesystem).
[=A0=A0=A0 3.355400] ------------[ cut here ]------------
[=A0=A0=A0 3.373911] kernel BUG at mm/prio_tree.c:79!
[=A0=A0=A0 3.390991] Oops: Exception in kernel mode, sig: 5 [#1]
[=A0=A0=A0 3.411889] NIP: C003FA34 LR: C0044D68 CTR: 00000000
[=A0=A0=A0 3.431752] REGS: c04b7dc0 TRAP: 0700=A0=A0 Not tainted=A0 =
(2.6.20)
[=A0=A0=A0 3.454721] MSR: 00029030 <EE,ME,IR,DR>=A0 CR: 44088048=A0 XER: =
2000000E
[=A0=A0=A0 3.480351] TASK =3D c02a9490[140] 'ifconfig' THREAD: c04b6000
[=A0=A0=A0 3.502282] GPR00: 00000001 C04B7E70 C02A9490 C0486BA8 C044E95C =
C04B7E20 C04B7E24 0FFDF000=20
[=A0=A0=A0 3.535955] GPR08: 000000AD 00000010 0000000F 00000011 24004042 =
10065ABC 00000001 30017510=20
[=A0=A0=A0 3.569632] GPR16: 10001B05 00000000 0FFDF000 000000AD C0432B94 =
00000000 C0432BA8 00000000=20
[=A0=A0=A0 3.603306] GPR24: C0675E20 00000000 0FFF0000 C044BA00 00000000 =
C0486B54 C0486BA8 C0486DA0=20
[=A0=A0=A0 3.637713] NIP [C003FA34] vma_prio_tree_add+0x54/0xd0
[=A0=A0=A0 3.658333] LR [C0044D68] vma_adjust+0x264/0x384
[=A0=A0=A0 3.676836] Call Trace:
[=A0=A0=A0 3.686598] [C04B7E70] [C0044D68] vma_adjust+0x264/0x384 =
(unreliable)
[=A0=A0=A0 3.712428] [C04B7ED0] [C0045B2C] split_vma+0x118/0x13c
[=A0=A0=A0 3.733395] [C04B7EF0] [C0046CF8] sys_mprotect+0x210/0x4dc
[=A0=A0=A0 3.755370] [C04B7F40] [C0002E54] ret_from_syscall+0x0/0x3c
[=A0=A0=A0 3.777723] Instruction dump:
[=A0=A0=A0 3.789602] 80040008 7d675850 7c0a0050 556ba33e 5400a33e =
7d295a14 7d080214 3908ffff=20
[=A0=A0=A0 3.820807] 3929ffff 7d294278 3149ffff 7c0a4910 <0f000000> =
39200000 9123002c 8004002c=20
