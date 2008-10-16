Return-Path: <w.sang@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 7A2E6DDFB4
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 22:12:58 +1100 (EST)
Date: Thu, 16 Oct 2008 13:13:00 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] i2c-cpm: Suppress autoprobing for devices
Message-ID: <20081016111300.GC3432@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Similar to commit 618b26d52843c0f85b8eb143cf2695d7f6fd072d, also remove
automatic probing for this i2c controller. Might need updates to dts files
using it.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/i2c/busses/i2c-cpm.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6/drivers/i2c/busses/i2c-cpm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/i2c/busses/i2c-cpm.c
+++ linux-2.6/drivers/i2c/busses/i2c-cpm.c
@@ -423,7 +423,6 @@ static const struct i2c_adapter cpm_ops=20
 	.owner		=3D THIS_MODULE,
 	.name		=3D "i2c-cpm",
 	.algo		=3D &cpm_i2c_algo,
-	.class		=3D I2C_CLASS_HWMON | I2C_CLASS_SPD,
 };
=20
 static int __devinit cpm_i2c_setup(struct cpm_i2c *cpm)
--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj3IbwACgkQD27XaX1/VRuNmgCdFZ6tJK1hrlUMY7LZsCIU/U5z
Y60An2H5rXTCDWl/p6sqUVTcOW1VefT2
=fuI2
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
