Date: Thu, 20 Sep 2001 08:51:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
Message-ID: <20010920085109.E13721@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010918115722.A5967@cpe-24-221-152-185.az.sprintbbd.net> <EFEAIMDCOOOHIEPHDNFJCEKKDCAA.stefan.roese@esd-electronics.com> <20010919071751.B8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA8DF9E.FD235CF6@mvista.com> <20010919155742.D8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA9241B.4322817A@mvista.com> <20010919163101.E8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA96CA2.20EC30C8@mvista.com> <20010920075537.A13721@cpe-24-221-152-185.az.sprintbbd.net> <3BAA0C91.42E0910D@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BAA0C91.42E0910D@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 20, 2001 at 11:34:41AM -0400, Dan Malek wrote:
>
> Tom Rini wrote:
>
> > Well, because it keeps us from duplicating 4 lines in the makefile.
>
> OK.
>
> > .....  CONFIG_TREEBOOT could probably die, unless
> > someone revives Oak or TiVo uses it.
>
> Walnut and Spruce use it.  Get it?  TREEboot?

heh.  You're assuming that I get to see docs on these boards.  I forgot
spruce uses it.  oak.h's board_info is the same as walnut, minus the PCI
line.  And I dunno what TiVo uses...

> > Not in 2.4 we aren't.  We aren't forcing bi_recs upon everyone just
> > yet.
>
> We should.  The purpose of consolidating bootloaders was to utilize
> a bunch of generic code on both sides (bootloader and Linux).  It
> isn't a major change on either side, since we already have bootloaders
> that do it.

Right.  But it's still possible to break bi_recs in some cases (tho it's
more theoretical).  Anyhow tho, changing requirements of bootloaders (even
in the case of just !ALL_PPC) in the middle of a 'stable' baseline doesn't
sound good.

> > ....  Hell, even in 2.5 as long
> > as we get the bi_recs, we shouldn't care what the bootloader does..
>
> The bootloader is a critical part to initializing the environment for
> the kernel.  With all of the MMU futzing around we do trying to get
> Linux running, Ben and I have discussed yet another better bootloader
> method to move some of this around between the bootloader and the
> kernel start up.  There are also initrd and command line things done
> by the bootloader (among other board specific initialization).  It's
> more than whether or not we all use bi_recs.

Okay.  Now, do you want to get this done in 2.4 first or 2.5 first? :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
