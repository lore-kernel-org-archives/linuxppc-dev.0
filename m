Return-Path: <holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.1])
 by ozlabs.org (Postfix) with SMTP id 0EC24B6FAF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 00:08:34 +1000 (EST)
From: Holger Brunck <holger.brunck@keymile.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc/83xx: update defconfig for kmeter1
Date: Tue,  8 May 2012 15:57:21 +0200
Message-Id: <1336485442-24190-3-git-send-email-holger.brunck@keymile.com>
In-Reply-To: <1336485442-24190-1-git-send-email-holger.brunck@keymile.com>
References: <1336485442-24190-1-git-send-email-holger.brunck@keymile.com>
Cc: Heiko Schocher <hs@denx.de>, Holger Brunck <holger.brunck@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Switch on UBIFS, HOTPLUG and TIPC and update the config to
the latest kernel version.

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
cc: Heiko Schocher <hs@denx.de>
cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/configs/83xx/kmeter1_defconfig |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/configs/83xx/kmeter1_defconfig b/arch/powerpc/configs/83xx/kmeter1_defconfig
index 07e1bba..a0dfef1 100644
--- a/arch/powerpc/configs/83xx/kmeter1_defconfig
+++ b/arch/powerpc/configs/83xx/kmeter1_defconfig
@@ -2,14 +2,14 @@ CONFIG_EXPERIMENTAL=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_SPARSE_IRQ=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
-# CONFIG_HOTPLUG is not set
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_MSDOS_PARTITION is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 # CONFIG_PPC_CHRP is not set
@@ -31,11 +31,10 @@ CONFIG_IP_PNP=y
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
+CONFIG_TIPC=y
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=y
 CONFIG_MTD=y
-CONFIG_MTD_CONCAT=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
@@ -50,17 +49,15 @@ CONFIG_MTD_UBI_DEBUG=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
-CONFIG_TUN=y
 CONFIG_MII=y
-CONFIG_MARVELL_PHY=y
-CONFIG_NET_ETHERNET=y
+CONFIG_TUN=y
 CONFIG_UCC_GETH=y
-# CONFIG_NETDEV_10000 is not set
-CONFIG_WAN=y
-CONFIG_HDLC=y
+CONFIG_MARVELL_PHY=y
 CONFIG_PPP=y
 CONFIG_PPP_MULTILINK=y
 CONFIG_PPPOE=y
+CONFIG_WAN=y
+CONFIG_HDLC=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
@@ -77,10 +74,7 @@ CONFIG_UIO=y
 # CONFIG_DNOTIFY is not set
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
+CONFIG_UBIFS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
-# CONFIG_MSDOS_PARTITION is not set
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
-- 
1.7.1
