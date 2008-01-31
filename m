Return-Path: <mail4mz@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 68048DE0C0
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 06:28:19 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so873314pyg.27
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 11:28:18 -0800 (PST)
Message-ID: <5c9cd53b0801311128s1801c720pdeda8ee1bdd518e@mail.gmail.com>
Date: Thu, 31 Jan 2008 14:28:17 -0500
From: "mike zheng" <mail4mz@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Kernel oops in MPC8568MDS BSP
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I am using MPC8568MDS BSP on my board, which has same memory map with
MPC8568MDS board. However I have kernel Ooop at
free_bootmem_with_active_regions() within do_init_bootmem(). Any idea
on this issue?


Thanks,


Mike

bootm 0x1000000 0x2000000 0x400000
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.23
   Created:      2008-01-31  18:52:45 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1370100 Bytes =  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 02000000 ...
   Image Name:   uboot ext2 ramdisk rootfs
   Created:      2007-11-26   2:28:38 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    4001113 Bytes =  3.8 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Booting using flat device tree at 0x400000
   Loading Ramdisk to 1fb6e000, end 1ff3ed59 ... OK
Using MPC85xx MDS machine description
Memory CAM mapping: CAM0=256Mb, CAM1=256Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.23 () (gcc version 4.1.2) #3 Thu Jan 31 13:52:40 EST 2008
Found initrd at 0xdfb6e000:0xdff3ed59
console [udbg0] enabled

Kernel BUG at c0296a68 [verbose debug info unavailable]
Oops: Exception in kernel mode, sig: 5 [#1]
MPC85xx MDS
Modules linked in:
NIP: c0296a68 LR: c0298100 CTR: 00001c00
REGS: c02c7ec0 TRAP: 0700   Not tainted  (2.6.23)
MSR: 00021000 <ME>  CR: 24002028  XER: 20000000
TASK = c02ac5e0[0] 'swapper' THREAD: c02c6000
GPR00: 00000001 c02c7f70 c02ac5e0 c02daa2c 0001e401 20000000 00000000
00000356
GPR08: 00000001 00000000 25e90000 25e90000 24002022 60000000 1ffbd400
007fff00
GPR16: 00000000 1ffb9824 00000004 1fffc830 00800000 00000000 007ffeb0
003d0d59
GPR24: 00000000 1ff3fe50 00001140 c02b0000 00000000 c02a5320 00020000
00000000
Call Trace:
[c02c7f90] [c0291144]
[c02c7fb0] [c028f250]
[c02c7fc0] [c028681c]
[c02c7ff0] [c0000388]
Instruction dump:
5489e8fa 7d000030 7d295a14 7d604828 7d6a0078 7d40492d 40a2fff4
7c095839
38840001 4182000c 4200ffd0 4e800020 <0fe00000> 48000000 3d20c02b
7c601b78
Kernel panic - not syncing: Attempted to kill the idle task!
