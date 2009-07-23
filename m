Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 957CBB7BDA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 17:08:18 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BA24DDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 17:08:17 +1000 (EST)
Subject: Re: [PATCH 9/20] powerpc/mm: Call mmu_context_init() from ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20090723162254.6ba0cb51.sfr@canb.auug.org.au>
References: <20090723055955.757B4DDD1B@ozlabs.org>
	<20090723162254.6ba0cb51.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Thu, 23 Jul 2009 17:07:59 +1000
Message-Id: <1248332879.3367.72.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-07-23 at 16:22 +1000, Stephen Rothwell wrote:
> Hi Ben,
> 
> On Thu, 23 Jul 2009 15:59:44 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > Index: linux-work/arch/powerpc/mm/mmu_context_hash64.c
> > ===================================================================
> > --- linux-work.orig/arch/powerpc/mm/mmu_context_hash64.c	2009-07-22 16:24:43.000000000 +1000
> > +++ linux-work/arch/powerpc/mm/mmu_context_hash64.c	2009-07-22 16:24:56.000000000 +1000
> > @@ -76,3 +76,4 @@ void destroy_context(struct mm_struct *m
> >  
> >  	mm->context.id = NO_CONTEXT;
> >  }
> > +
> 
> Really? :-(

Little mechanical problem, I used to have something in there in a
previous rev of the patch, I'll re-spin that one without that bit.

Cheers,
Ben.
