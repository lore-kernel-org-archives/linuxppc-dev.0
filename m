Subject: Re: MPC5200 Patches
From: Gary Thomas <gary@mlbassoc.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Wolfgang Denk <wd@denx.de>,
	Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20031112151824.GC31581@ip68-0-152-218.tc.ph.cox.net>
References: <20031110190207.GA12163@zenos.farnsworth.org>
	 <20031112003502.BBA4CC5F59@atlas.denx.de>
	 <20031112151824.GC31581@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Message-Id: <1068652170.9906.439.camel@hermes>
Mime-Version: 1.0
Date: 12 Nov 2003 08:49:30 -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-11-12 at 08:18, Tom Rini wrote:
> On Wed, Nov 12, 2003 at 01:34:57AM +0100, Wolfgang Denk wrote:
>
> [snip]*
>
> > * Does it make sense to add a "Board uses UBoot" config option to
> >   individual boards? [BTW: the name is "U-Boot".] If we do something
> >   like this (which I'd appreciate) we should do it right - there
> >   might be some other boards that use this, too.
>
> My question is, is it possible to support both U-Boot and $(VENDOR
> FIRMWARE) in the same build?  If possible I'd like to avoid adding a
> question for any type of firmware or a define_bool based on board
> selection.  I think we allow for this on Sandpoints, so

Actually, I don't think it's possible to handle this in a general way.
In  particular, I'd also like to see a "Uses RedBoot" option, as the
booting process there is different from U-Boot, PPCBug, OF, ...  Sadly,
there is no real common ground and this truly is a target [board]
setting.

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
