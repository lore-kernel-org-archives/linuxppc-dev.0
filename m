Return-Path: <dgibson@ozlabs.org>
Date: Wed, 16 May 2007 13:47:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: Small fixes for the Ebony device tree
Message-ID: <20070516034701.GD19127@localhost.localdomain>
References: <20070514045404.GP6517@localhost.localdomain>
	<3af16d1a6c09901f10dca3b6a3f8c698@kernel.crashing.org>
	<20070515011704.GB565@localhost.localdomain>
	<b353b330365fd9ede35fb1cbbbf09aec@kernel.crashing.org>
	<20070515054626.GB6998@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070515054626.GB6998@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 03:46:26PM +1000, David Gibson wrote:
> On Tue, May 15, 2007 at 06:59:49AM +0200, Segher Boessenkool wrote:
[snip]
> > driver as well -- can't you just *fix* the kernel driver,
> > instead?
> 
> Well.. I guess, but I'd prefer to leave that to BenH, who wrote the
> driver.

On second thoughts I will alter the driver, the new version I sent out
today has the fix to only look at 'compatible'.

> > > Don't really want to change the name, since
> > > that might encourage confusion with the other (more conventional) DMA
> > > controller.
> > 
> > Nah, just look at the other properties in the node and
> > you know what is what.  It is quite common to have nodes
> > with the same name representing different devices (for
> > example, "ethernet" devices -- "dma-controller" would be
> > a bit more unusual, sure).
> > 
> > I have no strong feelings about the name, "mcmal" is
> > generic enough a name as far as I'm concerned.

I'll leave it then.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
