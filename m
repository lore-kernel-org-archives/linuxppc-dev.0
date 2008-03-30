Return-Path: <dgibson@ozlabs.org>
Date: Mon, 31 Mar 2008 10:44:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/9] [POWERPC] mv64x60: change FDT compatible prefix to
	mrvl
Message-ID: <20080330234420.GA24402@localhost.localdomain>
References: <20080328233954.GA29499@farnsworth.org>
	<20080328234241.GA30214@farnsworth.org>
	<fa686aa40803281647y4ccc4605n1507f9c1868d4c0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40803281647y4ccc4605n1507f9c1868d4c0f@mail.gmail.com>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 28, 2008 at 05:47:25PM -0600, Grant Likely wrote:
> On Fri, Mar 28, 2008 at 5:42 PM, Dale Farnsworth <dale@farnsworth.org> wrote:
> > From: Dale Farnsworth <dale@farnsworth.org>
> >
> >  Follow the convention that compatible names are prefixed by the
> >  vendor's stock ticker symbol.  For Marvell Technology Group Ltd.,
> >  that's MRVL.
> >
> >  Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> >  Acked-by: Mark A. Greer <mgreer@mvista.com>
> 
> Are there any boards "in the wild" using the old string?  If so are
> does changing this string risk complicating upgrades to a new kernel
> version?

In particular are there any pre-flattened-tree real-OF systems in the
wild using "marvell" as the vendor prefix (there might be Apple or IBM
systems out there with Marvell PHYs for example).

Existing practice trumps "use stock ticker" for the standard vendor
prefix.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
