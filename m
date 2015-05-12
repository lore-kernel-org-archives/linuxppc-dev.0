Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CB991A0260
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 04:44:39 +1000 (AEST)
Date: Tue, 12 May 2015 19:44:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Zidan Wang <zidan.wang@freescale.com>
Message-ID: <20150512184426.GQ3066@sirena.org.uk>
References: <cover.1431337606.git.zidan.wang@freescale.com>
 <1431339894-4248-1-git-send-email-zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vIXBmblrD40XNCy4"
In-Reply-To: <1431339894-4248-1-git-send-email-zidan.wang@freescale.com>
Subject: Re: [PATCH 1/3] ASoC: fsl_sai: add sai master mode support
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com,
 tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 perex@perex.cz, nicoleotsuka@gmail.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vIXBmblrD40XNCy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2015 at 06:24:41PM +0800, Zidan Wang wrote:
> When sai works on master mode, set its bit clock and frame clock.
>=20
> SAI has 4 MCLK source, bus clock, MCLK1, MCLK2 and MCLK3. fsl_sai_set_bclk
> will select proper MCLK source, then calculate and set the bit clock divi=
der.

Applied, thanks.

--vIXBmblrD40XNCy4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUkoJAAoJECTWi3JdVIfQSTsH/1ZgL0iXjDVdC1pXGJxbjvPC
Qokgb8JoHr/G9YXh/Ff0ai8dEMsmF7OEIosGJ3D9oNamJ6y1xYL2MyKesFJhyc7T
4+kOWw8JIX7IxDMcJ4E515EkqX+jCHXc05rZfqTu35iQ2icfydwLLuIm/62b0LbA
O22bE21U6V9DAzavVTVqncKdaJ4bNIozvjkQRjqHM/aUwHFWnIsk/zH8wKDvCp1a
7hlCajIIN/z0EkB0hjI7p16XBtfS+iFpb3FIs/eK7Ndsw8nhz/zdknwYS5d54YdC
mO3FZRvSIwhtSgzDl/FqC1oxWfigFW3VMdzz4DiGhFDJpQ3Fn5aExCzC9A2TgVw=
=Qg2i
-----END PGP SIGNATURE-----

--vIXBmblrD40XNCy4--
