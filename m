Message-ID: <20040402171934.85963.qmail@web40301.mail.yahoo.com>
Date: Fri, 2 Apr 2004 09:19:34 -0800 (PST)
From: J Kang <jkang57@yahoo.com>
Subject: kernel oops -- shmem_read_super
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Everyone,
I am an newbie with linux and boards!
I am trying to do a kernel build for custom board (IBM
440 gx processor, M Vista 3.0)

I used ksymoops and I'm getting oops at
shmem_read_super.

I'm trying to understand what exactly shmem_read_super
is doing and how to fix this problem.
Can someone please give me an advice?

I'd really appreciate your help.

Sincerely,
Jagbir



ksymoops 2.4.4 on i686 2.4.18-3.  Options used
     -v JKANG/linux-2.4.18_mvl30/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m JKANG/linux-2.4.18_mvl30/System.map
(specified)

        CPU: 512 MHz
BEDBUG:ready
Oops: Exception in kernel mode, sig: 4
NIP: C003A900 XER: 00000000 LR: C0045968 SP: C0203EE0
REGS: c0203e20 TRAP: 0700    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0202000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C0045950 C0203EE0 C0202000 CFFFBA00 00000000
00000000 0000063C C0140197
GPR08: 00000000 00000001 00000034 C0203DF0 C0160000
30000000 0FFF1C00 00000001
GPR16: 007FFC0E 00000000 00000001 007FFC00 0FFEF428
FFFFFFFF 00000000 00000000
GPR24: 00000000 00800000 00000000 C003A900 00000000
00000000 CFFFBA00 CFFFBA48
Call backtrace:
C0045950 C0045F44 C0046698 C00466E4 C014F380 C014A7E8
C014A834
C00012C4 C0003E1C
Kernel panic: Attempted to kill init!
Oops: Exception in kernel mode, sig: 4
NIP: C003FAD0 XER: 00000000 LR: C0013924 SP: C0203D00
REGS: c0203c40 TRAP: 0700    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0202000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000001 C0203D00 C0202000 C011B3F8 00001030
FFFFFFFF 0000093C C0140197
GPR08: 00000000 C0164B80 00000030 00000000 C0160000
30000000 0FFF1C00 00000001
GPR16: 007FFC0E 00000000 00000001 007FFC00 00009032
C0203E10 00000000 C00017D8
GPR24: C0001BE0 00800000 00000000 C003A900 C0160000
C011BB38 C0202000 C0119148
Call backtrace:
C0013854 C0018114 C000199C C00019F4 C0001C38 C00017D8
C0045950
C0045F44 C0046698 C00466E4 C014F380 C014A7E8 C014A834
C00012C4
C0003E1C
Kernel panic: Attempted to kill init!
Oops: Exception in kernel mode, sig: 4
NIP: C003FAD0 XER: 00000000 LR: C0013924 SP: C0203B20
REGS: c0203a60 TRAP: 0700    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0202000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000001 C0203B20 C0202000 C011B3F8 00001030
FFFFFFFF 00000C76 C0140197
GPR08: 00000000 C0164B80 00000030 00000000 C0160000
30000000 0FFF1C00 00000001
GPR16: 007FFC0E 00000000 00000001 007FFC00 00009032
C0203C30 00000000 C00017D8
GPR24: C0001BE0 00800000 00000000 C003A900 C0160000
C011BB38 C0202000 C0119148
Call backtrace:
Warning (Oops_read): Code line not seen, dumping what
data is available

>>EIP; c003a900 <shmem_read_super+0/13c>   <=====
Trace; c0045950 <read_super+80/1e4>
Trace; c0045f44 <get_sb_nodev+58/7c>
Trace; c0046698 <do_kern_mount+1bc/1e8>
Trace; c00466e4 <kern_mount+20/30>
Trace; c014f380 <init_shmem_fs+78/e4>
Trace; c014a7e8 <do_initcalls+30/50>
Trace; c014a834 <do_basic_setup+2c/3c>
Trace; c00012c4 <init+28/224>
Trace; c0003e1c <kernel_thread+30/3c>
>>EIP; c003fad0 <sys_sync+0/28>   <=====
Trace; c0013854 <panic+68/13c>
Trace; c0018114 <complete_and_exit+0/28>
Trace; c000199c <die+88/90>
Trace; c00019f4 <_exception+50/54>
Trace; c0001c38 <ProgramCheckException+58/74>
Trace; c00017d8 <ret_from_except+0/34>
Trace; c0045950 <read_super+80/1e4>
Trace; c0045f44 <get_sb_nodev+58/7c>
Trace; c0046698 <do_kern_mount+1bc/1e8>
Trace; c00466e4 <kern_mount+20/30>
Trace; c014f380 <init_shmem_fs+78/e4>
Trace; c014a7e8 <do_initcalls+30/50>
Trace; c014a834 <do_basic_setup+2c/3c>
Trace; c00012c4 <init+28/224>
Trace; c0003e1c <kernel_thread+30/3c>
>>EIP; c003fad0 <sys_sync+0/28>   <=====


Yahoo! Small Business $15K Web Design Giveaway
http://promotions.yahoo.com/design_giveaway/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
