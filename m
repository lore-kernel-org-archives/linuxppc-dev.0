Date: Tue, 27 Jul 2004 14:01:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andreas Oberritter <obi@saftware.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] add board_init() (was [PATCH] make platform_init() weak for 8xx)
Message-ID: <20040727210132.GF10891@smtp.west.cox.net>
References: <1090253615.1415.24.camel@shiva.saftware.de> <20040719163203.GA6813@smtp.west.cox.net> <1090258468.1419.58.camel@shiva.saftware.de> <20040719182047.GC6813@smtp.west.cox.net> <1090591193.3939.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1090591193.3939.27.camel@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jul 23, 2004 at 03:59:53PM +0200, Andreas Oberritter wrote:
> Am Mo, den 19.07.2004 schrieb Tom Rini um 20:20:
> > On Mon, Jul 19, 2004 at 07:34:28PM +0200, Andreas Oberritter wrote:
> >
> > > On Mon, 2004-07-19 at 18:32, Tom Rini wrote:
> > > > Second, this takes us in the direction of 82xx.  Until the 82xx
> > > > abstractions get flushed out a bit more, I remain unconvinced that
> > > > they're really the right way to go (perhaps hooking the other direction
> > > > would work better, e.g. platform_init() calls board_init(), with a weak
> > > > version provided, and some functions forced to be provided by board.c,
> > > > such as m8xx_map_io).
> > >
> > > I chose this way because it seemed to be a simple way to port the dbox2
> > > board to 2.6 using the new device API. Is there another 8xx board which
> > > uses the device API for its onboard peripherials and can be used as a
> > > reference? Can I get my devices registered without modifying
> > > platform_init, or shall I send a patch with the board_init() you
> > > mentioned? See my board.c attached.
> >
> > There currently isn't a reference platform for what you speak of.  My
> > preference would be to see what I described given a shot to see if it
> > looks better or worse (and it better, or worse, in the flow of things).
>
> How about this patch?

Yes, I think that's about it.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
