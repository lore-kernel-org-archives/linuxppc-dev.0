Message-ID: <20000927103557.1222.qmail@dag.newtech.fi>
To: <linuxppc-embedded@lists.linuxppc.org>
cc: dag@newtech.fi
Subject: Porting problems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Sep 2000 13:35:56 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am porting Linux to an unsupported (so far)
VME-board and have been banging my head into
the following problem for some time now,
nothing seems to help.....

Thought I would ask the wise men on the net for some
hints on where to look.

The board is hal PReP and half CHRP and I have been
struggling to get the boot to work.
At the moment it starts up using the VxWorks boot
and I then load Linux over the net and start it up.

The problem can be that the VxWorks monitor
inits something wrongly ?

Any hint welcome.

The processor is a PPC740

Boot log:

ksymoops 2.3.4 on i686 2.2.15.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)
     -t powerpc -a powerpc

NIP: C01B2C84 XER: 00000000 LR: C01B2C74 REGS: c0189eb0 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0187ff0[0] 'swapper' Last syscall: 0
last math 00000000 last altivec 00000000
GPR00: 00000005 C0189F60 C0187FF0 00000029 00001032 00000000 C01D0000 00000000
GPR08: C01D0000 00000005 C01A0000 C0189E30 44828024 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 003FF000 00000000 00000000 00000000
GPR24: 00000000 C01D0000 C01D0000 00001000 00000000 C01D0000 00002000 00000004
Call backtrace:
C01B2C74 C01B2DC0 C01A7778 000036C4
Kernel panic: kernel access of bad area pc c01b2c84 lr c01b2c74 address 5 tsk
swapper/0
Warning (Oops_read): Code line not seen, dumping what data is available

>>NIP; c01b2c84 <dcache_init+18c/1bc>   <=====
Trace; c01b2c74 <dcache_init+17c/1bc>
Trace; c01b2dc0 <vfs_caches_init+10c/120>
Trace; c01a7778 <start_kernel+134/1a4>
Trace; 000036c4 Before first symbol
>>NIP; c01b2c84 <dcache_init+18c/1bc>   <=====


1 warning issued.  Results may not be reliable.


BRGDS
--
Dag Nygren                               email: dag@newtech.fi
Oy NewTech Ab                            phone: +358 9 8024910
Trasktorpet 3                              fax: +358 9 8024916
02360 ESBO                                 GSM: 0400-426312
FINLAND


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
