Return-Path: <geoff@infradead.org>
Message-Id: <c9fc20b63c625d8d5c136f1e72d9930a6b0070df.1421109719.git.geoff@infradead.org>
In-Reply-To: <cover.1421109719.git.geoff@infradead.org>
References: <cover.1421109719.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 6/6] powerpc/ps3: Update ps3_defconfig
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 13 Jan 2015 01:00:20 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Nathan Whitehorn <nwhitehorn@freebsd.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Refresh ps3_defconfig and add CONFIG_PS3_REPOSITORY_WRITE=y.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/configs/ps3_defconfig | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index 2e637c8..9836c1b 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -22,6 +22,8 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_PS3=y
+CONFIG_PS3_ADVANCED=y
+CONFIG_PS3_REPOSITORY_WRITE=y
 CONFIG_PS3_DISK=y
 CONFIG_PS3_ROM=y
 CONFIG_PS3_FLASH=y
@@ -64,11 +66,9 @@ CONFIG_BT_HCIBTUSB=m
 CONFIG_CFG80211=m
 CONFIG_CFG80211_WEXT=y
 CONFIG_MAC80211=m
-CONFIG_MAC80211_RC_PID=y
 # CONFIG_MAC80211_RC_MINSTREL is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FIRMWARE_IN_KERNEL is not set
-CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65535
@@ -76,7 +76,6 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_MULTI_LUN=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_MD=y
 CONFIG_BLK_DEV_DM=m
@@ -107,7 +106,6 @@ CONFIG_INPUT_EVDEV=m
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
 CONFIG_FB_PS3=y
 # CONFIG_VGA_CONSOLE is not set
@@ -130,8 +128,6 @@ CONFIG_HID_TWINHAN=m
 CONFIG_HID_LOGITECH=m
 CONFIG_HID_LOGITECH_DJ=m
 CONFIG_HID_MICROSOFT=m
-CONFIG_HID_PS3REMOTE=m
-CONFIG_HID_SONY=m
 CONFIG_HID_SUNPLUS=m
 CONFIG_HID_SMARTJOYPLUS=m
 CONFIG_USB_HIDDEV=y
@@ -169,18 +165,17 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_CRC_CCITT=m
 CONFIG_CRC_T10DIF=y
-CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_LOCKDEP=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_LIST=y
 CONFIG_RCU_CPU_STALL_TIMEOUT=60
 # CONFIG_FTRACE is not set
-CONFIG_DEBUG_STACKOVERFLOW=y
-CONFIG_CRYPTO_CCM=m
 CONFIG_CRYPTO_GCM=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-- 
1.9.1
