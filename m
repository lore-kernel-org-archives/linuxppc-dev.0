Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AD56F2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 05:30:16 +1000 (EST)
Date: Wed, 24 Jul 2013 14:30:07 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v5 3/4] DMA: Freescale: update driver to support
 8-channel DMA engine
To: <hongbo.zhang@freescale.com>
References: <1374646870-5162-1-git-send-email-hongbo.zhang@freescale.com>
 <1374646870-5162-4-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1374646870-5162-4-git-send-email-hongbo.zhang@freescale.com>
 (from hongbo.zhang@freescale.com on Wed Jul 24 01:21:08 2013)
Message-ID: <1374694207.15592.62@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: devicetree@vger.kernel.org, vinod.koul@intel.com,
 linux-kernel@vger.kernel.org, Hongbo Zhang <hongbo.zhang@freescale.com>,
 djbw@fb.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2013 01:21:08 AM, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>=20
> This patch adds support to 8-channel DMA engine, thus the driver =20
> works for both
> the new 8-channel and the legacy 4-channel DMA engines.
>=20
> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
> ---
>  drivers/dma/Kconfig  |    9 +++++----
>  drivers/dma/fsldma.c |    9 ++++++---
>  drivers/dma/fsldma.h |    2 +-
>  3 files changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 6825957..1b78272 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -89,14 +89,15 @@ config AT_HDMAC
>  	  Support the Atmel AHB DMA controller.
>=20
>  config FSL_DMA
> -	tristate "Freescale Elo and Elo Plus DMA support"
> +	tristate "Freescale Elo series DMA support"
>  	depends on FSL_SOC
>  	select DMA_ENGINE
>  	select ASYNC_TX_ENABLE_CHANNEL_SWITCH
>  	---help---
> -	  Enable support for the Freescale Elo and Elo Plus DMA =20
> controllers.
> -	  The Elo is the DMA controller on some 82xx and 83xx parts, =20
> and the
> -	  Elo Plus is the DMA controller on 85xx and 86xx parts.
> +	  Enable support for the Freescale Elo series DMA controllers.
> +	  The Elo is the DMA controller on some mpc82xx and mpc83xx =20
> parts, the
> +	  EloPlus is on mpc85xx and mpc86xx and Pxxx parts, and the =20
> Elo3 is on
> +	  some Txxx and Bxxx parts. Look up user manuals for details =20
> anyway.

The user manuals do not use the "elo" terminology.  I also don't =20
understand the tone you're trying to convey with "anyway".

-Scott=
