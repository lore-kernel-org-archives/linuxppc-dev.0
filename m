Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32BFEDE4FF
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 22:20:34 +1000 (EST)
Subject: Re: [PATCH 11/12] platinumfb: use linux/of_{device,platform}.h
	instead of asm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080523163958.c4236156.sfr@canb.auug.org.au>
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
	<20080523163958.c4236156.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Fri, 23 May 2008 08:20:23 -0400
Message-Id: <1211545223.8297.299.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-05-23 at 16:39 +1000, Stephen Rothwell wrote:
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/video/platinumfb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
> index cbe71a5..03b3670 100644
> --- a/drivers/video/platinumfb.c
> +++ b/drivers/video/platinumfb.c
> @@ -31,11 +31,11 @@
>  #include <linux/fb.h>
>  #include <linux/init.h>
>  #include <linux/nvram.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  #include <asm/io.h>
>  #include <asm/prom.h>
>  #include <asm/pgtable.h>
> -#include <asm/of_device.h>
> -#include <asm/of_platform.h>
>  
>  #include "macmodes.h"
>  #include "platinumfb.h"
> -- 
> 1.5.5.1
> 
