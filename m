Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 54839B71CC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 07:51:35 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/13] powerpc: Update mpc85xx/corenet 32-bit defconfigs
Date: Mon, 10 Oct 2011 15:50:45 -0500
Message-Id: <13182798883685-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <1318279885811-git-send-email-beckyb@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
 <13182798681100-git-send-email-beckyb@kernel.crashing.org>
 <1318279870278-git-send-email-beckyb@kernel.crashing.org>
 <13182798731357-git-send-email-beckyb@kernel.crashing.org>
 <13182798761457-git-send-email-beckyb@kernel.crashing.org>
 <13182798791090-git-send-email-beckyb@kernel.crashing.org>
 <1318279883564-git-send-email-beckyb@kernel.crashing.org>
 <1318279885811-git-send-email-beckyb@kernel.crashing.org>
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

Results from updates via make savedefconfig.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/configs/corenet32_smp_defconfig |    8 --------
 arch/powerpc/configs/mpc85xx_defconfig       |    5 +----
 arch/powerpc/configs/mpc85xx_smp_defconfig   |    6 +-----
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 4311d02..ab4db40 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -12,9 +12,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_KALLSYMS_ALL=y
-CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
@@ -69,7 +67,6 @@ CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
@@ -107,7 +104,6 @@ CONFIG_FSL_PQ_MDIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_LEGACY_PTYS is not set
-CONFIG_PPC_EPAPR_HV_BYTECHAN=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_EXTENDED=y
@@ -136,8 +132,6 @@ CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_OF=y
-CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_MPC85XX=y
@@ -146,7 +140,6 @@ CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_UIO=y
 CONFIG_STAGING=y
-# CONFIG_STAGING_EXCLUDE_BUILD is not set
 CONFIG_VIRT_DRIVERS=y
 CONFIG_FSL_HV_MANAGER=y
 CONFIG_EXT2_FS=y
@@ -173,7 +166,6 @@ CONFIG_MAC_PARTITION=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=m
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_INFO=y
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 2500912..a1e5a17 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -10,10 +10,8 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
-CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
@@ -41,7 +39,6 @@ CONFIG_TQM8560=y
 CONFIG_SBC8548=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
-CONFIG_GPIO_MPC8XXX=y
 CONFIG_HIGHMEM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -123,6 +120,7 @@ CONFIG_NVRAM=y
 CONFIG_I2C=y
 CONFIG_I2C_CPM=m
 CONFIG_I2C_MPC=y
+CONFIG_GPIO_MPC8XXX=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=y
 CONFIG_FB=y
@@ -206,7 +204,6 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
 CONFIG_CRC_T10DIF=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_INFO=y
 CONFIG_SYSCTL_SYSCALL_CHECK=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index a4ba13b..dd1e413 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -12,10 +12,8 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
-CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
@@ -42,7 +40,6 @@ CONFIG_TQM8560=y
 CONFIG_SBC8548=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
-CONFIG_GPIO_MPC8XXX=y
 CONFIG_HIGHMEM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -124,6 +121,7 @@ CONFIG_NVRAM=y
 CONFIG_I2C=y
 CONFIG_I2C_CPM=m
 CONFIG_I2C_MPC=y
+CONFIG_GPIO_MPC8XXX=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=y
 CONFIG_FB=y
@@ -207,10 +205,8 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
 CONFIG_CRC_T10DIF=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_VIRQ_DEBUG=y
 CONFIG_CRYPTO_PCBC=m
-- 
1.5.6.5
