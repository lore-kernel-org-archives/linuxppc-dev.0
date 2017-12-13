Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxs1R6NpmzDrvM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 09:34:03 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id m26so2170894pfj.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 14:34:03 -0800 (PST)
Date: Wed, 13 Dec 2017 14:33:57 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: Re: [PATCH v2 05/11] ASoC: fsl_ssi: Refine indentations and wrappings
Message-ID: <20171213223356.GA13576@Asurada-Nvidia>
References: <1513146874-25476-1-git-send-email-nicoleotsuka@gmail.com>
 <1513146874-25476-6-git-send-email-nicoleotsuka@gmail.com>
 <bf6f6d92-ae85-e61f-b027-95189c06916d@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bf6f6d92-ae85-e61f-b027-95189c06916d@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 13, 2017 at 11:30:31PM +0100, Maciej S. Szmigiero wrote:
> On 13.12.2017 07:34, Nicolin Chen wrote:
> > This patch just simply unifies the coding style.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> > 
> > Changelog
> > v1->v2
> >  * Added two missing indentation changes
> >  * Removed two extra blank lines.
> > 
> >  sound/soc/fsl/fsl_ssi.c     | 239 +++++++++++++++++++++-----------------------
> >  sound/soc/fsl/fsl_ssi.h     |   2 +-
> >  sound/soc/fsl/fsl_ssi_dbg.c |   3 +-
> >  3 files changed, 118 insertions(+), 126 deletions(-)
> > 
> > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> > index 8b5407d..9a3db08 100644
> > --- a/sound/soc/fsl/fsl_ssi.c
> > +++ b/sound/soc/fsl/fsl_ssi.c
> (..)
> > @@ -916,12 +917,11 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
> >  	case SND_SOC_DAIFMT_DSP_A:
> >  		/* Data on rising edge of bclk, frame high, 1clk before data */
> >  		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |
> > -			SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
> > +			 SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
> >  		break;
> >  	case SND_SOC_DAIFMT_DSP_B:
> >  		/* Data on rising edge of bclk, frame high */
> > -		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |
> > -			SSI_STCR_TXBIT0;
> > +		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |  SSI_STCR_TXBIT0;
> 
> It looks like an extra space got here			 ^.

Good catch.

Thanks
