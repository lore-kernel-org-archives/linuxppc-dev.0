Message-ID: <20020527092321.38165.qmail@web15001.mail.bjs.yahoo.com>
Date: Mon, 27 May 2002 17:23:21 +0800 (CST)
From: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Subject: About 2.4.19 kernel(ppckernel.org)boot panic?
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all:
	I try to port linuxppc2.4.19-pre8(from
www.ppckernel.org) to our borad from Rpxlite_config.
But it panic after dump some information.
Before porting 2.4.19 , I have porting 2.4.4(from
denx.de) to my borad and it works well, I have done
same work as what i have done with 2.4.4.
What problem,it says 'kernel access of bad area, sig:
11 '

Here is dump:

Linux/PPC load: console=ttyS0,9600 console=tty0
root=/dev/nfs rw
Uncompressing Linux...done.

Now booting the kernel

Linux version 2.4.19-pre8 (root@localhost.localdomain)
(gcc version 2.95.2 19992
On node 0 totalpages: 8192

zone(0): 8192 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: console=ttyS0,9600 console=tty0
root=/dev/nfs rw
Decrementer Frequency = 180000000/60

Calibrating delay loop... 47.51 BogoMIPS

Memory: 30928k available (1048k kernel code, 336k
data, 56k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768
bytes)
Inode cache hash table entries: 2048 (order: 2, 16384
bytes)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
//here just wait 2-3 seconds dump nothing
Oops: kernel access of bad area, sig: 11
                        d
NIP: C004AF10 XER: 00000000 LR: C004A554 SP: C0123ED0
REGS: c0123e20 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11

DAR: C2000000, DSISR: 0000052A

TASK = c0121fb0[0] 'swapper' Last syscall: 0

last math 00000000 last altivec 00000000

GPR00: B4004FA5 C0123ED0 C0121FB0 C01D0040 00000000
00000000 C01D0124 00000000
GPR08: BC036C17 0000000F C2000000 BE2550F7 0000000D
000692F8 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
GPR24: 00000000 00000200 00000000 C0126CE4 00000000
00000000 C01D0040 C01D2000
Call backtrace:

00000000 C00633B0 C003AD6C C003AF58 C013752C C0137878
C013733C
C0132558 C0002138

Kernel panic: Attempted to kill the idle task!

In idle task - not syncing

 <0>Rebooting in 180 seconds..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
