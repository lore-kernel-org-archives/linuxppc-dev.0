Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 47FE52C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 22:18:19 +1000 (EST)
Date: Thu, 29 Aug 2013 13:18:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Message-ID: <20130829121805.GZ10783@sirena.org.uk>
References: <CAPgLHd8kBPX2RjLJ3FeXSFpiZjvGyaUM4nmoU0wEVMM7zjfWBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ucH0Tl3ykwO2QBzm"
In-Reply-To: <CAPgLHd8kBPX2RjLJ3FeXSFpiZjvGyaUM4nmoU0wEVMM7zjfWBA@mail.gmail.com>
Subject: Re: [PATCH -next] ASoC: fsl_spdif: remove redundant dev_err call in
 fsl_spdif_probe()
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, tiwai@suse.de, timur@tabi.org, rob.herring@calxeda.com,
 perex@perex.cz, yongjun_wei@trendmicro.com.cn, grant.likely@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ucH0Tl3ykwO2QBzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2013 at 08:00:05AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.

Applied, thanks.

--ucH0Tl3ykwO2QBzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSHzv6AAoJELSic+t+oim9Hv0QAIVfYLr73m858p7s0zfwD1Jr
ZqBZkIeCJVWr6Z4oZszdbjU0Dmi8Ycq6GiCdODGwZpslKE5j4aS9KA/JsLIysrCr
dB3XX+JXB7Fp1G5EaTU6NdLK9oj3ztQK0kvJSV3WjvOGtJ71TW8239OcmsrZm21Z
Dfy629bXNyXXtbdLqcnRQDu31Kp3Date1yQkOiHXs2daUNuHQ8Ub91Hy3sy+L5l8
vLXfnoPS7RPsqdlhVqz3F6gCM4r9Wukn7f10px838tphVzO1gfwJs7AHspY87u6Q
y0Yw/chlrW1BmXy5r6SUAHpOy5YTD9onjX7vzvTvoRanz6BETASrxfloCX42CIQT
1xA2AxOECuYrQY2Xefbmz+/fd4CjT2cfgCA+rQyXScYjSN+xB5pZ/piIwqYy5nJ+
uKTfezqEq/KluMmb4Zi/DdSYh2OB3LRaOoojF+z+NGF39sT4/cqa/g8siq1mOmaR
oO4brBjJZRtGF61OWgC+oGr4NWm1ZXALa9kjy/0HrYx0S3wlSxLNodH/YFccLjOD
mEnlH3ULP2jPPpNxjTnGy85fdROlYV+GwiL3syMiyJ2JpBnAuvSIklOp9U+htMhC
EfwOREWBD97wY0OAbGKF5HTmljb9ozW2GWRIG7xKFUUtut66RUlw7FOj67VI51xF
F7Dab4cTavfC3Je0tAuY
=rANq
-----END PGP SIGNATURE-----

--ucH0Tl3ykwO2QBzm--
