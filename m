Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 34557B7035
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 17:55:21 +1000 (EST)
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net
	[192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 6CEE61801948
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 09:55:19 +0200 (CEST)
Received: from mail.denx.de (host-82-135-33-74.customer.m-online.net
	[82.135.33.74])
	by smtp-auth.mnet-online.de (Postfix) with ESMTPA id 945981C000BB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 09:55:19 +0200 (CEST)
Received: from pollux.denx.de (pollux [192.168.1.1])
	by mail.denx.de (Postfix) with ESMTP id 757CB34006D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 09:55:19 +0200 (CEST)
From: Heiko Schocher <hs@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc, mpc5200: update mpc5200_defconfig
Date: Wed, 22 Jun 2011 09:55:10 +0200
Message-Id: <1308729311-15375-4-git-send-email-hs@denx.de>
In-Reply-To: <1308729311-15375-1-git-send-email-hs@denx.de>
References: <1308729311-15375-1-git-send-email-hs@denx.de>
Cc: Heiko Schocher <hs@denx.de>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

just made a

make mpc5200_defconfig
make savedefconfig
cp defconfig arch/powerpc/configs/mpc5200_defconfig

So changes needed in mpc5200_defconfig for a4m072 board support
better indicated.

Signed-off-by: Heiko Schocher <hs@denx.de>
cc: Wolfgang Denk <wd@denx.de>
---
 arch/powerpc/configs/mpc5200_defconfig |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index e63f537..b3e27f6 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -1,8 +1,8 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
+CONFIG_SPARSE_IRQ=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
@@ -20,8 +20,6 @@ CONFIG_PPC_BESTCOMM=y
 CONFIG_SIMPLE_GPIO=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_SPARSE_IRQ=y
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -36,10 +34,7 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_CONCAT=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -115,7 +110,6 @@ CONFIG_RTC_DRV_DS1307=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_INOTIFY=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
@@ -133,5 +127,4 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-- 
1.7.5.4
