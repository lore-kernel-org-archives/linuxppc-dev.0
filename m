Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7C11DDFBB
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 02:51:34 +1100 (EST)
Date: Fri, 28 Mar 2008 10:51:25 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/3] mpc83xx: fix usb phy_type in mpc837x rdb device trees
Message-Id: <20080328105125.6a072ff7.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

the mpc837x rdb board uses low pin count interfaces (ULPI) to connect
to the USB PHY.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/boot/dts/mpc8377_rdb.dts |    2 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts |    2 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 440aa4d..1a7d516 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -151,7 +151,7 @@
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
-			phy_type = "utmi";
+			phy_type = "ulpi";
 		};
 
 		mdio@24520 {
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 9271153..9d259a1 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -151,7 +151,7 @@
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
-			phy_type = "utmi";
+			phy_type = "ulpi";
 		};
 
 		mdio@24520 {
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 0dda2fc..8dec2ee 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -151,7 +151,7 @@
 			#size-cells = <0>;
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
-			phy_type = "utmi";
+			phy_type = "ulpi";
 		};
 
 		mdio@24520 {
-- 
1.5.4.4.481.g5075
