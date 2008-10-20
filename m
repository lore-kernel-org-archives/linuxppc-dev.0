Return-Path: <w.sang@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id ED28847C31
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Oct 2008 04:12:53 +1100 (EST)
Date: Mon, 20 Oct 2008 19:12:57 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] [MPC52XX] gpio: remove dead code
Message-ID: <20081020171257.GC4362@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/powerpc/platforms/52xx/mpc52xx_gpio.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c b/arch/powerpc/plat=
forms/52xx/mpc52xx_gpio.c
index 8a455eb..07f89ae 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
@@ -363,11 +363,8 @@ static int mpc52xx_gpt_gpio_get(struct gpio_chip *gc, =
unsigned int gpio)
 {
 	struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
 	struct mpc52xx_gpt __iomem *regs =3D mm_gc->regs;
-	unsigned int ret;
=20
 	return (in_be32(&regs->status) & (1 << (31 - 23))) ? 1 : 0;
-
-	return ret;
 }
=20
 static void
--=20
1.5.6.5

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj8vBkACgkQD27XaX1/VRsBWwCdEEQLA9JWdvMO2q7tlbVetEmo
qg4An0ylnLqewI0fGVqBjVs/TsMnwDzu
=loTi
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
