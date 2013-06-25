Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5CDE22C0077
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 16:37:22 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mpc512x: update defconfig
Date: Tue, 25 Jun 2013 08:37:17 +0200
Message-Id: <1372142237-20554-1-git-send-email-agust@denx.de>
Cc: Gerhard Sittig <gsi@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gerhard Sittig <gsi@denx.de>

This patch does not change the content, it merely re-orders
configuration items and drops explicit options which already
apply as the default.

Signed-off-by: Gerhard Sittig <gsi@denx.de>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/configs/mpc512x_defconfig |   20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index 0d0d981..5b8ee80 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -1,7 +1,6 @@
-CONFIG_EXPERIMENTAL=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
-CONFIG_SPARSE_IRQ=y
+CONFIG_NO_HZ=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
@@ -9,6 +8,7 @@ CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_CFQ is not set
 # CONFIG_PPC_CHRP is not set
 CONFIG_PPC_MPC512x=y
@@ -16,9 +16,7 @@ CONFIG_MPC5121_ADS=y
 CONFIG_MPC512x_GENERIC=y
 CONFIG_PDM360NG=y
 # CONFIG_PPC_PMAC is not set
-CONFIG_NO_HZ=y
 CONFIG_HZ_1000=y
-# CONFIG_MIGRATION is not set
 # CONFIG_SECCOMP is not set
 # CONFIG_PCI is not set
 CONFIG_NET=y
@@ -33,8 +31,6 @@ CONFIG_IP_PNP=y
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CAN=y
-CONFIG_CAN_RAW=y
-CONFIG_CAN_BCM=y
 CONFIG_CAN_VCAN=y
 CONFIG_CAN_MSCAN=y
 CONFIG_CAN_DEBUG_DEVICES=y
@@ -46,7 +42,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FIRMWARE_IN_KERNEL is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
@@ -60,7 +55,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_BLK_DEV_XIP=y
-CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
 CONFIG_SCSI=y
@@ -68,6 +62,7 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_NETDEVICES=y
+CONFIG_FS_ENET=y
 CONFIG_MARVELL_PHY=y
 CONFIG_DAVICOM_PHY=y
 CONFIG_QSEMI_PHY=y
@@ -83,10 +78,6 @@ CONFIG_STE10XP=y
 CONFIG_LSI_ET1011C_PHY=y
 CONFIG_FIXED_PHY=y
 CONFIG_MDIO_BITBANG=y
-CONFIG_NET_ETHERNET=y
-CONFIG_FS_ENET=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_WLAN is not set
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
@@ -106,10 +97,7 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MPC8XXX=y
 # CONFIG_HWMON is not set
 CONFIG_MEDIA_SUPPORT=y
-CONFIG_VIDEO_DEV=y
 CONFIG_VIDEO_ADV_DEBUG=y
-# CONFIG_VIDEO_HELPER_CHIPS_AUTO is not set
-CONFIG_VIDEO_SAA711X=y
 CONFIG_FB=y
 CONFIG_FB_FSL_DIU=y
 # CONFIG_VGA_CONSOLE is not set
@@ -129,9 +117,7 @@ CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_UBIFS_FS=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
-- 
1.7.9.5
