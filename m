Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 4DD18DE268
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 07:06:55 +1000 (EST)
Date: Wed, 6 May 2009 23:06:44 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 10/12] mpc5121: Add MPC5121 Real time clock driver.
Message-ID: <20090506210644.GA17311@pengutronix.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-11-git-send-email-wd@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
In-Reply-To: <1241640919-4650-11-git-send-email-wd@denx.de>
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>,
	rtc-linux@googlegroups.com, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2009 at 10:15:17PM +0200, Wolfgang Denk wrote:
> From: John Rigby <jrigby@freescale.com>
>=20
> Based on Domen Puncer's rtc driver for 5200 posted to
> the ppclinux mailing list:
> 	http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=3D11675
> but never commited anywhere.
>=20
> Changes to Domen's original:
>=20
>     Changed filenames/routine names from mpc5200* to mpc5121*

Why not changing it to mpc5xxx? From a glimpse, it should still work on
MPC5200, too.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoB++QACgkQD27XaX1/VRu13QCgnkfCUiOcUwd3SUuLGvOQtzC5
MZUAn1MHTdf+4RReUeGKO5fT+l0tUtPH
=BeC4
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
