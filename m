Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 84E5667A67
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 16:08:58 +1000 (EST)
Date: Sat, 1 Jul 2006 23:08:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix warning in cell setup.c
Message-Id: <20060701230845.e2f8507d.akpm@osdl.org>
In-Reply-To: <1151814604.19419.20.camel@localhost.localdomain>
References: <1151814604.19419.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 02 Jul 2006 14:30:04 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Fixes a warning due to a missing #include on cell
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Index: linux-irq-work/arch/powerpc/platforms/cell/setup.c
> ===================================================================
> --- linux-irq-work.orig/arch/powerpc/platforms/cell/setup.c	2006-07-01 15:25:33.000000000 +1000
> +++ linux-irq-work/arch/powerpc/platforms/cell/setup.c	2006-07-01 15:25:36.000000000 +1000
> @@ -49,6 +49,7 @@
>  #include <asm/irq.h>
>  #include <asm/spu.h>
>  #include <asm/spu_priv1.h>
> +#include <asm/udbg.h>
>  
>  #include "interrupt.h"
>  #include "iommu.h"

I already had that.

I don't know what to do with powerpc patches any more.  Help.
