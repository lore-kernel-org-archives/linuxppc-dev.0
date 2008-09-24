Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71C63DDE11
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 14:36:21 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m8O4aHUm028022
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 23:36:18 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/86xx: Introduce a generic mpc86xx_defconfig
Date: Tue, 23 Sep 2008 23:36:17 -0500
Message-Id: <1222230977-24350-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Introduced a mpc86xx_defconfig that enables all 86xx boards and moved
all other 86xx related defconfigs under configs/86xx to match 83xx
and 85xx.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 .../configs/{ => 86xx}/mpc8610_hpcd_defconfig      |    0 
 .../configs/{ => 86xx}/mpc8641_hpcn_defconfig      |    0 
 arch/powerpc/configs/{ => 86xx}/sbc8641d_defconfig |    0 
 .../{mpc8641_hpcn_defconfig => mpc86xx_defconfig}  |   44 +++++--------------
 4 files changed, 12 insertions(+), 32 deletions(-)
 rename arch/powerpc/configs/{ => 86xx}/mpc8610_hpcd_defconfig (100%)
 copy arch/powerpc/configs/{ => 86xx}/mpc8641_hpcn_defconfig (100%)
 rename arch/powerpc/configs/{ => 86xx}/sbc8641d_defconfig (100%)
 rename arch/powerpc/configs/{mpc8641_hpcn_defconfig => mpc86xx_defconfig} (97%)

diff --git a/arch/powerpc/configs/mpc8610_hpcd_defconfig b/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc8610_hpcd_defconfig
rename to arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
diff --git a/arch/powerpc/configs/mpc8641_hpcn_defconfig b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
similarity index 100%
copy from arch/powerpc/configs/mpc8641_hpcn_defconfig
copy to arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
diff --git a/arch/powerpc/configs/sbc8641d_defconfig b/arch/powerpc/configs/86xx/sbc8641d_defconfig
similarity index 100%
rename from arch/powerpc/configs/sbc8641d_defconfig
rename to arch/powerpc/configs/86xx/sbc8641d_defconfig
diff --git a/arch/powerpc/configs/mpc8641_hpcn_defconfig b/arch/powerpc/configs/mpc86xx_defconfig
similarity index 97%
rename from arch/powerpc/configs/mpc8641_hpcn_defconfig
rename to arch/powerpc/configs/mpc86xx_defconfig
index ea09be3..9d4be82 100644
--- a/arch/powerpc/configs/mpc8641_hpcn_defconfig
+++ b/arch/powerpc/configs/mpc86xx_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.27-rc4
-# Thu Aug 21 00:52:11 2008
+# Linux kernel version: 2.6.27-rc5
+# Tue Sep 23 23:28:38 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -100,7 +100,6 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
-CONFIG_PCSPKR_PLATFORM=y
 CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
@@ -161,17 +160,18 @@ CONFIG_DEFAULT_CFQ=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="cfq"
 CONFIG_CLASSIC_RCU=y
+# CONFIG_MPC8xxx_GPIO is not set
 
 #
 # Platform support
 #
 CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_CLASSIC32=y
-CONFIG_PPC_CHRP=y
+# CONFIG_PPC_CHRP is not set
 # CONFIG_MPC5121_ADS is not set
 # CONFIG_MPC5121_GENERIC is not set
 # CONFIG_PPC_MPC52xx is not set
-CONFIG_PPC_PMAC=y
+# CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_82xx is not set
@@ -179,25 +179,22 @@ CONFIG_PPC_PMAC=y
 # CONFIG_PPC_83xx is not set
 CONFIG_PPC_86xx=y
 CONFIG_MPC8641_HPCN=y
-# CONFIG_SBC8641D is not set
-# CONFIG_MPC8610_HPCD is not set
+CONFIG_SBC8641D=y
+CONFIG_MPC8610_HPCD=y
+CONFIG_GEF_SBC610=y
 CONFIG_MPC8641=y
-CONFIG_PPC_NATIVE=y
-# CONFIG_UDBG_RTAS_CONSOLE is not set
+CONFIG_MPC8610=y
 # CONFIG_IPIC is not set
 CONFIG_MPIC=y
 # CONFIG_MPIC_WEIRD is not set
 CONFIG_PPC_I8259=y
-CONFIG_PPC_RTAS=y
-# CONFIG_RTAS_ERROR_LOGGING is not set
-CONFIG_RTAS_PROC=y
+# CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
-CONFIG_PPC_MPC106=y
+# CONFIG_PPC_MPC106 is not set
 # CONFIG_PPC_970_NAP is not set
 # CONFIG_PPC_INDIRECT_IO is not set
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
-# CONFIG_PPC601_SYNC_FIX is not set
 # CONFIG_TAU is not set
 CONFIG_FSL_ULI1575=y
 
@@ -221,7 +218,6 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=m
 # CONFIG_IOMMU_HELPER is not set
-# CONFIG_HOTPLUG_CPU is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_HAS_WALK_MEMORY=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
@@ -255,7 +251,6 @@ CONFIG_ISA_DMA_API=y
 #
 # Bus options
 #
-# CONFIG_ISA is not set
 CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PPC_INDIRECT_PCI=y
@@ -425,7 +420,6 @@ CONFIG_OF_I2C=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_FD is not set
-# CONFIG_MAC_FLOPPY is not set
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
@@ -528,8 +522,6 @@ CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
-# CONFIG_SCSI_MESH is not set
-# CONFIG_SCSI_MAC53C94 is not set
 # CONFIG_SCSI_SRP is not set
 # CONFIG_SCSI_DH is not set
 CONFIG_ATA=y
@@ -634,8 +626,6 @@ CONFIG_VITESSE_PHY=y
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
-# CONFIG_MACE is not set
-# CONFIG_BMAC is not set
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
@@ -781,14 +771,11 @@ CONFIG_SERIAL_8250_RSA=y
 # CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_SERIAL_PMACZILOG is not set
 # CONFIG_SERIAL_JSM is not set
 # CONFIG_SERIAL_OF_PLATFORM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-# CONFIG_BRIQ_PANEL is not set
-# CONFIG_HVC_RTAS is not set
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_NVRAM=y
@@ -825,12 +812,6 @@ CONFIG_I2C_HELPER_AUTO=y
 # CONFIG_I2C_VIAPRO is not set
 
 #
-# Mac SMBus host controller drivers
-#
-# CONFIG_I2C_HYDRA is not set
-CONFIG_I2C_POWERMAC=y
-
-#
 # I2C system bus drivers (mostly embedded / system-on-chip)
 #
 CONFIG_I2C_MPC=y
@@ -1135,8 +1116,6 @@ CONFIG_SND_INTEL8X0=y
 # CONFIG_SND_VX222 is not set
 # CONFIG_SND_YMFPCI is not set
 CONFIG_SND_PPC=y
-# CONFIG_SND_POWERMAC is not set
-# CONFIG_SND_AOA is not set
 CONFIG_SND_USB=y
 # CONFIG_SND_USB_AUDIO is not set
 # CONFIG_SND_USB_USX2Y is not set
@@ -1567,6 +1546,7 @@ CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_CODE_PATCHING_SELFTEST is not set
 # CONFIG_FTR_FIXUP_SELFTEST is not set
+# CONFIG_MSI_BITMAP_SELFTEST is not set
 # CONFIG_XMON is not set
 # CONFIG_IRQSTACKS is not set
 # CONFIG_BDI_SWITCH is not set
-- 
1.5.5.1
