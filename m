Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwfrf0qjDzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 15:50:42 +1000 (AEST)
In-Reply-To: <20160405190547.GA12673@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 James Dykman <jdykman@us.ibm.com>
Subject: Re: [1/1] powerpc/mm: Add memory barrier in __hugepte_alloc()
Message-Id: <3rwfrd6Vq2z9sxb@ozlabs.org>
Date: Fri, 22 Jul 2016 15:50:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-04 at 19:05:47 UTC, Sukadev Bhattiprolu wrote:
> >From f7b73c6b4508fe9b141a43d92be2f9dd7d3c4a58 Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Thu, 24 Mar 2016 02:07:57 -0400
> Subject: [PATCH 1/1] powerpc/mm: Add memory barrier in __hugepte_alloc()
> 
> __hugepte_alloc() uses kmem_cache_zalloc() to allocate a zeroed PTE
> and proceeds to use the newly allocated PTE. Add a memory barrier to
> make sure that the other CPUs see a properly initialized PTE.
> 
> Based on a fix suggested by James Dykman.
> 
> Reported-by: James Dykman <jdykman@us.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Tested-by: James Dykman <jdykman@us.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0eab46be21449f1612791201aa

cheers
