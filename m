Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 252261A0019
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 04:23:59 +1000 (EST)
Date: Tue, 29 Jul 2014 19:23:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20140729182310.GY17528@sirena.org.uk>
References: <cover.1406628283.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pIgUhm2PSpi2KHBa"
In-Reply-To: <cover.1406628283.git.nicoleotsuka@gmail.com>
Subject: Re: [PATCH v6 0/2] Add Freescale ASRC driver
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, b42378@freescale.com, timur@tabi.org,
 pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de,
 linux-kernel@vger.kernel.org, rdunlap@infradead.org, b02247@freescale.com,
 lgirdwood@gmail.com, perex@perex.cz, varkabhadram@gmail.com,
 robh+dt@kernel.org, galak@codeaurora.org, grant.likely@linaro.org,
 tklauser@distanz.ch, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--pIgUhm2PSpi2KHBa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 29, 2014 at 06:08:51PM +0800, Nicolin Chen wrote:
> This series of patches add Freescale ASRC module driver support along
> with the extra request in imx-sdma structure required by SDMA Device
> to Device script.

Applied both, thanks.

--pIgUhm2PSpi2KHBa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1+aKAAoJELSic+t+oim9SaoP/1FVsjb2QpLsKVSx6LP5AVJY
DKmL2lH6q3YqSurOEBtoKAPw8738LJdWxGtRGqPEA+AMgP2QwXE35PIEyo3NFE0K
ifGX0KKRfmvvGqWGajnYThJ71Z/0AWdlHj13ZTBuyschGBNi02JmeAwbPFH9y/Ux
Wab6Ygul8yGR3pcYO86vSAvPB9vXubHbZJIeyHV68saOjqTcR6BAK1ZgC6tFzvz6
QRtjosyqFDK00gWnXxPr3iyP+nq31cZPX3+LABwm3UDo8palIeKy+fz0AKpVr5IK
iE85eb/YQFJG+a0UU6JY0sxaQ7BYtnGIFRcgaohlUDyWvgTSnFIdDWpobaFCO1KF
M6pxRAtS3FPFY/oGvK+rzt7+fRkyj0AKd1mJLryYa6tG5OlBqESCuqy4mUa9xTmp
fewpqjuZPGURNX95bBl6aYtwqwC++fZKV+iM5jl3y2Hu60pGtXWanO6N5VxQPEXa
Ayd2VTrCQc6hgc3vmLTeXH7xFFX25HlFcYADI9ZCvH70JpeNmcKJzJyezF+lC6Ew
Rwx4pIRFVhi/NKUnWc8MWriKDhz27k9urM8VCesnTjZ2AwQUmX//rXQlJBRTWqWn
easFnaFB+wXzI3p/X7V3sTXYFkyOyWaludbgIyvU18hIwC2boLA2KDBkxfFwizFT
RnngHEH/Pf2zFzmlRuJ0
=ExYX
-----END PGP SIGNATURE-----

--pIgUhm2PSpi2KHBa--
