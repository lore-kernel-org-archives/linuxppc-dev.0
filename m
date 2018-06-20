Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419h8d5nc1zF0Vt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:36:46 +1000 (AEST)
Date: Wed, 20 Jun 2018 11:36:38 +0100
From: Mark Brown <broonie@kernel.org>
To: York Sun <york.sun@nxp.com>
Cc: "jocke@infinera.com" <joakim.tjernlund@infinera.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] spi/fsl-espi: Add missing cell-index OF property
Message-ID: <20180620103638.GB6242@sirena.org.uk>
References: <20180619162304.20125-1-joakim.tjernlund@infinera.com>
 <VI1PR04MB20782A7BE6789A3AE441DB359A700@VI1PR04MB2078.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
In-Reply-To: <VI1PR04MB20782A7BE6789A3AE441DB359A700@VI1PR04MB2078.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 04:29:35PM +0000, York Sun wrote:
> Joakim,
>=20
> I am not the maintainer for this driver. Adding Mark Brown.
>=20
> York
>=20
> On 06/19/2018 09:23 AM, Joakim Tjernlund wrote:
> > espi does not look for a OF cell-index property which
> > makes the bus numbering dynamic only. This add an

As documented in SubmittingPatches please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsqLjUACgkQJNaLcl1U
h9DMWgf/beW4ZZlIb58GQDm4I5tcHlCxT6wvmndRx/zshRthJLObKXyJgjra50YX
GOBhhlhPqylKb4v53WGXfb2PSvkN1zzsQXzgfAPJoScH6spJwjvcS+teT7PsLCJo
RfEenDqlhwZ1R2zPxgY4ddVppagCaQHCHECDiKycYqWOJeOpzC1iXyPUPTeyRF+i
/ZKIcs/ymSeJVIFK4OkLA58H89VsQdwEnphWJ6HFhrHwOvrN+qfVIg6YSoCa+XtA
02DeeMPS2206c+tu3s8No37lRYtmOAfdeDpnPc7BDVf/OrqjkR7WOGbiGWfR3Yf3
qtDxfj7sqFnwp7EMtZwjtiRxQIHN0g==
=jyjT
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
