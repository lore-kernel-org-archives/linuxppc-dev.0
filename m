Message-ID: <003f01bf42dc$c33c23c0$73f102de@sjzhu>
Reply-To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Help: Linux 2.2.13 on MPC823 FADS board
Date: Fri, 10 Dec 1999 15:04:10 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello, everyone

I build a kernel for MPC823 FADS board,
but there is something wrong.

Why is there the following error information:
        Kernel panic: kernel access of bad area pc c000fe90 
        lr c000fce0 address 2C80001E tsk swapper/1


Any suggestion is appreciated!

==========================================================
loaded at:     00400000 0040B1C0
board data at: 00011260 00011274
relocated to:  00200100 00200114
zimage at:     0040B1C0 0045E77D
initrd at:     0045E77D 005BFD32
avail ram:     005C0000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (sjzhu@linux.mcel.mot.com) (gcc version 2.7.2.1-ppclinux) #
130 Fri Dec 10 23:01:17 CST 1999
Boot arguments: root=/dev/ram
time_init: decrementer frequency = 90000000/60
Calibrating delay loop... 23.71 BogoMIPS
Memory: 13872k available (680k kernel code, 416k data, 0k init) [c0000000,c10000
00]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Starting kswapd v 1.5
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
RAM disk driver initialized:  16 RAM disks of 4096K size
RAMDISK: Compressed image found at block 0
page fault in interrupt handler, addr=2c80001e
NIP: C000FE90 XER: 8000917D LR: C000FCE0 REGS: c0117240 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0116000[1] 'swapper' mm->pgd c00ba000 Last syscall: 120
last math 00000000
GPR00: C00BF09C C0117330 C0116000 00000001 00008000 00000000 00000001 000001FE
GPR08: 7FFFFFFF 60000000 2C80001E C05EFEE8 0000000E 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00001032 00117380 C00AAA70 C00D0000
GPR24: C00C0000 C00C0000 C00C0000 C00BF09C 00000000 90090208 3800001E C0117330
NIP: C000FE90 XER: 8000917D LR: C000FCE0 REGS: c0117240 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0116000[1] 'swapper' mm->pgd c00ba000 Last syscall: 120
last math 00000000
GPR00: C00BF09C C0117330 C0116000 00000001 00008000 00000000 00000001 000001FE
GPR08: 7FFFFFFF 60000000 2C80001E C05EFEE8 0000000E 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00001032 00117380 C00AAA70 C00D0000
GPR24: C00C0000 C00C0000 C00C0000 C00BF09C 00000000 90090208 3800001E C0117330
Call backtrace:
C000FC78 C0017178 C00024F8 C009799C C009838C C00984D4 C0098558
C0098A94 C0098FD8 C0096D00 C009701C C009631C C000323C C0003358
C00079D4
Kernel panic: kernel access of bad area pc c000fe90 lr c000fce0 address 2C80001E
 tsk swapper/1

=====================================================================
symtab is:
c000f824 t update_wall_time_one_tick
c000f92c t update_wall_time
c000f9b0 T update_one_process
c000fae8 t update_process_times
c000fba8 t timer_bh
c000ff18 T do_timer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
