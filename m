Message-ID: <3A8C5ECE.29670E5A@mvista.com>
Date: Thu, 15 Feb 2001 17:57:18 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@drgw.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: calling giveup_altivec on machine with no altivec!?
References: <20010215160658.P26702@altus.drgw.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes wrote:

> Somehow prev->thread.regs->msr & MSR_VEC turned out true. I'm suspecting
> something got overwritten somewhere..

Crap....

> This is an SMP machine so I'm wondering if there wasn't a race condition
> on something with task structs..

Ahhhh, wait a minute......does SMP do the lazy Altivec or does it
always switch it?  On uP systems, MSR_VEC isn't set unless you get an
Altivec trap, but I seem to remember comments about always switching it
on SMP systems.  On an SMP system, if you don't really have Altivec
you probably shouldn't enable it in the configuration.....no common
config here :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
