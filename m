Return-Path: <B36685@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CDA7D2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2013 19:32:06 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/fsl/defconfig: enable CONFIG_AT803X_PHY
Date: Tue, 3 Sep 2013 16:28:26 +0800
Message-ID: <1378196906-9850-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable CONFIG_AT803X_PHY to support AR8030/8033/8035 PHY.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 arch/powerpc/configs/mpc85xx_defconfig       |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig   |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 60027c2..ccb9d12 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -103,6 +103,7 @@ CONFIG_FSL_PQ_MDIO=y
 CONFIG_E1000=y
 CONFIG_E1000E=y
 CONFIG_VITESSE_PHY=y
+CONFIG_AT803X_PHY=y
 CONFIG_FIXED_PHY=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 5a58882..2ddbba5 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -136,6 +136,7 @@ CONFIG_MARVELL_PHY=y
 CONFIG_DAVICOM_PHY=y
 CONFIG_CICADA_PHY=y
 CONFIG_VITESSE_PHY=y
+CONFIG_AT803X_PHY=y
 CONFIG_FIXED_PHY=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 152fa05..b08ba94 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -136,6 +136,7 @@ CONFIG_MARVELL_PHY=y
 CONFIG_DAVICOM_PHY=y
 CONFIG_CICADA_PHY=y
 CONFIG_VITESSE_PHY=y
+CONFIG_AT803X_PHY=y
 CONFIG_FIXED_PHY=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
-- 
1.7.0.4
