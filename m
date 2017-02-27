Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vX9YQ6ByjzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 05:42:18 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 1so1847276pgz.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 10:42:18 -0800 (PST)
Date: Mon, 27 Feb 2017 10:42:33 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Alin Grigorean <alin.grig93@gmail.com>
Cc: timur@tabi.org, Xiubo.Lee@gmail.com, perex@perex.cz, tiwai@suse.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com,
 lgirdwood@gmail.com, broonie@kernel.org
Subject: Re: [PATCH] ASoC: fsl: Remove unneeded init of static variable
Message-ID: <20170227184233.GA22071@Asurada-Nvidia>
References: <20170225104726.15936-1-alin.grig93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170225104726.15936-1-alin.grig93@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 25, 2017 at 12:47:26PM +0200, Alin Grigorean wrote:
> This was reported by checkpatch.pl
> 
> Signed-off-by: Alin Grigorean <alin.grig93@gmail.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/imx-pcm-fiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
> index dac6688540dc..92410f7ca1fa 100644
> --- a/sound/soc/fsl/imx-pcm-fiq.c
> +++ b/sound/soc/fsl/imx-pcm-fiq.c
> @@ -282,7 +282,7 @@ static int imx_pcm_new(struct snd_soc_pcm_runtime *rtd)
>  	return 0;
>  }
>  
> -static int ssi_irq = 0;
> +static int ssi_irq;
>  
>  static int imx_pcm_fiq_new(struct snd_soc_pcm_runtime *rtd)
>  {
> -- 
> 2.11.1
> 
