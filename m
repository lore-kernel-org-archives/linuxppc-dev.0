Return-Path: <shh.xie@gmail.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0078.outbound.protection.outlook.com [157.56.110.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E93791A02D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2015 15:08:05 +1000 (AEST)
From: <shh.xie@gmail.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <scottwood@freescale.com>, Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: [PATCH 2/2] powerpc/config: enable aquantia PHY
Date: Fri, 24 Jul 2015 11:46:33 +0800
Message-ID: <1437709593-26494-1-git-send-email-shh.xie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Shaohui Xie <Shaohui.Xie@freescale.com>

Aquantia PHYs used on platforms such as T2080RDB, T1024RDB.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 arch/powerpc/configs/corenet32_smp_defconfig | 1 +
 arch/powerpc/configs/corenet64_smp_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index fe77d60..7e98cc2 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -96,6 +96,7 @@ CONFIG_FSL_PQ_MDIO=y
 CONFIG_FSL_XGMAC_MDIO=y
 CONFIG_E1000=y
 CONFIG_E1000E=y
+CONFIG_AQUANTIA_PHY=y
 CONFIG_AT803X_PHY=y
 CONFIG_TERANETICS_PHY=y
 CONFIG_VITESSE_PHY=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 3c5b5ac..b935260 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -91,6 +91,7 @@ CONFIG_DUMMY=y
 CONFIG_FSL_PQ_MDIO=y
 CONFIG_FSL_XGMAC_MDIO=y
 CONFIG_E1000E=y
+CONFIG_AQUANTIA_PHY=y
 CONFIG_TERANETICS_PHY=y
 CONFIG_VITESSE_PHY=y
 CONFIG_FIXED_PHY=y
-- 
1.8.4.1
