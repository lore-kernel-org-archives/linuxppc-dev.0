From: Benjamin Herrenschmidt <bh40@calva.net>
To: <cl.en@gmx.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: recent fixes in devel tree
Date: Sat, 16 Sep 2000 20:05:11 +0200
Message-Id: <20000916180511.18729@192.168.1.10>
In-Reply-To: <20000916152035.A517@olis.north.de>
References: <20000916152035.A517@olis.north.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >:
> >: - On my "lombard", the machine doesn't wakeup from sleep.  When I awaken
> >:   it, it just shuts off.

I'll move some sleep fixes I have in my tree to 2.4 soon (still a few
things to fix).

>just for the record:
>same story with a fresh 2.2.18pre4-ben1
>
> kernel: Unable to handle kernel NULL pointer dereference at virtual
>address 00000024 (error 20000000)
> kernel: NIP: C00CF34C XER: C000BE6F LR: C00CFA88 REGS: c4c5fcb0 TRAP: 0300
> kernel: MSR: 00009032 [EEIRDRME]
> kernel: TASK = c4c5e000[299] 'pmud' mm->pgd c4cbe000 Last syscall: 54
> kernel: GPR00: C00CFA88 C4C5FD60 C4C5E000 C01CA7D8 00000000
>C01492F8 00004000 C01BF250
> kernel: GPR08: 00000000 00000000 F3000020 C045AAA0 55553535 1001E8BC
>00000000 100A2B10
> kernel: GPR16: 00000000 DEADBEEF 00000000 00000000 00009032 04C5FE80
>C01CABB4 C01CA650
> kernel: GPR24: C0180000 C01CABB0 000
>00002 00418570 00000008 00000001 00000000 C01CA7D8
> kernel: Call backtrace:
> kernel: C0179E2C C00CFA88 C00F2BCC C0185B00 C00F2FAC C003C310 C000392
> kernel: 0FF8D9A4 1000302C 100015D4 0FF0B69C 00000000
> kernel: Kernel panic: kernel access of bad area pc c00cf34c lr c00cfa88
>address 24 tsk pmud/299
>

Can you lookup in System.map where NIP and LR are ? And eventually a bit
of the backtrace ? I'll check on my side if I see something.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
