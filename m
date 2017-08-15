Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWqcf5ttpzDr39
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 21:14:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Julia Lawall <Julia.Lawall@lip6.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: store the intended structure
In-Reply-To: <1502630663-18599-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1502630663-18599-1-git-send-email-Julia.Lawall@lip6.fr>
Date: Tue, 15 Aug 2017 21:14:21 +1000
Message-ID: <87valpt75e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Julia Lawall <Julia.Lawall@lip6.fr> writes:

> Normally the values in the resource field and the argument to ARRAY_SIZE
> in the num_resources are the same.  In this case, the value in the reousrce
> field is the same as the one in the previous platform_device structure, and
> appears to be a copy-paste error.  Replace the value in the resource field
> with the argument to the local call to ARRAY_SIZE.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  arch/powerpc/platforms/chrp/pegasos_eth.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks. This is close to EOL code I think, but I'll merge it anyway as
it seems obviously correct.

cheers

> diff --git a/arch/powerpc/platforms/chrp/pegasos_eth.c b/arch/powerpc/platforms/chrp/pegasos_eth.c
> index 2b4dc6a..1976071 100644
> --- a/arch/powerpc/platforms/chrp/pegasos_eth.c
> +++ b/arch/powerpc/platforms/chrp/pegasos_eth.c
> @@ -63,7 +63,7 @@
>  	.name		= "orion-mdio",
>  	.id		= -1,
>  	.num_resources	= ARRAY_SIZE(mv643xx_eth_mvmdio_resources),
> -	.resource	= mv643xx_eth_shared_resources,
> +	.resource	= mv643xx_eth_mvmdio_resources,
>  };
>  
>  static struct resource mv643xx_eth_port1_resources[] = {
