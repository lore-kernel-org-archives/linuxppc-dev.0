Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 424F6DE277
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 04:03:38 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id E76C08810
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 21:03:36 +0400 (SAMT)
Date: Tue, 13 Nov 2007 20:00:43 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] [POWERPC] mpc832x_rdb_defconfig: enable SPI_MPC83xx and
	MMC-over-SPI
Message-ID: <20071113170043.GC23979@localhost.localdomain>
References: <20071113165825.GA23739@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071113165825.GA23739@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/configs/mpc832x_rdb_defconfig |   43 ++++++++++++++++++++++++----
 1 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/configs/mpc832x_rdb_defconfig b/arch/powerpc/configs/mpc832x_rdb_defconfig
index 16d54c0..fcda7cc 100644
--- a/arch/powerpc/configs/mpc832x_rdb_defconfig
+++ b/arch/powerpc/configs/mpc832x_rdb_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.24-rc2
-# Tue Nov 13 19:33:24 2007
+# Tue Nov 13 19:36:27 2007
 #
 # CONFIG_PPC64 is not set
 
@@ -679,8 +679,21 @@ CONFIG_I2C_MPC=y
 #
 # SPI support
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
+CONFIG_SPI=y
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+CONFIG_SPI_BITBANG=y
+CONFIG_SPI_MPC83xx=y
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_AT25 is not set
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 CONFIG_HWMON=y
@@ -702,6 +715,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_GL520SM is not set
 # CONFIG_SENSORS_IT87 is not set
 # CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM70 is not set
 # CONFIG_SENSORS_LM75 is not set
 # CONFIG_SENSORS_LM77 is not set
 # CONFIG_SENSORS_LM78 is not set
@@ -916,7 +930,24 @@ CONFIG_USB_MON=y
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
-# CONFIG_MMC is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
+
+#
+# MMC/SD Card Drivers
+#
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
+# CONFIG_SDIO_UART is not set
+
+#
+# MMC/SD Host Controller Drivers
+#
+# CONFIG_MMC_SDHCI is not set
+# CONFIG_MMC_WBSD is not set
+# CONFIG_MMC_TIFM_SD is not set
+CONFIG_MMC_SPI=y
 # CONFIG_NEW_LEDS is not set
 # CONFIG_INFINIBAND is not set
 # CONFIG_EDAC is not set
@@ -1095,9 +1126,9 @@ CONFIG_UCC=y
 CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
-# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC_ITU_T=y
 CONFIG_CRC32=y
-# CONFIG_CRC7 is not set
+CONFIG_CRC7=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
-- 
1.5.2.2
