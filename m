Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/7] Remove bogus comment in dma_direct_alloc_coherent()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <f62c2a7477a956c09fe9286922c350465a60dacd.1200894155.git.michael@ellerman.id.au>
References: <2949748ba6ad7e14f0768ac3889267e42c050d7a.1200894155.git.michael@ellerman.id.au>
	<f62c2a7477a956c09fe9286922c350465a60dacd.1200894155.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Mon, 21 Jan 2008 17:22:08 +1100
Message-Id: <1200896528.7222.117.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	cbe-oss-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-01-21 at 16:42 +1100, Michael Ellerman wrote:
> Since commit c80d9133e99de1af607314107910a2a1645efb17 (Make direct DMA use
> node local allocations) went in this comment makes no sense.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/kernel/dma_64.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
> index 72fdc06..8423907 100644
> --- a/arch/powerpc/kernel/dma_64.c
> +++ b/arch/powerpc/kernel/dma_64.c
> @@ -130,7 +130,6 @@ static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
>  	void *ret;
>  	int node = dev->archdata.numa_node;
>  
> -	/* TODO: Maybe use the numa node here too ? */
>  	page = alloc_pages_node(node, flag, get_order(size));
>  	if (page == NULL)
>  		return NULL;
