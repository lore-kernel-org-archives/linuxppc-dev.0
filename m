Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A048ADDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 17:48:48 +1100 (EST)
Subject: Re: [PATCH 3/3] powerpc: Rework context management for CPUs with
	no hash table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20081204173813.fa04b41b.sfr@canb.auug.org.au>
References: <20081204054232.2554CDDE2A@ozlabs.org>
	<20081204173813.fa04b41b.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Thu, 04 Dec 2008 17:46:32 +1100
Message-Id: <1228373192.7356.278.camel@pasglop>
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

On Thu, 2008-12-04 at 17:38 +1100, Stephen Rothwell wrote:
> Hi Ben,
> 
> On Thu, 04 Dec 2008 16:41:53 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > +++ linux-work/arch/powerpc/mm/mmu_context_nohash.c	2008-12-04 15:18:46.000000000 +1100
> > +	/* No more free contexts, let's try to steal one */
> > +	if (nr_free_contexts == 0) {
> > +#ifdef CONFIF_SMP
>                ^
> typo

Bah, leave me some surprises for Kumar for when he tests on actual SMP
hardware :-)

Cheers,
Ben.
