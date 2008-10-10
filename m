Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78F06DE2E4
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 02:36:00 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Subject: [PATCH] powerpc: disable CHRP and PMAC support in various defconfigs
Date: Fri, 10 Oct 2008 10:35:50 -0500
Message-Id: <1223652950-11791-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Because CHRP and PMAC are by default enabled, several non-CHRP and non-PMAC
PowerPC defconfigs will have these Kconfig options set erroneously.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/configs/83xx/asp8347_defconfig       |    2 ++
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |    2 ++
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |    2 ++
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |    2 ++
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |    2 ++
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |    2 ++
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |    2 ++
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |    2 ++
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |    2 ++
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |    2 ++
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |    2 ++
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |    2 ++
 arch/powerpc/configs/83xx/sbc834x_defconfig       |    2 ++
 arch/powerpc/configs/86xx/gef_sbc610_defconfig    |    5 ++++-
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |    2 ++
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |    2 ++
 arch/powerpc/configs/86xx/sbc8641d_defconfig      |    2 ++
 arch/powerpc/configs/ep8248e_defconfig            |    2 ++
 arch/powerpc/configs/mpc8272_ads_defconfig        |    2 ++
 arch/powerpc/configs/mpc83xx_defconfig            |    2 ++
 arch/powerpc/configs/pq2fads_defconfig            |    2 ++
 21 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/configs/83xx/asp8347_defconfig b/arch/powerpc/configs/83xx/asp8347_defconfig
index 6638f5a..0b1fa20 100644
--- a/arch/powerpc/configs/83xx/asp8347_defconfig
+++ b/arch/powerpc/configs/83xx/asp8347_defconfig
@@ -164,6 +164,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
index df125f3..b7eae2b 100644
--- a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
@@ -163,6 +163,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
index 6e0e08c..b0a27a6 100644
--- a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
@@ -163,6 +163,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
index d6e204a..ad825bc 100644
--- a/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
@@ -163,6 +163,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
index 1f3d343..3826750 100644
--- a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
@@ -163,6 +163,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
index 4686c21..90aab34 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
@@ -163,6 +163,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
index f11c25e..7458a24 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
@@ -163,6 +163,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc834x_mds_defconfig b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
index ffe4b2e..1a92798 100644
--- a/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
@@ -163,6 +163,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
index 71445e3..03d8ced 100644
--- a/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
@@ -163,6 +163,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
index 58486cc..cdf8417 100644
--- a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
@@ -164,6 +164,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
index 0171e21..97e02d7 100644
--- a/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
@@ -164,6 +164,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
index d6b383b..5ac3305 100644
--- a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
@@ -164,6 +164,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/83xx/sbc834x_defconfig b/arch/powerpc/configs/83xx/sbc834x_defconfig
index b8dd17b..c359cc2 100644
--- a/arch/powerpc/configs/83xx/sbc834x_defconfig
+++ b/arch/powerpc/configs/83xx/sbc834x_defconfig
@@ -162,6 +162,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/86xx/gef_sbc610_defconfig b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
index f589489..312d7af 100644
--- a/arch/powerpc/configs/86xx/gef_sbc610_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
@@ -156,7 +156,10 @@ CONFIG_CLASSIC_RCU=y
 #
 # Platform support
 #
-# CONFIG_PPC_MULTIPLATFORM is not set
+CONFIG_PPC_MULTIPLATFORM=y
+CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 CONFIG_PPC_86xx=y
diff --git a/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig b/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
index 14116a8..c98c6ee 100644
--- a/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
+++ b/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
@@ -165,6 +165,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
index 07e369d..444ddf9 100644
--- a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
+++ b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
@@ -167,6 +167,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/86xx/sbc8641d_defconfig b/arch/powerpc/configs/86xx/sbc8641d_defconfig
index 3326303..d900f8f 100644
--- a/arch/powerpc/configs/86xx/sbc8641d_defconfig
+++ b/arch/powerpc/configs/86xx/sbc8641d_defconfig
@@ -166,6 +166,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/ep8248e_defconfig b/arch/powerpc/configs/ep8248e_defconfig
index a63cd05..cd691f7 100644
--- a/arch/powerpc/configs/ep8248e_defconfig
+++ b/arch/powerpc/configs/ep8248e_defconfig
@@ -150,6 +150,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/mpc8272_ads_defconfig b/arch/powerpc/configs/mpc8272_ads_defconfig
index ddbca3e..ff6f7c4 100644
--- a/arch/powerpc/configs/mpc8272_ads_defconfig
+++ b/arch/powerpc/configs/mpc8272_ads_defconfig
@@ -151,6 +151,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 994a4e7..991c9bd 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -166,6 +166,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
diff --git a/arch/powerpc/configs/pq2fads_defconfig b/arch/powerpc/configs/pq2fads_defconfig
index e687cc0..7e17862 100644
--- a/arch/powerpc/configs/pq2fads_defconfig
+++ b/arch/powerpc/configs/pq2fads_defconfig
@@ -152,6 +152,8 @@ CONFIG_CLASSIC_RCU=y
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-- 
1.5.5
