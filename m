Message-ID: <38516E87.63D3B98A@netx4.com>
Date: Fri, 10 Dec 1999 16:20:07 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@ccrl.mot.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.2.13 kernel and BSE board
References: <38516AA1.9CE83D69@ccrl.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Rossi wrote:


> NIP: C000CCAC XER: 20000242 LR: C009E9AC REGS: c00c29d0 TRAP: 0300
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c00c0c90[0] 'swapper' mm->pgd c00bf000 Last syscall: 0
> last math 00000000
> GPR00: C009E9AC C00C2A80 C00C0C90 002E7379 00000001 0000002A 00000054
> FFFFFFFF
> GPR08: FFFFFFFF 00000005 00000015 00000001 00000040 00000000 00000000
> 00000000
> GPR16: 00000000 00000000 00000000 00000000 00009032 001001C4 00210000
> C00E0000
> GPR24: 00000000 00000004 C00CE6C4 00000004 00000001 C00D9154 6D746162
> C00C2A80
> Call backtrace:
> 00000000 C009E9AC C009EB80 C00D30D4 C00D0724 C000221C


There is this really cool file called "System.map" that just
happens to have a memory map of the kernel.  Look what function
contains the address at NIP, then follow the Call Backtrace (ignoring
the first word) doing the same thing.

Send that information to me......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
