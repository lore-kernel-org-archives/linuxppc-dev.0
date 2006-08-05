Return-Path: <mporter@embeddedalley.com>
Received: from matthew-porters-computer.local (cpe-088197.static.wadsnet.net
	[65.114.88.197]) by ozlabs.org (Postfix) with ESMTP id C724A67B55
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 02:14:14 +1000 (EST)
Date: Sat, 5 Aug 2006 09:11:57 -0400
From: Matt Porter <mporter@embeddedalley.com>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Subject: Re: [PATCH] Fix powerpc 44x_mmu build
Message-ID: <20060805131157.GA1873@matthew-porters-computer.local>
References: <20060804164401.GB4959@gate.crashing.org>
	<1154740342.2847.6.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1154740342.2847.6.camel@vader.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 04, 2006 at 08:12:22PM -0500, Josh Boyer wrote:
> On Fri, 2006-08-04 at 11:44 -0500, Matt Porter wrote:
> > The PIN_SIZE definition name changed, update 44x_mmu.c accordingly.
> 
> As far as I know, 4xx still builds as ARCH=ppc...  is this patch just
> something you noticed, or is it a hint that you're working on moving 4xx
> to arch/powerpc?

Yes, working on moving 4xx to arch/powerpc.

> Just curious, since I've been poking at this a bit and would rather not
> duplicate effort.

Sounds great. In fact, I talked to BenH and tgall at ols about this
and they mentioned you were doing some work. These patches are
just some obvious basic things to get started.

Since there's a lot of work here, what aspect are you working on?
I haven't seen anything publicly but hear plenty of talk of people
working on dt soc definitions for 4xx i/o blocks.

I'm currently looking at merging ocotea but am using it to focus
on a few fundamental things like merging over a version of the
non-coherent DMA API implementation. The plan here is to get
a serial-only port merged and then sync with whoever is working
on the definitions and driver changes for the essential drivers
(obviously emac first from my POV).

-Matt`
