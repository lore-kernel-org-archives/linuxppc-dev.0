Date: Sat, 23 Jan 1999 13:59:03 +1100
Message-Id: <199901230259.NAA17964@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: hozer@drgw.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.4.04.9901221336410.12144-100000@narn.local.drgw.net>
	(message from Troy Benjegerdes on Fri, 22 Jan 1999 13:44:25 -0600
	(CST))
Subject: Re: kswapd and SMP still broke on 2.2.0-pre9
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.04.9901221336410.12144-100000@narn.local.drgw.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes <hozer@drgw.net> wrote:

> kswapd is still dieing on boot with SMP enabled (and this time the second
> processor is actually active)
> 
> Does this indicate something is wrong with SMP and the MM code, or that
> some PPC-specific part needs fixing? I've tried to keep up on
> linux-kernel, but it's a little overwhelming ;)

The SMP stuff in Linux/PPC currently only supports the Apple MP
architecture (I think they call it "powersurge").  Your MTX board
probably has entirely different ways of coordinating the CPUs.  Have
you looked at arch/ppc/kernel/smp.c?  I think that's where you'd have
to start changing things.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
