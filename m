Message-ID: <003d01c3845c$d212c910$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "Dan Malek" <dan@embeddededge.com>,
	"Jean-Denis Boyer" <jdboyer@m5t.com>,
	"Steffen Rumler" <Steffen.Rumler@siemens.com>,
	"linuxppc" <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLEEGCFPAA.joakim.tjernlund@lumentis.se> <IGEFJKJNHJDCBKALBJLLGEGDFPAA.joakim.tjernlund@lumentis.se> <20030926163102.GB904@ip68-0-152-218.tc.ph.cox.net>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
Date: Fri, 26 Sep 2003 20:34:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On Wed, Sep 17, 2003 at 06:33:06PM +0200, Joakim Tjernlund wrote:
>
> >
> > > > Whatever the boot rom initializes.
> > >
> > > OK, then I will assume TX buffer length of 1, until serial_console_setup has run and
> > > initialize it to 4.
> > >
> > >  Jocke
> >
> > Here we go again. This patch adds the above. I am unable to break it, please try to :)
>
> What tree is this against, specifically?  It doesn't apply cleanly to
> 2_4_devel, 2_4 or kernel.org.

It is against 2_4_devel minus the recent white space cleanup, as far as I can tell.
I should apply if you ignore white space differences. Can you try?

>
> I've just moved a bunch of Dan's old changes from _devel out to a tree
> Marcelo pulls from as well as linuxppc-2.4, so can you please re-do this
> patch against that tree?  Thanks.

I can only run & patch against 2_4_devel since I have made custom changes to my tree.
My tree is a bit behind right  now, sorry.

> --
> Tom Rini
> http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
