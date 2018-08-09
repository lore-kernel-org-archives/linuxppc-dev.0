Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41m7zf4mFwzDqkP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 10:14:38 +1000 (AEST)
Message-ID: <eebe8416aa668740945dca6b271268b464aac02a.camel@kernel.crashing.org>
Subject: Re: [PATCH 09/20] powerpc/dma: remove the unused ISA_DMA_THRESHOLD
 export
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Robin Murphy
 <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-ia64@vger.kernel.org
Date: Thu, 09 Aug 2018 10:14:17 +1000
In-Reply-To: <20180730163824.10064-10-hch@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
 <20180730163824.10064-10-hch@lst.de>
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
>  arch/powerpc/kernel/setup_32.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index 74457485574b..3c2d093f74c7 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -55,7 +55,6 @@ unsigned long ISA_DMA_THRESHOLD;
>  unsigned int DMA_MODE_READ;
>  unsigned int DMA_MODE_WRITE;
>  
> -EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
>  EXPORT_SYMBOL(DMA_MODE_READ);
>  EXPORT_SYMBOL(DMA_MODE_WRITE);
>  fooBenjam
