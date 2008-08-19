Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEAE0DE0FD
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 16:15:14 +1000 (EST)
Message-ID: <3ef3fed769e5aa57681bacea1230e82b.squirrel@secure.sipsolutions.net>
In-Reply-To: <48AA407C.8090409@gmail.com> 
References: <48AA407C.8090409@gmail.com>
Date: Tue, 19 Aug 2008 08:15:05 +0200 (CEST)
Subject: Re: [PATCH] duplicate SNDRV_PCM_FMTBIT_S{16,24}_BE
From: "Johannes Berg" <johannes@sipsolutions.net>
To: "roel kluin" <roel.kluin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

roel kluin wrote:
> untested, is it correct?

not a clue, do you know how long ago that was? :)
does the driver check endianness anywhere?

> duplicate SNDRV_PCM_FMTBIT_S{16,24}_BE
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/sound/aoa/codecs/snd-aoa-codec-tas.c
> b/sound/aoa/codecs/snd-aoa-codec-tas.c
> index 7a16a33..c922505 100644
> --- a/sound/aoa/codecs/snd-aoa-codec-tas.c
> +++ b/sound/aoa/codecs/snd-aoa-codec-tas.c
> @@ -654,15 +654,15 @@ static struct snd_kcontrol_new bass_control = {
>  static struct transfer_info tas_transfers[] = {
>  	{
>  		/* input */
> -		.formats = SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S16_BE |
> -			   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S24_BE,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
> +			   SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE,
>  		.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
> SNDRV_PCM_RATE_48000,
>  		.transfer_in = 1,
>  	},
>  	{
>  		/* output */
> -		.formats = SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S16_BE |
> -			   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S24_BE,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
> +			   SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE,
>  		.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
> SNDRV_PCM_RATE_48000,
>  		.transfer_in = 0,
>  	},
>
>
