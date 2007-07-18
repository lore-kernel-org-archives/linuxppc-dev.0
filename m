Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE3DADDF04
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 15:09:09 +1000 (EST)
In-Reply-To: <20070718013527.GT15238@ld0162-tx32.am.freescale.net>
References: <20070718013527.GT15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E50327CF-2C25-44F2-A840-54BC66B89F0D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 22/61] Rename mpc82xx_ads to mpc8272ads.
Date: Wed, 18 Jul 2007 00:09:37 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2007, at 8:35 PM, Scott Wood wrote:

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/platforms/82xx/Kconfig       |    6 +-
>  arch/powerpc/platforms/82xx/Makefile      |    2 +-
>  arch/powerpc/platforms/82xx/mpc8272ads.c  |  640 ++++++++++++++++++ 
> +++++++++++

can we use mpc8272_ads.c to follow the naming we have elsewhere in  
other 8xxx land.

>  arch/powerpc/platforms/82xx/mpc82xx_ads.c |  640  
> -----------------------------
>  4 files changed, 644 insertions(+), 644 deletions(-)
>  create mode 100644 arch/powerpc/platforms/82xx/mpc8272ads.c
>  delete mode 100644 arch/powerpc/platforms/82xx/mpc82xx_ads.c
>
> diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/ 
> platforms/82xx/Kconfig
> index 89fde43..b4af8c2 100644
> --- a/arch/powerpc/platforms/82xx/Kconfig
> +++ b/arch/powerpc/platforms/82xx/Kconfig
> @@ -1,10 +1,10 @@
>  choice
>  	prompt "82xx Board Type"
>  	depends on PPC_82xx
> -	default MPC82xx_ADS
> +	default MPC8272ADS
>
> -config MPC82xx_ADS
> -	bool "Freescale MPC82xx ADS"
> +config MPC8272ADS
> +	bool "Freescale MPC8272ADS"
>  	select DEFAULT_UIMAGE
>  	select PQ2ADS
>  	select 8272

Similar comments about using underscore in Kconfig vars.

[snip].

- k
