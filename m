Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9063E1A028F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Aug 2014 05:23:11 +1000 (EST)
Date: Thu, 31 Jul 2014 20:22:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20140731192252.GK17528@sirena.org.uk>
References: <1406779660-17177-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wmr0DEQJrDWlOkHc"
In-Reply-To: <1406779660-17177-1-git-send-email-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: Fix sparse warnings in FSL_ASRC_FORMATS
 due to typo
Cc: alsa-devel@alsa-project.org, b42378@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--wmr0DEQJrDWlOkHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2014 at 12:07:40PM +0800, Nicolin Chen wrote:
> reproduce: make C=3D1 CF=3D-D__CHECK_ENDIAN__
>=20
> sparse warnings: (new ones prefixed by >>)

Applied, thanks.

--wmr0DEQJrDWlOkHc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2peJAAoJELSic+t+oim9Eo0P/2lb/ft50+xFazaCOlmRJadz
d3CTZca7JdwILR4sEDDZR6rXgFnuIfagIILcXyAfmI/97K01NkNjf41Jgi7ap1BJ
3Fa1kisQHR0geq0Vt/NUVb0MwYVREm7hoyG2r8j5AThQSg1hv9S0ETTkdI6aVlO3
U27j2ycLqXIAF0rzLA0D3JSLfdETao07JWGi/Od/JnfbKGvBcmuZsh952GFqFQXC
ZCHUrlruuOzDORboEWOs+a+Q5kpko02OIEydjBp0fiwt/QUYHexzY1hkxlPKbTci
ZoSUbLF3HK7EjQ1BkFCxtf7woaEGz92XEnO1gDtD2iwoZJRrO7HJH+wReDb9aE4z
8HnHWU5bW20nO2CqyFW1qw6bCLWKGLdVVcebbWPydJPzr1imRooxtVBAXrZHuK2G
Zt2ezT0w7swD1/9vJYeQw/pTKNg51IqdeoehhUfugamxQeJGiU67612XNbQx5Ciy
ynwJY59UPItuv4Nnz/HhAZ5CWxOc4uAtbGrnS8B7i9pU7xS9SsK9Lp5x2V1z8JOS
xQgHlLbmxEVx9w+mc1wzAYstkmgblJJADxh/34O4A9CoAPN04kfx/bwmfFAFO2pu
h7dz3OkGfTqouC34FV17iGE7OUx7yXRHbVvM6kcN1SD8Pkfhpnvo+p6wvSJ9KsNY
Pb6h25wKN4HotPkXnqmq
=0WRs
-----END PGP SIGNATURE-----

--wmr0DEQJrDWlOkHc--
