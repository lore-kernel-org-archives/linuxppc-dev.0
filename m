Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1C17B140084
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2014 05:24:28 +1000 (EST)
Date: Fri, 9 May 2014 14:24:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
Subject: Re: [PATCHv2] powerpc/85xx: Add OCA4080 board support
Message-ID: <20140509192415.GA28160@home.buserror.net>
References: <1397584306-8706-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1397584306-8706-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
Cc: stef.van.os@prodrive-technologies.com,
 Martijn de Gouw <martijn.de.gouw@prodrive.nl>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 15, 2014 at 07:51:46PM +0200, Martijn de Gouw wrote:
> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> index fbd871e..f3685047 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -55,8 +55,6 @@ void __init corenet_gen_setup_arch(void)
>  	mpc85xx_smp_init();
>  
>  	swiotlb_detect_4g();
> -
> -	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);

Valentin's patch kept this line but removed "from Freescale
Semiconductor"; I'll leave it like that when applying.

-Scott
