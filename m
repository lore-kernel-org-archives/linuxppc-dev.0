Date: Wed, 19 Sep 2001 15:57:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
Message-ID: <20010919155742.D8132@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010918115722.A5967@cpe-24-221-152-185.az.sprintbbd.net> <EFEAIMDCOOOHIEPHDNFJCEKKDCAA.stefan.roese@esd-electronics.com> <20010919071751.B8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA8DF9E.FD235CF6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BA8DF9E.FD235CF6@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 19, 2001 at 02:10:38PM -0400, Dan Malek wrote:

> > Well, do you forsee the need to put in board-specific defines?
>
> This isn't the right way.  If you notice the way the ports work,
> everything 4xx (or 8xx, or 6xx, or whatever), include the single
> header file, in this case ppc4xx.h.  This include file will select
> the proper board specific file.  The board specific file, contains,
> well, the stuff specific to a board.

Er, yes.  But if there's nothing specific to the CPCI405, why add in an
empty file and the
#ifdef CONFIG_CPCI405
#include <asm/cpci405.h> /* Empty */
#endif
in ppc4xx.h?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
