Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 008BADDDE3
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2008 15:37:26 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix mismerge of iss4xx platform support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081208043311.5CB96DDE07@ozlabs.org>
References: <20081208043311.5CB96DDE07@ozlabs.org>
Content-Type: text/plain
Date: Mon, 08 Dec 2008 15:37:17 +1100
Message-Id: <1228711037.7101.26.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-08 at 15:32 +1100, Benjamin Herrenschmidt wrote:
> The Makefile missed the necessary bit for treeboot-iss4xx.o to be built
> thus breaking builds of this platform
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

Ignore patch, my mistake :-)

Cheers,
Ben.

>  arch/powerpc/boot/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-work.orig/arch/powerpc/boot/Makefile	2008-12-08 15:30:38.000000000 +1100
> +++ linux-work/arch/powerpc/boot/Makefile	2008-12-08 15:30:56.000000000 +1100
> @@ -70,7 +70,7 @@ src-plat := of.c cuboot-52xx.c cuboot-82
>  		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
>  		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
>  		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
> -		cuboot-acadia.c
> +		cuboot-acadia.c treeboot-iss4xx.c
>  src-boot := $(src-wlib) $(src-plat) empty.c
>  
>  src-boot := $(addprefix $(obj)/, $(src-boot))
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
