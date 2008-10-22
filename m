Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2EDF6DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 11:23:36 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add del_node function to allow early boot
	code to prune inapplicable devices.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Ditto <mditto@consentry.com>
In-Reply-To: <20081021233306.GA2108@secretlab.ca>
References: <48F7E1E6.4040701@consentry.com>
	<20081017012604.GA22213@yookeroo.seuss> <48FE4A6D.5@consentry.com>
	<20081021233306.GA2108@secretlab.ca>
Content-Type: text/plain
Date: Wed, 22 Oct 2008 11:23:29 +1100
Message-Id: <1224635009.7654.290.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-10-21 at 17:33 -0600, Grant Likely wrote:
> On Tue, Oct 21, 2008 at 02:32:29PM -0700, Mike Ditto wrote:
> > Reposting in proper format...
> > 
> > Some platforms have variants that can share most of a flat device tree but need
> > a few devices selectively pruned at boot time.  This adds del_node() to ops.h
> > to allow access to the existing fdt_del_node().
> > 
> > Signed-off-by: Mike Ditto <mditto@consentry.com>
> 
> Looks good to me.
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

little nit: The patch doesn't quite have the right form.

Patches to the kernel are expected to apply with -p1, so
for example, the patch line contains:

arch/powerpc/boot/ops.h

It should be

something/arch/powerpc/boot/ops.h

I've fixed it up manually so no need to re-submit, but you'll know next
time :-)

Cheers,
Ben.
