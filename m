Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 365EA1A024F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 16:44:18 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH v2] powerpc/defconfig: update RTC support
Date: Wed, 28 May 2014 13:55:46 +0800
Message-ID: <1401256546-14203-1-git-send-email-Shengzhou.Liu@freescale.com>
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

- remove CONFIG_RTC_DRV_CMOS in corenet32_smp_defconfig(it's unused),
  reserve CONFIG_RTC_DRV_CMOS in mpc85xx_defconfig(needed on some CDS boards)

- enable CONFIG_RTC_DRV_DS1307, CONFIG_RTC_DRV_DS1374,
  CONFIG_RTC_DRV_DS3232 in mpc85xx_defconfig, mpc85xx_smp_defconfig

- enable RTC support in  corenet64_smp_defconfig

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
v2: updated with comments.

 arch/powerpc/configs/corenet32_smp_defconfig | 3 ++-
 arch/powerpc/configs/corenet64_smp_defconfig | 4 ++++
 arch/powerpc/configs/mpc85xx_defconfig       | 3 +++
 arch/powerpc/configs/mpc85xx_smp_defconfig   | 3 +++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index bbd794d..9866898 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -138,8 +138,9 @@ CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_MPC85XX=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_DS1374=y
 CONFIG_RTC_DRV_DS3232=y
-CONFIG_RTC_DRV_CMOS=y
 CONFIG_UIO=y
 CONFIG_STAGING=y
 CONFIG_VIRT_DRIVERS=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 63508dd..bdae4d0 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -125,6 +125,10 @@ CONFIG_USB_EHCI_FSL=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_DS1374=y
+CONFIG_RTC_DRV_DS3232=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_DMADEVICES=y
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index d2e0fab..541a5b6 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -210,6 +210,9 @@ CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_DS1374=y
+CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 4cb7b59..105991a 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -211,6 +211,9 @@ CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_DS1374=y
+CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
-- 
1.8.0
