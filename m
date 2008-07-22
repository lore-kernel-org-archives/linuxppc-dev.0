Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.224])
	by ozlabs.org (Postfix) with ESMTP id 3169DDE0A4
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 07:26:11 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id c8so2348835qbc.39
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:26:10 -0700 (PDT)
Date: Tue, 22 Jul 2008 17:25:37 -0400
From: Grant Likely <grant.likely@secretlab.ca>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: Export DAI and codec for TLV320AIC26
Message-ID: <20080722212537.GE12412@secretlab.ca>
References: <20080722115205.GA12555@sirena.org.uk>
	<1216727589-19544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1216727589-19544-2-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1216727589-19544-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Tue, Jul 22, 2008 at 12:53:08PM +0100, Mark Brown wrote:
> This fixes sparse warnings and allows non-OpenFirmware systems to attempt
> to bind to the device.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  sound/soc/codecs/tlv320aic26.c |    1 +
>  sound/soc/codecs/tlv320aic26.h |    3 +++
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
> index 4621fda..73b7027 100644
> --- a/sound/soc/codecs/tlv320aic26.c
> +++ b/sound/soc/codecs/tlv320aic26.c
> @@ -383,6 +383,7 @@ struct snd_soc_codec_device aic26_soc_codec_dev = {
>  	.probe = aic26_probe,
>  	.remove = aic26_remove,
>  };
> +EXPORT_SYMBOL_GPL(aic26_soc_codec_dev);
>  
>  /* ---------------------------------------------------------------------
>   * SPI device portion of driver: sysfs files for debugging
> diff --git a/sound/soc/codecs/tlv320aic26.h b/sound/soc/codecs/tlv320aic26.h
> index 62b1f22..786ba16 100644
> --- a/sound/soc/codecs/tlv320aic26.h
> +++ b/sound/soc/codecs/tlv320aic26.h
> @@ -90,4 +90,7 @@ enum aic26_wlen {
>  	AIC26_WLEN_32	= 3 << 10,
>  };
>  
> +extern struct snd_soc_dai aic26_dai;
> +extern struct snd_soc_codec_device aic26_soc_codec_dev;
> +
>  #endif /* _TLV320AIC16_H_ */
> -- 
> 1.5.6.3
> 
