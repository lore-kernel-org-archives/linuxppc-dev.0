Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7ABD6DDEDE
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 06:51:54 +1100 (EST)
Subject: Re: [RFC/PATCH 0/14] powerpc: 4xx PCI and PCI-X support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200711211504.13003.sr@denx.de>
References: <1195625777.579001.269266058699.qpush@grosgo>
	<20071121072348.7fff79a9@weaponx>  <200711211504.13003.sr@denx.de>
Content-Type: text/plain
Date: Thu, 22 Nov 2007 06:51:39 +1100
Message-Id: <1195674699.6970.92.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-11-21 at 15:04 +0100, Stefan Roese wrote:
> On Wednesday 21 November 2007, Josh Boyer wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > Here's a set of patches that bring PCI and PCI-X support for
> > > 4xx (PCIe still missing) in arch/powerpc.
> > >
> > > This is for review before I ask paulus to pull that into his
> > > for 2.6.25 tree. Some of the patches still need a bit more
> > > testing vs. regressions on other platforms such as the
> > > 64 bits resource fixup one.
> >
> > I'm starting my 2.6.25 branch today.  I'll probably throw these in
> > there after I've tested a bit, since I need them to make further
> > progress with 4xx anyway.
> 
> Yes, it would be great to have an "official" repo with all the new 4xx stuff 
> (PCI, EMAC...) stuff.

It would be good, but not in the form of a for-2.6.25 because some of
the patches aren't yet dry enough, more like something paulus could pull
into powerpc.git...

Ben.
