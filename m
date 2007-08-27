Return-Path: <dgibson@ozlabs.org>
Date: Mon, 27 Aug 2007 16:21:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 2/3] [POWERPC] Add pci node to sequoia dts
Message-ID: <20070827062135.GC7306@localhost.localdomain>
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
	<20070825092954.4087.95333.stgit@localhost.localdomain>
	<20070827015417.GB12804@localhost.localdomain>
	<200708270807.17351.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200708270807.17351.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 27, 2007 at 08:07:17AM +0200, Stefan Roese wrote:
[snip]
> > I usually put device_type, compatible and reg at the top of the block,
> > to announce what the node actually is before giving all the details.
> >
> > Also, apart from the stray space in the compatible, I'm guessing that
> > the 440EPx bridge is actually more-or-less like the PCI bridges on
> > other 4xx chips, so we should have a more general compatible string
> > too.
> 
> Yes, it is "more-or-less" like any other 4xx PCI core. So it really would make 
> sense to define it more generally. Something like:
> 
> 			compatible = "ibm,pci-440epx", "ibm,pci4xx";
> 
> or even:
> 
> 			compatible = "ibm,pci-440epx", "ibm,pci";
> 
> ?

Hrm.. "xx" is ugly, and "ibm,pci" isn't specific enough.  I think
we're better off just using the oldest similar chip.  Since this is
vanilla PCI, I think that makes it "ibm,pci-405gp"

> > Is the 440EPx a vanilla PCI or a PCI-X bridge?  If the later that
> > should be reflected in the name and compatible as well.
> 
> It's a vanilla PCI bridge.

Ok, so it is different from 440GP which is PCI-X.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
