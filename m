Reply-To: <fabidi@ultsol.com>
From: "Fahd Abidi" <fabidi@ultsol.com>
To: "'Marco Schramel'" <Schramel.Linux@go.bartec.de>,
	"PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: BDI kernel debug
Date: Wed, 7 Jul 2004 07:42:19 -0400
Message-ID: <81C69D96BDD30640952C7A404004AA25018722@h0007e95d9fa7.ne.client2.attbi.com>
In-Reply-To: <200407061331.08613.Schramel.Linux@go.bartec.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marco,

Please look online at the Ultimate Solutions website, I documented this
issue a little while ago, http://www.ultsol.com/faq-P305.htm. Wolfgang made
the right suggestion, using BDI_CONFIG_SWITCH will cure this problem.

Fahd

-----Original Message-----
From: Marco Schramel [mailto:Schramel.Linux@go.bartec.de]
Sent: Tuesday, July 06, 2004 6:31 AM
Subject: BDI kernel debug

i have some problems with debugging my kernel. This is the first time i
use bdi for kernel debugging. ELDK 3.0 is my toolchain (Target 8270). My
bdi2000 can sync with the gdb (ddd) debugger. I let the kernel run until
"start_here", at example. Then i try to step through the source. I see
the source and i can step in it. Sometimes it happens that i spend a lot
of time in linux/kernel/timer.c. Then the output of gdb is "
(gdb) next
 Single stepping until exit from function __cli,
 which has no line number information.

 Program received signal SIGSTOP, Stopped (signal).
 0xc0007dec in __cli ()"

The same output with "step". "Cont" ends also there, although i had set
a breakpoint later in the source.

Are there some options in the kernel or in the gdb to set ?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
