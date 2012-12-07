Return-Path: <holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.1])
 by ozlabs.org (Postfix) with SMTP id 1F38A2C00DE
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2012 02:20:36 +1100 (EST)
From: Holger Brunck <holger.brunck@keymile.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] powerpc/83xx: update kmeter1_defconfig
Date: Fri,  7 Dec 2012 16:09:16 +0100
Message-Id: <1354892956-14623-5-git-send-email-holger.brunck@keymile.com>
In-Reply-To: <1354892956-14623-1-git-send-email-holger.brunck@keymile.com>
References: <1354892956-14623-1-git-send-email-holger.brunck@keymile.com>
Cc: Holger Brunck <holger.brunck@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Synchronize this defconfig with latest kernel version.

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/configs/83xx/kmeter1_defconfig |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/configs/83xx/kmeter1_defconfig b/arch/powerpc/configs/83xx/kmeter1_defconfig
index a0dfef1..e12e60c 100644
--- a/arch/powerpc/configs/83xx/kmeter1_defconfig
+++ b/arch/powerpc/configs/83xx/kmeter1_defconfig
@@ -2,6 +2,8 @@ CONFIG_EXPERIMENTAL=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
@@ -16,8 +18,6 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_83xx=y
 CONFIG_KMETER1=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 # CONFIG_SECCOMP is not set
 CONFIG_NET=y
@@ -45,7 +45,6 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_PHRAM=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_GLUEBI=y
-CONFIG_MTD_UBI_DEBUG=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
@@ -76,5 +75,4 @@ CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_UBIFS_FS=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
-- 
1.7.1
