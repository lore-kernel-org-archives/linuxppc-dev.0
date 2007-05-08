Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 May 2007 10:18:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 05/13] Document the fsl,
	magic-packet property in gianfar nodes.
Message-ID: <20070508001808.GD7449@localhost.localdomain>
References: <20070507182947.GD26920@ld0162-tx32.am.freescale.net>
	<B7081C3F-C551-42D8-BB5D-6FE5DC311C99@freescale.com>
	<463F9A38.6080408@freescale.com>
	<AC7B08C0-E41A-458F-8E9F-59901443600A@freescale.com>
	<3FE06AFA-BEE6-46CF-B12C-29D979AE50D7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FE06AFA-BEE6-46CF-B12C-29D979AE50D7@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 07, 2007 at 06:06:39PM -0500, Kumar Gala wrote:
> 
> On May 7, 2007, at 4:51 PM, Andy Fleming wrote:
> 
> >
> > On May 7, 2007, at 16:29, Scott Wood wrote:
> >
> >> Andy Fleming wrote:
> >>> On May 7, 2007, at 13:29, Scott Wood wrote:
> >>>> +   Optional properties:
> >>>> +    - fsl,magic-packet : Indicates that this device supports wake
> >>>> +      on Magic Packet.
> >>>> +
> >>> Isn't this a fairly generic option?  Does it need the "fsl"
> >>> qualifier?
> >>
> >> As I previously wrote internally, it's only needed because some
> >> versions of the device have it and some don't; what it really means
> >> is that certain bits in certain registers are valid.  Making it
> >> generic would imply that all hardware that can do magic packet
> >> should have it, which isn't true.
> >
> >
> > Yeah, I just read that.  You should either make that more explicit in
> > the documentation, or make it generic.  It's fine if there are
> > drivers/devices that don't need to be told or tell anyone that they
> > recognize magic packets for them to work.  The lack of the property
> > in other controllers won't break anything.
> >
> > But I'm fine if you just document that the bit indicates,
> > specifically, the presence of magic-packet bits in certain registers
> > on the eTSEC.
> 
> I'd ask is it really freescale specific?  In that I'd assume its  
> support for the standard wake-on-lan packet.

Further, is there already a standard description for WoL capability
described in one of the OF binding documents.  Segher?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
