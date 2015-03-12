Return-Path: <hongtao.jia@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0108.outbound.protection.outlook.com [207.46.100.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EC701A018B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 18:18:49 +1100 (AEDT)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>
Subject: [PATCH 1/2] powerpc: Enable thermal monitor feature in defconfig for
 supported platforms
Date: Thu, 12 Mar 2015 15:00:13 +0800
Message-ID: <1426143614-24958-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: hongtao.jia@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
---
 arch/powerpc/configs/corenet32_smp_defconfig | 2 +-
 arch/powerpc/configs/corenet64_smp_defconfig | 2 +-
 arch/powerpc/configs/mpc85xx_defconfig       | 3 +--
 arch/powerpc/configs/mpc85xx_smp_defconfig   | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index ca7957b..7370990 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -118,7 +118,7 @@ CONFIG_SPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_SPI_FSL_SPI=y
 CONFIG_SPI_FSL_ESPI=y
-# CONFIG_HWMON is not set
+CONFIG_SENSORS_LM90=y
 CONFIG_USB_HID=m
 CONFIG_USB=y
 CONFIG_USB_MON=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 04737aa..4cfc3e8 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -103,7 +103,7 @@ CONFIG_SPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_SPI_FSL_SPI=y
 CONFIG_SPI_FSL_ESPI=y
-# CONFIG_HWMON is not set
+CONFIG_SENSORS_LM90=y
 CONFIG_USB_HID=m
 CONFIG_USB=y
 CONFIG_USB_MON=y
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 8535c34..6ecf7bd 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -150,8 +150,7 @@ CONFIG_SPI=y
 CONFIG_SPI_FSL_SPI=y
 CONFIG_SPI_FSL_ESPI=y
 CONFIG_GPIO_MPC8XXX=y
-CONFIG_HWMON=m
-CONFIG_SENSORS_LM90=m
+CONFIG_SENSORS_LM90=y
 CONFIG_FB=y
 CONFIG_FB_FSL_DIU=y
 # CONFIG_VGA_CONSOLE is not set
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index c45ad2e..b6c7111 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -143,7 +143,7 @@ CONFIG_SPI=y
 CONFIG_SPI_FSL_SPI=y
 CONFIG_SPI_FSL_ESPI=y
 CONFIG_GPIO_MPC8XXX=y
-# CONFIG_HWMON is not set
+CONFIG_SENSORS_LM90=y
 CONFIG_FB=y
 CONFIG_FB_FSL_DIU=y
 # CONFIG_VGA_CONSOLE is not set
-- 
2.1.0.27.g96db324
