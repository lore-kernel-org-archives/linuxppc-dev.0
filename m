Reply-To: <govindan@tejasnetworks.com>
From: "Govindan" <govindan@tejasnetworks.com>
To: <linuxppc-dev@lists.linuxppc.org>,
        <damm@kierayapc01.p.y.ki.era.ericsson.se>,
        <dhinds@pcmcia.sourceforge.org>
Cc: <gopi@tejasnetworks.com>
Subject: Problem with PCMCIA and RPXCLASSIC
Date: Tue, 19 Dec 2000 18:52:04 +0530
Message-ID: <011d01c069be$ae578d50$1b01a8c0@india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,


[We are using Hard HAt Linux (Kernel 2.2.14) and PCMCIA
patch for pcmcia-cs-3.1.19]



I am trying to get IBM microdrive based on PCMCIA  up on CLLF
board(RPXCLASSIC).

With _IO_BASE=0x80000000(in mpc8xx.h), kernel doesnt come up at all,
just prints a kernel panic msg about access to memory..

So, we tried changing the IO_BASE to 0(this was the value in older
versions before the patch of pcmcia-3.1.19 was put up).

With this as IO_BASE the kernel comes up and we get the shell prompt
also.(BUt what is the correct value of _IO_BASE for cllf rpxclassic
board)?


Now when trying to get the IBM microdrive up as an ide disc, when we
invoke cardmgr(after doing insmod of the pcmcia basic modules),
the following error is shown..

--------------------------------------------------------------------------
sh-2.03# cardmgr
cardmgr[27]: starting, version is 3.1.19
sh-2.03# cardmgr[27]: watching 1 sockets
cardmgr[27]: initializing socket 0
cardmgr[27]: socket 0: IBM microdrive
NIP: C00AA784 XER: E000A77F LR: C00AAB04 REGS: c0d09450 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0d08000[27] 'cardmgr' mm->pgd c0d0a000 Last syscall: 54
last math 00000000
GPR00: 000000A0 C0D09500 C0D08000 C0119C90 000000EC 00000000 C0D09564
00050000
GPR08: 0100010F 00000106 C011A30C C0D09568 33F33453 10021674 100B6FF0
00000000
GPR16: 100BE450 FFFFFFFF FFFFFFFF 00000000 00009032 00D09E80 00000000
C01686E0
GPR24: C011180C 00009032 C0119DA1 C0119CE0 000000EC C0119C60 C0119C60
C0119C90
Call backtrace:
C404D000 C00AAB04 C00AB60C C00A4CA8 C00A548C C40115BC C4011970
C40021A8 C4003864 C4011178 C400E84C C400F55C C0033690 C00022D0
100026FC 10002D90 100041B8 0FF094F8 00000000
Kernel panic: kernel access of bad area pc c00aa784 lr c00aab04 address 106
tsk
cardmgr/27
--------------------------------------------------------------------------

Any idea what the problem is..

Thanks in advance,
Govindan

"Code it clear rather than clever"
---------------------------------------------------------------------
Govindan  K Thrithala                 Tel: +91-80-226-7495x4033
Tejas Networks India Pvt. Ltd.     Fax: +91-80-226 7494
49, Khanija Bhavan, Race Course Road
Bangalore 560 001
-------------------------------------------------------------------
"I care for future, because I spend rest of my life there"


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
