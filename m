Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E2D02BF0E
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Jan 2005 11:33:25 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20050109123515.GC17561@pegasos>
References: <20050109115720.GA19213@lst.de> <20050109123515.GC17561@pegasos>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 01:33:05 +0100
Message-Id: <1105576385.6021.2.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: status of the G4 l2 cache flush and MSR errate patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Mmm, well, i am not really the author of this one. Jacob Pan from freescale is
> the author, so we should change this, will do. So this should show :
> 
> ## DP: Patch author: Pan Jacob-r7aahq <Jacob.Pan@freescale.com>
> > ## DP: Upstream status: under review by benh.
> 
> The patch does two things. Use hardware assist for cache flush, which seems to
> be ok on 744x processors, but broken on earlier G4s and G3s. And add a printk
> in case of some exception, so the user knows about it instead of it being
> silently discarded. 

The HW assist isn't completely ok neither... it should be enough for
enabling the cache at boot though. I've been banging my head lately
trying to get a properly working & reliable cache flush mecanism for use
on the Mac laptops since we need that for cpufreq and sleep on various
models, but what I have right now is just a "works most of the time"
kind of implementation.

> I was under the impression that benh said that the patch was ok, but not
> really relevant, since it applies to code travel cases which either are not
> really used in the common case, or result in a dying of the kernel anyway.
> Don't remember all the details though. They do respond to some G4 processor
> errata's though.

I'll have a look again. Just back from vacation, leave me a coupe of
days to catch up with everything and I'll take care of those.

Ben.
