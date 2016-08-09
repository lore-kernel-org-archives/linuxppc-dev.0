Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sS06dQFzDqfS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:40 +1000 (AEST)
In-Reply-To: <488c970c5ae.f93db6b@auth.smtp.1and1.co.uk>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: olof@lixom.net, Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: pasemi: Fix coherent_dma_mask for dma engine
Message-Id: <3s7sS05dmxz9t1y@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-27-07 at 14:41:29 UTC, Darren Stevens wrote:
> Commit 817820b0226a ("powerpc/iommu: Support "hybrid" iommu/direct DMA
>     ops for coherent_mask < dma_mask) adds a check of coherent_dma_mask
>     for dma allocations.
>     Unfortunately current PASemi code does not set this value for the DMA
>     engine, which ends up with the default value of 0xffffffff, the result 
>     is on a PASemi system with >2Gb ram and iommu enabled the the onboard 
>     ethernet stops working due to an inability to allocate memory.
>     Add an initialisation to pci_dma_dev_setup_pasemi()
>   
>     Signed-off-by: Darren Stevens <darren@stevens-zone.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/416f37d0816b9720b8227953e5

cheers
