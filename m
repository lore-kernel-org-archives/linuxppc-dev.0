Date: Wed, 19 Sep 2001 07:17:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stefan Roese <stefan.roese@esd-electronics.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>, dan@mvista.com
Subject: Re: CPCI-405 port (PPC405GP)
Message-ID: <20010919071751.B8132@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010918115722.A5967@cpe-24-221-152-185.az.sprintbbd.net> <EFEAIMDCOOOHIEPHDNFJCEKKDCAA.stefan.roese@esd-electronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EFEAIMDCOOOHIEPHDNFJCEKKDCAA.stefan.roese@esd-electronics.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 19, 2001 at 03:46:37PM +0200, Stefan Roese wrote:

> I also tried to make the "ppc405_map_irq" function more generic (since the
> number of slots isn't identical for all 405gp boards). Any comments?

Sounds like a good idea.  Also, doing inline ... __init is rather silly.
How's the idea sound Dan?

> >  Also do we actually need
> > include/asm-ppc/cpci405.h?  All it does is include ppcboot.h.  So I'm
> > guessing this board only boots w/ PPCBOOT, which should include it's own
> > version of this file.  So is this really needed?
>
> You are right again. At this moment this file isn't needed at all. I thought
> that I would need this file perhaps later, when some other boardspecific
> defines have to be included (like in tqm8xx.h). Please let me know if you
> would still suggest to remove this file.

Well, do you forsee the need to put in board-specific defines?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
