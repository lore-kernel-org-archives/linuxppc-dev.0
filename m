Return-Path: <mpa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E75D1A088D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 15:44:28 +1000 (AEST)
Date: Fri, 31 Jul 2015 07:27:19 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 3/6] ASoC: fsl_ssi: enable AC'97 asymmetric rates
Message-ID: <20150731052719.GU30895@pengutronix.de>
References: <55BA35EB.6020901@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fqIB0bRxfTYxTb/F"
In-Reply-To: <55BA35EB.6020901@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--fqIB0bRxfTYxTb/F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 30, 2015 at 04:34:19PM +0200, Maciej S. Szmigiero wrote:
> AC'97 bus can support asymmetric playback/capture rates
> so enable them in this case in fsl_ssi driver.
>=20
> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
> ---
>  sound/soc/fsl/fsl_ssi.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index a83b900..7f4f0b9 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1377,7 +1377,9 @@ static int fsl_ssi_probe(struct platform_device *pd=
ev)
> =20
>  	/* Are the RX and the TX clocks locked? */
>  	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
> -		ssi_private->cpu_dai_drv.symmetric_rates =3D 1;
> +		if (!fsl_ssi_is_ac97(ssi_private))
> +			ssi_private->cpu_dai_drv.symmetric_rates =3D 1;
> +

Why don't you use the DT property that is parsed here to enable
asymmetric rates?

Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--fqIB0bRxfTYxTb/F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVuwc3AAoJEEpcgKtcEGQQA6IQAJmlRbcHijl03wnE6FmU4ilG
36Gy0rwdz2wRLzrn8DK4JaZBIS9S8nuC/TPrA79B7YMbJmYphv9dJbN3PaFUINp6
vaBGKsRpOlp6kJ+WebQdRgdVqlbzAgkFQVDaAaQYTjrOM4QQ0x/dQqiKlrjHADYj
wS9fdt6iB1cGG3udprPi8YF+xBjwwVzi/tD5MkwEQPD+x9k8YfmYjD7glJg9DobT
4ze1jNlKJNkkddmEjJXlaquB5shxQlqXYTZeG6/7LSvCaEd/IZbJJPuznxirgBoD
9gTjfF+Q8kQzxg9KSfyR1Q106AmN7sr3p3cyHR3bi5jboPVuIOgQAKviHFI17iY6
DF7rE8+Yf88dW181E3ORXgDMeowbrvlQU2de+785n81mAHTOQeYKFZiiEVow2qa0
El/JMDk4KQAvUcDqWTR5ZHXCDPYw6nzHbo8zdZVdYuJRijQG7k9O5OCSc5HkR9ic
xfCxYZMJ/5Us9O9dGmsQUCOZKADC0XoGDX3SCaJvd+GI5en5b/4lLN2P/wr+Lc3Q
/nOCnF/ie2OcoI9pL1tmEkuFura2OOw5JW9dOG1Lk8AfBo5oW8gRLAOca7w3mIM9
r7apLaxI95B1NoS2gwjgjiLyCVGC1sUiypI6lbYQQ5XCgegBMCRTtsji1gAuCVn0
3FxaiQzoXhkcMKMaNYpA
=5Uxs
-----END PGP SIGNATURE-----

--fqIB0bRxfTYxTb/F--
