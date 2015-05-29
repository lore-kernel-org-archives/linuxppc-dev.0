Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AC2B1A004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 11:01:35 +1000 (AEST)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0119.outbound.protection.outlook.com [65.55.169.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3B21E14012C
 for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2015 11:01:33 +1000 (AEST)
Date: Thu, 28 May 2015 19:46:57 -0500
From: Scott Wood <scottwood@freescale.com>
To: songwenbin <Wenbin.Song@freescale.com>
CC: <linuxppc-dev@ozlabs.org>, <Mingkai.hu@freescale.com>, York Sun
 <yorksun@freescale.com>
Subject: Re: [v2,1/2] powerpc/mpc8xxx: Change EDAC for FSL SoC
Message-ID: <20150529004657.GA8866@home.buserror.net>
References: <1430991698-29832-1-git-send-email-Wenbin.Song@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1430991698-29832-1-git-send-email-Wenbin.Song@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 07, 2015 at 05:41:37PM +0800, songwenbin wrote:
> From: York Sun <yorksun@freescale.com>
> 
> Remove mpc83xx and mpc85xx as dependency.
> 
> Signed-off-by: York Sun <yorksun@freescale.com>
> Signed-off-by: songwenbin <wenbin.song@freescale.com>
> ---
>  drivers/edac/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

These patches need to be sent to the EDAC list and maintainer.

> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index cb59619..ad07d4f 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -262,10 +262,10 @@ config EDAC_SBRIDGE
>  
>  config EDAC_MPC85XX
>  	tristate "Freescale MPC83xx / MPC85xx"
> -	depends on EDAC_MM_EDAC && FSL_SOC && (PPC_83xx || PPC_85xx)
> +	depends on EDAC_MM_EDAC && FSL_SOC
>  	help
>  	  Support for error detection and correction on the Freescale
> -	  MPC8349, MPC8560, MPC8540, MPC8548
> +	  MPC8349, MPC8560, MPC8540, MPC8548, T4240

Why T4240?  We're not really going to list every mpc85xx/QorIQ PPC chip
here, are we?

-Scott
