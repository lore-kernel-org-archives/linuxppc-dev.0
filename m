Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E8DA6DE347
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 21:22:30 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 792BC8814
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 16:22:29 +0500 (SAMST)
Date: Wed, 12 Sep 2007 15:25:36 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] mpc8568e_mds: UCC0's PHY is at 0x7, not 0x1
Message-ID: <20070912112536.GD15556@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There was probably a typo in the documentation, or it's hw errata.
Recent u-boot also using 0x7.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index b1dcfbe..719929c 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -97,10 +97,10 @@
 			device_type = "mdio";
 			compatible = "gianfar";
 			reg = <24520 20>;
-			phy0: ethernet-phy@0 {
+			phy0: ethernet-phy@7 {
 				interrupt-parent = <&mpic>;
 				interrupts = <1 1>;
-				reg = <0>;
+				reg = <7>;
 				device_type = "ethernet-phy";
 			};
 			phy1: ethernet-phy@1 {
@@ -417,10 +417,10 @@
 
 			/* These are the same PHYs as on
 			 * gianfar's MDIO bus */
-			qe_phy0: ethernet-phy@00 {
+			qe_phy0: ethernet-phy@07 {
 				interrupt-parent = <&mpic>;
 				interrupts = <1 1>;
-				reg = <0>;
+				reg = <7>;
 				device_type = "ethernet-phy";
 			};
 			qe_phy1: ethernet-phy@01 {
-- 
1.5.0.6
