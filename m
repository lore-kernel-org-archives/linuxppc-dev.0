Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 1ACD1B6F6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 May 2011 15:20:44 +1000 (EST)
From: Heiko Schocher <hs@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc, mpc52xx: update defconfig
Date: Wed,  4 May 2011 07:20:38 +0200
Message-Id: <1304486438-20943-1-git-send-email-hs@denx.de>
Cc: Heiko Schocher <hs@denx.de>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Did following steps:

make mpc5200_defconfig
make savedefconfig
cp defconfig arch/powerpc/configs/mpc5200_defconfig

Signed-off-by: Heiko Schocher <hs@denx.de>
cc: Grant Likely <grant.likely@secretlab.ca>
cc: Wolfgang Denk <wd@denx.de>
---
based against:
git://git.secretlab.ca/git/linux-2.6

Grant: Don;t know, if this patch is needed, but with it,
the next patch shows only the changes I need for the
charon board support.

./scripts/checkpatch.pl 0001-powerpc-mpc52xx-update-defconfig.patch
total: 0 errors, 0 warnings, 36 lines checked

0001-powerpc-mpc52xx-update-defconfig.patch has no obvious style problems and is ready for submission.

 arch/powerpc/configs/mpc5200_defconfig |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index e63f537..e9813a7 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -1,5 +1,6 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
+CONFIG_SPARSE_IRQ=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -20,8 +21,6 @@ CONFIG_PPC_BESTCOMM=y
 CONFIG_SIMPLE_GPIO=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_SPARSE_IRQ=y
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -36,10 +35,8 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -115,7 +112,6 @@ CONFIG_RTC_DRV_DS1307=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_INOTIFY=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
@@ -133,5 +129,4 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-- 
1.7.4.4
