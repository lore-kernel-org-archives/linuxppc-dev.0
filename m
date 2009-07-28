Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35])
	by bilbo.ozlabs.org (Postfix) with ESMTP id D4FBCB7B5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 18:48:04 +1000 (EST)
Date: Tue, 28 Jul 2009 10:31:00 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: "B.J. Buchalter" <bj@mhlabs.com>
Subject: Re: Question about tracking freescale patches for Linux
Message-ID: <20090728083059.GB3170@pengutronix.de>
References: <06A91D45-B506-44F8-A234-D9E55301349D@mhlabs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
In-Reply-To: <06A91D45-B506-44F8-A234-D9E55301349D@mhlabs.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I have contacted Freescale, but they basically say that they provide the=
=20
> BSP, and make no commitments to supporting any other version of the linux=
=20
> kernel.

So true :(

> 1) is there any way to determine if any these patches are currently =20
> being worked into the mainline kernel, or if they have been abandoned =20
> for some reason?

I usually use search engines (which often lead to linux-ppc threads) and
patchwork.ozlabs.org.

>
> 2) Is it worth trying to move these patches up to the head of =20
> development and trying to get them merged into the mainline kernel, or =
=20
> is that really just up to freescale to do?

It surely is worth (and is often done by people not involved with fsl). But=
 be
warned, some patches are in a terrible state, meaning half a rewrite is
necessary.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkput0MACgkQD27XaX1/VRvVbgCfaW42IpC7zKqlADX0X6OiuTBb
BHUAn3CpWn1R3Y7hTMbakML8GrHjkhaK
=GuCV
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
