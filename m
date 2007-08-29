Return-Path: <dgibson@ozlabs.org>
Date: Wed, 29 Aug 2007 15:55:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 6/9] mpc82xx: Rename mpc82xx_ads to mpc8272_ads.
Message-ID: <20070829055512.GE3206@localhost.localdomain>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201926.GF24329@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828201926.GF24329@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 28, 2007 at 03:19:26PM -0500, Scott Wood wrote:
> This is just a rename patch; internal references to mpc82xx_ads will be
> changed in the next one.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/platforms/82xx/Kconfig                |    8 ++++----
>  arch/powerpc/platforms/82xx/Makefile               |    2 +-
>  .../82xx/{mpc82xx_ads.c => mpc8272_ads.c}          |    0 
>  3 files changed, 5 insertions(+), 5 deletions(-)
>  rename arch/powerpc/platforms/82xx/{mpc82xx_ads.c => mpc8272_ads.c} (100%)
> 
> diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
> index 89fde43..f260c01 100644
> --- a/arch/powerpc/platforms/82xx/Kconfig
> +++ b/arch/powerpc/platforms/82xx/Kconfig
> @@ -1,17 +1,17 @@
>  choice
>  	prompt "82xx Board Type"
>  	depends on PPC_82xx
> -	default MPC82xx_ADS
> +	default MPC8272_ADS

Not actually relevant to this patch, but we should be getting rid of
all these 'choice' things for board selection and instead allowing
each board to be separately enabled or disabled.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
