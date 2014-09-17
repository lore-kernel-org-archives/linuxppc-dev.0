Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0140.outbound.protection.outlook.com [157.56.111.140])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B32AC1A0070
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 11:08:36 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx/defconfig: Remove duplicate CONFIG_RTC_DRV_DS1307
Date: Tue, 16 Sep 2014 19:53:08 -0500
Message-ID: <1410915188-26480-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit a95e8c28b3dc "powerpc/defconfig: update RTC support" duplicated
the CONFIG_RTC_DRV_DS1307 symbol in mpc85xx_defconfig and
mpc85xx_smp_defconfig, resulting in this:

arch/powerpc/configs/mpc85xx_smp_defconfig:217:warning: override: reassigning to symbol RTC_DRV_DS1307

Fixes: a95e8c28b3dc "powerpc/defconfig: update RTC support"
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/configs/mpc85xx_defconfig     | 1 -
 arch/powerpc/configs/mpc85xx_smp_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 8b2d759..d2c4154 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -213,7 +213,6 @@ CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_DS1374=y
 CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_CMOS=y
-CONFIG_RTC_DRV_DS1307=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
 # CONFIG_NET_DMA is not set
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index a3003b2..8746008 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -214,7 +214,6 @@ CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_DS1374=y
 CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_CMOS=y
-CONFIG_RTC_DRV_DS1307=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
 # CONFIG_NET_DMA is not set
-- 
1.9.1
