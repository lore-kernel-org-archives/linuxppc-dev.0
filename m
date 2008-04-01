Return-Path: <dgibson@ozlabs.org>
Date: Tue, 1 Apr 2008 12:53:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH 1/9] [POWERPC] mv64x60: change FDT compatible prefix to
	mrvl
Message-ID: <20080401015342.GB32615@localhost.localdomain>
References: <20080328233954.GA29499@farnsworth.org>
	<20080328234241.GA30214@farnsworth.org>
	<fa686aa40803281647y4ccc4605n1507f9c1868d4c0f@mail.gmail.com>
	<20080330234420.GA24402@localhost.localdomain>
	<20080331165605.GD13750@farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080331165605.GD13750@farnsworth.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 31, 2008 at 09:56:05AM -0700, Dale Farnsworth wrote:
> On Mon, Mar 31, 2008 at 10:44:20AM +1100, David Gibson wrote:
> > On Fri, Mar 28, 2008 at 05:47:25PM -0600, Grant Likely wrote:
> > > On Fri, Mar 28, 2008 at 5:42 PM, Dale Farnsworth <dale@farnsworth.org> wrote:
> > > > From: Dale Farnsworth <dale@farnsworth.org>
> > > >
> > > >  Follow the convention that compatible names are prefixed by the
> > > >  vendor's stock ticker symbol.  For Marvell Technology Group Ltd.,
> > > >  that's MRVL.
> > > >
> > > >  Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> > > >  Acked-by: Mark A. Greer <mgreer@mvista.com>
> > > 
> > > Are there any boards "in the wild" using the old string?  If so are
> > > does changing this string risk complicating upgrades to a new kernel
> > > version?
> > 
> > In particular are there any pre-flattened-tree real-OF systems in the
> > wild using "marvell" as the vendor prefix (there might be Apple or IBM
> > systems out there with Marvell PHYs for example).
> 
> It's difficult to prove a negative.  However, I've seen no evidence of
> such systems.  When Mark invented the "marvell," prefix, it wasn't based
> on existing practice.
> 
> However, I believe that the Genesi Pegasos board uses OF and has a
> Marvell bridge chip.  They may have copied the "marvell," prefix.
> 
> Matt, can you check whether any of the Genesi boards contain device node
> descriptions for the Marvel 64[34]60, and let us know what prefix is used
> in their compatible properties?

Ok, fair enough.  As long as you've been duly diligent about checking
for existing practice I'm happy.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
