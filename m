Return-Path: <christophe.alayrac@cresitt.com>
Received: from smtp4-g19.free.fr (smtp4-g19.free.fr [212.27.42.30])
	by ozlabs.org (Postfix) with ESMTP id AC99CDDED8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 22:43:23 +1100 (EST)
Received: from [192.168.0.2] (sou45-1-82-229-118-71.fbx.proxad.net
	[82.229.118.71])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 10B978862
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 12:43:21 +0100 (CET)
Subject: ML403, 2.6.17.1 kernel panic
From: alayrac christophe <christophe.alayrac@cresitt.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 23 Jan 2007 13:43:15 +0100
Message-Id: <1169556195.16144.3.camel@localhost.localdomain>
Mime-Version: 1.0
Reply-To: christophe.alayrac@cresitt.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I did not succeed to start kernel 2.6.17.1 on ML403 platform.

Any help would be appreciated.

Please foind log message here after

<--------------------------------------------->
loaded at:     00400000 0051313C
board data at: 00511124 0051113C
relocated to:  004050F0 00405108
zimage at:     00405805 00510151
avail ram:     00514000 10000000

Linux/PPC load: console=ttyS0,9600 ip=off root=/dev/xsa2 rw
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.17.1 (alayrac@debian-ca) (gcc version
3.4.4) #6 Tue Jan 23 13:02:07 CET 2007
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: console=ttyS0,9600 ip=off
root=/dev/xsa2 rw
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
[    0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)
[    0.000447] Console: colour dummy device 80x25
[    0.004755] Dentry cache hash table entries: 32768 (order: 5, 131072
bytes)
[    0.012362] Inode-cache hash table entries: 16384 (order: 4, 65536
bytes)
[    0.150082] Memory: 257408k available (1720k kernel code, 604k data,
92k init, 0k highmem)
[    0.233054] Mount-cache hash table entries: 512
[    0.248273] NET: Registered protocol family 16
[    0.269541] NET: Registered protocol family 2
[    0.309165] IP route cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.311470] TCP established hash table entries: 8192 (order: 3, 32768
bytes)
[    0.313095] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.313868] TCP: Hash tables configured (established 8192 bind 4096)
[    0.313969] TCP reno registered
[    0.340676] NTFS driver 2.1.27 [Flags: R/O].
[    0.341618] io scheduler noop registered
[    0.341905] io scheduler anticipatory registered (default)
[    0.342144] io scheduler deadline registered
[    0.342556] io scheduler cfq registered
[    0.445374] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
sharing disabled
[    0.456887] serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 3) is a
16550A
[    2.198859] RAMDISK driver initialized: 16 RAM disks of 8192K size
1024 blocksize
[    2.302352] loop: loaded (max 8 devices)
[    2.352351] nbd: registered device at major 43
[    2.441661]  xsa: xsa1 xsa2
[    2.494925] Data machine check in kernel mode.
[    2.548283] Oops: machine check, sig: 7 [#1]
[    2.599427] NIP: C013C8D8 LR: C012C5E8 CTR: 00000000
[    2.658911] REGS: c023cf50 TRAP: 0202   Not tainted  (2.6.17.1)
[    2.729919] MSR: 00029030 <EE,ME,IR,DR>  CR: 84000048  XER: 20000030
[    2.806810] TASK = c04a9b40[1] 'swapper' THREAD: c04b0000
[    2.869491] GPR00: 0000000A C04B1E10 C04A9B40 C01CD6A8 00000068
D1042200 C057942C C056A418 
[    2.970525] GPR08: C056A260 C0579304 D1042010 11111111 00000000
FFFFFFFF FFFFFFFF FFFFFFFF 
[    3.071561] GPR16: FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF
00510FFC FFFFEFFF FFFFFFFF 
[    3.172597] GPR24: FFFFFFFF C01EF708 C05792D8 C01EF858 C01EF820
C01EF700 C0579260 C0240000 
[    3.275823] NIP [C013C8D8] XPacketFifoV200a_Initialize+0x60/0x7c
[    3.348007] LR [C012C5E8] XTemac_ConfigureFifoAccess+0x28/0x9c
[    3.418100] Call Trace:
[    3.447386] [C04B1E10] [C000ACE8] __ioremap+0xe8/0x14c (unreliable)
[    3.522798] [C04B1E20] [C012C5E8] XTemac_ConfigureFifoAccess
+0x28/0x9c
[    3.601334] [C04B1E30] [C012ACF0] Initialize+0x3c/0xd0
[    3.663101] [C04B1E40] [C012A35C] xtenet_probe+0x14c/0x608
[    3.729033] [C04B1EB0] [C011E964] driver_probe_device+0x90/0x108
[    3.801321] [C04B1ED0] [C011EB18] __driver_attach+0x88/0xf4
[    3.868296] [C04B1EF0] [C011DC68] bus_for_each_dev+0x54/0x94
[    3.936313] [C04B1F20] [C011EBA8] driver_attach+0x24/0x34
[    4.001204] [C04B1F30] [C011E274] bus_add_driver+0x74/0x148
[    4.068180] [C04B1F50] [C011F150] driver_register+0xa4/0xb8
[    4.135153] [C04B1F80] [C0233D58] xtenet_init+0x18/0x28
[    4.198066] [C04B1F90] [C0002454] init+0xa4/0x27c
[    4.254624] [C04B1FF0] [C000509C] kernel_thread+0x44/0x60
[    4.319606] Instruction dump:
[    4.355234] 40a20014 4bffff79 38000001 901fb758 48000024 38000000
901fb758 91690004 
[    4.448871] 90a90008 91490000 3800000a 900a0000 <7c0006ac> 80010014
38600000 83e1000c 
[    4.548246] Kernel panic - not syncing: Attempted to kill init!
[    4.619432]  <0>Rebooting in 180 seconds..
<--------------------------------------------->

Regards

Chris
