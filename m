Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D7AF1A0E02
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 03:33:37 +1000 (AEST)
Date: Wed, 10 Jun 2015 18:33:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Message-ID: <20150610173322.GN14071@sirena.org.uk>
References: <20150610153723.GB10549@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6PH4sE4TNvTKzKhJ"
In-Reply-To: <20150610153723.GB10549@mwanda>
Subject: Re: [patch] ASoC: fsl: add an error check
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--6PH4sE4TNvTKzKhJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2015 at 06:37:23PM +0300, Dan Carpenter wrote:
> My static checker complains that:
>=20
> 	sound/soc/fsl/imx-wm8962.c:196 imx_wm8962_probe() warn:
> 	we tested 'ret' before and it was 'false'

Applied, thanks.

--6PH4sE4TNvTKzKhJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVeHThAAoJECTWi3JdVIfQSaUH/1tsyvDV53+1YCX/srzK2hrX
iACRMxDjE/SUz/lPGaEkhGWT3a7Y40szgW6h2HnNVX9/RksSAHuTQeFHzvCgVgS2
Scfdl6uNkzuwGTqTqV5j4wlE5ir966+D5uI0L5mhSjrnyEeIbPPT61PSY1O3OXIQ
4g0Vac4AcCkWGGCdPlHBtrfsZO9KuIn1seR03hut1MmBrKiPfAr+f/crOCND+Sm6
yQH9I1WSSpWPFlIlaVtL8TKt3ZSP5F73ReUc9PojIc4B2mif/4hM8gHkj2nXeRKH
g6VpN2kwpUqI1VvCdJWxfNZlCk8HhYMzN1i0B3XZtB/wwhREkkZMyZeK6pIEcSI=
=wzMN
-----END PGP SIGNATURE-----

--6PH4sE4TNvTKzKhJ--
