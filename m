Message-Id: <4.3.2.7.0.20000620203521.00acd470@10.0.0.2>
Date: Tue, 20 Jun 2000 20:43:21 -0400
To: Lucinda Schafer <lucsch@adaptivemicro.com>,
        linuxppc-embedded@lists.linuxppc.org
From: Mike Coy <coym@embeddedplanet.com>
Subject: RE: PCMCIA ATA flash support?
In-Reply-To: <A109131318C4D1119AC20060088DECE330F446@amwmail.adaptivemic
 ro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Emulation routine where the panic is called. Use your System.map file to see
>if you can find the last functions called, for example:
>                 show_regs(regs);
>                         print_backtrace( (unsigned long *)regs->gpr[1] );
>                         instruction_dump((unsigned long *)regs->nip);
>                         panic("Kernel Mode Software FPU Emulation");

OK, i added the  backtrace, but hardly any of the calls are IN my system.map!
Odd!

And I tried looking at the SIUMCR register as suggested in the list message
you posted, and it is 0x800, which would seem to be the correct value.

thanks,
mike


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
