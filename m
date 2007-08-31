Return-Path: <dgibson@ozlabs.org>
Date: Fri, 31 Aug 2007 13:24:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 6/9] bootwrapper: Add a zImage.bin.<platform> target.
Message-ID: <20070831032405.GJ19271@localhost.localdomain>
References: <20070829164534.GA31585@ld0162-tx32.am.freescale.net>
	<20070829164741.GD31640@ld0162-tx32.am.freescale.net>
	<20070830003409.GE21072@localhost.localdomain>
	<20070830142115.GB24123@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070830142115.GB24123@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 09:21:15AM -0500, Scott Wood wrote:
> On Thu, Aug 30, 2007 at 10:34:09AM +1000, David Gibson wrote:
> > Hrm.. I think the --binary option at least should be removed, and
> > subsumed into the platform id - all other binary formats are selected
> > by the platform name at present.
> > 
> > And I think it's probably best to do that for --fixed-entry as well,
> > although it's a bit less clear there.
> 
> I'm not particularly fond of having huge platform switch blocks in the
> wrapper script -- if it can be reasonably parameterized, why not do so?

Because I'd prefer to keep as much of the per-platform details (what
binary format is needed and so forth) concentrated in wrapper, rather
than scattered across multiple places.  I agree we're not really doing
it the best way - I had some ideas for a nicer way to rewrite wrapper,
but I haven't had a chance to implement it yet.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
