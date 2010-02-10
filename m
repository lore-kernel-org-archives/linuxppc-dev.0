Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AB8FCB7D81
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Feb 2010 21:21:38 +1100 (EST)
Date: Wed, 10 Feb 2010 11:21:30 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v6 2/4] i2c-mpc: rename "setclock" initialization
	functions to "setup"
Message-ID: <20100210102130.GB5239@pengutronix.de>
References: <1265796330-15976-1-git-send-email-wg@grandegger.com>
	<1265796330-15976-2-git-send-email-wg@grandegger.com>
	<1265796330-15976-3-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
In-Reply-To: <1265796330-15976-3-git-send-email-wg@grandegger.com>
Cc: Wolfgang Grandegger <wg@denx.de>, Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org, Linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 10, 2010 at 11:05:28AM +0100, Wolfgang Grandegger wrote:
> From: Wolfgang Grandegger <wg@denx.de>
>=20
> To prepare  support for the MPC512x processors from Freescale the
> "setclock" initialization functions have been renamed to "setup"
> because I2C interrupts must be enabled for the MPC512x by this
> function as well.
>=20
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktyiKoACgkQD27XaX1/VRvbLACeOfNnwxjSG7CFOIRKM7wFwx0A
bn4An2166t2pNPhSaRwgr1ixS2YKI6jX
=qsek
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
