Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd9b36bBBzDr8x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 06:01:51 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id a84so34548pfl.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 11:01:51 -0800 (PST)
Date: Thu, 16 Nov 2017 11:01:59 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: fsl_asrc: Fix line continuation format
Message-ID: <20171116190158.GA11301@Asurada-Nvidia>
References: <cover.1510849466.git.joe@perches.com>
 <370a4a8e3963eb4dc4c4e13defda5170eee72753.1510849466.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <370a4a8e3963eb4dc4c4e13defda5170eee72753.1510849466.git.joe@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 16, 2017 at 08:25:46AM -0800, Joe Perches wrote:
> Line continuations with excess spacing causes unexpected output
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_asrc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 806d39927318..ed683fe8b94a 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -288,8 +288,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  
>  	if ((outrate > 8000 && outrate < 30000) &&
>  	    (outrate/inrate > 24 || inrate/outrate > 8)) {
> -		pair_err("exceed supported ratio range [1/24, 8] for \
> -				inrate/outrate: %d/%d\n", inrate, outrate);
> +		pair_err("exceed supported ratio range [1/24, 8] for inrate/outrate: %d/%d\n",
> +			 inrate, outrate);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.15.0
> 
