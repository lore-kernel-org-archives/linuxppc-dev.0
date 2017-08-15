Return-Path: <peter.ujfalusi@ti.com>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWqbb6t97zDrJD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 21:13:31 +1000 (AEST)
Subject: Re: [PATCH 05/11] ASoC: omap: make snd_soc_platform_driver const
To: Bhumika Goyal <bhumirks@gmail.com>, <julia.lawall@lip6.fr>,
 <brian.austin@cirrus.com>, <Paul.Handrigan@cirrus.com>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <bardliao@realtek.com>, <chiou@realtek.com>,
 <timur@tabi.org>, <nicoleotsuka@gmail.com>, <Xiubo.Lee@gmail.com>,
 <fabio.estevam@nxp.com>, <yang.jie@linux.intel.com>,
 <jarkko.nikula@bitmer.com>, <daniel@zonque.org>,
 <haojian.zhuang@gmail.com>, <robert.jarzmik@free.fr>,
 <plai@codeaurora.org>, <bgoswami@codeaurora.org>, <krzk@kernel.org>,
 <sbkim73@samsung.com>, <s.nawrocki@samsung.com>,
 <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
 <1502710730-18912-6-git-send-email-bhumirks@gmail.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <9084e936-c239-0c37-7a54-0d4c9d3bbae6@ti.com>
Date: Tue, 15 Aug 2017 13:47:50 +0300
MIME-Version: 1.0
In-Reply-To: <1502710730-18912-6-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=EF=BB=BF

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 2017-08-14 14:38, Bhumika Goyal wrote:
> Make this const as it is only passed as the 2nd argument to the
> function devm_snd_soc_register_platform, which is of type const.
> Done using Coccinelle.
>=20
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  sound/soc/omap/omap-pcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index 94e9ff7..1283473 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -243,7 +243,7 @@ static int omap_pcm_new(struct snd_soc_pcm_runtime *r=
td)
>  	return ret;
>  }
> =20
> -static struct snd_soc_platform_driver omap_soc_platform =3D {
> +static const struct snd_soc_platform_driver omap_soc_platform =3D {
>  	.ops		=3D &omap_pcm_ops,
>  	.pcm_new	=3D omap_pcm_new,
>  	.pcm_free	=3D omap_pcm_free_dma_buffers,
>=20

- P=C3=A9ter
