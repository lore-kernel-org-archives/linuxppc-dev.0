Date: Sun, 23 Sep 2001 13:50:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Josh Huber <huber@alum.wpi.edu>, Dan Malek <dan@mvista.com>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
Message-ID: <20010923135047.B1878@cpe-24-221-152-185.az.sprintbbd.net>
References: <87k7ytygaf.fsf@mclinux.com> <20010923180012.755801009E@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010923180012.755801009E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, Sep 23, 2001 at 08:00:07PM +0200, Wolfgang Denk wrote:
> In message <87k7ytygaf.fsf@mclinux.com> Josh Huber wrote:
> > Tom Rini <trini@kernel.crashing.org> writes:
> >
> > > But the bi_recs in 2.5 won't look like 2.4.current.
> >
> > bummer...can it not be changed in a compatible manner?
>
> Where can I get more information what it will look like in  2.5?  I'd
> like to be able to have PPCBoot prepared for this change, and ideally
> in  a way that provides a soft migration from current kernel versions
> to the new stuff.

Search the -dev archives for '2.5 birecs' or '2.5 bi recs'.  It was also
on the (old) -commit list before that.

> Or is there even a discussion of this stuff where one  can  at  least
> inject  ideas  or point out thinks that might cause problems - BEFORE
> everything is cast in stone?

Well, it's already been 'agreeded' to look somewhat like the current
bi_recs (<asm/bootinfo.h>).  Different location and more of.  And
other changes that haven't been fleshed out..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
