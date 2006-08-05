Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-40-242-100.roch.qwest.net
	[67.40.242.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9640A679F0
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Aug 2006 02:34:10 +1000 (EST)
Subject: Re: [PATCH] Fix powerpc 44x_mmu build
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Matt Porter <mporter@embeddedalley.com>
In-Reply-To: <20060805131157.GA1873@matthew-porters-computer.local>
References: <20060804164401.GB4959@gate.crashing.org>
	<1154740342.2847.6.camel@vader.jdub.homelinux.org>
	<20060805131157.GA1873@matthew-porters-computer.local>
Content-Type: text/plain
Date: Sat, 05 Aug 2006 11:33:49 -0500
Message-Id: <1154795629.2847.23.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-08-05 at 09:11 -0400, Matt Porter wrote:
> On Fri, Aug 04, 2006 at 08:12:22PM -0500, Josh Boyer wrote:
> > On Fri, 2006-08-04 at 11:44 -0500, Matt Porter wrote:
> > > The PIN_SIZE definition name changed, update 44x_mmu.c accordingly.
> > 
> > As far as I know, 4xx still builds as ARCH=ppc...  is this patch just
> > something you noticed, or is it a hint that you're working on moving 4xx
> > to arch/powerpc?
> 
> Yes, working on moving 4xx to arch/powerpc.

Excellent.

> 
> > Just curious, since I've been poking at this a bit and would rather not
> > duplicate effort.
> 
> Sounds great. In fact, I talked to BenH and tgall at ols about this
> and they mentioned you were doing some work. These patches are
> just some obvious basic things to get started.
> 
> Since there's a lot of work here, what aspect are you working on?
> I haven't seen anything publicly but hear plenty of talk of people
> working on dt soc definitions for 4xx i/o blocks.

At the moment, I'm mostly trying to sit down and figure out the whole
device tree stack.  That, and keep up with the irq rework BenH did.  I
won't really be digging in for another couple weeks, but then I hope to
start actually doing something.

> I'm currently looking at merging ocotea but am using it to focus
> on a few fundamental things like merging over a version of the
> non-coherent DMA API implementation. The plan here is to get
> a serial-only port merged and then sync with whoever is working
> on the definitions and driver changes for the essential drivers
> (obviously emac first from my POV).

That sounds like a good plan.  I know a guy already working on emac, but
it's a bit of a unique setup he's got.  I'll try and get some patches
out of him soon.

>From talking with BenH, we'd also need the dt-in-zImage patches that are
floating around.  Anybody know what's going on with those?

josh
