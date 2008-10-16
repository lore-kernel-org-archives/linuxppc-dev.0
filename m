Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id CD3EEDE42D
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 06:12:06 +1100 (EST)
Date: Thu, 16 Oct 2008 21:12:00 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [RESEND] i2c-cpm: Suppress autoprobing for devices
Message-ID: <20081016191200.GB13629@pengutronix.de>
References: <20081016111300.GC3432@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
In-Reply-To: <20081016111300.GC3432@pengutronix.de>
Cc: i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Similar to commit 618b26d52843c0f85b8eb143cf2695d7f6fd072d, also remove
automatic probing for this i2c controller. Might need updates to dts files
using it.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Jochen Friedrich <jochen@scram.de>
---
Resend with cc to i2c.

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

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj3kgAACgkQD27XaX1/VRutfQCgyXxb8ffSIjRPSbTSCewXsdyG
cYIAnAlJbPLIGbATxXKoPA6bwhw88zzK
=W+5A
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
