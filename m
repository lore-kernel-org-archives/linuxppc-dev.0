Message-ID: <37D0F88E70D96C428C19EEB865701A38ED70F0@buda902a.siemens.hu>
From: =?ISO-8859-1?Q?M=E9sz=E1ros_Lajos?= <ludwigm@siemens.hu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Transfer error ack signal
Date: Mon, 17 Jun 2002 14:13:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All!

After starting 2.4.18 kernel on MPC8260ADS (from PpcBoot) with "initrd"
(inside only static compiled /bin/bash as init and few entry in /dev :
ttyS's cua's and console) there is machine check:

 .....
Freeing unused kernel memory: 56k init
tty_io.c: process 1 (swapper) used obsolete /dev/ttyS2 - update software to
use /dev/ttyS2
Machine check in kernel mode.
Caused by (from SRR1=49030): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C0022634 XER: 00000000 LR: C00894AC SP: C0F6FC80 REGS: c0f6fbd0 TRAP:
0200    Not tainted
MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0f6e000[1] 'bash' Last syscall: 13
 .....

The LR: C00894AC shows it happens in "rd_blkdev_pagecache_IO" while
accessing ramdisk, which is positively operating (seeing that BASH was
loaded from there).

Have any hint?

	Ludwig

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
