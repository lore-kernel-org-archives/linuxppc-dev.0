Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41m7bG13cQzDqkP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 09:56:57 +1000 (AEST)
Message-ID: <0b5def1ec1551fb5438279795f5ae3fc5a8902e4.camel@kernel.crashing.org>
Subject: Re: [PATCH 07/20] powerpc/dma: remove the unused
 ARCH_HAS_DMA_MMAP_COHERENT define
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Robin Murphy
 <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-ia64@vger.kernel.org
Date: Thu, 09 Aug 2018 09:56:38 +1000
In-Reply-To: <20180730163824.10064-8-hch@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
 <20180730163824.10064-8-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-07-30 at 18:38 +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/include/asm/dma-mapping.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index 8fa394520af6..f2a4a7142b1e 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -112,7 +112,5 @@ extern int dma_set_mask(struct device *dev, u64 dma_mask);
>  
>  extern u64 __dma_get_required_mask(struct device *dev);
>  
> -#define ARCH_HAS_DMA_MMAP_COHERENT
> -
>  #endif /* __KERNEL__ */
>  #endif	/* _ASM_DMA_MAPPING_H */
