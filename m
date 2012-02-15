Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id D547B1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 13:31:18 +1100 (EST)
Date: Wed, 15 Feb 2012 13:31:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: remove legacy iSeries from ppc64_defconfig
Message-Id: <20120215133109.7f4adf05b76a076e92c4efe3@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__15_Feb_2012_13_31_09_+1100_aixVvt8SXC5ROI6j"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__15_Feb_2012_13_31_09_+1100_aixVvt8SXC5ROI6j
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since we are heading towards removing the Legacy iSeries platform, start
by no longer building it for ppc64_defconfig.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/configs/ppc64_defconfig |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/pp=
c64_defconfig
index 2156e07..1acf650 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -24,10 +24,6 @@ CONFIG_PPC_SPLPAR=3Dy
 CONFIG_SCANLOG=3Dm
 CONFIG_PPC_SMLPAR=3Dy
 CONFIG_DTL=3Dy
-CONFIG_PPC_ISERIES=3Dy
-CONFIG_VIODASD=3Dy
-CONFIG_VIOCD=3Dm
-CONFIG_VIOTAPE=3Dm
 CONFIG_PPC_MAPLE=3Dy
 CONFIG_PPC_PASEMI=3Dy
 CONFIG_PPC_PASEMI_IOMMU=3Dy
@@ -259,7 +255,6 @@ CONFIG_PASEMI_MAC=3Dy
 CONFIG_MLX4_EN=3Dm
 CONFIG_QLGE=3Dm
 CONFIG_BE2NET=3Dm
-CONFIG_ISERIES_VETH=3Dm
 CONFIG_PPP=3Dm
 CONFIG_PPP_ASYNC=3Dm
 CONFIG_PPP_SYNC_TTY=3Dm
--=20
1.7.9

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__15_Feb_2012_13_31_09_+1100_aixVvt8SXC5ROI6j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPOxjtAAoJEECxmPOUX5FEHq4P/i7Hf4xqd0Ki55BHFWH0rr6b
yT/IQLI+wNaPDr0Dg1qVjGCSjdyA/g3W+K9c0IRaHY1CRHIGPl9j/MCMY7qPEfFa
AVPgmJoqzIwLvS0S3+emKA+LwQ3FC560ocMnPw2HvAmX/TX5eyA/HUHwwQNgS4yL
51aFSZzV+V3a0Kj/y6CGG21RkyqgC9mbfNWcmsg90eIZBVRyCN2TH1b3ssXJk56R
fvu9DGgogDpEQTo93nX/SO8lUN2PZXAQgjrcdMk4Xyv4/F0DqqjxYkzMvqbi+Tdj
i/hWTWpDo8h7X3bnq3sGMev+hXzBnkK7gnMHtQjiMHyvf+6PZoBrWcdNoR4SQ5P2
8Ti5ow/CSW0zk8PgZibEf+2zLPVNqjBLjLejewzOAXJQQaxE4xBCymunGsfRHPdR
/WsPXnegNkOhhTLnBMMSiLZwM2XZC0bFOW3+LmIy2T6KFgVkKauoox4N1osCQiVv
Stv/t/uLfXyFB6brlIrgMg9z0sKoBolGrNoZfQPrrgg8pJ9x+h/8ymAX31Zex2VY
FfSOH52cKL14ajCAtneo1gaHMM+dCWUl96tPqE9MtI/++wD41DJAvFtdXU9CNA36
gzLvytS4N3GAHoC4oX1g7Y6qSGVdJLwkaphQBs4H1r7qCDBxk9+Zf2XAAVCrBXIr
bCGsvfrm1TOn8AaftG15
=WqGi
-----END PGP SIGNATURE-----

--Signature=_Wed__15_Feb_2012_13_31_09_+1100_aixVvt8SXC5ROI6j--
