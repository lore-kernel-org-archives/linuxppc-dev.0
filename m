Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D9B9DE0E7
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 06:51:24 +1100 (EST)
Subject: Re: [RFC/PATCH 0/14] powerpc: 4xx PCI and PCI-X support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071121072348.7fff79a9@weaponx>
References: <1195625777.579001.269266058699.qpush@grosgo>
	<20071121072348.7fff79a9@weaponx>
Content-Type: text/plain
Date: Thu, 22 Nov 2007 06:50:51 +1100
Message-Id: <1195674651.6970.91.camel@pasglop>
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


On Wed, 2007-11-21 at 07:23 -0600, Josh Boyer wrote:
> On Wed, 21 Nov 2007 17:16:17 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Here's a set of patches that bring PCI and PCI-X support for
> > 4xx (PCIe still missing) in arch/powerpc.
> > 
> > This is for review before I ask paulus to pull that into his
> > for 2.6.25 tree. Some of the patches still need a bit more
> > testing vs. regressions on other platforms such as the
> > 64 bits resource fixup one.
> 
> I'm starting my 2.6.25 branch today.  I'll probably throw these in
> there after I've tested a bit, since I need them to make further
> progress with 4xx anyway.

Don't until I submit them for inclusion (when I said paulus above, I
actually meant you of course :-), I want one more round (I already have
enough comments to do minor fixups on most of them)

But I would definitely appreciate testing :-)

Cheers,
Ben.
