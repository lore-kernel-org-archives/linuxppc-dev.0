Return-Path: <luca.manai@duolabs.com>
Received: from ml3.1stcomwebhosting.com (31.52.11.204.1stcomwebhosting.com
	[204.11.52.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36637DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 01:11:56 +1100 (EST)
Received: from [217.194.179.100] (port=42451 helo=[192.168.0.50])
	by ml3.1stcomwebhosting.com with esmtpa (Exim 4.52)
	id 1HKEIy-0007H8-5l
	for linuxppc-embedded@ozlabs.org; Thu, 22 Feb 2007 08:48:16 -0500
Message-ID: <45DD9F03.6060004@duolabs.com>
Date: Thu, 22 Feb 2007 14:47:47 +0100
From: Luca Manai <luca.manai@duolabs.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Help with a board similar to the Xilinx ML403
Content-Type: multipart/alternative;
	boundary="------------010708070008040200060401"
Reply-To: luca.manai@duolabs.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010708070008040200060401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

I would need some help to understand what is the problem...
I am a bit lost...

The board is very similar to the Xilinx ML403 with a Virtex-4 and PPC 405.

What can I provide to make the debugging easier?

Can the problem be the content of the initrd RAM disk?

Thanks for your help.

Luca.

===========================================================================

loaded at:     00400000 0065213C
board data at: 00650124 0065013C
relocated to:  0040408C 004040A4
zimage at:     00404E19 004F055F
initrd at:     004F1000 0064FE30
avail ram:     00653000 04000000

Linux/PPC load: console=ttyS0,9600
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.20 (rapax@localhost.localdomain) (gcc 
version 3.4.4) #24 Thu Feb 22 14:26:45 CET 2007
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    16384
[    0.000000]   Normal      16384 ->    16384
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    16384
[    0.000000] Built 1 zonelists.  Total pages: 16256
[    0.000000] Kernel command line: console=ttyS0,9600
[    0.000000] Xilinx INTC #0 at 0x05810000 mapped to 0xFDFFE000
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000254] Console: colour dummy device 80x25
[    0.001029] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.002145] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.022641] Memory: 61408k available (1560k kernel code, 432k data, 
100k init, 0k highmem)
[    0.208605] Mount-cache hash table entries: 512
[    0.215183] NET: Registered protocol family 16
[    0.240164] NET: Registered protocol family 2
[    0.296652] IP route cache hash table entries: 1024 (order: 0, 4096 
bytes)
[    0.297952] TCP established hash table entries: 2048 (order: 1, 8192 
bytes)
[    0.298188] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.298314] TCP: Hash tables configured (established 2048 bind 1024)
[    0.298347] TCP reno registered
[    0.317702] checking if image is initramfs...it isn't (no cpio 
magic); looks like an initrd
[    1.078167] Freeing initrd memory: 1403k freed
[    1.085007] io scheduler noop registered
[    1.085068] io scheduler anticipatory registered (default)
[    1.085098] io scheduler deadline registered
[    1.085303] io scheduler cfq registered
[    1.158419] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ 
sharing disabled
[    1.166897] serial8250.0: ttyS0 at MMIO 0x6001003 (irq = 5) is a 16550A
[    1.868935] RAMDISK driver initialized: 16 RAM disks of 65536K size 
1024 blocksize
[    1.901545] tun: Universal TUN/TAP device driver, 1.6
[    1.921877] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.948919] XTemac: using sgDMA mode.
[    1.963764] XTemac: using TxDRE mode
[    1.978133] XTemac: using RxDRE mode
[    1.992471] XTemac: buffer descriptor size: 32768 (0x8000)
[    2.015328] XTemac: (buffer_descriptor_init) phy: 0x610000, virt: 
0xff100000, size: 0x8000
[    2.055149] eth0: Dropping NETIF_F_SG since no checksum feature.
[    2.080791] eth0: Xilinx TEMAC #0 at 0xFFE00000 mapped to 0xC5000000, 
irq=4
[    2.108767] eth0: XTemac id 1.0f, block id 5, type 8
[    2.129728] mice: PS/2 mouse device common for all mice
[    2.151097] TCP cubic registered
[    2.164340] NET: Registered protocol family 1
[    2.181936] NET: Registered protocol family 17
[    2.201411] RAMDISK: Compressed image found at block 0
[    3.229002] VFS: Mounted root (ext2 filesystem).
[    3.355400] ------------[ cut here ]------------
[    3.373911] kernel BUG at mm/prio_tree.c:79!
[    3.390991] Oops: Exception in kernel mode, sig: 5 [#1]
[    3.411889] NIP: C003FA34 LR: C0044D68 CTR: 00000000
[    3.431752] REGS: c04b7dc0 TRAP: 0700   Not tainted  (2.6.20)
[    3.454721] MSR: 00029030 <EE,ME,IR,DR>  CR: 44088048  XER: 2000000E
[    3.480351] TASK = c02a9490[140] 'ifconfig' THREAD: c04b6000
[    3.502282] GPR00: 00000001 C04B7E70 C02A9490 C0486BA8 C044E95C 
C04B7E20 C04B7E24 0FFDF000
[    3.535955] GPR08: 000000AD 00000010 0000000F 00000011 24004042 
10065ABC 00000001 30017510
[    3.569632] GPR16: 10001B05 00000000 0FFDF000 000000AD C0432B94 
00000000 C0432BA8 00000000
[    3.603306] GPR24: C0675E20 00000000 0FFF0000 C044BA00 00000000 
C0486B54 C0486BA8 C0486DA0
[    3.637713] NIP [C003FA34] vma_prio_tree_add+0x54/0xd0
[    3.658333] LR [C0044D68] vma_adjust+0x264/0x384
[    3.676836] Call Trace:
[    3.686598] [C04B7E70] [C0044D68] vma_adjust+0x264/0x384 (unreliable)
[    3.712428] [C04B7ED0] [C0045B2C] split_vma+0x118/0x13c
[    3.733395] [C04B7EF0] [C0046CF8] sys_mprotect+0x210/0x4dc
[    3.755370] [C04B7F40] [C0002E54] ret_from_syscall+0x0/0x3c
[    3.777723] Instruction dump:
[    3.789602] 80040008 7d675850 7c0a0050 556ba33e 5400a33e 7d295a14 
7d080214 3908ffff
[    3.820807] 3929ffff 7d294278 3149ffff 7c0a4910 <0f000000> 39200000 
9123002c 8004002c


--------------010708070008040200060401
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="-1"><font face="Courier New, Courier, monospace">Hello.<br>
<br>
I would need some help to understand what is the problem...<br>
I am a bit lost...<br>
<br>
The board is very similar to the Xilinx ML403 with a Virtex-4 and PPC
405.<br>
<br>
What can I provide to make the debugging easier?<br>
<br>
Can the problem be the content of the initrd RAM disk?<br>
<br>
Thanks for your help.<br>
<br>
Luca.<br>
<br>
===========================================================================<br>
<br>
loaded at:&nbsp;&nbsp;&nbsp;&nbsp; 00400000 0065213C<br>
board data at: 00650124 0065013C<br>
relocated to:&nbsp; 0040408C 004040A4<br>
zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 00404E19 004F055F<br>
initrd at:&nbsp;&nbsp;&nbsp;&nbsp; 004F1000 0064FE30<br>
avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 00653000 04000000<br>
<br>
Linux/PPC load: console=ttyS0,9600<br>
Uncompressing Linux...done.<br>
Now booting the kernel<br>
[&nbsp;&nbsp;&nbsp; 0.000000] Linux version 2.6.20 (<a class="moz-txt-link-abbreviated" href="mailto:rapax@localhost.localdomain">rapax@localhost.localdomain</a>) (gcc
version 3.4.4) #24 Thu Feb 22 14:26:45 CET 2007<br>
[&nbsp;&nbsp;&nbsp; 0.000000] Xilinx ML403 Reference System (Virtex-4 FX)<br>
[&nbsp;&nbsp;&nbsp; 0.000000] Zone PFN ranges:<br>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 16384<br>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16384 -&gt;&nbsp;&nbsp;&nbsp; 16384<br>
[&nbsp;&nbsp;&nbsp; 0.000000] early_node_map[1] active PFN ranges<br>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 16384<br>
[&nbsp;&nbsp;&nbsp; 0.000000] Built 1 zonelists.&nbsp; Total pages: 16256<br>
[&nbsp;&nbsp;&nbsp; 0.000000] Kernel command line: console=ttyS0,9600<br>
[&nbsp;&nbsp;&nbsp; 0.000000] Xilinx INTC #0 at 0x05810000 mapped to 0xFDFFE000<br>
[&nbsp;&nbsp;&nbsp; 0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)<br>
[&nbsp;&nbsp;&nbsp; 0.000254] Console: colour dummy device 80x25<br>
[&nbsp;&nbsp;&nbsp; 0.001029] Dentry cache hash table entries: 8192 (order: 3, 32768
bytes)<br>
[&nbsp;&nbsp;&nbsp; 0.002145] Inode-cache hash table entries: 4096 (order: 2, 16384
bytes)<br>
[&nbsp;&nbsp;&nbsp; 0.022641] Memory: 61408k available (1560k kernel code, 432k data,
100k init, 0k highmem)<br>
[&nbsp;&nbsp;&nbsp; 0.208605] Mount-cache hash table entries: 512<br>
[&nbsp;&nbsp;&nbsp; 0.215183] NET: Registered protocol family 16<br>
[&nbsp;&nbsp;&nbsp; 0.240164] NET: Registered protocol family 2<br>
[&nbsp;&nbsp;&nbsp; 0.296652] IP route cache hash table entries: 1024 (order: 0, 4096
bytes)<br>
[&nbsp;&nbsp;&nbsp; 0.297952] TCP established hash table entries: 2048 (order: 1, 8192
bytes)<br>
[&nbsp;&nbsp;&nbsp; 0.298188] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)<br>
[&nbsp;&nbsp;&nbsp; 0.298314] TCP: Hash tables configured (established 2048 bind 1024)<br>
[&nbsp;&nbsp;&nbsp; 0.298347] TCP reno registered<br>
[&nbsp;&nbsp;&nbsp; 0.317702] checking if image is initramfs...it isn't (no cpio
magic); looks like an initrd<br>
[&nbsp;&nbsp;&nbsp; 1.078167] Freeing initrd memory: 1403k freed<br>
[&nbsp;&nbsp;&nbsp; 1.085007] io scheduler noop registered<br>
[&nbsp;&nbsp;&nbsp; 1.085068] io scheduler anticipatory registered (default)<br>
[&nbsp;&nbsp;&nbsp; 1.085098] io scheduler deadline registered<br>
[&nbsp;&nbsp;&nbsp; 1.085303] io scheduler cfq registered<br>
[&nbsp;&nbsp;&nbsp; 1.158419] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
sharing disabled<br>
[&nbsp;&nbsp;&nbsp; 1.166897] serial8250.0: ttyS0 at MMIO 0x6001003 (irq = 5) is a
16550A<br>
[&nbsp;&nbsp;&nbsp; 1.868935] RAMDISK driver initialized: 16 RAM disks of 65536K size
1024 blocksize<br>
[&nbsp;&nbsp;&nbsp; 1.901545] tun: Universal TUN/TAP device driver, 1.6<br>
[&nbsp;&nbsp;&nbsp; 1.921877] tun: (C) 1999-2004 Max Krasnyansky
<a class="moz-txt-link-rfc2396E" href="mailto:maxk@qualcomm.com">&lt;maxk@qualcomm.com&gt;</a><br>
[&nbsp;&nbsp;&nbsp; 1.948919] XTemac: using sgDMA mode.<br>
[&nbsp;&nbsp;&nbsp; 1.963764] XTemac: using TxDRE mode<br>
[&nbsp;&nbsp;&nbsp; 1.978133] XTemac: using RxDRE mode<br>
[&nbsp;&nbsp;&nbsp; 1.992471] XTemac: buffer descriptor size: 32768 (0x8000)<br>
[&nbsp;&nbsp;&nbsp; 2.015328] XTemac: (buffer_descriptor_init) phy: 0x610000, virt:
0xff100000, size: 0x8000<br>
[&nbsp;&nbsp;&nbsp; 2.055149] eth0: Dropping NETIF_F_SG since no checksum feature.<br>
[&nbsp;&nbsp;&nbsp; 2.080791] eth0: Xilinx TEMAC #0 at 0xFFE00000 mapped to
0xC5000000, irq=4<br>
[&nbsp;&nbsp;&nbsp; 2.108767] eth0: XTemac id 1.0f, block id 5, type 8<br>
[&nbsp;&nbsp;&nbsp; 2.129728] mice: PS/2 mouse device common for all mice<br>
[&nbsp;&nbsp;&nbsp; 2.151097] TCP cubic registered<br>
[&nbsp;&nbsp;&nbsp; 2.164340] NET: Registered protocol family 1<br>
[&nbsp;&nbsp;&nbsp; 2.181936] NET: Registered protocol family 17<br>
[&nbsp;&nbsp;&nbsp; 2.201411] RAMDISK: Compressed image found at block 0<br>
[&nbsp;&nbsp;&nbsp; 3.229002] VFS: Mounted root (ext2 filesystem).<br>
[&nbsp;&nbsp;&nbsp; 3.355400] ------------[ cut here ]------------<br>
[&nbsp;&nbsp;&nbsp; 3.373911] kernel BUG at mm/prio_tree.c:79!<br>
[&nbsp;&nbsp;&nbsp; 3.390991] Oops: Exception in kernel mode, sig: 5 [#1]<br>
[&nbsp;&nbsp;&nbsp; 3.411889] NIP: C003FA34 LR: C0044D68 CTR: 00000000<br>
[&nbsp;&nbsp;&nbsp; 3.431752] REGS: c04b7dc0 TRAP: 0700&nbsp;&nbsp; Not tainted&nbsp; (2.6.20)<br>
[&nbsp;&nbsp;&nbsp; 3.454721] MSR: 00029030 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 44088048&nbsp; XER:
2000000E<br>
[&nbsp;&nbsp;&nbsp; 3.480351] TASK = c02a9490[140] 'ifconfig' THREAD: c04b6000<br>
[&nbsp;&nbsp;&nbsp; 3.502282] GPR00: 00000001 C04B7E70 C02A9490 C0486BA8 C044E95C
C04B7E20 C04B7E24 0FFDF000 <br>
[&nbsp;&nbsp;&nbsp; 3.535955] GPR08: 000000AD 00000010 0000000F 00000011 24004042
10065ABC 00000001 30017510 <br>
[&nbsp;&nbsp;&nbsp; 3.569632] GPR16: 10001B05 00000000 0FFDF000 000000AD C0432B94
00000000 C0432BA8 00000000 <br>
[&nbsp;&nbsp;&nbsp; 3.603306] GPR24: C0675E20 00000000 0FFF0000 C044BA00 00000000
C0486B54 C0486BA8 C0486DA0 <br>
[&nbsp;&nbsp;&nbsp; 3.637713] NIP [C003FA34] vma_prio_tree_add+0x54/0xd0<br>
[&nbsp;&nbsp;&nbsp; 3.658333] LR [C0044D68] vma_adjust+0x264/0x384<br>
[&nbsp;&nbsp;&nbsp; 3.676836] Call Trace:<br>
[&nbsp;&nbsp;&nbsp; 3.686598] [C04B7E70] [C0044D68] vma_adjust+0x264/0x384 (unreliable)<br>
[&nbsp;&nbsp;&nbsp; 3.712428] [C04B7ED0] [C0045B2C] split_vma+0x118/0x13c<br>
[&nbsp;&nbsp;&nbsp; 3.733395] [C04B7EF0] [C0046CF8] sys_mprotect+0x210/0x4dc<br>
[&nbsp;&nbsp;&nbsp; 3.755370] [C04B7F40] [C0002E54] ret_from_syscall+0x0/0x3c<br>
[&nbsp;&nbsp;&nbsp; 3.777723] Instruction dump:<br>
[&nbsp;&nbsp;&nbsp; 3.789602] 80040008 7d675850 7c0a0050 556ba33e 5400a33e 7d295a14
7d080214 3908ffff <br>
[&nbsp;&nbsp;&nbsp; 3.820807] 3929ffff 7d294278 3149ffff 7c0a4910 &lt;0f000000&gt;
39200000 9123002c 8004002c <br>
<br>
</font></font>
</body>
</html>

--------------010708070008040200060401--
