Return-Path: <geoff@infradead.org>
Message-Id: <3252c8a3d0bf3c6af6ce7c76c40444943cda2943.1335379330.git.geoff@infradead.org>
In-Reply-To: <cover.1335379330.git.geoff@infradead.org>
References: <cover.1335379330.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 10/10] powerpc/ps3: Refresh ps3_defconfig
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 Apr 2012 19:19:35 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/configs/ps3_defconfig |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index ded8678..c2f4b4a 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -6,7 +6,6 @@ CONFIG_NR_CPUS=2
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_SPARSE_IRQ=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EMBEDDED=y
@@ -25,7 +24,6 @@ CONFIG_PS3_DISK=y
 CONFIG_PS3_ROM=y
 CONFIG_PS3_FLASH=y
 CONFIG_PS3_VRAM=m
-CONFIG_PS3_LPM=m
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_HIGH_RES_TIMERS=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
@@ -53,8 +51,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_DIAG is not set
 CONFIG_IPV6=y
 CONFIG_BT=m
-CONFIG_BT_L2CAP=y
-CONFIG_BT_SCO=y
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
 CONFIG_BT_BNEP=m
@@ -63,7 +59,6 @@ CONFIG_BT_BNEP_PROTO_FILTER=y
 CONFIG_BT_HIDP=m
 CONFIG_BT_HCIBTUSB=m
 CONFIG_CFG80211=m
-# CONFIG_WIRELESS_EXT_SYSFS is not set
 CONFIG_MAC80211=m
 CONFIG_MAC80211_RC_PID=y
 # CONFIG_MAC80211_RC_MINSTREL is not set
@@ -181,7 +176,6 @@ CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_WRITECOUNT=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_LIST=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_CRYPTO_CCM=m
-- 
1.7.9.5
