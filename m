Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vwrfh1yNvzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Apr 2017 20:13:32 +1000 (AEST)
Date: Sun, 2 Apr 2017 12:05:36 +0200
From: Pavel Machek <pavel@denx.de>
To: sr@denx.de, jwboyer@linux.vnet.ibm.com, robh+dt@kernel.org,
 mark.rutland@arm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/sequoia: fix NAND partitions not to overlap
Message-ID: <20170402100535.GA18340@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix overlapping NAND partitions.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequ=
oia.dts
index b1d3292..e41b88a 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -229,7 +229,7 @@
 						};
 						partition@84000 {
 							label =3D "user";
-							reg =3D <0x00000000 0x01f7c000>;
+							reg =3D <0x00084000 0x01f7c000>;
 						};
 					};
 				};



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljgzO8ACgkQMOfwapXb+vKEZgCfVRsMI8C5xK/R4J8IZxqMTax3
eO4An2eRzivAtre0Jf3x2C8/79dSlR83
=15XD
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
