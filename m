Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 119A3DDFF3
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 01:18:39 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 569142273C9
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 15:18:47 +0100 (CET)
Received: from [10.0.30.2] (p4FE673A2.dip.t-dialin.net [79.230.115.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id D44879006C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 15:18:37 +0100 (CET)
Message-ID: <47E2723D.1090101@grandegger.com>
Date: Thu, 20 Mar 2008 15:18:37 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Oops with TQM5200 on TQM5200
Content-Type: multipart/mixed; boundary="------------020806020303090007040707"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020806020303090007040707
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

I just tried Linux 2.6.25-rc6 on my TQM5200 module and got the attached
oops. Are there any known patches fixing the problems?

TIA.

Wolfgang.

--------------020806020303090007040707
Content-Type: text/x-log;
 name="oops.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="oops.log"

## Booting image at 00200000 ...
   Image Name:   Linux-2.6.25-rc6-01058-gf8937ce-
   Created:      2008-03-20  13:19:36 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1697503 Bytes =  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0x400000
[    0.000000] Using mpc5200-simple-platform machine description
[    0.000000] Linux version 2.6.25-rc6-01058-gf8937ce-dirty (wolf@lancy.lan.de) (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #14 Thu Mar 20 14:19:25 CET 2008
[    0.000000] PCI host bridge /pci@f0000d00 (primary) ranges:
[    0.000000]  MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 Prefetch
[    0.000000]  MEM 0x0000000090000000..0x000000009fffffff -> 0x0000000090000000 
[    0.000000]   IO 0x00000000a0000000..0x00000000a0ffffff -> 0x0000000000000000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    16384
[    0.000000]   Normal      16384 ->    16384
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    16384
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
[    0.000000] Kernel command line: root=/dev/nfs rw nfsroot=10.0.30.2:/opt/eldk/ppc_6xx ip=10.0.30.210:10.0.30.2:::tqm5200:eth0:off panic=1 console=ttyPSC0,115200
[    0.000000] MPC52xx PIC is up and running!
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000014] clocksource: timebase mult[79364d9] shift[22] registered
[    0.000241] console [ttyPSC0] enabled
[    0.004376] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.008573] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.021186] Memory: 61236k/65536k available (3328k kernel code, 4236k reserved, 120k data, 149k bss, 180k init)
[    0.024179] SLUB: Genslabs=12, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
[    0.120160] Mount-cache hash table entries: 512
[    0.128111] net_namespace: 152 bytes
[    0.133162] NET: Registered protocol family 16
[    0.150957] PCI: Probing PCI hardware
[    0.168836] SCSI subsystem initialized
[    0.174379] usbcore: registered new interface driver usbfs
[    0.176629] usbcore: registered new interface driver hub
[    0.180942] usbcore: registered new device driver usb
[    0.200000] Time: timebase clocksource has been installed.
[    0.208268] NET: Registered protocol family 2
[    0.252350] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.260660] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    0.268181] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.272125] TCP: Hash tables configured (established 2048 bind 2048)
[    0.276028] TCP reno registered
[    0.338145] JFFS2 version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
[    0.342627] io scheduler noop registered
[    0.344114] io scheduler anticipatory registered (default)
[    0.348032] io scheduler deadline registered
[    0.352847] io scheduler cfq registered
[    0.778513] Generic RTC Driver v1.07
[    0.780658] Serial: MPC52xx PSC UART driver
[    0.784474] f0002000.serial: ttyPSC0 at MMIO 0xf0002000 (irq = 129) is a MPC52xx PSC
[    0.793028] f0002200.serial: ttyPSC1 at MMIO 0xf0002200 (irq = 130) is a MPC52xx PSC
[    0.797297] f0002400.serial: ttyPSC2 at MMIO 0xf0002400 (irq = 131) is a MPC52xx PSC
[    0.814501] brd: module loaded
[    0.823106] loop: module loaded
[    0.824132] vcan: Virtual CAN interface driver
[    0.828033] slcan: serial line CAN interface driver
[    0.832030] slcan: 10 dynamic interface channels.
[    0.840408] mpc52xx-mscan mpc52xx-mscan.0: probe for port at 0xC5062900 done (irq 145)
[    0.846001] mpc52xx-mscan mpc52xx-mscan.1: probe for port at 0xC5064980 done (irq 146)
[    0.852251] Unable to handle kernel paging request for data at address 0x0000000c
[    0.860026] Faulting instruction address: 0xc0017fec
[    0.864036] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.868000] mpc5200-simple-platform
[    0.868000] Modules linked in:
[    0.868000] NIP: c0017fec LR: c0019064 CTR: 00000010
[    0.868000] REGS: c381fd20 TRAP: 0300   Not tainted  (2.6.25-rc6-01058-gf8937ce-dirty)
[    0.868000] MSR: 00009032 <EE,ME,IR,DR>  CR: 28000028  XER: 2000005f
[    0.868000] DAR: 0000000c, DSISR: 20000000
[    0.868000] TASK = c3812400[1] 'swapper' THREAD: c381e000
[    0.868000] GPR00: 00000010 c381fdd0 c3812400 00000100 00000008 00000008 fcff7000 c382ca00 
[    0.868000] GPR08: 00002000 00000000 00000000 f00035a9 f0003000 fefd7f7f 07fb3000 04000000 
[    0.868000] GPR16: 00000000 007fff00 00000000 c02c0000 c0340000 c0330000 07fb2678 00000000 
[    0.868000] GPR24: c0330000 00000008 c0360000 00000100 00000008 f0003184 000005f2 00000000 
[    0.868000] NIP [c0017fec] bcom_task_alloc+0x30/0x198
[    0.868000] LR [c0019064] bcom_fec_rx_init+0x24/0x74
[    0.868000] Call Trace:
[    0.868000] [c381fdd0] [c006863c] __get_vm_area_node+0x80/0x1b8 (unreliable)
[    0.868000] [c381fe00] [c0019064] bcom_fec_rx_init+0x24/0x74
[    0.868000] [c381fe20] [c028428c] 0xc028428c
[    0.868000] [c381fe60] [c01ea26c] of_platform_device_probe+0x58/0x80
[    0.868000] [c381fe80] [c017ddd0] driver_probe_device+0xb8/0x1cc
[    0.868000] [c381fea0] [c017e0bc] __driver_attach+0xcc/0xf8
[    0.868000] [c381fec0] [c017c93c] bus_for_each_dev+0x58/0x94
[    0.868000] [c381fef0] [c017db00] driver_attach+0x24/0x34
[    0.868000] [c381ff00] [c017d9c0] bus_add_driver+0x188/0x250
[    0.868000] [c381ff20] [c017e598] driver_register+0x48/0x130
[    0.868000] [c381ff40] [c01ea48c] of_register_driver+0x54/0x70
[    0.868000] [c381ff50] [c032c6b4] mpc52xx_fec_init+0x64/0x80
[    0.868000] [c381ff70] [c0313858] kernel_init+0x98/0x28c
[    0.868000] [c381fff0] [c001229c] kernel_thread+0x44/0x60
[    0.868000] Instruction dump:
[    0.868000] 7c0802a6 9421ffd0 bf210014 3f40c036 7c7b1b78 7c992378 90010034 38000010 
[    0.868000] 7cbc2b78 813a5224 7c0903a6 3be00000 <8129000c> 80090004 57fd2834 2f800000 
[    0.868081] ---[ end trace ab0c326e02602f58 ]---
[    0.872036] Kernel panic - not syncing: Attempted to kill init!
[    0.876034] Rebooting in 1 seconds..

U-Boot 1.3.1-g5f7f945a-dirty (Dec 19 2007 - 16:58:01)

CPU:   MPC5200B v2.2, Core v1.4 at 396 MHz
       Bus 132 MHz, IPB 132 MHz, PCI 66 MHz
Board: TQM5200 (TQ-Components GmbH)
       on a STK52xx carrier board
I2C:   85 kHz, ready
DRAM:  128 MB

--------------020806020303090007040707--
