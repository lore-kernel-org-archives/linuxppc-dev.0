Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5AF4EDDE07
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Sep 2008 03:19:57 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org,
	benh@kernel.crashing.org
Subject: [PATCH] powerpc: remove CHRP and PMAC support from defconfigs,
	fix Kconfigs
Date: Fri, 26 Sep 2008 12:19:46 -0500
Message-Id: <1222449586-14622-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Kconfig files for PowerPC CHRP and PMAC support had "default=y" for some
Kconfig options, and this caused support for CHRP and PMAC platforms to be
enabled incorrectly for several platforms.  Fix the Kconfigs and the
affected defconfigs.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for 2.6.28.  Ben, please review and make sure I'm not being to
conservative or too aggressive.  I don't know enough about CHRP and PMAC to
be sure I'm doing this right.

 arch/powerpc/configs/83xx/asp8347_defconfig       |    2 --
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |    2 --
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |    2 --
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |    2 --
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |    2 --
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |    2 --
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |    2 --
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |    2 --
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |    2 --
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |    2 --
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |    2 --
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |    2 --
 arch/powerpc/configs/83xx/sbc834x_defconfig       |    2 --
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |    2 --
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |    2 --
 arch/powerpc/configs/86xx/sbc8641d_defconfig      |    2 --
 arch/powerpc/configs/ep8248e_defconfig            |    2 --
 arch/powerpc/configs/mpc8272_ads_defconfig        |    2 --
 arch/powerpc/configs/mpc83xx_defconfig            |    2 --
 arch/powerpc/configs/pq2fads_defconfig            |    2 --
 arch/powerpc/platforms/chrp/Kconfig               |    1 -
 arch/powerpc/platforms/powermac/Kconfig           |    4 ----
 22 files changed, 0 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/configs/83xx/asp8347_defconfig b/arch/powerpc/configs/83xx/asp8347_defconfig
index 5e6780a..6638f5a 100644
--- a/arch/powerpc/configs/83xx/asp8347_defconfig
+++ b/arch/powerpc/configs/83xx/asp8347_defconfig
@@ -164,11 +164,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
index 2028337..df125f3 100644
--- a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
@@ -163,11 +163,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
index dd80eb0..6e0e08c 100644
--- a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
@@ -163,11 +163,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
index bdf50c8..d6e204a 100644
--- a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
@@ -163,11 +163,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
index 4eef8c9..1f3d343 100644
--- a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
@@ -163,11 +163,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
index 8d65139..4686c21 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
@@ -163,11 +163,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
index a8afa39..f11c25e 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
@@ -163,11 +163,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_mds_defconfig b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
index 24c320a..ffe4b2e 100644
--- a/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
@@ -163,11 +163,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
index cf2706a..71445e3 100644
--- a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
@@ -163,11 +163,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
index 7d674be..58486cc 100644
--- a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
@@ -164,11 +164,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
index de47202..0171e21 100644
--- a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
@@ -164,11 +164,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
index e8d2d69..d6b383b 100644
--- a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
@@ -164,11 +164,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/83xx/sbc834x_defconfig b/arch/powerpc/configs/83xx/sbc834x_defconfig
index 9245a67..b8dd17b 100644
--- a/arch/powerpc/configs/83xx/sbc834x_defconfig
+++ b/arch/powerpc/configs/83xx/sbc834x_defconfig
@@ -162,11 +162,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig b/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
index 1a99907..14116a8 100644
--- a/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
+++ b/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
@@ -165,11 +165,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
index ea09be3..07e369d 100644
--- a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
+++ b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
@@ -167,11 +167,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/86xx/sbc8641d_defconfig b/arch/powerpc/configs/86xx/sbc8641d_defconfig
index f545421..3326303 100644
--- a/arch/powerpc/configs/86xx/sbc8641d_defconfig
+++ b/arch/powerpc/configs/86xx/sbc8641d_defconfig
@@ -166,11 +166,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/ep8248e_defconfig b/arch/powerpc/configs/ep8248e_defconfig
index ef0c6e8..a63cd05 100644
--- a/arch/powerpc/configs/ep8248e_defconfig
+++ b/arch/powerpc/configs/ep8248e_defconfig
@@ -150,11 +150,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 CONFIG_PPC_82xx=y
diff --git a/arch/powerpc/configs/mpc8272_ads_defconfig b/arch/powerpc/configs/mpc8272_ads_defconfig
index 7c435c8..ddbca3e 100644
--- a/arch/powerpc/configs/mpc8272_ads_defconfig
+++ b/arch/powerpc/configs/mpc8272_ads_defconfig
@@ -151,11 +151,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 CONFIG_PPC_82xx=y
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 916e3df..994a4e7 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -166,11 +166,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
diff --git a/arch/powerpc/configs/pq2fads_defconfig b/arch/powerpc/configs/pq2fads_defconfig
index b390b74..e687cc0 100644
--- a/arch/powerpc/configs/pq2fads_defconfig
+++ b/arch/powerpc/configs/pq2fads_defconfig
@@ -152,11 +152,9 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 CONFIG_PPC_82xx=y
diff --git a/arch/powerpc/platforms/chrp/Kconfig b/arch/powerpc/platforms/chrp/Kconfig
index 22b4b4e..682afbc 100644
--- a/arch/powerpc/platforms/chrp/Kconfig
+++ b/arch/powerpc/platforms/chrp/Kconfig
@@ -9,4 +9,3 @@ config PPC_CHRP
 	select PPC_UDBG_16550
 	select PPC_NATIVE
 	select PCI
-	default y
diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
index 055990c..85619d3 100644
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -6,7 +6,6 @@ config PPC_PMAC
 	select PPC_INDIRECT_PCI if PPC32
 	select PPC_MPC106 if PPC32
 	select PPC_NATIVE
-	default y
 
 config PPC_PMAC64
 	bool
@@ -16,6 +15,3 @@ config PPC_PMAC64
 	select MPIC_U3_HT_IRQS
 	select GENERIC_TBSYNC
 	select PPC_970_NAP
-	default y
-
-
-- 
1.5.5
