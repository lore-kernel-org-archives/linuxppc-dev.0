Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419DF1A01DA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 22:16:24 +1000 (AEST)
Date: Wed, 13 May 2015 12:43:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Zidan Wang <zidan.wang@freescale.com>
Message-ID: <20150513114321.GK3066@sirena.org.uk>
References: <e6293a2408ccd8390fa2999df2af26b6de20f933.1431500729.git.zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ljn2+zwPkKedfiv/"
In-Reply-To: <e6293a2408ccd8390fa2999df2af26b6de20f933.1431500729.git.zidan.wang@freescale.com>
Subject: Re: [alsa-devel][PATCH v2 1/3] ASoC: fsl_sai: add sai master mode
 support
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


--ljn2+zwPkKedfiv/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 03:12:59PM +0800, Zidan Wang wrote:
> When sai works on master mode, set its bit clock and frame clock.
>=20
> SAI has 4 MCLK source, bus clock, MCLK1, MCLK2 and MCLK3. fsl_sai_set_bclk
> will select proper MCLK source, then calculate and set the bit clock divi=
der.

This looks like a patch I've already applied?  If there are any changes
needed please send incremental fixes.

--ljn2+zwPkKedfiv/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUzjYAAoJECTWi3JdVIfQO+oH/i54BuaZgM2RreWpI3PTmABP
b9YBqj/V1AZIgEXjJltESwjIAK8VQhoV7+X+UzuIAQomLr1b3PWDQlwbutNTWtCC
JYM596ewKG8clk4W2C0UjfnT3lMBwuRRuGsOJ/yzilOZZYov2Gx+qEK6TdNLbn1L
BTVt29gGbGN6avYB5J3D6bCsz8gVAZpYPBbw9Q7Mux8IjzAGPjdIWxcQu4omE4hF
KF45V397gqe0AwHmVsqkKCANYsbRgwk6mGR6yrDjaSIqvg4FSv8aEV1rotvEGFCF
AGZB8SOszZza1Al4ThMxwhIZw9DfHf1H8xOXlL2dHGOM0lfAsyEULwebFjtkUTk=
=BZ2a
-----END PGP SIGNATURE-----

--ljn2+zwPkKedfiv/--
