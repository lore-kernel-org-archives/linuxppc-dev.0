Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by ozlabs.org (Postfix) with ESMTP id 7BA86B7D29
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Jun 2010 07:19:42 +1000 (EST)
Received: by pva4 with SMTP id 4so313380pva.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 03 Jun 2010 14:19:41 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH] powerpc/5200: Update defconfigs
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 03 Jun 2010 15:17:55 -0600
Message-ID: <20100603211755.7822.66.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: linuxppc-dev@lists.ozlabs.org
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/configs/52xx/cm5200_defconfig    |   45 +++--
 arch/powerpc/configs/52xx/lite5200b_defconfig |  109 +++++++++----
 arch/powerpc/configs/52xx/motionpro_defconfig |   76 ++++++---
 arch/powerpc/configs/52xx/pcm030_defconfig    |  108 ++++++++----
 arch/powerpc/configs/52xx/tqm5200_defconfig   |   75 ++++++---
 arch/powerpc/configs/mpc5200_defconfig        |  217 ++++++++++++++++---------
 6 files changed, 421 insertions(+), 209 deletions(-)

diff --git a/arch/powerpc/configs/52xx/cm5200_defconfig b/arch/powerpc/configs/52xx/cm5200_defconfig
index 218d49b..70fdf88 100644
--- a/arch/powerpc/configs/52xx/cm5200_defconfig
+++ b/arch/powerpc/configs/52xx/cm5200_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.34-rc1
-# Wed Mar 10 14:34:22 2010
+# Linux kernel version: 2.6.35-rc1
+# Thu Jun  3 08:28:02 2010
 #
 # CONFIG_PPC64 is not set
 
@@ -72,6 +72,7 @@ CONFIG_CONSTRUCTORS=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
@@ -144,6 +145,7 @@ CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
 CONFIG_HAVE_DMA_ATTRS=y
+CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
 CONFIG_HAVE_CLK=y
 CONFIG_HAVE_DMA_API_DEBUG=y
 
@@ -308,6 +310,8 @@ CONFIG_ISA_DMA_API=y
 # Bus options
 #
 CONFIG_ZONE_DMA=y
+# CONFIG_NEED_DMA_MAP_STATE is not set
+CONFIG_NEED_SG_DMA_LENGTH=y
 CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PPC_PCI_CHOICE=y
 # CONFIG_PCI is not set
@@ -379,6 +383,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
+# CONFIG_L2TP is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
@@ -411,9 +416,14 @@ CONFIG_WIRELESS=y
 #
 # CFG80211 needs to be enabled for MAC80211
 #
+
+#
+# Some wireless drivers require a rate control algorithm
+#
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
 
 #
 # Device Drivers
@@ -451,6 +461,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_SM_FTL is not set
 # CONFIG_MTD_OOPS is not set
 
 #
@@ -543,6 +554,7 @@ CONFIG_HAVE_IDE=y
 #
 # SCSI device support
 #
+CONFIG_SCSI_MOD=y
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
 CONFIG_SCSI_DMA=y
@@ -603,6 +615,7 @@ CONFIG_LXT_PHY=y
 # CONFIG_NATIONAL_PHY is not set
 # CONFIG_STE10XP is not set
 # CONFIG_LSI_ET1011C_PHY is not set
+# CONFIG_MICREL_PHY is not set
 # CONFIG_FIXED_PHY is not set
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
@@ -640,6 +653,7 @@ CONFIG_WLAN=y
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
 # CONFIG_USB_USBNET is not set
+# CONFIG_USB_IPHETH is not set
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
@@ -666,6 +680,7 @@ CONFIG_WLAN=y
 # CONFIG_VT is not set
 CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_N_GSM is not set
 
 #
 # Serial drivers
@@ -683,6 +698,8 @@ CONFIG_SERIAL_MPC52xx_CONSOLE=y
 CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=57600
 # CONFIG_SERIAL_TIMBERDALE is not set
 # CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
@@ -695,6 +712,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
+# CONFIG_RAMOOPS is not set
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_COMPAT=y
@@ -725,15 +743,9 @@ CONFIG_I2C_MPC=y
 # Other I2C/SMBus bus drivers
 #
 # CONFIG_I2C_PCA_PLATFORM is not set
-
-#
-# Miscellaneous I2C Chip support
-#
-# CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
 
 #
@@ -753,7 +765,6 @@ CONFIG_WATCHDOG=y
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
-# CONFIG_MAX63XX_WATCHDOG is not set
 # CONFIG_MPC5200_WDT is not set
 
 #
@@ -766,15 +777,14 @@ CONFIG_SSB_POSSIBLE=y
 # Sonics Silicon Backplane
 #
 # CONFIG_SSB is not set
-
-#
-# Multifunction device drivers
-#
+CONFIG_MFD_SUPPORT=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_88PM860X is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_TPS6507X is not set
 # CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TC35892 is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_PMIC_DA903X is not set
 # CONFIG_PMIC_ADP5520 is not set
@@ -784,7 +794,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_WM8350_I2C is not set
 # CONFIG_MFD_WM8994 is not set
 # CONFIG_MFD_PCF50633 is not set
-# CONFIG_AB3100_CORE is not set
+# CONFIG_ABX500_CORE is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
@@ -815,7 +825,6 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_DEVICE_CLASS is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_OTG is not set
 # CONFIG_USB_OTG_WHITELIST is not set
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
 # CONFIG_USB_MON is not set
@@ -918,10 +927,6 @@ CONFIG_USB_STORAGE=y
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
-
-#
-# TI VLYNQ
-#
 # CONFIG_STAGING is not set
 
 #
@@ -1035,6 +1040,7 @@ CONFIG_SUNRPC_GSS=y
 CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
+# CONFIG_CEPH_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1200,6 +1206,7 @@ CONFIG_BRANCH_PROFILE_NONE=y
 # CONFIG_WORKQUEUE_TRACER is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_DMA_API_DEBUG is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
diff --git a/arch/powerpc/configs/52xx/lite5200b_defconfig b/arch/powerpc/configs/52xx/lite5200b_defconfig
index 90492ff..84636bc 100644
--- a/arch/powerpc/configs/52xx/lite5200b_defconfig
+++ b/arch/powerpc/configs/52xx/lite5200b_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.34-rc1
-# Wed Mar 10 14:34:24 2010
+# Linux kernel version: 2.6.35-rc1
+# Thu Jun  3 08:28:04 2010
 #
 # CONFIG_PPC64 is not set
 
@@ -73,6 +73,7 @@ CONFIG_CONSTRUCTORS=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
@@ -146,6 +147,7 @@ CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
 CONFIG_HAVE_DMA_ATTRS=y
+CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
 CONFIG_HAVE_CLK=y
 CONFIG_HAVE_DMA_API_DEBUG=y
 
@@ -321,6 +323,8 @@ CONFIG_ISA_DMA_API=y
 # Bus options
 #
 CONFIG_ZONE_DMA=y
+# CONFIG_NEED_DMA_MAP_STATE is not set
+CONFIG_NEED_SG_DMA_LENGTH=y
 CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PPC_PCI_CHOICE=y
@@ -399,6 +403,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
+# CONFIG_L2TP is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
@@ -431,9 +436,14 @@ CONFIG_WIRELESS=y
 #
 # CFG80211 needs to be enabled for MAC80211
 #
+
+#
+# Some wireless drivers require a rate control algorithm
+#
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
 
 #
 # Device Drivers
@@ -489,6 +499,7 @@ CONFIG_MISC_DEVICES=y
 # CONFIG_ENCLOSURE_SERVICES is not set
 # CONFIG_HP_ILO is not set
 # CONFIG_ISL29003 is not set
+# CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_DS1682 is not set
 # CONFIG_C2PORT is not set
 
@@ -506,6 +517,7 @@ CONFIG_HAVE_IDE=y
 #
 # SCSI device support
 #
+CONFIG_SCSI_MOD=y
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
 CONFIG_SCSI_DMA=y
@@ -592,68 +604,94 @@ CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
 CONFIG_ATA_VERBOSE_ERROR=y
 CONFIG_SATA_PMP=y
+
+#
+# Controllers with non-SFF native interface
+#
 # CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_AHCI_PLATFORM is not set
+# CONFIG_SATA_INIC162X is not set
 # CONFIG_SATA_SIL24 is not set
 CONFIG_ATA_SFF=y
-# CONFIG_SATA_SVW is not set
+
+#
+# SFF controllers with custom DMA interface
+#
+# CONFIG_PDC_ADMA is not set
+CONFIG_PATA_MPC52xx=y
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_SX4 is not set
+CONFIG_ATA_BMDMA=y
+
+#
+# SATA SFF controllers with BMDMA
+#
 # CONFIG_ATA_PIIX is not set
 # CONFIG_SATA_MV is not set
 # CONFIG_SATA_NV is not set
-# CONFIG_PDC_ADMA is not set
-# CONFIG_SATA_QSTOR is not set
 # CONFIG_SATA_PROMISE is not set
-# CONFIG_SATA_SX4 is not set
 # CONFIG_SATA_SIL is not set
 # CONFIG_SATA_SIS is not set
+# CONFIG_SATA_SVW is not set
 # CONFIG_SATA_ULI is not set
 # CONFIG_SATA_VIA is not set
 # CONFIG_SATA_VITESSE is not set
-# CONFIG_SATA_INIC162X is not set
+
+#
+# PATA SFF controllers with BMDMA
+#
 # CONFIG_PATA_ALI is not set
 # CONFIG_PATA_AMD is not set
 # CONFIG_PATA_ARTOP is not set
-# CONFIG_PATA_ATP867X is not set
 # CONFIG_PATA_ATIIXP is not set
-# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_ATP867X is not set
 # CONFIG_PATA_CMD64X is not set
 # CONFIG_PATA_CS5520 is not set
 # CONFIG_PATA_CS5530 is not set
 # CONFIG_PATA_CYPRESS is not set
 # CONFIG_PATA_EFAR is not set
-# CONFIG_ATA_GENERIC is not set
 # CONFIG_PATA_HPT366 is not set
 # CONFIG_PATA_HPT37X is not set
 # CONFIG_PATA_HPT3X2N is not set
 # CONFIG_PATA_HPT3X3 is not set
-# CONFIG_PATA_IT821X is not set
 # CONFIG_PATA_IT8213 is not set
+# CONFIG_PATA_IT821X is not set
 # CONFIG_PATA_JMICRON is not set
-# CONFIG_PATA_LEGACY is not set
-# CONFIG_PATA_TRIFLEX is not set
 # CONFIG_PATA_MARVELL is not set
-CONFIG_PATA_MPC52xx=y
-# CONFIG_PATA_MPIIX is not set
-# CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_NETCELL is not set
 # CONFIG_PATA_NINJA32 is not set
-# CONFIG_PATA_NS87410 is not set
 # CONFIG_PATA_NS87415 is not set
-# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_OPTIDMA is not set
 # CONFIG_PATA_PDC2027X is not set
 # CONFIG_PATA_PDC_OLD is not set
 # CONFIG_PATA_RADISYS is not set
 # CONFIG_PATA_RDC is not set
-# CONFIG_PATA_RZ1000 is not set
 # CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SCH is not set
 # CONFIG_PATA_SERVERWORKS is not set
 # CONFIG_PATA_SIL680 is not set
 # CONFIG_PATA_SIS is not set
 # CONFIG_PATA_TOSHIBA is not set
+# CONFIG_PATA_TRIFLEX is not set
 # CONFIG_PATA_VIA is not set
 # CONFIG_PATA_WINBOND is not set
+
+#
+# PIO-only SFF controllers
+#
+# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_OPTI is not set
 # CONFIG_PATA_PLATFORM is not set
-# CONFIG_PATA_SCH is not set
+# CONFIG_PATA_RZ1000 is not set
+
+#
+# Generic fallback / legacy drivers
+#
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_LEGACY is not set
 # CONFIG_MD is not set
 # CONFIG_FUSION is not set
 
@@ -698,6 +736,7 @@ CONFIG_LXT_PHY=y
 # CONFIG_NATIONAL_PHY is not set
 # CONFIG_STE10XP is not set
 # CONFIG_LSI_ET1011C_PHY is not set
+# CONFIG_MICREL_PHY is not set
 # CONFIG_FIXED_PHY is not set
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
@@ -745,6 +784,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_BNX2 is not set
 # CONFIG_CNIC is not set
 # CONFIG_MV643XX_ETH is not set
+# CONFIG_XILINX_LL_TEMAC is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 # CONFIG_ATL1E is not set
@@ -754,6 +794,8 @@ CONFIG_NETDEV_10000=y
 # CONFIG_CHELSIO_T1 is not set
 CONFIG_CHELSIO_T3_DEPENDS=y
 # CONFIG_CHELSIO_T3 is not set
+CONFIG_CHELSIO_T4_DEPENDS=y
+# CONFIG_CHELSIO_T4 is not set
 # CONFIG_ENIC is not set
 # CONFIG_IXGBE is not set
 # CONFIG_IXGB is not set
@@ -810,6 +852,7 @@ CONFIG_WLAN=y
 # CONFIG_VT is not set
 CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_N_GSM is not set
 # CONFIG_NOZOMI is not set
 
 #
@@ -829,6 +872,8 @@ CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=115200
 # CONFIG_SERIAL_JSM is not set
 # CONFIG_SERIAL_TIMBERDALE is not set
 # CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
@@ -844,6 +889,7 @@ CONFIG_GEN_RTC=y
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
+# CONFIG_RAMOOPS is not set
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_COMPAT=y
@@ -892,15 +938,9 @@ CONFIG_I2C_MPC=y
 #
 # CONFIG_I2C_PCA_PLATFORM is not set
 # CONFIG_I2C_STUB is not set
-
-#
-# Miscellaneous I2C Chip support
-#
-# CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
 
 #
@@ -920,15 +960,14 @@ CONFIG_SSB_POSSIBLE=y
 # Sonics Silicon Backplane
 #
 # CONFIG_SSB is not set
-
-#
-# Multifunction device drivers
-#
+CONFIG_MFD_SUPPORT=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_88PM860X is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_TPS6507X is not set
 # CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TC35892 is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_PMIC_DA903X is not set
 # CONFIG_PMIC_ADP5520 is not set
@@ -938,8 +977,10 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_WM8350_I2C is not set
 # CONFIG_MFD_WM8994 is not set
 # CONFIG_MFD_PCF50633 is not set
-# CONFIG_AB3100_CORE is not set
+# CONFIG_ABX500_CORE is not set
 # CONFIG_LPC_SCH is not set
+# CONFIG_MFD_RDC321X is not set
+# CONFIG_MFD_JANZ_CMODIO is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
@@ -991,10 +1032,6 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
-
-#
-# TI VLYNQ
-#
 # CONFIG_STAGING is not set
 
 #
@@ -1094,6 +1131,7 @@ CONFIG_SUNRPC_GSS=y
 CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
+# CONFIG_CEPH_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1203,6 +1241,7 @@ CONFIG_BRANCH_PROFILE_NONE=y
 # CONFIG_WORKQUEUE_TRACER is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_DMA_API_DEBUG is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
diff --git a/arch/powerpc/configs/52xx/motionpro_defconfig b/arch/powerpc/configs/52xx/motionpro_defconfig
index dffc8ca..0dc23db 100644
--- a/arch/powerpc/configs/52xx/motionpro_defconfig
+++ b/arch/powerpc/configs/52xx/motionpro_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.34-rc1
-# Wed Mar 10 14:34:23 2010
+# Linux kernel version: 2.6.35-rc1
+# Thu Jun  3 08:28:03 2010
 #
 # CONFIG_PPC64 is not set
 
@@ -72,6 +72,7 @@ CONFIG_CONSTRUCTORS=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
@@ -144,6 +145,7 @@ CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
 CONFIG_HAVE_DMA_ATTRS=y
+CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
 CONFIG_HAVE_CLK=y
 CONFIG_HAVE_DMA_API_DEBUG=y
 
@@ -309,6 +311,8 @@ CONFIG_ISA_DMA_API=y
 # Bus options
 #
 CONFIG_ZONE_DMA=y
+# CONFIG_NEED_DMA_MAP_STATE is not set
+CONFIG_NEED_SG_DMA_LENGTH=y
 CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PPC_PCI_CHOICE=y
 # CONFIG_PCI is not set
@@ -380,6 +384,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
+# CONFIG_L2TP is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
@@ -412,9 +417,14 @@ CONFIG_WIRELESS=y
 #
 # CFG80211 needs to be enabled for MAC80211
 #
+
+#
+# Some wireless drivers require a rate control algorithm
+#
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
 
 #
 # Device Drivers
@@ -452,6 +462,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_SM_FTL is not set
 # CONFIG_MTD_OOPS is not set
 
 #
@@ -541,6 +552,7 @@ CONFIG_MISC_DEVICES=y
 # CONFIG_ICS932S401 is not set
 # CONFIG_ENCLOSURE_SERVICES is not set
 # CONFIG_ISL29003 is not set
+# CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_DS1682 is not set
 # CONFIG_C2PORT is not set
 
@@ -557,6 +569,7 @@ CONFIG_HAVE_IDE=y
 #
 # SCSI device support
 #
+CONFIG_SCSI_MOD=y
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
 CONFIG_SCSI_DMA=y
@@ -597,10 +610,36 @@ CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
 CONFIG_ATA_VERBOSE_ERROR=y
 CONFIG_SATA_PMP=y
+
+#
+# Controllers with non-SFF native interface
+#
+# CONFIG_SATA_AHCI_PLATFORM is not set
 CONFIG_ATA_SFF=y
-# CONFIG_SATA_MV is not set
+
+#
+# SFF controllers with custom DMA interface
+#
 CONFIG_PATA_MPC52xx=y
+CONFIG_ATA_BMDMA=y
+
+#
+# SATA SFF controllers with BMDMA
+#
+# CONFIG_SATA_MV is not set
+
+#
+# PATA SFF controllers with BMDMA
+#
+
+#
+# PIO-only SFF controllers
+#
 # CONFIG_PATA_PLATFORM is not set
+
+#
+# Generic fallback / legacy drivers
+#
 # CONFIG_MD is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
@@ -628,6 +667,7 @@ CONFIG_ICPLUS_PHY=y
 # CONFIG_NATIONAL_PHY is not set
 # CONFIG_STE10XP is not set
 # CONFIG_LSI_ET1011C_PHY is not set
+# CONFIG_MICREL_PHY is not set
 # CONFIG_FIXED_PHY is not set
 CONFIG_MDIO_BITBANG=y
 CONFIG_NET_ETHERNET=y
@@ -681,6 +721,7 @@ CONFIG_WLAN=y
 # CONFIG_VT is not set
 CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_N_GSM is not set
 
 #
 # Serial drivers
@@ -698,6 +739,8 @@ CONFIG_SERIAL_MPC52xx_CONSOLE=y
 CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=115200
 # CONFIG_SERIAL_TIMBERDALE is not set
 # CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
@@ -709,6 +752,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
+# CONFIG_RAMOOPS is not set
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_COMPAT=y
@@ -738,15 +782,9 @@ CONFIG_I2C_MPC=y
 # Other I2C/SMBus bus drivers
 #
 # CONFIG_I2C_PCA_PLATFORM is not set
-
-#
-# Miscellaneous I2C Chip support
-#
-# CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
 
 #
@@ -807,12 +845,14 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_PC87427 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_SENSORS_DME1737 is not set
+# CONFIG_SENSORS_EMC1403 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
 # CONFIG_SENSORS_SMSC47M192 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_ADS7828 is not set
 # CONFIG_SENSORS_AMC6821 is not set
 # CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_TMP102 is not set
 # CONFIG_SENSORS_TMP401 is not set
 # CONFIG_SENSORS_TMP421 is not set
 # CONFIG_SENSORS_VT1211 is not set
@@ -832,7 +872,6 @@ CONFIG_WATCHDOG=y
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
-# CONFIG_MAX63XX_WATCHDOG is not set
 # CONFIG_MPC5200_WDT is not set
 CONFIG_SSB_POSSIBLE=y
 
@@ -840,15 +879,14 @@ CONFIG_SSB_POSSIBLE=y
 # Sonics Silicon Backplane
 #
 # CONFIG_SSB is not set
-
-#
-# Multifunction device drivers
-#
+CONFIG_MFD_SUPPORT=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_88PM860X is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_TPS6507X is not set
 # CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TC35892 is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_PMIC_DA903X is not set
 # CONFIG_PMIC_ADP5520 is not set
@@ -858,7 +896,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_WM8350_I2C is not set
 # CONFIG_MFD_WM8994 is not set
 # CONFIG_MFD_PCF50633 is not set
-# CONFIG_AB3100_CORE is not set
+# CONFIG_ABX500_CORE is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
@@ -887,11 +925,11 @@ CONFIG_LEDS_CLASS=y
 # CONFIG_LEDS_LP3944 is not set
 # CONFIG_LEDS_PCA955X is not set
 # CONFIG_LEDS_BD2802 is not set
+CONFIG_LEDS_TRIGGERS=y
 
 #
 # LED Triggers
 #
-CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 # CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
 # CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
@@ -964,10 +1002,6 @@ CONFIG_RTC_DRV_DS1307=y
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
-
-#
-# TI VLYNQ
-#
 # CONFIG_STAGING is not set
 
 #
@@ -1081,6 +1115,7 @@ CONFIG_SUNRPC_GSS=y
 CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
+# CONFIG_CEPH_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1246,6 +1281,7 @@ CONFIG_BRANCH_PROFILE_NONE=y
 # CONFIG_WORKQUEUE_TRACER is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_DMA_API_DEBUG is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
diff --git a/arch/powerpc/configs/52xx/pcm030_defconfig b/arch/powerpc/configs/52xx/pcm030_defconfig
index 3cb2a52..0ace2d6 100644
--- a/arch/powerpc/configs/52xx/pcm030_defconfig
+++ b/arch/powerpc/configs/52xx/pcm030_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.34-rc1
-# Wed Mar 10 14:34:25 2010
+# Linux kernel version: 2.6.35-rc1
+# Thu Jun  3 08:28:05 2010
 #
 # CONFIG_PPC64 is not set
 
@@ -73,6 +73,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
 CONFIG_LOCALVERSION="trunk"
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
@@ -144,6 +145,7 @@ CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
 CONFIG_HAVE_DMA_ATTRS=y
+CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
 CONFIG_HAVE_CLK=y
 CONFIG_HAVE_DMA_API_DEBUG=y
 
@@ -312,6 +314,8 @@ CONFIG_ISA_DMA_API=y
 # Bus options
 #
 CONFIG_ZONE_DMA=y
+# CONFIG_NEED_DMA_MAP_STATE is not set
+CONFIG_NEED_SG_DMA_LENGTH=y
 CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PPC_PCI_CHOICE=y
@@ -383,6 +387,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
+# CONFIG_L2TP is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
@@ -415,9 +420,14 @@ CONFIG_WIRELESS=y
 #
 # CFG80211 needs to be enabled for MAC80211
 #
+
+#
+# Some wireless drivers require a rate control algorithm
+#
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
 
 #
 # Device Drivers
@@ -454,6 +464,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_SM_FTL is not set
 # CONFIG_MTD_OOPS is not set
 
 #
@@ -532,6 +543,7 @@ CONFIG_HAVE_IDE=y
 #
 # SCSI device support
 #
+CONFIG_SCSI_MOD=m
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=m
 CONFIG_SCSI_DMA=y
@@ -569,68 +581,94 @@ CONFIG_ATA=m
 # CONFIG_ATA_NONSTANDARD is not set
 CONFIG_ATA_VERBOSE_ERROR=y
 CONFIG_SATA_PMP=y
+
+#
+# Controllers with non-SFF native interface
+#
 # CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_AHCI_PLATFORM is not set
+# CONFIG_SATA_INIC162X is not set
 # CONFIG_SATA_SIL24 is not set
 CONFIG_ATA_SFF=y
-# CONFIG_SATA_SVW is not set
+
+#
+# SFF controllers with custom DMA interface
+#
+# CONFIG_PDC_ADMA is not set
+CONFIG_PATA_MPC52xx=m
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_SX4 is not set
+CONFIG_ATA_BMDMA=y
+
+#
+# SATA SFF controllers with BMDMA
+#
 # CONFIG_ATA_PIIX is not set
 # CONFIG_SATA_MV is not set
 # CONFIG_SATA_NV is not set
-# CONFIG_PDC_ADMA is not set
-# CONFIG_SATA_QSTOR is not set
 # CONFIG_SATA_PROMISE is not set
-# CONFIG_SATA_SX4 is not set
 # CONFIG_SATA_SIL is not set
 # CONFIG_SATA_SIS is not set
+# CONFIG_SATA_SVW is not set
 # CONFIG_SATA_ULI is not set
 # CONFIG_SATA_VIA is not set
 # CONFIG_SATA_VITESSE is not set
-# CONFIG_SATA_INIC162X is not set
+
+#
+# PATA SFF controllers with BMDMA
+#
 # CONFIG_PATA_ALI is not set
 # CONFIG_PATA_AMD is not set
 # CONFIG_PATA_ARTOP is not set
-# CONFIG_PATA_ATP867X is not set
 # CONFIG_PATA_ATIIXP is not set
-# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_ATP867X is not set
 # CONFIG_PATA_CMD64X is not set
 # CONFIG_PATA_CS5520 is not set
 # CONFIG_PATA_CS5530 is not set
 # CONFIG_PATA_CYPRESS is not set
 # CONFIG_PATA_EFAR is not set
-# CONFIG_ATA_GENERIC is not set
 # CONFIG_PATA_HPT366 is not set
 # CONFIG_PATA_HPT37X is not set
 # CONFIG_PATA_HPT3X2N is not set
 # CONFIG_PATA_HPT3X3 is not set
-# CONFIG_PATA_IT821X is not set
 # CONFIG_PATA_IT8213 is not set
+# CONFIG_PATA_IT821X is not set
 # CONFIG_PATA_JMICRON is not set
-# CONFIG_PATA_LEGACY is not set
-# CONFIG_PATA_TRIFLEX is not set
 # CONFIG_PATA_MARVELL is not set
-CONFIG_PATA_MPC52xx=m
-# CONFIG_PATA_MPIIX is not set
-# CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_NETCELL is not set
 # CONFIG_PATA_NINJA32 is not set
-# CONFIG_PATA_NS87410 is not set
 # CONFIG_PATA_NS87415 is not set
-# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_OPTIDMA is not set
 # CONFIG_PATA_PDC2027X is not set
 # CONFIG_PATA_PDC_OLD is not set
 # CONFIG_PATA_RADISYS is not set
 # CONFIG_PATA_RDC is not set
-# CONFIG_PATA_RZ1000 is not set
 # CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SCH is not set
 # CONFIG_PATA_SERVERWORKS is not set
 # CONFIG_PATA_SIL680 is not set
 # CONFIG_PATA_SIS is not set
 # CONFIG_PATA_TOSHIBA is not set
+# CONFIG_PATA_TRIFLEX is not set
 # CONFIG_PATA_VIA is not set
 # CONFIG_PATA_WINBOND is not set
+
+#
+# PIO-only SFF controllers
+#
+# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_OPTI is not set
 # CONFIG_PATA_PLATFORM is not set
-# CONFIG_PATA_SCH is not set
+# CONFIG_PATA_RZ1000 is not set
+
+#
+# Generic fallback / legacy drivers
+#
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_LEGACY is not set
 # CONFIG_MD is not set
 # CONFIG_FUSION is not set
 
@@ -675,6 +713,7 @@ CONFIG_PHYLIB=y
 # CONFIG_NATIONAL_PHY is not set
 # CONFIG_STE10XP is not set
 # CONFIG_LSI_ET1011C_PHY is not set
+# CONFIG_MICREL_PHY is not set
 # CONFIG_FIXED_PHY is not set
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
@@ -724,6 +763,7 @@ CONFIG_WLAN=y
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
 # CONFIG_USB_USBNET is not set
+# CONFIG_USB_IPHETH is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
@@ -754,6 +794,7 @@ CONFIG_WLAN=y
 # CONFIG_VT is not set
 CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_N_GSM is not set
 # CONFIG_NOZOMI is not set
 
 #
@@ -773,6 +814,8 @@ CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=9600
 # CONFIG_SERIAL_JSM is not set
 # CONFIG_SERIAL_TIMBERDALE is not set
 # CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 # CONFIG_LEGACY_PTYS is not set
@@ -786,6 +829,7 @@ CONFIG_HW_RANDOM=y
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
+# CONFIG_RAMOOPS is not set
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_COMPAT=y
@@ -835,15 +879,9 @@ CONFIG_I2C_MPC=y
 #
 # CONFIG_I2C_PCA_PLATFORM is not set
 # CONFIG_I2C_STUB is not set
-
-#
-# Miscellaneous I2C Chip support
-#
-# CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
 
 #
@@ -863,15 +901,14 @@ CONFIG_SSB_POSSIBLE=y
 # Sonics Silicon Backplane
 #
 # CONFIG_SSB is not set
-
-#
-# Multifunction device drivers
-#
+CONFIG_MFD_SUPPORT=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_88PM860X is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_TPS6507X is not set
 # CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TC35892 is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_PMIC_DA903X is not set
 # CONFIG_PMIC_ADP5520 is not set
@@ -881,8 +918,10 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_WM8350_I2C is not set
 # CONFIG_MFD_WM8994 is not set
 # CONFIG_MFD_PCF50633 is not set
-# CONFIG_AB3100_CORE is not set
+# CONFIG_ABX500_CORE is not set
 # CONFIG_LPC_SCH is not set
+# CONFIG_MFD_RDC321X is not set
+# CONFIG_MFD_JANZ_CMODIO is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
@@ -917,7 +956,6 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_DEVICE_CLASS is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_OTG is not set
 # CONFIG_USB_OTG_WHITELIST is not set
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
 # CONFIG_USB_MON is not set
@@ -1082,10 +1120,6 @@ CONFIG_RTC_DRV_PCF8563=m
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
-
-#
-# TI VLYNQ
-#
 # CONFIG_STAGING is not set
 
 #
@@ -1197,6 +1231,7 @@ CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
+# CONFIG_CEPH_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1296,6 +1331,7 @@ CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
 CONFIG_TRACING_SUPPORT=y
 # CONFIG_FTRACE is not set
 # CONFIG_DMA_API_DEBUG is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_PPC_DISABLE_WERROR is not set
diff --git a/arch/powerpc/configs/52xx/tqm5200_defconfig b/arch/powerpc/configs/52xx/tqm5200_defconfig
index 96181c6..2b8bbd6 100644
--- a/arch/powerpc/configs/52xx/tqm5200_defconfig
+++ b/arch/powerpc/configs/52xx/tqm5200_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.34-rc1
-# Wed Mar 10 14:34:24 2010
+# Linux kernel version: 2.6.35-rc1
+# Thu Jun  3 08:28:04 2010
 #
 # CONFIG_PPC64 is not set
 
@@ -72,6 +72,7 @@ CONFIG_CONSTRUCTORS=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
@@ -144,6 +145,7 @@ CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
 CONFIG_HAVE_DMA_ATTRS=y
+CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
 CONFIG_HAVE_CLK=y
 CONFIG_HAVE_DMA_API_DEBUG=y
 
@@ -314,6 +316,8 @@ CONFIG_ISA_DMA_API=y
 # Bus options
 #
 CONFIG_ZONE_DMA=y
+# CONFIG_NEED_DMA_MAP_STATE is not set
+CONFIG_NEED_SG_DMA_LENGTH=y
 CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PPC_PCI_CHOICE=y
 # CONFIG_PCI is not set
@@ -385,6 +389,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
+# CONFIG_L2TP is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
@@ -417,9 +422,14 @@ CONFIG_WIRELESS=y
 #
 # CFG80211 needs to be enabled for MAC80211
 #
+
+#
+# Some wireless drivers require a rate control algorithm
+#
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
 
 #
 # Device Drivers
@@ -458,6 +468,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_SM_FTL is not set
 # CONFIG_MTD_OOPS is not set
 
 #
@@ -550,6 +561,7 @@ CONFIG_HAVE_IDE=y
 #
 # SCSI device support
 #
+CONFIG_SCSI_MOD=y
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
 CONFIG_SCSI_DMA=y
@@ -591,11 +603,37 @@ CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
 CONFIG_ATA_VERBOSE_ERROR=y
 CONFIG_SATA_PMP=y
+
+#
+# Controllers with non-SFF native interface
+#
+# CONFIG_SATA_AHCI_PLATFORM is not set
 CONFIG_ATA_SFF=y
-# CONFIG_SATA_MV is not set
+
+#
+# SFF controllers with custom DMA interface
+#
 CONFIG_PATA_MPC52xx=y
+CONFIG_ATA_BMDMA=y
+
+#
+# SATA SFF controllers with BMDMA
+#
+# CONFIG_SATA_MV is not set
+
+#
+# PATA SFF controllers with BMDMA
+#
+
+#
+# PIO-only SFF controllers
+#
 CONFIG_PATA_PLATFORM=y
 # CONFIG_PATA_OF_PLATFORM is not set
+
+#
+# Generic fallback / legacy drivers
+#
 # CONFIG_MD is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
@@ -623,6 +661,7 @@ CONFIG_LXT_PHY=y
 # CONFIG_NATIONAL_PHY is not set
 # CONFIG_STE10XP is not set
 # CONFIG_LSI_ET1011C_PHY is not set
+# CONFIG_MICREL_PHY is not set
 # CONFIG_FIXED_PHY is not set
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
@@ -660,6 +699,7 @@ CONFIG_WLAN=y
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
 # CONFIG_USB_USBNET is not set
+# CONFIG_USB_IPHETH is not set
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
@@ -686,6 +726,7 @@ CONFIG_WLAN=y
 # CONFIG_VT is not set
 CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_N_GSM is not set
 
 #
 # Serial drivers
@@ -703,6 +744,8 @@ CONFIG_SERIAL_MPC52xx_CONSOLE=y
 CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=115200
 # CONFIG_SERIAL_TIMBERDALE is not set
 # CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
@@ -714,6 +757,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
+# CONFIG_RAMOOPS is not set
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_COMPAT=y
@@ -745,15 +789,9 @@ CONFIG_I2C_MPC=y
 #
 # CONFIG_I2C_PCA_PLATFORM is not set
 # CONFIG_I2C_STUB is not set
-
-#
-# Miscellaneous I2C Chip support
-#
-# CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
 
 #
@@ -814,12 +852,14 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_PC87427 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_SENSORS_DME1737 is not set
+# CONFIG_SENSORS_EMC1403 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
 # CONFIG_SENSORS_SMSC47M192 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_ADS7828 is not set
 # CONFIG_SENSORS_AMC6821 is not set
 # CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_TMP102 is not set
 # CONFIG_SENSORS_TMP401 is not set
 # CONFIG_SENSORS_TMP421 is not set
 # CONFIG_SENSORS_VT1211 is not set
@@ -839,7 +879,6 @@ CONFIG_WATCHDOG=y
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
-# CONFIG_MAX63XX_WATCHDOG is not set
 # CONFIG_MPC5200_WDT is not set
 
 #
@@ -852,15 +891,14 @@ CONFIG_SSB_POSSIBLE=y
 # Sonics Silicon Backplane
 #
 # CONFIG_SSB is not set
-
-#
-# Multifunction device drivers
-#
+CONFIG_MFD_SUPPORT=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_88PM860X is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_TPS6507X is not set
 # CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TC35892 is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_PMIC_DA903X is not set
 # CONFIG_PMIC_ADP5520 is not set
@@ -870,7 +908,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_WM8350_I2C is not set
 # CONFIG_MFD_WM8994 is not set
 # CONFIG_MFD_PCF50633 is not set
-# CONFIG_AB3100_CORE is not set
+# CONFIG_ABX500_CORE is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
@@ -901,7 +939,6 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_DEVICE_CLASS is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_OTG is not set
 # CONFIG_USB_OTG_WHITELIST is not set
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
 CONFIG_USB_MON=y
@@ -1062,10 +1099,6 @@ CONFIG_RTC_DRV_DS1307=y
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
-
-#
-# TI VLYNQ
-#
 # CONFIG_STAGING is not set
 
 #
@@ -1179,6 +1212,7 @@ CONFIG_SUNRPC_GSS=y
 CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
+# CONFIG_CEPH_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1344,6 +1378,7 @@ CONFIG_BRANCH_PROFILE_NONE=y
 # CONFIG_WORKQUEUE_TRACER is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_DMA_API_DEBUG is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index 7012ac0..a7d92e0 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.34-rc1
-# Wed Mar 10 14:38:54 2010
+# Linux kernel version: 2.6.35-rc1
+# Thu Jun  3 09:09:21 2010
 #
 # CONFIG_PPC64 is not set
 
@@ -73,7 +73,9 @@ CONFIG_CONSTRUCTORS=y
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
@@ -97,8 +99,7 @@ CONFIG_RCU_FANOUT=32
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
@@ -155,13 +156,16 @@ CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
 CONFIG_HAVE_DMA_ATTRS=y
+CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
 CONFIG_HAVE_CLK=y
 CONFIG_HAVE_DMA_API_DEBUG=y
 
 #
 # GCOV-based kernel profiling
 #
-# CONFIG_SLOW_WORK is not set
+# CONFIG_GCOV_KERNEL is not set
+CONFIG_SLOW_WORK=y
+# CONFIG_SLOW_WORK_DEBUG is not set
 # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
@@ -193,27 +197,27 @@ CONFIG_DEFAULT_IOSCHED="cfq"
 # CONFIG_INLINE_SPIN_LOCK_BH is not set
 # CONFIG_INLINE_SPIN_LOCK_IRQ is not set
 # CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
-CONFIG_INLINE_SPIN_UNLOCK=y
+# CONFIG_INLINE_SPIN_UNLOCK is not set
 # CONFIG_INLINE_SPIN_UNLOCK_BH is not set
-CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
+# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
 # CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
 # CONFIG_INLINE_READ_TRYLOCK is not set
 # CONFIG_INLINE_READ_LOCK is not set
 # CONFIG_INLINE_READ_LOCK_BH is not set
 # CONFIG_INLINE_READ_LOCK_IRQ is not set
 # CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
-CONFIG_INLINE_READ_UNLOCK=y
+# CONFIG_INLINE_READ_UNLOCK is not set
 # CONFIG_INLINE_READ_UNLOCK_BH is not set
-CONFIG_INLINE_READ_UNLOCK_IRQ=y
+# CONFIG_INLINE_READ_UNLOCK_IRQ is not set
 # CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
 # CONFIG_INLINE_WRITE_TRYLOCK is not set
 # CONFIG_INLINE_WRITE_LOCK is not set
 # CONFIG_INLINE_WRITE_LOCK_BH is not set
 # CONFIG_INLINE_WRITE_LOCK_IRQ is not set
 # CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
-CONFIG_INLINE_WRITE_UNLOCK=y
+# CONFIG_INLINE_WRITE_UNLOCK is not set
 # CONFIG_INLINE_WRITE_UNLOCK_BH is not set
-CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
+# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
 # CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
 # CONFIG_MUTEX_SPIN_ON_OWNER is not set
 CONFIG_FREEZER=y
@@ -280,9 +284,9 @@ CONFIG_HZ_250=y
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ=250
 CONFIG_SCHED_HRTICK=y
-CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_NONE is not set
 # CONFIG_PREEMPT_VOLUNTARY is not set
-# CONFIG_PREEMPT is not set
+CONFIG_PREEMPT=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_HAVE_AOUT is not set
@@ -336,6 +340,8 @@ CONFIG_ISA_DMA_API=y
 # Bus options
 #
 CONFIG_ZONE_DMA=y
+# CONFIG_NEED_DMA_MAP_STATE is not set
+CONFIG_NEED_SG_DMA_LENGTH=y
 CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PPC_PCI_CHOICE=y
@@ -414,6 +420,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
+# CONFIG_L2TP is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
@@ -435,7 +442,26 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
-# CONFIG_CAN is not set
+CONFIG_CAN=m
+CONFIG_CAN_RAW=m
+CONFIG_CAN_BCM=m
+
+#
+# CAN Device Drivers
+#
+# CONFIG_CAN_VCAN is not set
+CONFIG_CAN_DEV=m
+CONFIG_CAN_CALC_BITTIMING=y
+# CONFIG_CAN_MCP251X is not set
+CONFIG_CAN_MSCAN=m
+CONFIG_CAN_MPC5XXX=m
+# CONFIG_CAN_SJA1000 is not set
+
+#
+# CAN USB interfaces
+#
+# CONFIG_CAN_EMS_USB is not set
+# CONFIG_CAN_DEBUG_DEVICES is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
@@ -446,9 +472,14 @@ CONFIG_WIRELESS=y
 #
 # CFG80211 needs to be enabled for MAC80211
 #
+
+#
+# Some wireless drivers require a rate control algorithm
+#
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
 
 #
 # Device Drivers
@@ -458,7 +489,8 @@ CONFIG_WIRELESS=y
 # Generic Driver Options
 #
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-# CONFIG_DEVTMPFS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
@@ -489,6 +521,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_SM_FTL is not set
 # CONFIG_MTD_OOPS is not set
 
 #
@@ -508,7 +541,7 @@ CONFIG_MTD_CFI_I1=y
 CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
-# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
@@ -603,6 +636,7 @@ CONFIG_MISC_DEVICES=y
 # CONFIG_ENCLOSURE_SERVICES is not set
 # CONFIG_HP_ILO is not set
 # CONFIG_ISL29003 is not set
+# CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_DS1682 is not set
 # CONFIG_TI_DAC7512 is not set
 # CONFIG_C2PORT is not set
@@ -622,6 +656,7 @@ CONFIG_HAVE_IDE=y
 #
 # SCSI device support
 #
+CONFIG_SCSI_MOD=y
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
 CONFIG_SCSI_DMA=y
@@ -707,69 +742,95 @@ CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
 CONFIG_ATA_VERBOSE_ERROR=y
 CONFIG_SATA_PMP=y
+
+#
+# Controllers with non-SFF native interface
+#
 # CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_AHCI_PLATFORM is not set
+# CONFIG_SATA_INIC162X is not set
 # CONFIG_SATA_SIL24 is not set
 CONFIG_ATA_SFF=y
-# CONFIG_SATA_SVW is not set
+
+#
+# SFF controllers with custom DMA interface
+#
+# CONFIG_PDC_ADMA is not set
+CONFIG_PATA_MPC52xx=y
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_SX4 is not set
+CONFIG_ATA_BMDMA=y
+
+#
+# SATA SFF controllers with BMDMA
+#
 # CONFIG_ATA_PIIX is not set
 # CONFIG_SATA_MV is not set
 # CONFIG_SATA_NV is not set
-# CONFIG_PDC_ADMA is not set
-# CONFIG_SATA_QSTOR is not set
 # CONFIG_SATA_PROMISE is not set
-# CONFIG_SATA_SX4 is not set
 # CONFIG_SATA_SIL is not set
 # CONFIG_SATA_SIS is not set
+# CONFIG_SATA_SVW is not set
 # CONFIG_SATA_ULI is not set
 # CONFIG_SATA_VIA is not set
 # CONFIG_SATA_VITESSE is not set
-# CONFIG_SATA_INIC162X is not set
+
+#
+# PATA SFF controllers with BMDMA
+#
 # CONFIG_PATA_ALI is not set
 # CONFIG_PATA_AMD is not set
 # CONFIG_PATA_ARTOP is not set
-# CONFIG_PATA_ATP867X is not set
 # CONFIG_PATA_ATIIXP is not set
-# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_ATP867X is not set
 # CONFIG_PATA_CMD64X is not set
 # CONFIG_PATA_CS5520 is not set
 # CONFIG_PATA_CS5530 is not set
 # CONFIG_PATA_CYPRESS is not set
 # CONFIG_PATA_EFAR is not set
-# CONFIG_ATA_GENERIC is not set
 # CONFIG_PATA_HPT366 is not set
 # CONFIG_PATA_HPT37X is not set
 # CONFIG_PATA_HPT3X2N is not set
 # CONFIG_PATA_HPT3X3 is not set
-# CONFIG_PATA_IT821X is not set
 # CONFIG_PATA_IT8213 is not set
+# CONFIG_PATA_IT821X is not set
 # CONFIG_PATA_JMICRON is not set
-# CONFIG_PATA_LEGACY is not set
-# CONFIG_PATA_TRIFLEX is not set
 # CONFIG_PATA_MARVELL is not set
-CONFIG_PATA_MPC52xx=y
-# CONFIG_PATA_MPIIX is not set
-# CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_NETCELL is not set
 # CONFIG_PATA_NINJA32 is not set
-# CONFIG_PATA_NS87410 is not set
 # CONFIG_PATA_NS87415 is not set
-# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_OPTIDMA is not set
 # CONFIG_PATA_PDC2027X is not set
 # CONFIG_PATA_PDC_OLD is not set
 # CONFIG_PATA_RADISYS is not set
 # CONFIG_PATA_RDC is not set
-# CONFIG_PATA_RZ1000 is not set
 # CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SCH is not set
 # CONFIG_PATA_SERVERWORKS is not set
 # CONFIG_PATA_SIL680 is not set
 # CONFIG_PATA_SIS is not set
 # CONFIG_PATA_TOSHIBA is not set
+# CONFIG_PATA_TRIFLEX is not set
 # CONFIG_PATA_VIA is not set
 # CONFIG_PATA_WINBOND is not set
+
+#
+# PIO-only SFF controllers
+#
+# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_OPTI is not set
 CONFIG_PATA_PLATFORM=y
 # CONFIG_PATA_OF_PLATFORM is not set
-# CONFIG_PATA_SCH is not set
+# CONFIG_PATA_RZ1000 is not set
+
+#
+# Generic fallback / legacy drivers
+#
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_LEGACY is not set
 # CONFIG_MD is not set
 # CONFIG_FUSION is not set
 
@@ -814,6 +875,7 @@ CONFIG_LXT_PHY=y
 # CONFIG_NATIONAL_PHY is not set
 # CONFIG_STE10XP is not set
 # CONFIG_LSI_ET1011C_PHY is not set
+# CONFIG_MICREL_PHY is not set
 # CONFIG_FIXED_PHY is not set
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
@@ -865,6 +927,7 @@ CONFIG_WLAN=y
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
 # CONFIG_USB_USBNET is not set
+# CONFIG_USB_IPHETH is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
@@ -923,6 +986,7 @@ CONFIG_HW_CONSOLE=y
 # CONFIG_VT_HW_CONSOLE_BINDING is not set
 CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_N_GSM is not set
 # CONFIG_NOZOMI is not set
 
 #
@@ -943,6 +1007,8 @@ CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=115200
 # CONFIG_SERIAL_JSM is not set
 # CONFIG_SERIAL_TIMBERDALE is not set
 # CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
@@ -957,6 +1023,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
+# CONFIG_RAMOOPS is not set
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_COMPAT=y
@@ -1008,15 +1075,9 @@ CONFIG_I2C_MPC=y
 #
 # CONFIG_I2C_PCA_PLATFORM is not set
 # CONFIG_I2C_STUB is not set
-
-#
-# Miscellaneous I2C Chip support
-#
-# CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_I2C_DEBUG_CHIP is not set
 CONFIG_SPI=y
 # CONFIG_SPI_DEBUG is not set
 CONFIG_SPI_MASTER=y
@@ -1069,6 +1130,7 @@ CONFIG_GPIOLIB=y
 # CONFIG_GPIO_CS5535 is not set
 # CONFIG_GPIO_BT8XX is not set
 # CONFIG_GPIO_LANGWELL is not set
+# CONFIG_GPIO_RDC321X is not set
 
 #
 # SPI GPIO expanders:
@@ -1080,6 +1142,10 @@ CONFIG_GPIOLIB=y
 #
 # AC97 GPIO expanders:
 #
+
+#
+# MODULbus GPIO expanders:
+#
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 CONFIG_HWMON=y
@@ -1138,12 +1204,15 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_SHT15 is not set
 # CONFIG_SENSORS_SIS5595 is not set
 # CONFIG_SENSORS_DME1737 is not set
+# CONFIG_SENSORS_EMC1403 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
 # CONFIG_SENSORS_SMSC47M192 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_ADS7828 is not set
+# CONFIG_SENSORS_ADS7871 is not set
 # CONFIG_SENSORS_AMC6821 is not set
 # CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_TMP102 is not set
 # CONFIG_SENSORS_TMP401 is not set
 # CONFIG_SENSORS_TMP421 is not set
 # CONFIG_SENSORS_VIA686A is not set
@@ -1167,7 +1236,6 @@ CONFIG_WATCHDOG=y
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
-# CONFIG_MAX63XX_WATCHDOG is not set
 # CONFIG_ALIM7101_WDT is not set
 # CONFIG_MPC5200_WDT is not set
 # CONFIG_WATCHDOG_RTAS is not set
@@ -1188,17 +1256,16 @@ CONFIG_SSB_POSSIBLE=y
 # Sonics Silicon Backplane
 #
 # CONFIG_SSB is not set
-
-#
-# Multifunction device drivers
-#
+CONFIG_MFD_SUPPORT=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_88PM860X is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
 # CONFIG_HTC_I2CPLD is not set
 # CONFIG_TPS65010 is not set
+# CONFIG_TPS6507X is not set
 # CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TC35892 is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_PMIC_DA903X is not set
 # CONFIG_PMIC_ADP5520 is not set
@@ -1209,11 +1276,13 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_WM8994 is not set
 # CONFIG_MFD_PCF50633 is not set
 # CONFIG_MFD_MC13783 is not set
-# CONFIG_AB3100_CORE is not set
+# CONFIG_ABX500_CORE is not set
 # CONFIG_EZX_PCAP is not set
-# CONFIG_AB4500_CORE is not set
+# CONFIG_AB8500_CORE is not set
 # CONFIG_MFD_TIMBERDALE is not set
 # CONFIG_LPC_SCH is not set
+# CONFIG_MFD_RDC321X is not set
+# CONFIG_MFD_JANZ_CMODIO is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
@@ -1292,14 +1361,16 @@ CONFIG_FB_RADEON_BACKLIGHT=y
 # CONFIG_FB_BROADSHEET is not set
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=m
+# CONFIG_LCD_L4F00242T03 is not set
 # CONFIG_LCD_LMS283GF05 is not set
 # CONFIG_LCD_LTV350QV is not set
-# CONFIG_LCD_ILI9320 is not set
 # CONFIG_LCD_TDO24M is not set
 # CONFIG_LCD_VGG2432A4 is not set
 # CONFIG_LCD_PLATFORM is not set
+# CONFIG_LCD_S6E63M0 is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_GENERIC=y
+# CONFIG_BACKLIGHT_ADP8860 is not set
 
 #
 # Display device support
@@ -1340,11 +1411,13 @@ CONFIG_USB_HID=y
 CONFIG_HID_A4TECH=y
 CONFIG_HID_APPLE=y
 CONFIG_HID_BELKIN=y
+# CONFIG_HID_CANDO is not set
 CONFIG_HID_CHERRY=y
 CONFIG_HID_CHICONY=y
 CONFIG_HID_CYPRESS=y
 CONFIG_HID_DRAGONRISE=y
 # CONFIG_DRAGONRISE_FF is not set
+# CONFIG_HID_EGALAX is not set
 CONFIG_HID_EZKEY=y
 CONFIG_HID_KYE=y
 CONFIG_HID_GYRATION=y
@@ -1362,7 +1435,10 @@ CONFIG_HID_ORTEK=y
 CONFIG_HID_PANTHERLORD=y
 # CONFIG_PANTHERLORD_FF is not set
 CONFIG_HID_PETALYNX=y
+# CONFIG_HID_PICOLCD is not set
 # CONFIG_HID_QUANTA is not set
+# CONFIG_HID_ROCCAT is not set
+# CONFIG_HID_ROCCAT_KONE is not set
 CONFIG_HID_SAMSUNG=y
 CONFIG_HID_SONY=y
 # CONFIG_HID_STANTUM is not set
@@ -1376,6 +1452,7 @@ CONFIG_HID_THRUSTMASTER=y
 # CONFIG_THRUSTMASTER_FF is not set
 CONFIG_HID_ZEROPLUS=y
 # CONFIG_ZEROPLUS_FF is not set
+# CONFIG_HID_ZYDACRON is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
@@ -1390,7 +1467,6 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_DEVICE_CLASS is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_OTG is not set
 CONFIG_USB_MON=y
 # CONFIG_USB_WUSB is not set
 # CONFIG_USB_WUSB_CBAF is not set
@@ -1494,15 +1570,6 @@ CONFIG_USB_STORAGE=y
 # CONFIG_MEMSTICK is not set
 CONFIG_NEW_LEDS=y
 # CONFIG_LEDS_CLASS is not set
-
-#
-# LED drivers
-#
-
-#
-# LED Triggers
-#
-# CONFIG_LEDS_TRIGGERS is not set
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 # CONFIG_EDAC is not set
@@ -1576,10 +1643,6 @@ CONFIG_RTC_DRV_DS1307=y
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
-
-#
-# TI VLYNQ
-#
 # CONFIG_STAGING is not set
 
 #
@@ -1595,6 +1658,7 @@ CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4_FS is not set
 CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
@@ -1628,9 +1692,9 @@ CONFIG_INOTIFY_USER=y
 #
 # DOS/FAT/NT Filesystems
 #
-CONFIG_FAT_FS=y
-CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
 CONFIG_FAT_DEFAULT_CODEPAGE=437
 CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
@@ -1699,6 +1763,7 @@ CONFIG_SUNRPC_GSS=y
 CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
+# CONFIG_CEPH_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1789,7 +1854,7 @@ CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_STRIP_ASM_SYMS is not set
 # CONFIG_UNUSED_SYMBOLS is not set
-# CONFIG_DEBUG_FS is not set
+CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
@@ -1806,6 +1871,7 @@ CONFIG_SCHED_DEBUG=y
 # CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_SLUB_STATS is not set
 # CONFIG_DEBUG_KMEMLEAK is not set
+CONFIG_DEBUG_PREEMPT=y
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
@@ -1830,6 +1896,7 @@ CONFIG_DEBUG_MEMORY_INIT=y
 # CONFIG_BACKTRACE_SELF_TEST is not set
 # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
 # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_LKDTM is not set
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_LATENCYTOP is not set
 # CONFIG_SYSCTL_SYSCALL_CHECK is not set
@@ -1839,20 +1906,10 @@ CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
 CONFIG_HAVE_DYNAMIC_FTRACE=y
 CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
 CONFIG_TRACING_SUPPORT=y
-CONFIG_FTRACE=y
-# CONFIG_FUNCTION_TRACER is not set
-# CONFIG_IRQSOFF_TRACER is not set
-# CONFIG_SCHED_TRACER is not set
-# CONFIG_ENABLE_DEFAULT_TRACERS is not set
-# CONFIG_BOOT_TRACER is not set
-CONFIG_BRANCH_PROFILE_NONE=y
-# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
-# CONFIG_PROFILE_ALL_BRANCHES is not set
-# CONFIG_STACK_TRACER is not set
-# CONFIG_KMEMTRACE is not set
-# CONFIG_WORKQUEUE_TRACER is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_FTRACE is not set
+# CONFIG_DYNAMIC_DEBUG is not set
 # CONFIG_DMA_API_DEBUG is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
@@ -1861,11 +1918,13 @@ CONFIG_PPC_WERROR=y
 CONFIG_PRINT_STACK_DEPTH=64
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_PPC_EMULATED_STATS is not set
 # CONFIG_CODE_PATCHING_SELFTEST is not set
 # CONFIG_FTR_FIXUP_SELFTEST is not set
 # CONFIG_MSI_BITMAP_SELFTEST is not set
 # CONFIG_XMON is not set
 # CONFIG_IRQSTACKS is not set
+# CONFIG_VIRQ_DEBUG is not set
 # CONFIG_BDI_SWITCH is not set
 # CONFIG_BOOTX_TEXT is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
