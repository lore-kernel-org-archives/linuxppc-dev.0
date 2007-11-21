Return-Path: <jwboyer@gmail.com>
Received: from ro-out-1112.google.com (ro-out-1112.google.com [72.14.202.176])
	by ozlabs.org (Postfix) with ESMTP id B81FEDDDDB
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 01:33:34 +1100 (EST)
Received: by ro-out-1112.google.com with SMTP id p7so2708219roc
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 06:33:33 -0800 (PST)
Date: Wed, 21 Nov 2007 08:33:29 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [RFC/PATCH 0/14] powerpc: 4xx PCI and PCI-X support
Message-ID: <20071121083329.7fce01e9@weaponx>
In-Reply-To: <200711211504.13003.sr@denx.de>
References: <1195625777.579001.269266058699.qpush@grosgo>
	<20071121072348.7fff79a9@weaponx> <200711211504.13003.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 Nov 2007 15:04:12 +0100
Stefan Roese <sr@denx.de> wrote:

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

Sure, I can do that.  I'll probably use my master branch for this
instead, and reserve for-2.6.25 for sending stuff to Paul.  Reason
being that lots of useful things for 4xx don't actually go through my
tree (like EMAC, MTD stuff, etc).

I'll send out an email when I've queued up some stuff.

josh
