Message-ID: <3BB34CCB.5BD5EB2A@mvista.com>
Date: Thu, 27 Sep 2001 11:59:07 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: James F Dougherty <jfd@GigabitNetworks.COM>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC824x
References: <200109270627.XAA14161@krakatoa.gigabitnetworks.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James F Dougherty wrote:

> Does anyone have a working port of ppclinux
> (preferably HHL 2.0) ?

The current linuxppc_2_4_devel tree has working 8245
and Sandpoint X3 support.  There was a subsequent
release of HHL 2.0 that added Sandpoint X3 support
(which already supported 8245) available to subscribers.

> .... The serial port seems
> trivial since it is a memmapped NS16552.

I don't personally have this completed in Linux because
I haven't used any boards that utilize this feature.
It seems everyone took a working 8240 design and just
adapted it to 8245, and rather than rewrite boot roms
it was easier to just drop hardware on the board.

> has the port from 8240 to 8245 been relatively
> easy?

It depends how far you want to push the differences.
>From the Linux perspective today, there isn't any
difference between 8240 and 8245.  Due to the subtle
changes in the 8245, you could make it look quite different.
It just depends on your requirements.

> .... It seems like the right place to start
> would be SandPoint X3 with an 8245PMC module.

That would be my suggestion.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
