Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A9E25B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Dec 2010 17:13:07 +1100 (EST)
From: Heiko Schocher <hs@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc, mpc5200: update defconfig to fit with 2.6.37-rc4
Date: Sat, 11 Dec 2010 07:13:00 +0100
Message-Id: <1292047981-1435-1-git-send-email-hs@denx.de>
Cc: Heiko Schocher <hs@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Heiko Schocher <hs@denx.de>
cc: Wolfram Sang <w.sang@pengutronix.de>
cc: linuxppc-dev@lists.ozlabs.org
---
- based against 2.6.37-rc4
- I did the following steps to generate this patch:

  make mpc5200_defconfig
  make savedefconfig
  cp ./defconfig arch/powerpc/configs/mpc5200_defconfig

 arch/powerpc/configs/mpc5200_defconfig |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index 7376e27..6f75623 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -1,5 +1,6 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
+CONFIG_SPARSE_IRQ=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -20,7 +21,6 @@ CONFIG_PPC_BESTCOMM=y
 CONFIG_SIMPLE_GPIO=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_SPARSE_IRQ=y
 CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -52,7 +52,6 @@ CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=32768
-CONFIG_EEPROM_AT24=y
 CONFIG_SCSI_TGT=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
@@ -114,7 +113,6 @@ CONFIG_RTC_DRV_DS1307=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_INOTIFY=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
@@ -132,5 +130,4 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-- 
1.7.2.3
