Date: Wed, 12 Nov 2003 08:53:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
Cc: Wolfgang Denk <wd@denx.de>,
	Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches
Message-ID: <20031112155333.GD31581@ip68-0-152-218.tc.ph.cox.net>
References: <20031110190207.GA12163@zenos.farnsworth.org> <20031112003502.BBA4CC5F59@atlas.denx.de> <20031112151824.GC31581@ip68-0-152-218.tc.ph.cox.net> <1068652170.9906.439.camel@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1068652170.9906.439.camel@hermes>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 12, 2003 at 08:49:30AM -0700, Gary Thomas wrote:
> On Wed, 2003-11-12 at 08:18, Tom Rini wrote:
> > On Wed, Nov 12, 2003 at 01:34:57AM +0100, Wolfgang Denk wrote:
> >
> > [snip]*
> >
> > > * Does it make sense to add a "Board uses UBoot" config option to
> > >   individual boards? [BTW: the name is "U-Boot".] If we do something
> > >   like this (which I'd appreciate) we should do it right - there
> > >   might be some other boards that use this, too.
> >
> > My question is, is it possible to support both U-Boot and $(VENDOR
> > FIRMWARE) in the same build?  If possible I'd like to avoid adding a
> > question for any type of firmware or a define_bool based on board
> > selection.  I think we allow for this on Sandpoints, so
>
> Actually, I don't think it's possible to handle this in a general way.
> In  particular, I'd also like to see a "Uses RedBoot" option, as the
> booting process there is different from U-Boot, PPCBug, OF, ...  Sadly,
> there is no real common ground and this truly is a target [board]
> setting.

>From what I recall of how this worked for U-Boot vs in-kernel wrapper
was that the only thing the kernel cared about was how a data structure
was passed in, so we just checked to see if it was one or the other and
used whatever we had.

#include
<previous_too_long_never_implemented_sadly_bi_rec_thread_and_move_on>

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
