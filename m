Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21CA61A0D07
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 02:51:41 +1000 (AEST)
Date: Fri, 1 May 2015 17:51:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Message-ID: <20150501165127.GN22845@sirena.org.uk>
References: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430496014-32309-2-git-send-email-k.kozlowski.k@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OBDwML3JH6o7XXm2"
In-Reply-To: <1430496014-32309-2-git-send-email-k.kozlowski.k@gmail.com>
Subject: Re: [PATCH 2/4] ASoC: bt-sco: Constify platform_device_id
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>,
 linux-kernel@vger.kernel.org, Timur Tabi <timur@tabi.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Sangbeom Kim <sbkim73@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--OBDwML3JH6o7XXm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 02, 2015 at 01:00:12AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.

Applied, thanks.

--OBDwML3JH6o7XXm2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ68OAAoJECTWi3JdVIfQ350H/R/KcV0w1F4SgQPDeQAUCiuU
fgrhKJznJL3PH+i8AP3/KsjvhuHMnltuwzSNrzFnIuaBgKM/IqDJeuDSUT9Lu+xA
r4CMDVH0SYLdVn0nPBPh9OoNtsrg7kRlw5xwtiOmyru7/ZpNCwsDkodpU0ivOeA5
wY+78WTTgZAkKC8lYMVccKwTQQCdcUY5+ezAHkgaCx/nkp5+eAAyZ2BW0mNvN5xE
aJ75N3Pi3IZlXEdsfKhFBDxH2wGp9dMGUQUHOWdGd33tFXhsG5sLOEiKqfmH3pno
5tdcgC7fZYBDoz/kJpFIi5JOnxY4Bdw26FV5wqKWxK5Mml2Af3NYGG85GmFNgSg=
=2pRh
-----END PGP SIGNATURE-----

--OBDwML3JH6o7XXm2--
