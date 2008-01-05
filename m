Return-Path: <dgibson@ozlabs.org>
Date: Sat, 5 Jan 2008 23:25:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] MTD for Taco
Message-ID: <20080105122542.GH4326@localhost.localdomain>
References: <477F12D1.2070109@pikatech.com> <200801051041.18173.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200801051041.18173.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 05, 2008 at 10:41:17AM +0100, Stefan Roese wrote:
> On Saturday 05 January 2008, Sean MacLennan wrote:
> > +++ drivers/mtd/maps/taco.c     2008-01-02 13:07:43.000000000 -0500
> > @@ -0,0 +1,140 @@
> > +/*
> > + * $Id: $
> > + *
> > + * drivers/mtd/maps/taco.c
> > + *
> > + * Mapping for PIKA Taco flash
> 
> I'm pretty sure that you don't need a board specific mapping driver
> for NOR flash. physmap_of should be exactly what you need. You just need
> to fill the device tree properties correctly.

Absolutely.  We should not be using C-coded maps in arch/powerpc

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
