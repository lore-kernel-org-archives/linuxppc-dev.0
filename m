Return-Path: <dgibson@ozlabs.org>
Date: Wed, 26 Mar 2008 08:21:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: dtc: Simplify error handling for unparseable input
Message-ID: <20080325212127.GA8281@localhost.localdomain>
References: <20080324034424.GC29985@localhost.localdomain>
	<20080324173641.GA22159@loki.buserror.net>
	<20080325012805.GA1227@localhost.localdomain>
	<20080325143619.GB13187@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080325143619.GB13187@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, Mar 25, 2008 at 09:36:19AM -0500, Scott Wood wrote:
> On Tue, Mar 25, 2008 at 12:28:05PM +1100, David Gibson wrote:
> > On Mon, Mar 24, 2008 at 12:36:41PM -0500, Scott Wood wrote:
> > > If you remove this, there'll be no way to indicate semantic errors other
> > > than die() (the NULL approaches are no good, since they inhibit recovery),
> > > which is suboptimal if the error is not immediately fatal.
> > 
> > But everything is immediately fatal.  When we have a *real* example of
> > something that's not, we can restore an error code.
> 
> Failed binary includes are not immediately fatal.

And is there any advantage to having them not immediately fatal?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
