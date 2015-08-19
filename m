Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95B931A0E13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 09:14:16 +1000 (AEST)
In-Reply-To: <1438928387-6454-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [1/5] powerpc/mm: Fix pte_pagesize_index() crash on 4K w/64K hash
Message-Id: <20150819231416.27A7D140788@ozlabs.org>
Date: Thu, 20 Aug 2015 09:14:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-08 at 06:19:43 UTC, Michael Ellerman wrote:
> The powerpc kernel can be built to have either a 4K PAGE_SIZE or a 64K
> PAGE_SIZE.
...

> This fix is ugly, but simple. When we're called for a kernel address we
> return 4K, which is always correct in this configuration, otherwise we
> use the slice mask.
> 
> Fixes: 7aa0727f3302 ("powerpc/mm: Increase the slice range to 64TB")
> Reported-by: Cyril Bur <cyrilbur@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/74b5037baa2011a2799e

cheers
