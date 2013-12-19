Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1C37D2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 21:48:11 +1100 (EST)
Date: Thu, 19 Dec 2013 10:48:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20131219104804.GT31886@sirena.org.uk>
References: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QCC2I/2CckNfI+Tr"
In-Reply-To: <1386845085-21682-1-git-send-email-Guangyu.Chen@freescale.com>
Subject: Re: [RFC][PATCH v1] ASoC: fsl_ssi: Add DAI master mode support for
 SSI on i.MX series
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 timur@tabi.org, perex@perex.cz, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--QCC2I/2CckNfI+Tr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2013 at 06:44:45PM +0800, Nicolin Chen wrote:
> From: Nicolin Chen <b42378@freescale.com>
>=20
> This patch adds three main functions for DAI master mode: set_dai_fmt(),
> set_dai_sysclk() and set_dai_tdm_slot(), and one essential baud clock
> accordingly. After appending this patch, the fsl_ssi driver on i.MX series
> has the ability to derive LRCLK and BCLK from baud clock source so as to
> support some audio Codecs which can only be used in slave mode.

Applied, thanks.

--QCC2I/2CckNfI+Tr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSss7hAAoJELSic+t+oim9EeYP/RDpWeDZFHzVsCBe66KpRKlH
I8HCnRChRZz6dI10EheWrIEiYXWWZ9UkRsXXx6DphN+K5OniRU2ozogDZdewvaBj
Y1eZk8Ho09gufRz7mWQNA+JLA6PfZ5nUWLQpIYYnv9kVDyQJ3EhGCK/izg+jVc+y
uKVg6Lvz6DTPsWuHqNl6/Dc75y87XuAVjYiYH56X/louGm4Y//4BfFbUNqO8UxVT
kJeUaOV2um/wiDfnuOjB3ojSiNq1AJXNWk9tl8/Jh0khXCIAj/6Zv7qeIZh9jaQI
fZf1MVVSqWKnkAJKQhxVWLzy/GH7Abi+SHeSWMXcO9jhKdqqjt+kSis2QEFlayzV
xuEyhLdtY3RWcyoZta4c+dySZY8IH0ahRDsbdByEcSLH1adP0vSu0/Th+Ynq7gAW
YtK2VRoQI1z02CGP3JAWmW8hCDTOECUwMs/6TtmrcYMnrrajY8eF0kHv0ju7A3Ze
1w0EfFOV67lTJEpWe/ruWfcbTFq+n3flvYO6TlgZA4tuS9PsYrPKJiN2YMui7+NH
vfHjH0x8PcrT1P+UWKL+g621lhalxKvUTR/dyONRFG6seNGkHVrtKr61T27jSMXo
Vmhvo4nxc1bubV0bsE7C3GRWdffa8dPPdgWBRsciJCqDEmK2R1vv0Xr4Ctt5xlVx
6G520tJq91ENcWquOG/t
=+6lW
-----END PGP SIGNATURE-----

--QCC2I/2CckNfI+Tr--
