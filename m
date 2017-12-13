Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxrxX3ysKzDsFl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 09:30:40 +1100 (AEDT)
Subject: Re: [PATCH v2 05/11] ASoC: fsl_ssi: Refine indentations and wrappings
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1513146874-25476-1-git-send-email-nicoleotsuka@gmail.com>
 <1513146874-25476-6-git-send-email-nicoleotsuka@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <bf6f6d92-ae85-e61f-b027-95189c06916d@maciej.szmigiero.name>
Date: Wed, 13 Dec 2017 23:30:31 +0100
MIME-Version: 1.0
In-Reply-To: <1513146874-25476-6-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13.12.2017 07:34, Nicolin Chen wrote:
> This patch just simply unifies the coding style.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> 
> Changelog
> v1->v2
>  * Added two missing indentation changes
>  * Removed two extra blank lines.
> 
>  sound/soc/fsl/fsl_ssi.c     | 239 +++++++++++++++++++++-----------------------
>  sound/soc/fsl/fsl_ssi.h     |   2 +-
>  sound/soc/fsl/fsl_ssi_dbg.c |   3 +-
>  3 files changed, 118 insertions(+), 126 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 8b5407d..9a3db08 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
(..)
> @@ -916,12 +917,11 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
>  	case SND_SOC_DAIFMT_DSP_A:
>  		/* Data on rising edge of bclk, frame high, 1clk before data */
>  		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |
> -			SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
> +			 SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
>  		break;
>  	case SND_SOC_DAIFMT_DSP_B:
>  		/* Data on rising edge of bclk, frame high */
> -		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |
> -			SSI_STCR_TXBIT0;
> +		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |  SSI_STCR_TXBIT0;

It looks like an extra space got here			 ^.

Maciej
