Message-ID: <3B6EAA45.F066CBC1@tejasnetworks.com>
Date: Mon, 06 Aug 2001 20:01:33 +0530
From: Nicholas Basker <nbasker@tejasnetworks.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: kernel crash while running gdb, NIP is 0.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi:

I am running powerpc linux kernal (version 2.2.14)
on a custom board with MPC860 processor.
When I run gdb (version 5.0) on a hello world program the
kernel crashes. There is no swap space configured. Also, the
file system is minimal, we removed a lot of lib and binaries
that are not necessary for our applications.

After this whenever gdb is started to run any program kernel
crashes. The NIP during a kernel crash is 0. The crash output
is bleow

sh-2.03# NIP: 00000000 XER: 8000BA76 LR: C0003C04 REGS: c7517dc0 TRAP:
0400
MSR: 08209032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR:
11
TASK = c7516000[153] 't' mm->pgd c7762000 Last syscall:
4
last math
00000000
GPR00: 00000000 C7517E70 C7516000 C7517E90 30014000 0000000D 00000018
15000000
GPR08: 10000575 C0100000 00001712 7FFFFD30 30015000 10018688 100AFA90
00000000
GPR16: 100A2990 7FFFDBE8 10015315 00000000 00009032 07517E80 00000000
C000253C
GPR24: C0003BB8 100A2990 10000544 00000001 7FFFFE24 7FFFFE2C 0FFE8720
C7517E90
Call
backtrace:
7FFFFE2C C000253C 100003FC 1000048C 0FF094F8
00000000
NIP: 00000000 XER: 8000BA76 LR: C000B4DC REGS: c7517cd0 TRAP:
0400
MSR: 08209032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR:
11
TASK = c7516000[153] 't' mm->pgd c7762000 Last syscall:
4
last math
00000000
GPR00: 00000000 C7517D80 C7516000 C7517DC0 00000001 00000001 00000001
C0299C20
GPR08: C00FFC38 C0100000 00000001 C7517C90 35033A39 10018688 100AFA90
00000000
GPR16: 100A2990 7FFFDBE8 10015315 00000000 00009032 07517DB0 00000000
C000253C
GPR24: C000B1AC 100A2990 10000544 C7BEE2E0 08209032 C7BEE2F8 00000000
C7517DC0
Call
backtrace:
C000B4B8 C000B448 C000253C 7FFFFE2C C000253C 100003FC
1000048C
0FF094F8 00000000

Since NIP 0, the ksymoops utility does not help much in figuring
out where the crash happened. Also is it possible to run the
kernel under BDM and break as soon as a kernel crash or NIP becomes
zero.

Anyhelp would be greatly appreciated.

Thanks for your time,
Nicholas.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
