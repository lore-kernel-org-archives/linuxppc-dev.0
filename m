Date: Fri, 26 Sep 2003 11:38:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Dan Malek <dan@embeddededge.com>,
	Jean-Denis Boyer <jdboyer@m5t.com>,
	Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
Message-ID: <20030926183813.GA8927@ip68-0-152-218.tc.ph.cox.net>
References: <IGEFJKJNHJDCBKALBJLLEEGCFPAA.joakim.tjernlund@lumentis.se> <IGEFJKJNHJDCBKALBJLLGEGDFPAA.joakim.tjernlund@lumentis.se> <20030926163102.GB904@ip68-0-152-218.tc.ph.cox.net> <003d01c3845c$d212c910$020120b0@jockeXP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <003d01c3845c$d212c910$020120b0@jockeXP>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Sep 26, 2003 at 08:34:28PM +0200, Joakim Tjernlund wrote:
> > On Wed, Sep 17, 2003 at 06:33:06PM +0200, Joakim Tjernlund wrote:
> >
> > >
> > > > > Whatever the boot rom initializes.
> > > >
> > > > OK, then I will assume TX buffer length of 1, until serial_console_setup has run and
> > > > initialize it to 4.
> > > >
> > > >  Jocke
> > >
> > > Here we go again. This patch adds the above. I am unable to break it, please try to :)
> >
> > What tree is this against, specifically?  It doesn't apply cleanly to
> > 2_4_devel, 2_4 or kernel.org.
>
> It is against 2_4_devel minus the recent white space cleanup, as far as I can tell.
> I should apply if you ignore white space differences. Can you try?

It does.  I'll test this out this afternoon.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
