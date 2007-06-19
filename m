Return-Path: <dgibson@ozlabs.org>
Date: Tue, 19 Jun 2007 15:08:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Message-ID: <20070619050812.GA32039@localhost.localdomain>
References: <20070618185715.321010@gmx.net>
	<20070618191529.GC8740@mag.az.mvista.com>
	<20070618194359.321010@gmx.net>
	<20070618202518.GG8740@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070618202518.GG8740@mag.az.mvista.com>
Cc: "list <linuxppc-dev"@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2007 at 01:25:18PM -0700, Mark A. Greer wrote:
> On Mon, Jun 18, 2007 at 09:43:59PM +0200, Gerhard Pircher wrote:
> > Von: "Mark A. Greer" <mgreer@mvista.com>
> > > On Mon, Jun 18, 2007 at 08:57:15PM +0200, Gerhard Pircher wrote:
> > > 
> > > > 1. The AmigaOne makes use of different G3...
> > > 
> > > I'm far from an authoritative figure on this but making a
> > > reasonable default (in your dts file) then updating in the 
> > > bootwrapper makes sense to me.  That's what I did for several 
> > > properties in the prpmc2800's dts.
> > So, the bootwrapper should update the name property of the CPU node. Is the cpu node name used somewhere?
> 
> Oh, sorry I really talking about the cpu frequencies, etc.
> I don't think the name of the cpu node matters but I'd have to check.
> Others probably know off the top of their heads.

I don't believe the name is actually used.  It would be nice to get it
right, though - I think it can be considered option for the first cut,
though.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
