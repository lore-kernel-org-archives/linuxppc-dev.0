Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 816D31A19FD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 20:01:01 +1000 (AEST)
In-Reply-To: <1435123522.3996.29.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/3] powerpc/iommu: Remove dma_data union
Message-Id: <20150716100100.EB1FA1402C2@ozlabs.org>
Date: Thu, 16 Jul 2015 20:01:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-24-06 at 05:25:22 UTC, Benjamin Herrenschmidt wrote:
> To support "hybrid" DMA ops in a subsequent patch, we will need both
> a direct DMA offset and an iommu pointer. Those are currently exclusive
> (a union), so change them to be separate fields.
> 
> While there, also type iommu_table_base properly and make exist only
> on CONFIG_PPC64 since it's not referenced on 32-bit at all.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2db4928bb559f8b43ca7

cheers
