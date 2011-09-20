Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BFB05B6F89
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2011 03:32:35 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: update 512x-defconfig
Date: Tue, 20 Sep 2011 19:32:21 +0200
Message-Id: <1316539941-14092-2-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1316539941-14092-1-git-send-email-w.sang@pengutronix.de>
References: <1316539941-14092-1-git-send-email-w.sang@pengutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Activate all MPC512x related boards. Also enable GPIO-driver, SPI driver
and at25 to test SPI. Enable DEVTMPFS. Bump to 3.1-rc6.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/configs/mpc512x_defconfig |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index c02bbb2..211fcc9 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -1,9 +1,9 @@
 CONFIG_EXPERIMENTAL=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
+CONFIG_SPARSE_IRQ=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
 CONFIG_MODULES=y
@@ -13,10 +13,11 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_PPC_CHRP is not set
 CONFIG_PPC_MPC512x=y
 CONFIG_MPC5121_ADS=y
+CONFIG_MPC5121_GENERIC=y
+CONFIG_PDM360NG=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_NO_HZ=y
 CONFIG_HZ_1000=y
-CONFIG_SPARSE_IRQ=y
 # CONFIG_MIGRATION is not set
 # CONFIG_SECCOMP is not set
 # CONFIG_PCI is not set
@@ -35,18 +36,16 @@ CONFIG_CAN=y
 CONFIG_CAN_RAW=y
 CONFIG_CAN_BCM=y
 CONFIG_CAN_VCAN=y
-CONFIG_CAN_DEV=y
 CONFIG_CAN_MSCAN=y
 CONFIG_CAN_DEBUG_DEVICES=y
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FIRMWARE_IN_KERNEL is not set
 CONFIG_MTD=y
-CONFIG_MTD_CONCAT=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -63,6 +62,7 @@ CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_BLK_DEV_XIP=y
 CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_AT24=y
+CONFIG_EEPROM_AT25=y
 CONFIG_SCSI=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
@@ -99,10 +99,14 @@ CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=115200
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
+CONFIG_SPI=y
+CONFIG_SPI_MPC512x_PSC=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_MPC8XXX=y
 # CONFIG_HWMON is not set
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_VIDEO_DEV=y
-# CONFIG_VIDEO_ALLOW_V4L1 is not set
 CONFIG_VIDEO_ADV_DEBUG=y
 # CONFIG_VIDEO_HELPER_CHIPS_AUTO is not set
 CONFIG_VIDEO_SAA711X=y
@@ -132,6 +136,5 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
-- 
1.7.5.4
