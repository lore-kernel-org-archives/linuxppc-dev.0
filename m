Message-Id: <20000704153052.Postino-019966@smtp01.highway.ne.jp>
Date: Tue, 4 Jul 2000 15:30:52 +0900
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: still CMD646 IDE problem in kernel-2.4.0-test3
In-Reply-To: <200007040557.HAA00792@piglet.grunz.lu>
References: <20000704081806.Postino-015237@smtp01.highway.ne.jp>
 <200007040557.HAA00792@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks, your reply.


From: Michel Lanners <mlan@cpu.lu>

> > Partition check:
> >  hda:Machine check in kernel mode.
> > Caused by (from SRR1=41030): Transfer erre ack signal
> > NIP: C00D5AF4 XER: 00000000 LR:C00D5A94 REGS: c022fd60 TRAP: 0200
>        ^^^^^^^^                  ^^^^^^^^
> Could you have a look at your System.map and tell us in what function
> these adresses are? For me it panics in the interrupt handler.

c00d5974 T ide_timer_expiry
c00d5c38 t unexpected_intr

I saw Sysmap but c00d5af4 is nothing.

>
> > MSR: 00041030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > TASK = c022e030[0] 'swapper' Last syscall: 120
> > last math 00000000 last altivec 00000000
> > GPR00: 000000FF C022FE10 C022E030 00000000 00001032 00000000 00000000 00000000
> > GPR08: C02DB1AC FE000000 FE000000 C0250000 00000001 003030AC 00000000 00000000
> > GPR16: 00000000 C02B0000 C02B0000 C02C0000 C0230000 C02BA694 C02BA690 C00050EB
> > GPR24: C0006644 C022D3E0 C022D3E0 C022D3E0 C02DB1AC C03E5260 C00E0CC4 C02DB214
>
> Are you sure this is the complete panic message? There should be a few
> more lines after this one, with a backtrace and a few more details on
> what happened...
>
> What I hate the most about this panic is that it should indicate a
> hardware problem, according to the PPC docs. 'Transfer error ack' should
> be raised by the memory controller on parity errors and the such. I
> wonder how this signal is actually wired in macs.....
>
> Michel

last line is GPR24:xxxx xxxxx
I don't have more another line.

Since last Novenber I have tryed develop kernel,but it couldn't  still work
 my fast IDE.

Always I used linuxppc on the IDE.
kernel-2.2.16 is no problem even the IDE.

Thanks

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
