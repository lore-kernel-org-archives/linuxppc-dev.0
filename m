Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 85160DE187
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:42:18 +1100 (EST)
Date: Mon, 12 Mar 2007 14:42:07 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 19/19] Set default dts files for most 83xx/85xx/86xx configs.
Message-ID: <20070312204207.GS28545@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This provides a default device tree to use with cuImage.
I did not provide one for mpc85xx_cds_defconfig, as there
are thee device trees in the kernel that work with that
config.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/configs/mpc832x_mds_defconfig   |   43 ++++++++++++++++++-----
 arch/powerpc/configs/mpc834x_itx_defconfig   |   48 ++++++++++++++++++++------
 arch/powerpc/configs/mpc834x_itxgp_defconfig |   42 +++++++++++++++++-----
 arch/powerpc/configs/mpc834x_mds_defconfig   |   39 +++++++++++++++++----
 arch/powerpc/configs/mpc836x_mds_defconfig   |   18 +++++++---
 arch/powerpc/configs/mpc8540_ads_defconfig   |   41 +++++++++++++++++-----
 arch/powerpc/configs/mpc8560_ads_defconfig   |   43 ++++++++++++++++++-----
 arch/powerpc/configs/mpc8568mds_defconfig    |   19 +++++++---
 arch/powerpc/configs/mpc8641_hpcn_defconfig  |   44 ++++++++++++++++++-----
 9 files changed, 262 insertions(+), 75 deletions(-)

diff --git a/arch/powerpc/configs/mpc832x_mds_defconfig b/arch/powerpc/configs/mpc832x_mds_defconfig
index e1b36de..747e284 100644
--- a/arch/powerpc/configs/mpc832x_mds_defconfig
+++ b/arch/powerpc/configs/mpc832x_mds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc5
-# Tue Jan 30 14:27:25 2007
+# Linux kernel version: 2.6.21-rc3
+# Mon Mar 12 14:23:27 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -34,9 +34,9 @@ CONFIG_DEFAULT_UIMAGE=y
 CONFIG_PPC_83xx=y
 # CONFIG_PPC_85xx is not set
 # CONFIG_PPC_86xx is not set
+# CONFIG_PPC_8xx is not set
 # CONFIG_40x is not set
 # CONFIG_44x is not set
-# CONFIG_8xx is not set
 # CONFIG_E200 is not set
 CONFIG_6xx=y
 CONFIG_83xx=y
@@ -63,6 +63,7 @@ CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
@@ -71,6 +72,7 @@ CONFIG_SYSVIPC=y
 # CONFIG_IKCONFIG is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -129,10 +131,11 @@ CONFIG_PPC_GEN550=y
 #
 # Platform support
 #
+# CONFIG_MPC8313_RDB is not set
 CONFIG_MPC832x_MDS=y
-# CONFIG_MPC834x_SYS is not set
+# CONFIG_MPC834x_MDS is not set
 # CONFIG_MPC834x_ITX is not set
-# CONFIG_MPC8360E_PB is not set
+# CONFIG_MPC836x_MDS is not set
 CONFIG_PPC_MPC832x=y
 # CONFIG_MPIC is not set
 
@@ -163,15 +166,18 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 CONFIG_SECCOMP=y
+CONFIG_CUIMAGE_DTS="mpc832x_mds.dts"
 CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
+CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -220,6 +226,7 @@ CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -324,6 +331,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -342,7 +350,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -524,11 +531,13 @@ CONFIG_UCC_GETH=y
 # CONFIG_UGETH_FILTERING is not set
 # CONFIG_UGETH_TX_ON_DEMOND is not set
 # CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
 
 #
 # Ethernet (10000 Mbit)
 #
 # CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
@@ -621,6 +630,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
+# CONFIG_SERIAL_OF_PLATFORM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -691,6 +701,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PASEMI is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
 # CONFIG_I2C_SIS5595 is not set
@@ -738,6 +749,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
 # CONFIG_SENSORS_ADM1031 is not set
 # CONFIG_SENSORS_ADM9240 is not set
 # CONFIG_SENSORS_ASB100 is not set
@@ -779,6 +791,11 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -791,10 +808,9 @@ CONFIG_HWMON=y
 #
 # Graphics support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -805,6 +821,7 @@ CONFIG_FIRMWARE_EDID=y
 # HID Devices
 #
 CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
 
 #
 # USB support
@@ -869,6 +886,10 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 
 #
+# Auxiliary Display support
+#
+
+#
 # Virtualization
 #
 
@@ -1012,7 +1033,8 @@ CONFIG_BITREVERSE=y
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
 
 #
 # Instrumentation Support
@@ -1061,8 +1083,10 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_GF128MUL is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
@@ -1076,6 +1100,7 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
 
 #
diff --git a/arch/powerpc/configs/mpc834x_itx_defconfig b/arch/powerpc/configs/mpc834x_itx_defconfig
index 23d8964..05f5a9e 100644
--- a/arch/powerpc/configs/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/mpc834x_itx_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Wed Feb  7 13:12:18 2007
+# Linux kernel version: 2.6.21-rc3
+# Mon Mar 12 14:23:59 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -63,6 +63,7 @@ CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
@@ -71,6 +72,7 @@ CONFIG_SYSVIPC=y
 # CONFIG_IKCONFIG is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -128,10 +130,11 @@ CONFIG_PPC_GEN550=y
 #
 # Platform support
 #
+# CONFIG_MPC8313_RDB is not set
 # CONFIG_MPC832x_MDS is not set
-# CONFIG_MPC834x_SYS is not set
+# CONFIG_MPC834x_MDS is not set
 CONFIG_MPC834x_ITX=y
-# CONFIG_MPC8360E_PB is not set
+# CONFIG_MPC836x_MDS is not set
 CONFIG_MPC834x=y
 # CONFIG_MPIC is not set
 
@@ -161,15 +164,18 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 CONFIG_SECCOMP=y
+CONFIG_CUIMAGE_DTS="mpc8349emitx.dts"
 CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
+CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -218,6 +224,7 @@ CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -389,7 +396,6 @@ CONFIG_MTD_PHYSMAP_BANKWIDTH=2
 # NAND Flash Device Drivers
 #
 # CONFIG_MTD_NAND is not set
-# CONFIG_MTD_NAND_CAFE is not set
 
 #
 # OneNAND Flash Device Drivers
@@ -404,6 +410,7 @@ CONFIG_MTD_PHYSMAP_BANKWIDTH=2
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -423,7 +430,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -537,6 +543,7 @@ CONFIG_SATA_SIL=y
 # CONFIG_SATA_ULI is not set
 # CONFIG_SATA_VIA is not set
 # CONFIG_SATA_VITESSE is not set
+# CONFIG_SATA_INIC162X is not set
 # CONFIG_PATA_ALI is not set
 # CONFIG_PATA_AMD is not set
 # CONFIG_PATA_ARTOP is not set
@@ -552,6 +559,7 @@ CONFIG_SATA_SIL=y
 # CONFIG_PATA_HPT3X2N is not set
 # CONFIG_PATA_HPT3X3 is not set
 # CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_IT8213 is not set
 # CONFIG_PATA_JMICRON is not set
 # CONFIG_PATA_TRIFLEX is not set
 # CONFIG_PATA_MARVELL is not set
@@ -667,11 +675,13 @@ CONFIG_CICADA_PHY=y
 CONFIG_GIANFAR=y
 CONFIG_GFAR_NAPI=y
 # CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
 
 #
 # Ethernet (10000 Mbit)
 #
 # CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
@@ -745,6 +755,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
+# CONFIG_SERIAL_OF_PLATFORM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -819,6 +830,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PASEMI is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
 # CONFIG_I2C_SIS5595 is not set
@@ -861,6 +873,7 @@ CONFIG_SPI_MPC83xx=y
 #
 # SPI Protocol Masters
 #
+# CONFIG_SPI_AT25 is not set
 
 #
 # Dallas's 1-wire bus
@@ -874,6 +887,11 @@ CONFIG_SPI_MPC83xx=y
 # CONFIG_HWMON_VID is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -887,10 +905,9 @@ CONFIG_SPI_MPC83xx=y
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -910,7 +927,6 @@ CONFIG_USB=y
 # Miscellaneous USB options
 #
 CONFIG_USB_DEVICEFS=y
-# CONFIG_USB_BANDWIDTH is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
 # CONFIG_USB_OTG is not set
 
@@ -921,6 +937,7 @@ CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_SPLIT_ISO is not set
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
+# CONFIG_USB_EHCI_BIG_ENDIAN_MMIO is not set
 # CONFIG_USB_ISP116X_HCD is not set
 # CONFIG_USB_OHCI_HCD is not set
 # CONFIG_USB_UHCI_HCD is not set
@@ -996,6 +1013,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
@@ -1006,6 +1024,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1071,7 +1090,6 @@ CONFIG_RTC_DRV_DS1307=y
 # CONFIG_RTC_DRV_DS1672 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
 # CONFIG_RTC_DRV_PCF8563 is not set
-# CONFIG_RTC_DRV_PCF8583 is not set
 # CONFIG_RTC_DRV_RS5C348 is not set
 # CONFIG_RTC_DRV_RS5C372 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
@@ -1095,6 +1113,10 @@ CONFIG_NET_DMA=y
 CONFIG_INTEL_IOATDMA=y
 
 #
+# Auxiliary Display support
+#
+
+#
 # Virtualization
 #
 
@@ -1278,7 +1300,8 @@ CONFIG_BITREVERSE=y
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
 
 #
 # Instrumentation Support
@@ -1327,8 +1350,10 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_GF128MUL is not set
 # CONFIG_CRYPTO_ECB is not set
 CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
@@ -1342,6 +1367,7 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
 
 #
diff --git a/arch/powerpc/configs/mpc834x_itxgp_defconfig b/arch/powerpc/configs/mpc834x_itxgp_defconfig
index 4aa666c..bc53850 100644
--- a/arch/powerpc/configs/mpc834x_itxgp_defconfig
+++ b/arch/powerpc/configs/mpc834x_itxgp_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Fri Feb  9 13:28:19 2007
+# Linux kernel version: 2.6.21-rc3
+# Mon Mar 12 14:24:20 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -63,6 +63,7 @@ CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
@@ -71,6 +72,7 @@ CONFIG_SYSVIPC=y
 # CONFIG_IKCONFIG is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -128,10 +130,11 @@ CONFIG_PPC_GEN550=y
 #
 # Platform support
 #
+# CONFIG_MPC8313_RDB is not set
 # CONFIG_MPC832x_MDS is not set
-# CONFIG_MPC834x_SYS is not set
+# CONFIG_MPC834x_MDS is not set
 CONFIG_MPC834x_ITX=y
-# CONFIG_MPC8360E_PB is not set
+# CONFIG_MPC836x_MDS is not set
 CONFIG_MPC834x=y
 # CONFIG_MPIC is not set
 
@@ -161,15 +164,18 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 CONFIG_SECCOMP=y
+CONFIG_CUIMAGE_DTS="mpc8349emitxgp.dts"
 CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
+CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -218,6 +224,7 @@ CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -389,7 +396,6 @@ CONFIG_MTD_PHYSMAP_BANKWIDTH=2
 # NAND Flash Device Drivers
 #
 # CONFIG_MTD_NAND is not set
-# CONFIG_MTD_NAND_CAFE is not set
 
 #
 # OneNAND Flash Device Drivers
@@ -404,6 +410,7 @@ CONFIG_MTD_PHYSMAP_BANKWIDTH=2
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -422,7 +429,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -601,11 +607,13 @@ CONFIG_CICADA_PHY=y
 CONFIG_GIANFAR=y
 CONFIG_GFAR_NAPI=y
 # CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
 
 #
 # Ethernet (10000 Mbit)
 #
 # CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
@@ -679,6 +687,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
+# CONFIG_SERIAL_OF_PLATFORM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -748,6 +757,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PASEMI is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
 # CONFIG_I2C_SIS5595 is not set
@@ -790,6 +800,7 @@ CONFIG_SPI_MPC83xx=y
 #
 # SPI Protocol Masters
 #
+# CONFIG_SPI_AT25 is not set
 
 #
 # Dallas's 1-wire bus
@@ -803,6 +814,11 @@ CONFIG_SPI_MPC83xx=y
 # CONFIG_HWMON_VID is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -815,10 +831,9 @@ CONFIG_SPI_MPC83xx=y
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -896,7 +911,6 @@ CONFIG_RTC_DRV_DS1307=y
 # CONFIG_RTC_DRV_DS1672 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
 # CONFIG_RTC_DRV_PCF8563 is not set
-# CONFIG_RTC_DRV_PCF8583 is not set
 # CONFIG_RTC_DRV_RS5C348 is not set
 # CONFIG_RTC_DRV_RS5C372 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
@@ -920,6 +934,10 @@ CONFIG_NET_DMA=y
 CONFIG_INTEL_IOATDMA=y
 
 #
+# Auxiliary Display support
+#
+
+#
 # Virtualization
 #
 
@@ -1103,7 +1121,8 @@ CONFIG_BITREVERSE=y
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
 
 #
 # Instrumentation Support
@@ -1152,8 +1171,10 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_GF128MUL is not set
 # CONFIG_CRYPTO_ECB is not set
 CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
@@ -1167,6 +1188,7 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
 
 #
diff --git a/arch/powerpc/configs/mpc834x_mds_defconfig b/arch/powerpc/configs/mpc834x_mds_defconfig
index 2e3f8ef..b63719b 100644
--- a/arch/powerpc/configs/mpc834x_mds_defconfig
+++ b/arch/powerpc/configs/mpc834x_mds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Thu Feb  8 01:00:48 2007
+# Linux kernel version: 2.6.21-rc3
+# Mon Mar 12 14:24:37 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -63,6 +63,7 @@ CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
@@ -71,6 +72,7 @@ CONFIG_SYSVIPC=y
 # CONFIG_IKCONFIG is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -132,7 +134,7 @@ CONFIG_PPC_GEN550=y
 # CONFIG_MPC832x_MDS is not set
 CONFIG_MPC834x_MDS=y
 # CONFIG_MPC834x_ITX is not set
-# CONFIG_MPC8360E_PB is not set
+# CONFIG_MPC836x_MDS is not set
 CONFIG_MPC834x=y
 # CONFIG_MPIC is not set
 
@@ -162,15 +164,18 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 CONFIG_SECCOMP=y
+CONFIG_CUIMAGE_DTS="mpc834x_mds.dts"
 CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
+CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -219,6 +224,7 @@ CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=m
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -323,6 +329,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -341,7 +348,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -460,6 +466,7 @@ CONFIG_E100=y
 # CONFIG_SUNDANCE is not set
 # CONFIG_TLAN is not set
 # CONFIG_VIA_RHINE is not set
+# CONFIG_SC92031 is not set
 
 #
 # Ethernet (1000 Mbit)
@@ -481,11 +488,13 @@ CONFIG_E100=y
 CONFIG_GIANFAR=y
 # CONFIG_GFAR_NAPI is not set
 # CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
 
 #
 # Ethernet (10000 Mbit)
 #
 # CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
@@ -577,6 +586,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
+# CONFIG_SERIAL_OF_PLATFORM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -647,6 +657,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PASEMI is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
 # CONFIG_I2C_SIS5595 is not set
@@ -694,6 +705,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
 # CONFIG_SENSORS_ADM1031 is not set
 # CONFIG_SENSORS_ADM9240 is not set
 # CONFIG_SENSORS_ASB100 is not set
@@ -735,6 +747,11 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -747,10 +764,9 @@ CONFIG_HWMON=y
 #
 # Graphics support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -761,6 +777,7 @@ CONFIG_FIRMWARE_EDID=y
 # HID Devices
 #
 CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
 
 #
 # USB support
@@ -825,6 +842,10 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 
 #
+# Auxiliary Display support
+#
+
+#
 # Virtualization
 #
 
@@ -961,7 +982,8 @@ CONFIG_BITREVERSE=y
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
 
 #
 # Instrumentation Support
@@ -1010,8 +1032,10 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_GF128MUL is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
@@ -1025,6 +1049,7 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
 
 #
diff --git a/arch/powerpc/configs/mpc836x_mds_defconfig b/arch/powerpc/configs/mpc836x_mds_defconfig
index 8eb475c..2a2d058 100644
--- a/arch/powerpc/configs/mpc836x_mds_defconfig
+++ b/arch/powerpc/configs/mpc836x_mds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Sat Feb 17 10:09:26 2007
+# Linux kernel version: 2.6.21-rc3
+# Mon Mar 12 14:24:51 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -72,6 +72,7 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_IKCONFIG is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -169,6 +170,7 @@ CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 CONFIG_SECCOMP=y
+CONFIG_CUIMAGE_DTS="mpc836x_mds.dts"
 CONFIG_ISA_DMA_API=y
 
 #
@@ -328,6 +330,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -346,7 +349,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -528,6 +530,7 @@ CONFIG_UCC_GETH=y
 # CONFIG_UGETH_FILTERING is not set
 # CONFIG_UGETH_TX_ON_DEMOND is not set
 # CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -745,6 +748,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
 # CONFIG_SENSORS_ADM1031 is not set
 # CONFIG_SENSORS_ADM9240 is not set
 # CONFIG_SENSORS_ASB100 is not set
@@ -786,6 +790,11 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -798,10 +807,9 @@ CONFIG_HWMON=y
 #
 # Graphics support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
diff --git a/arch/powerpc/configs/mpc8540_ads_defconfig b/arch/powerpc/configs/mpc8540_ads_defconfig
index 17120c4..d3dc97c 100644
--- a/arch/powerpc/configs/mpc8540_ads_defconfig
+++ b/arch/powerpc/configs/mpc8540_ads_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc5
-# Mon Jan 22 22:25:24 2007
+# Linux kernel version: 2.6.21-rc3
+# Mon Mar 12 14:25:08 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -34,9 +34,9 @@ CONFIG_DEFAULT_UIMAGE=y
 # CONFIG_PPC_83xx is not set
 CONFIG_PPC_85xx=y
 # CONFIG_PPC_86xx is not set
+# CONFIG_PPC_8xx is not set
 # CONFIG_40x is not set
 # CONFIG_44x is not set
-# CONFIG_8xx is not set
 # CONFIG_E200 is not set
 CONFIG_85xx=y
 CONFIG_E500=y
@@ -63,6 +63,7 @@ CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
@@ -71,6 +72,7 @@ CONFIG_SYSVIPC=y
 # CONFIG_IKCONFIG is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -127,7 +129,9 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 CONFIG_MPC8540_ADS=y
 # CONFIG_MPC8560_ADS is not set
 # CONFIG_MPC85xx_CDS is not set
+# CONFIG_MPC85xx_MDS is not set
 CONFIG_MPC8540=y
+CONFIG_MPC85xx=y
 CONFIG_PPC_INDIRECT_PCI_BE=y
 CONFIG_MPIC=y
 
@@ -158,15 +162,18 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 # CONFIG_SECCOMP is not set
+CONFIG_CUIMAGE_DTS="mpc8540ads.dts"
 CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
+CONFIG_ZONE_DMA=y
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
 CONFIG_PPC_INDIRECT_PCI=y
@@ -212,6 +219,7 @@ CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=y
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -297,6 +305,7 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
@@ -317,6 +326,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -330,14 +340,12 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
 #
 # Misc devices
 #
-# CONFIG_TIFM_CORE is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -504,6 +512,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_OF_PLATFORM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -558,6 +567,11 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -570,10 +584,9 @@ CONFIG_HWMON=y
 #
 # Graphics support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -584,6 +597,7 @@ CONFIG_FIRMWARE_EDID=y
 # HID Devices
 #
 CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
 
 #
 # USB support
@@ -646,6 +660,10 @@ CONFIG_HID=y
 #
 
 #
+# Auxiliary Display support
+#
+
+#
 # Virtualization
 #
 
@@ -779,7 +797,8 @@ CONFIG_BITREVERSE=y
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
 
 #
 # Instrumentation Support
@@ -796,15 +815,16 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_RWSEMS is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -814,6 +834,9 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUGGER is not set
 # CONFIG_BDI_SWITCH is not set
 # CONFIG_BOOTX_TEXT is not set
diff --git a/arch/powerpc/configs/mpc8560_ads_defconfig b/arch/powerpc/configs/mpc8560_ads_defconfig
index ecaa267..209cd8e 100644
--- a/arch/powerpc/configs/mpc8560_ads_defconfig
+++ b/arch/powerpc/configs/mpc8560_ads_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc5
-# Mon Jan 22 22:25:53 2007
+# Linux kernel version: 2.6.21-rc3
+# Mon Mar 12 14:25:35 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -20,7 +20,7 @@ CONFIG_GENERIC_NVRAM=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
-# CONFIG_PPC_UDBG_16550 is not set
+CONFIG_PPC_UDBG_16550=y
 # CONFIG_GENERIC_TBSYNC is not set
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
@@ -34,9 +34,9 @@ CONFIG_DEFAULT_UIMAGE=y
 # CONFIG_PPC_83xx is not set
 CONFIG_PPC_85xx=y
 # CONFIG_PPC_86xx is not set
+# CONFIG_PPC_8xx is not set
 # CONFIG_40x is not set
 # CONFIG_44x is not set
-# CONFIG_8xx is not set
 # CONFIG_E200 is not set
 CONFIG_85xx=y
 CONFIG_E500=y
@@ -63,6 +63,7 @@ CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
@@ -71,6 +72,7 @@ CONFIG_SYSVIPC=y
 # CONFIG_IKCONFIG is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -128,7 +130,9 @@ CONFIG_CPM2=y
 # CONFIG_MPC8540_ADS is not set
 CONFIG_MPC8560_ADS=y
 # CONFIG_MPC85xx_CDS is not set
+# CONFIG_MPC85xx_MDS is not set
 CONFIG_MPC8560=y
+CONFIG_MPC85xx=y
 CONFIG_PPC_INDIRECT_PCI_BE=y
 CONFIG_MPIC=y
 
@@ -160,15 +164,18 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
 # CONFIG_PROC_DEVICETREE is not set
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 # CONFIG_SECCOMP is not set
+CONFIG_CUIMAGE_DTS="mpc8560ads.dts"
 CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
+CONFIG_ZONE_DMA=y
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
 CONFIG_PPC_INDIRECT_PCI=y
@@ -217,6 +224,7 @@ CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -302,6 +310,7 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
@@ -322,6 +331,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -340,7 +350,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -466,11 +475,13 @@ CONFIG_E1000_NAPI=y
 CONFIG_GIANFAR=y
 CONFIG_GFAR_NAPI=y
 # CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
 
 #
 # Ethernet (10000 Mbit)
 #
 # CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
@@ -622,6 +633,11 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -634,10 +650,9 @@ CONFIG_HWMON=y
 #
 # Graphics support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -648,6 +663,7 @@ CONFIG_FIRMWARE_EDID=y
 # HID Devices
 #
 CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
 
 #
 # USB support
@@ -712,6 +728,10 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 
 #
+# Auxiliary Display support
+#
+
+#
 # Virtualization
 #
 
@@ -845,7 +865,8 @@ CONFIG_BITREVERSE=y
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
 
 #
 # Instrumentation Support
@@ -862,15 +883,16 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_RWSEMS is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -880,6 +902,9 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUGGER is not set
 # CONFIG_KGDB_CONSOLE is not set
 # CONFIG_BDI_SWITCH is not set
diff --git a/arch/powerpc/configs/mpc8568mds_defconfig b/arch/powerpc/configs/mpc8568mds_defconfig
index 7b38006..287e66e 100644
--- a/arch/powerpc/configs/mpc8568mds_defconfig
+++ b/arch/powerpc/configs/mpc8568mds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Sat Feb 17 16:26:53 2007
+# Linux kernel version: 2.6.21-rc3
+# Mon Mar 12 14:25:56 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -72,6 +72,7 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_IKCONFIG is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -168,6 +169,7 @@ CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 CONFIG_SECCOMP=y
+CONFIG_CUIMAGE_DTS="mpc8568mds.dts"
 CONFIG_ISA_DMA_API=y
 
 #
@@ -326,6 +328,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -339,7 +342,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -639,6 +641,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
 # CONFIG_SENSORS_ADM1031 is not set
 # CONFIG_SENSORS_ADM9240 is not set
 # CONFIG_SENSORS_ASB100 is not set
@@ -677,6 +680,11 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -689,10 +697,9 @@ CONFIG_HWMON=y
 #
 # Graphics support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -929,6 +936,7 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
@@ -943,6 +951,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 CONFIG_DEBUGGER=y
diff --git a/arch/powerpc/configs/mpc8641_hpcn_defconfig b/arch/powerpc/configs/mpc8641_hpcn_defconfig
index 53fcd69..5781665 100644
--- a/arch/powerpc/configs/mpc8641_hpcn_defconfig
+++ b/arch/powerpc/configs/mpc8641_hpcn_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc5
-# Mon Jan 22 22:27:14 2007
+# Linux kernel version: 2.6.21-rc3
+# Mon Mar 12 14:28:16 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -24,7 +24,7 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_GENERIC_TBSYNC=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
-# CONFIG_DEFAULT_UIMAGE is not set
+CONFIG_DEFAULT_UIMAGE=y
 
 #
 # Processor support
@@ -34,9 +34,9 @@ CONFIG_GENERIC_BUG=y
 # CONFIG_PPC_83xx is not set
 # CONFIG_PPC_85xx is not set
 CONFIG_PPC_86xx=y
+# CONFIG_PPC_8xx is not set
 # CONFIG_40x is not set
 # CONFIG_44x is not set
-# CONFIG_8xx is not set
 # CONFIG_E200 is not set
 CONFIG_6xx=y
 CONFIG_PPC_FPU=y
@@ -73,6 +73,7 @@ CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -159,15 +160,18 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 # CONFIG_SECCOMP is not set
+CONFIG_CUIMAGE_DTS="mpc8641_hpcn.dts"
 CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
+CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_MPIC_WEIRD is not set
 CONFIG_PPC_I8259=y
@@ -217,6 +221,7 @@ CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=y
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
@@ -234,7 +239,7 @@ CONFIG_IP_PNP_RARP=y
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
-# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_TUNNEL=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
@@ -314,6 +319,7 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
@@ -334,6 +340,7 @@ CONFIG_FW_LOADER=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -352,7 +359,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=131072
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -473,11 +479,13 @@ CONFIG_MII=y
 CONFIG_GIANFAR=y
 # CONFIG_GFAR_NAPI is not set
 # CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
 
 #
 # Ethernet (10000 Mbit)
 #
 # CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
@@ -581,6 +589,7 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
+# CONFIG_SERIAL_OF_PLATFORM is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
 
@@ -636,6 +645,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PASEMI is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
 # CONFIG_I2C_SIS5595 is not set
@@ -680,6 +690,11 @@ CONFIG_SENSORS_EEPROM=y
 # CONFIG_HWMON_VID is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -692,7 +707,7 @@ CONFIG_SENSORS_EEPROM=y
 #
 # Graphics support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
 
@@ -702,7 +717,6 @@ CONFIG_FIRMWARE_EDID=y
 CONFIG_VGA_CONSOLE=y
 # CONFIG_VGACON_SOFT_SCROLLBACK is not set
 CONFIG_DUMMY_CONSOLE=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -713,6 +727,7 @@ CONFIG_DUMMY_CONSOLE=y
 # HID Devices
 #
 CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
 
 #
 # USB support
@@ -777,6 +792,10 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 
 #
+# Auxiliary Display support
+#
+
+#
 # Virtualization
 #
 
@@ -958,7 +977,8 @@ CONFIG_BITREVERSE=y
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
 
 #
 # Instrumentation Support
@@ -975,15 +995,16 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_MUTEXES is not set
-# CONFIG_DEBUG_RWSEMS is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -994,6 +1015,9 @@ CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUGGER is not set
 # CONFIG_BDI_SWITCH is not set
 # CONFIG_BOOTX_TEXT is not set
-- 
1.5.0.3
