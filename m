Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3AD8867A75
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 16:40:58 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix warning in cell setup.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060701230845.e2f8507d.akpm@osdl.org>
References: <1151814604.19419.20.camel@localhost.localdomain>
	<20060701230845.e2f8507d.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 16:40:41 +1000
Message-Id: <1151822441.19419.22.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-07-01 at 23:08 -0700, Andrew Morton wrote:
> On Sun, 02 Jul 2006 14:30:04 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Fixes a warning due to a missing #include on cell
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > Index: linux-irq-work/arch/powerpc/platforms/cell/setup.c
> > ===================================================================
> > --- linux-irq-work.orig/arch/powerpc/platforms/cell/setup.c	2006-07-01 15:25:33.000000000 +1000
> > +++ linux-irq-work/arch/powerpc/platforms/cell/setup.c	2006-07-01 15:25:36.000000000 +1000
> > @@ -49,6 +49,7 @@
> >  #include <asm/irq.h>
> >  #include <asm/spu.h>
> >  #include <asm/spu_priv1.h>
> > +#include <asm/udbg.h>
> >  
> >  #include "interrupt.h"
> >  #include "iommu.h"
> 
> I already had that.
> 
> I don't know what to do with powerpc patches any more.  Help.

If you already have it, drop it :) I didnt notice it was already there.
For trivialities like that, it doesn't matter. Important stuff goes
through paulus.

Ben.
