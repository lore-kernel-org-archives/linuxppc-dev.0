Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 28B65DDED0
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 12:49:26 +1100 (EST)
Subject: Re: [PATCH 9/9] powerpc: Add SMP support to no-hash TLB handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <493DA081.8010205@freescale.com>
References: <20081208054144.503C7DDE2A@ozlabs.org>
	<493DA081.8010205@freescale.com>
Content-Type: text/plain
Date: Tue, 09 Dec 2008 12:47:12 +1100
Message-Id: <1228787232.7101.42.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-08 at 16:32 -0600, Scott Wood wrote:
> Benjamin Herrenschmidt wrote:
> > Index: linux-work/arch/powerpc/mm/tlb_nohash.c
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-work/arch/powerpc/mm/tlb_nohash.c	2008-12-08 16:21:24.000000000 +1100
> [snip]
> > +#include <asm/spinlock.h>
> 
> Needs to be linux/spinlock.h, or UP won't build.

Ah right.

Cheers,
Ben.
