Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 19D042C011E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 02:38:17 +1000 (EST)
Date: Fri, 20 Sep 2013 17:36:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Russell King <rmk+kernel@arm.linux.org.uk>
Message-ID: <20130920163654.GN21013@sirena.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMm9m-0007ij-ER@rmk-PC.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NbUNL4d9A9kY58qh"
In-Reply-To: <E1VMm9m-0007ij-ER@rmk-PC.arm.linux.org.uk>
Subject: Re: [PATCH 28/51] DMA-API: sound: fix dma mask handling in a lot of
 drivers
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 Takashi Iwai <tiwai@suse.de>, linux-mmc@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jaroslav Kysela <perex@perex.cz>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 linux-ide@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 e1000-devel@lists.sourceforge.net, b43-dev@lists.infradead.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Timur Tabi <timur@tabi.org>,
 Kukjin Kim <kgene.kim@samsung.com>, dri-devel@lists.freedesktop.org,
 Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 Eric Miao <eric.y.miao@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-crypto@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
 linuxppc-dev@lists.ozlabs.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--NbUNL4d9A9kY58qh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2013 at 10:53:02PM +0100, Russell King wrote:
> This code sequence is unsafe in modules:
>=20
> static u64 mask =3D DMA_BIT_MASK(something);
> ...
> 	if (!dev->dma_mask)
> 		dev->dma_mask =3D &mask;

Acked-by: Mark Brown <broonie@linaro.org>

--NbUNL4d9A9kY58qh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSPHmjAAoJELSic+t+oim9WB4QAINsf282vDwWmQYHGXTeorHo
q0pJ/9bTwBrSE0KzOK9H6UvL7oxCgzMPOT8RiSjWcdEXX/FavpH1TCf+ETkaYyEA
NaPvO/uUV/99qWhM/PJQvtv4yxhIR7ENiZKywUuFnWQuc44yGUWBLK8ooA4xXtme
WMcWyy7SMMcP/+9eBd9aNe1FPYFirsqSrrCpWSR/fD+TWFKMB6HG+OZGNYRFMrRm
Xet5sWMGwzBiL453M0ujAEHKd/g4VOkweCydEq+2Rt2am6ph+SrMuoQvCDZ1bvbh
71nyYA+j2xNy8jb7AA9PukWoeXyAI0xRY8zh939Uvdxf4SPUIVgw9wJE5rMRGoT5
k4We/z2A4m1DGCtg1JQN86HAe7jv3YlGLoPOhsrOnOEV55VnXIz0Lm9x3HjTNfvG
LcJXBGeHmU3Jvj3JEpA57YDbOhpwx0klK7RS5v6BjIJrJUSwjATqt1WQVr528HDp
rXQpUqxUL3KObdlA5TYweR2I0KxWe47rw612XGqhRiI+equSdTDP770QsO1nXlsA
qCfn3Gh7t+hyB3yFZUquWEXwKVv0YMh3Ds/bR2RtZluSl3SzM9n/Dp45w6SMu1LN
oSpxUS7KNzTPXQp0kns7dDFnJJWXid7mUScjK4rc5pSyBF4NSEqJsmqHm0whd/qL
uR8J7AFq8DkXx3g+/4gf
=H53r
-----END PGP SIGNATURE-----

--NbUNL4d9A9kY58qh--
