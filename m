Date: Fri, 26 Sep 2003 09:31:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: Dan Malek <dan@embeddededge.com>,
	Jean-Denis Boyer <jdboyer@m5t.com>,
	Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
Message-ID: <20030926163102.GB904@ip68-0-152-218.tc.ph.cox.net>
References: <IGEFJKJNHJDCBKALBJLLEEGCFPAA.joakim.tjernlund@lumentis.se> <IGEFJKJNHJDCBKALBJLLGEGDFPAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IGEFJKJNHJDCBKALBJLLGEGDFPAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 17, 2003 at 06:33:06PM +0200, Joakim Tjernlund wrote:

>
> > > Whatever the boot rom initializes.
> >
> > OK, then I will assume TX buffer length of 1, until serial_console_setup has run and
> > initialize it to 4.
> >
> >  Jocke
>
> Here we go again. This patch adds the above. I am unable to break it, please try to :)

What tree is this against, specifically?  It doesn't apply cleanly to
2_4_devel, 2_4 or kernel.org.

I've just moved a bunch of Dan's old changes from _devel out to a tree
Marcelo pulls from as well as linuxppc-2.4, so can you please re-do this
patch against that tree?  Thanks.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
