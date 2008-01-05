Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2949DDE3B
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 21:20:05 +1100 (EST)
Subject: Re: [PATCH] ibm_newemac: Increase number of default rx-/tx-buffers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1199526609-12290-1-git-send-email-sr@denx.de>
References: <1199526609-12290-1-git-send-email-sr@denx.de>
Content-Type: text/plain
Date: Sat, 05 Jan 2008 21:19:48 +1100
Message-Id: <1199528388.7291.55.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-01-05 at 10:50 +0100, Stefan Roese wrote:
> Performance tests done by AMCC have shown that 256 buffer increase the
> performance of the Linux EMAC driver. So let's update the default
> values to match this setup.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---

Do we have the numbers ? Did they also measure latency ?

Ben.

>  drivers/net/ibm_newemac/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ibm_newemac/Kconfig b/drivers/net/ibm_newemac/Kconfig
> index 0d3e738..5a06727 100644
> --- a/drivers/net/ibm_newemac/Kconfig
> +++ b/drivers/net/ibm_newemac/Kconfig
> @@ -9,12 +9,12 @@ config IBM_NEW_EMAC
>  config IBM_NEW_EMAC_RXB
>  	int "Number of receive buffers"
>  	depends on IBM_NEW_EMAC
> -	default "128"
> +	default "256"
>  
>  config IBM_NEW_EMAC_TXB
>  	int "Number of transmit buffers"
>  	depends on IBM_NEW_EMAC
> -	default "64"
> +	default "256"
>  
>  config IBM_NEW_EMAC_POLL_WEIGHT
>  	int "MAL NAPI polling weight"
