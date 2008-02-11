Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A2150DDF56
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 09:03:24 +1100 (EST)
Message-ID: <47B0C59C.5080209@freescale.com>
Date: Mon, 11 Feb 2008 16:01:00 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH 1/2] powerpc: publish 85xx soc dts entries as of_device
References: <20080211203243.GA5331@blade.az.mvista.com>
In-Reply-To: <20080211203243.GA5331@blade.az.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dave Jiang wrote:

> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> index 4e03050..024393c 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> @@ -26,6 +26,8 @@
>  #include <asm/mpic.h>
>  #include <mm/mmu_decl.h>
>  #include <asm/udbg.h>
> +#include <asm/of_device.h>
> +#include <asm/of_platform.h>

Please use <linux/of_{device,platform}.h> throughout instead.

Thanks.
jdl
