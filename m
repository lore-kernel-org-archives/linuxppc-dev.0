Return-Path: <SRS0=QhAZ=NY=denx.de=sr@srs.kundenserver.de>
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] [POWERPC] Add pci node to sequoia dts
Date: Mon, 27 Aug 2007 08:38:48 +0200
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
	<200708270807.17351.sr@denx.de>
	<20070827062135.GC7306@localhost.localdomain>
In-Reply-To: <20070827062135.GC7306@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708270838.48675.sr@denx.de>
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 27 August 2007, David Gibson wrote:
> On Mon, Aug 27, 2007 at 08:07:17AM +0200, Stefan Roese wrote:
> [snip]
>
> > > I usually put device_type, compatible and reg at the top of the block,
> > > to announce what the node actually is before giving all the details.
> > >
> > > Also, apart from the stray space in the compatible, I'm guessing that
> > > the 440EPx bridge is actually more-or-less like the PCI bridges on
> > > other 4xx chips, so we should have a more general compatible string
> > > too.
> >
> > Yes, it is "more-or-less" like any other 4xx PCI core. So it really would
> > make sense to define it more generally. Something like:
> >
> > 			compatible = "ibm,pci-440epx", "ibm,pci4xx";
> >
> > or even:
> >
> > 			compatible = "ibm,pci-440epx", "ibm,pci";
> >
> > ?
>
> Hrm.. "xx" is ugly, and "ibm,pci" isn't specific enough.  I think
> we're better off just using the oldest similar chip.  Since this is
> vanilla PCI, I think that makes it "ibm,pci-405gp"

Fine with me.

> > > Is the 440EPx a vanilla PCI or a PCI-X bridge?  If the later that
> > > should be reflected in the name and compatible as well.
> >
> > It's a vanilla PCI bridge.
>
> Ok, so it is different from 440GP which is PCI-X.

Yes. There are some common parts (IIRC), but there are differences. Perhaps 
both, IBM-PCI and IBM-PCI-X can be integrated into one source too, but I 
think we should start with PCI-only right now.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
