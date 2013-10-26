Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0F9A22C013B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Oct 2013 07:34:30 +1100 (EST)
Date: Sat, 26 Oct 2013 21:34:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Message-ID: <20131026203412.GC6362@sirena.org.uk>
References: <CAPgLHd-2d+RLDq1U=wXR72nAEH1Hr6FDcWp0eAyEkrNmfjrEaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
In-Reply-To: <CAPgLHd-2d+RLDq1U=wXR72nAEH1Hr6FDcWp0eAyEkrNmfjrEaA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: fix return value check in
 fsl_spdif_probe()
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 timur@tabi.org, rob.herring@calxeda.com, perex@perex.cz,
 yongjun_wei@trendmicro.com.cn, grant.likely@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2013 at 05:29:25PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> In case of error, the function platform_get_resource() returns NULL
> pointer not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.

Applied, thanks.

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbCdBAAoJELSic+t+oim9tXoP/R8vKktz5XS1Z9dhDYcNtlAw
fgsVHr0oSIqCXIO7vtLQH+HkFJoP80gWfP0DWAAmE24ho7AccKfohsTHSkYecuxd
rhnDRfQa22p8WTTGEcn6A01bm3dtOpGs3xw/claxRaGZEafaCXRFJaAwcdEWd/6N
gbhx2/v7vdNVxRWbL5BUFcVvNRo+DNN2rA5KugeK3e68KriCl6eg5iUrGhZKH0PB
tF3zr4bRslzVVEuUNic9VPjaiE9VzNmCTab0pHR8c3Na4NcoBANHnCBN/dGLkGwW
zF0kzAY6SLvgSCNSIqZIyvFXqMfsjEbiC4aikMtMw5ONdCqvBYb6ob5RP2r6GrD0
EzBaAnsLKgr2Nf5xNO40VAy8qYcnYPS4ATIzUYvO1WhOEkEINjjNBwBMNyBGi08M
rdhv8hiafQOKJsp3zibHCq0SbNbe3J0RPwF9cAz0qOErIWUT8JaFcGgeHaaVJ5f8
COsD1N805PCxT+tdGUNBo99x0cogG5vutUVB+hU9pX2GUDtjPudLP56PlUG7+K1J
fxCPVGk63iFhA7QcW5tYYR0671WjDgxMKNXEgtLve5ccoOJXgkrgYNYDt5vPMm8v
LBOL91XXIGW/7IGKddRniybriv7+/2hBdWbhPvWFMV5iC39X/z/C0eESdW/+k39E
fpEU/rQOWEhnq0AqTjvK
=UNV2
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
