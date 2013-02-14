Return-Path: <geoff@infradead.org>
Message-Id: <e2170d10295a6391bbbb7c296c6d50a8f2ac5bc1.1360810584.git.geoff@infradead.org>
In-Reply-To: <cover.1360810584.git.geoff@infradead.org>
References: <cover.1360810584.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 3/4] powerpc/ps3: Refresh ps3_defconfig
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 14 Feb 2013 03:03:16 +0000
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/configs/ps3_defconfig |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index c2f4b4a..7a5c15f 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -6,6 +6,7 @@ CONFIG_NR_CPUS=2
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EMBEDDED=y
@@ -24,12 +25,13 @@ CONFIG_PS3_DISK=y
 CONFIG_PS3_ROM=y
 CONFIG_PS3_FLASH=y
 CONFIG_PS3_VRAM=m
+CONFIG_PS3_LPM=m
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
-CONFIG_HIGH_RES_TIMERS=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_BINFMT_MISC=y
 CONFIG_KEXEC=y
 # CONFIG_SPARSEMEM_VMEMMAP is not set
+# CONFIG_COMPACTION is not set
 CONFIG_SCHED_SMT=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE=""
@@ -59,6 +61,7 @@ CONFIG_BT_BNEP_PROTO_FILTER=y
 CONFIG_BT_HIDP=m
 CONFIG_BT_HCIBTUSB=m
 CONFIG_CFG80211=m
+CONFIG_CFG80211_WEXT=y
 CONFIG_MAC80211=m
 CONFIG_MAC80211_RC_PID=y
 # CONFIG_MAC80211_RC_MINSTREL is not set
@@ -78,7 +81,6 @@ CONFIG_MD=y
 CONFIG_BLK_DEV_DM=m
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CHELSIO is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 # CONFIG_NET_VENDOR_MICREL is not set
@@ -119,21 +121,21 @@ CONFIG_SND=m
 # CONFIG_SND_DRIVERS is not set
 CONFIG_SND_USB_AUDIO=m
 CONFIG_HIDRAW=y
-CONFIG_USB_HIDDEV=y
 CONFIG_HID_APPLE=m
 CONFIG_HID_BELKIN=m
 CONFIG_HID_CHERRY=m
 CONFIG_HID_EZKEY=m
 CONFIG_HID_TWINHAN=m
 CONFIG_HID_LOGITECH=m
+CONFIG_HID_LOGITECH_DJ=m
 CONFIG_HID_MICROSOFT=m
+CONFIG_HID_PS3REMOTE=m
 CONFIG_HID_SONY=m
 CONFIG_HID_SUNPLUS=m
 CONFIG_HID_SMARTJOYPLUS=m
+CONFIG_USB_HIDDEV=y
 CONFIG_USB=m
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-CONFIG_USB_DEVICEFS=y
-# CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_SUSPEND=y
 CONFIG_USB_MON=m
 CONFIG_USB_EHCI_HCD=m
@@ -158,8 +160,8 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
+CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_CIFS=m
 CONFIG_NLS=y
@@ -176,6 +178,7 @@ CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_WRITECOUNT=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_LIST=y
+CONFIG_RCU_CPU_STALL_TIMEOUT=60
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_CRYPTO_CCM=m
-- 
1.7.9.5
