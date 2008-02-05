Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Add set_dma_ops() to match get_dma_ops().
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <edf2d9650b044e2bc21e9b74ad1044f4e5b6615c.1201257905.git.michael@ellerman.id.au>
References: <edf2d9650b044e2bc21e9b74ad1044f4e5b6615c.1201257905.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 11:23:04 +1100
Message-Id: <1202170984.7079.35.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-01-25 at 21:45 +1100, Michael Ellerman wrote:
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  include/asm-powerpc/dma-mapping.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
> index 5eea6db..bbefb69 100644
> --- a/include/asm-powerpc/dma-mapping.h
> +++ b/include/asm-powerpc/dma-mapping.h
> @@ -76,6 +76,11 @@ static inline struct dma_mapping_ops *get_dma_ops(struct device *dev)
>  	return dev->archdata.dma_ops;
>  }
>  
> +static inline void set_dma_ops(struct device *dev, struct dma_mapping_ops *ops)
> +{
> +	dev->archdata.dma_ops = ops;
> +}
> +
>  static inline int dma_supported(struct device *dev, u64 mask)
>  {
>  	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
