Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B1475B7C1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 07:04:33 +1000 (EST)
Message-Id: <40312002-766E-428B-8AC4-5CB50D854647@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1248405855-15546-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 3/5] add set_dma_mask hook to struct dma_map_ops
Date: Mon, 27 Jul 2009 16:02:57 -0500
References: <1248405855-15546-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1248405855-15546-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 23, 2009, at 10:24 PM, FUJITA Tomonori wrote:

> POWERPC needs this hook. SPARC could use it too.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Acked-by: Becky Bruce <beckyb@kernel.crashing.org>

>
> ---
> include/linux/dma-mapping.h |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index c0f6c3c..91b7618 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -58,6 +58,7 @@ struct dma_map_ops {
> 				   enum dma_data_direction dir);
> 	int (*mapping_error)(struct device *dev, dma_addr_t dma_addr);
> 	int (*dma_supported)(struct device *dev, u64 mask);
> +	int (*set_dma_mask)(struct device *dev, u64 mask);
> 	int is_phys;
> };
>
> --  
> 1.6.0.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
