Message-Id: <5.0.2.1.0.20010508155109.00a01ec0@pop.gmx.de>
Date: Tue, 08 May 2001 16:02:24 +0800
To: Dan Malek <dan@mvista.com>
From: Michael Habermann <MHabermann@gmx.de>
Subject: Re: Uncompress Ok, but cannot run linux kernel...
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3AF748FF.E308BF0C@mvista.com>
References: <5.0.2.1.0.20010508085652.00a4aec0@pop.gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 09:16 PM 5/7/2001 -0400, Dan Malek wrote:

> > I have the same problem on an FADS board.
>
>What "same" problem?  How are you loading and tracing the kernel?

The same problem is that the kernel doesn't survive until the welcome
messge is printed.
The kernel is loaded with ppcboot and the tftpboot commando. To trace, I
used mpc8bug.

I use the Montavista linux-2.4.0-test2-1.2.0-1 kernel.
I set a breakpoint at the entry of the __start routine. After passing
the turn_on_mmu label, it returns with an rfi and hangs.
It is maybe ment to be started from a power_on interrupt, because in
this context, I don't see the sense for an rfi. But I don't know much details.


I believe there is a working FADS port in the FSM Labs BitKeeper
>sources.  If not, you can download the older 2.4.0-test2 LSP from
>MontaVista and use it as a guide for updating a later kernel.  The
>changes are very minor.

The Montavista is the one I used. I also tried one from Bitkeeper, but I
didn't found support
for the FADS board. Even when I compiled for MBX, I got no image in
arch/ppc/coffboot.
Which is the machine type I should configure for a MPC860FADS?

It would be nice if you could help me. So far I couldn't start any kernel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
