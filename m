Return-Path: <dgibson@ozlabs.org>
Date: Mon, 11 Feb 2008 14:13:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [libfdt] RFC: Node iterators (v2)
Message-ID: <20080211031343.GE11572@localhost.localdomain>
References: <20080116062022.GD5016@localhost.localdomain>
	<20080117051009.GA12239@localhost.localdomain>
	<47AB956D.4090805@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47AB956D.4090805@freescale.com>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 07, 2008 at 05:34:05PM -0600, Scott Wood wrote:
> David Gibson wrote:
> > And here's a revised version.  This now also handles recursive
> > iteration and iteration across nodes without respect to depth.  I've
> > removed the for_each() macros for the time being, because they were
> > making my brain hurt, but I'm still contemplating bringing them back.
> > Several libfdt functions are now implemented using the new iterator,
> > so this ends up as a code-size-reducing patch.
> > 
> > I'm pretty happy with the basic outline of this now, although the
> > names and details might want a bit of polish still.
> 
> Can we get this merged?

Well, I'm back from holidays now, so I will resume looking at this.  I
hope we can merge it soon, yes.

> > +int _fdt_next_node(const void *fdt, int offset, int *depth)
> > +{
> 
> This is a public function; why the underscore?

Well, because I still think of it as a low-level "only use if you
really know what you're doing" type function (which is what _ is
supposed to indicate; truly private functions don't need the fdt_
prefix at all).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
