Return-Path: <tony@bakeyournoodle.com>
Date: Wed, 23 Nov 2011 10:50:46 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH] powerpc: 44x: Add mtd ndfc to the ppx44x defconfig
Message-ID: <20111122234933.GA28400@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---

Again appologies for the SPAM trying to send this message.

 arch/powerpc/configs/ppc44x_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/p=
pc44x_defconfig
index 6cdf1c0..3b98d73 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -52,6 +52,8 @@ CONFIG_MTD_CFI=3Dy
 CONFIG_MTD_JEDECPROBE=3Dy
 CONFIG_MTD_CFI_AMDSTD=3Dy
 CONFIG_MTD_PHYSMAP_OF=3Dy
+CONFIG_MTD_NAND=3Dm
+CONFIG_MTD_NAND_NDFC=3Dm
 CONFIG_MTD_UBI=3Dm
 CONFIG_MTD_UBI_GLUEBI=3Dm
 CONFIG_PROC_DEVICETREE=3Dy
--=20
1.7.6.4


Yours Tony

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOzDVVAAoJEEsCiJRY75GKwtsQAKv7CUTjPxtXvb2XJHRdMlNa
5qbg+sRbmaTD07/7ZmUWUf8D8wJM1EczuqswYbf0CrdsttIKCxA9gNR/2B0pprVc
4XXdVzFXbIYVupQe8/q9q0g8DtOlTNJ63qjwK421yxDMFn/4kdhaKxLmI8POuFVg
sgOQN2X7FF8X/dNFv3pTIdKSDSF1QURtEZe+gSJw9WLEv+PzI15QhZ1zk/IcgaO3
/pLo2uf6+V+JywyNUGDsXyLyioU1tAKzC2f49pXXEjtBpy56Nj3AJ7DYDmawuwhT
yyWmSYiTURDOG/KIMvQ+3Zzj2Nb2bucFeHjnOMfcw+v8uDSQ5XxcNC4sTS1abj7j
EnazH7arcxyQBGz8gxd3tyB4WAOHp67qMBKfNsfE0kx1y/oTZ9WjY43RHNLwvxxj
N1O1QD8PzAil5f3ZJHT5ZyqajFvLLhk4VqcBV8kSFW2Ajp82LnOnT89S1AIUB58L
XDBXyuJG8YZ5y5npyNf99TIS9xW9NhKiDdEqHZ9smKovX7zs8N4IT8zQv0J7F1zZ
ltpEXNSUJZ6KByyIaV/XoOa3rnpAzHDPbaZ3wO3jdHJKCjISztw/IwhzBF08O9r3
NVrjjc6XLePqNATK1sSYzHf6MTtz/5EmqwsCkMDMR7n3Z9/8B3pdrPHfcwq1bRHW
k9DG/9muoZ1SC0u5Bhgp
=gA5W
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
