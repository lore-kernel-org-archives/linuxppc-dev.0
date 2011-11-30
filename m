Return-Path: <geoff@infradead.org>
Message-Id: <984c0b3123dc3d0875f0cbfa9ee49fbbdfb67900.1322615824.git.geoff@infradead.org>
In-Reply-To: <cover.1322615824.git.geoff@infradead.org>
References: <cover.1322615824.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 8/8] powerpc/ps3: Update ps3_defconfig
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 30 Nov 2011 01:38:50 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Refresh ps3_defconfig to latest kernel sources and
change the options:

  CONFIG_PPP=m to CONFIG_PPP=n.
  CONFIG_NAMESPACES=y to CONFIG_NAMESPACES=n
  CONFIG_NUMA=y to CONFIG_NUMA=n

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/configs/ps3_defconfig |   39 ++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index 185c292..ded8678 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -6,10 +6,10 @@ CONFIG_NR_CPUS=2
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_NAMESPACES=y
+CONFIG_SPARSE_IRQ=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_EXPERT=y
-CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EMBEDDED=y
 # CONFIG_PERF_EVENTS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
@@ -17,6 +17,7 @@ CONFIG_PROFILING=y
 CONFIG_OPROFILE=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+# CONFIG_PPC_POWERNV is not set
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_PS3=y
@@ -27,14 +28,14 @@ CONFIG_PS3_VRAM=m
 CONFIG_PS3_LPM=m
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_HIGH_RES_TIMERS=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_BINFMT_MISC=y
 CONFIG_KEXEC=y
-CONFIG_SPARSE_IRQ=y
 # CONFIG_SPARSEMEM_VMEMMAP is not set
 CONFIG_SCHED_SMT=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE=""
-CONFIG_PM=y
+CONFIG_PM_RUNTIME=y
 CONFIG_PM_DEBUG=y
 # CONFIG_SECCOMP is not set
 # CONFIG_PCI is not set
@@ -81,20 +82,23 @@ CONFIG_SCSI_MULTI_LUN=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_DM=m
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CHELSIO is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
 CONFIG_GELIC_NET=y
 CONFIG_GELIC_WIRELESS=y
-# CONFIG_NETDEV_10000 is not set
+# CONFIG_NET_VENDOR_XILINX is not set
 CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_CDCETHER is not set
+# CONFIG_USB_NET_CDC_NCM is not set
 # CONFIG_USB_NET_NET1080 is not set
 # CONFIG_USB_NET_CDC_SUBSET is not set
 # CONFIG_USB_NET_ZAURUS is not set
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPPOE=m
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_JOYDEV=m
@@ -135,22 +139,21 @@ CONFIG_USB=m
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_DEVICE_CLASS is not set
+CONFIG_USB_SUSPEND=y
 CONFIG_USB_MON=m
 CONFIG_USB_EHCI_HCD=m
-CONFIG_USB_EHCI_TT_NEWSCHED=y
 # CONFIG_USB_EHCI_HCD_PPC_OF is not set
 CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_STORAGE=m
 CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_PS3=m
+CONFIG_RTC_DRV_PS3=y
+# CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=m
 CONFIG_EXT3_FS=m
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT4_FS=y
-CONFIG_INOTIFY=y
 CONFIG_QUOTA=y
 CONFIG_QFMT_V2=y
-CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
@@ -167,19 +170,17 @@ CONFIG_CIFS=m
 CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_CRC_CCITT=m
 CONFIG_CRC_T10DIF=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_LOCKDEP=y
-CONFIG_DEBUG_SPINLOCK_SLEEP=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_WRITECOUNT=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_LIST=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
-- 
1.7.0.4
