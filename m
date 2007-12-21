Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 968EDDDE32
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 23:16:55 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBLBEmDx009808
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 06:14:48 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBLCGqwk167642
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 05:16:52 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBLCGphQ003313
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 05:16:51 -0700
Date: Fri, 21 Dec 2007 06:11:08 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 20/21] [POWERPC] pci32: 4xx embedded platforms want to
	reassign all PCI resources
Message-ID: <20071221061108.5ca6afff@zod.rchland.ibm.com>
In-Reply-To: <20071221043941.37EB9DDFEC@ozlabs.org>
References: <20071221043941.37EB9DDFEC@ozlabs.org>
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

On Fri, 21 Dec 2007 15:39:37 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Index: linux-merge/arch/powerpc/platforms/44x/sequoia.c
> ===================================================================
> --- linux-merge.orig/arch/powerpc/platforms/44x/sequoia.c	2007-12-14 15:48:53.000000000 +1100
> +++ linux-merge/arch/powerpc/platforms/44x/sequoia.c	2007-12-14 15:49:52.000000000 +1100
> @@ -21,7 +21,8 @@
>  #include <asm/udbg.h>
>  #include <asm/time.h>
>  #include <asm/uic.h>
> -#include "44x.h"
> +#include <asm/pci-bridge.h>
> +

This is still broken because you removed the 44x.h include.  I'll fix
it on my commit.

josh
