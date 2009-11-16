Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id B6315B7093
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 05:44:23 +1100 (EST)
Date: Mon, 16 Nov 2009 19:44:16 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] net/can: add driver for mscan family & mpc52xx_mscan
Message-ID: <20091116184416.GA21491@pengutronix.de>
References: <1258128892-28800-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40911130939x54ac53f9x173a875a5a4435d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
In-Reply-To: <fa686aa40911130939x54ac53f9x173a875a5a4435d3@mail.gmail.com>
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

Wolfgang commented on some points already, I will pick up the other remarks,
just one question:

> > + =A0 =A0 =A0 clk_src =3D of_get_property(np, "fsl,mscan-clk-src", NULL=
);
> > + =A0 =A0 =A0 if (clk_src && strcmp(clk_src, "ip") =3D=3D 0)
>=20
> Should protect against non-null.  strncmp() maybe?

"ip" is null-terminated, or what do you mean?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksBnYAACgkQD27XaX1/VRsMsACeM/nHKEPAcSgJm1Sf8GJCBJNH
ZfsAoI4nFj8M+aEq6Ge5oedSn+YlBMBt
=mI3e
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
