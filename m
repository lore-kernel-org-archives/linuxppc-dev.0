Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y702r6XRtzDr1T
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 15:21:40 +1100 (AEDT)
In-Reply-To: <20170903181513.29635-1-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: alistair@popple.id.au
Subject: Re: [v3,1/2] powerpc/mm: Export flush_all_mm()
Message-Id: <3y702r4yzGz9t3v@ozlabs.org>
Date: Thu,  5 Oct 2017 15:21:40 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-09-03 at 18:15:12 UTC, Frederic Barrat wrote:
> With the optimizations introduced by commit a46cc7a90fd8
> ("powerpc/mm/radix: Improve TLB/PWC flushes"), flush_tlb_mm() no
> longer flushes the page walk cache with radix. This patch introduces
> flush_all_mm(), which flushes everything, tlb and pwc, for a given mm.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Reviewed-By: Alistair Popple <alistair@popple.id.au>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6110236b9bbd177debc045c5fc2922

cheers
