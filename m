Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21150DDED6
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 20:11:45 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n2K9BdtC006104
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 04:11:40 -0500
Subject: Re: [PATCH 2/6] powerpc/mm: Merge various PTE bits and accessors
	definitions (v3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20090320053428.E643EDDF03@ozlabs.org>
References: <20090320053428.E643EDDF03@ozlabs.org>
Content-Type: text/plain
Date: Fri, 20 Mar 2009 20:11:39 +1100
Message-Id: <1237540299.25062.580.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-03-20 at 16:34 +1100, Benjamin Herrenschmidt wrote:

> Index: linux-work/arch/powerpc/include/asm/pgtable-ppc64.h
> ===================================================================
> --- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2009-03-20 15:49:51.000000000 +1100
> +++ linux-work/arch/powerpc/include/asm/pgtable-ppc64.h	2009-03-20 15:52:59.000000000 +1100
> @@ -80,82 +80,8 @@
>   * Include the PTE bits definitions
>   */
>  #include <asm/pte-hash64.h>
> +#include <asm/pte-common.h
                             ^

The one I committed to "test" doesn't have that obvious typo :-)

Cheers,
Ben.
 
