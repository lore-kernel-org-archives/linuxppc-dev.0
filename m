Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0B2CDE017
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 12:45:19 +1000 (EST)
Message-Id: <889F831A-D38C-43E8-BADB-BE772F7A3ADF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
In-Reply-To: <1241790769-3843-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] mmc: Add fsl,esdhc as a valid compatible to bind against
Date: Wed, 13 May 2009 21:45:08 -0500
References: <1241790769-3843-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, pierre@ossman.eu, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 8, 2009, at 8:52 AM, Kumar Gala wrote:

> We plan to use fsl,esdhc going forward as the base compatible so  
> update
> the driver to bind against it.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> drivers/mmc/host/sdhci-of.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

Any feedback or possibility of picking this up.

- k

>
>
> diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
> index 3ff4ac3..09cc597 100644
> --- a/drivers/mmc/host/sdhci-of.c
> +++ b/drivers/mmc/host/sdhci-of.c
> @@ -277,6 +277,7 @@ static int __devexit sdhci_of_remove(struct  
> of_device *ofdev)
> static const struct of_device_id sdhci_of_match[] = {
> 	{ .compatible = "fsl,mpc8379-esdhc", .data = &sdhci_esdhc, },
> 	{ .compatible = "fsl,mpc8536-esdhc", .data = &sdhci_esdhc, },
> +	{ .compatible = "fsl,esdhc", .data = &sdhci_esdhc, },
> 	{ .compatible = "generic-sdhci", },
> 	{},
> };
> -- 
> 1.6.0.6
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
