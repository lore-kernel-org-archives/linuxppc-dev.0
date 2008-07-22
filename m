Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.224])
	by ozlabs.org (Postfix) with ESMTP id CE091DEFF2
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 07:26:31 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id c8so2348835qbc.39
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:26:31 -0700 (PDT)
Date: Tue, 22 Jul 2008 17:26:06 -0400
From: Grant Likely <grant.likely@secretlab.ca>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: Staticise keyclick dev_attr in tlv320aic26
Message-ID: <20080722212605.GF12412@secretlab.ca>
References: <20080722115205.GA12555@sirena.org.uk>
	<1216727589-19544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1216727589-19544-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1216727589-19544-3-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1216727589-19544-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: alsa-project.org@rakim.wolfsonmicro.main, linuxppc-dev@ozlabs.org,
	timur@freescale.com, liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 22, 2008 at 12:53:09PM +0100, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  sound/soc/codecs/tlv320aic26.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
> index 73b7027..bed8a9e 100644
> --- a/sound/soc/codecs/tlv320aic26.c
> +++ b/sound/soc/codecs/tlv320aic26.c
> @@ -418,7 +418,7 @@ static ssize_t aic26_keyclick_set(struct device *dev,
>  	return count;
>  }
>  
> -DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
> +static DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
>  
>  /* ---------------------------------------------------------------------
>   * SPI device portion of driver: probe and release routines and SPI
> -- 
> 1.5.6.3
> 
