Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x234.google.com (mail-pd0-x234.google.com
 [IPv6:2607:f8b0:400e:c02::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC7E21A044C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2015 16:41:45 +1000 (AEST)
Received: by pdbqa5 with SMTP id qa5so48689771pdb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2015 23:41:42 -0700 (PDT)
Date: Sat, 23 May 2015 23:41:31 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Timur Tabi <timur@tabi.org>, Takashi Iwai <tiwai@suse.de>,
 Jiri Kosina <trivial@kernel.org>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH trivial] ASoC: fsl_esai: Spelling
 s/specifially/specifically/
Message-ID: <20150524064130.GA2144@Asurada>
References: <1432209738-20877-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432209738-20877-1-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 21, 2015 at 02:02:18PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>


Thank you

> ---
>  sound/soc/fsl/fsl_esai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 5c7597191e3ffc68..45eee131c47d43cd 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -517,7 +517,7 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
>  	u32 bclk, mask, val;
>  	int ret;
>  
> -	/* Override slot_width if being specifially set */
> +	/* Override slot_width if being specifically set */
>  	if (esai_priv->slot_width)
>  		slot_width = esai_priv->slot_width;
>  
> -- 
> 1.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
