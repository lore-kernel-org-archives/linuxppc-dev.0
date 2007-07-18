Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89C8BDF1F2
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:21 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1aFnq027776
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:36:15 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1aEvm001609
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:14 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BXAN008001
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:34 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id EA296AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:13 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1aDXc015482
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:36:13 -0500
Date: Tue, 17 Jul 2007 20:36:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 55/61] Update mpc8272ads defconfig.
Message-ID: <20070718013613.GA15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/configs/mpc8272_ads_defconfig |  170 ++++++++++++++++++++--------
 1 files changed, 120 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/configs/mpc8272_ads_defconfig b/arch/powerpc/configs/mpc8272_ads_defconfig
index 4a42929..47fa429 100644
--- a/arch/powerpc/configs/mpc8272_ads_defconfig
+++ b/arch/powerpc/configs/mpc8272_ads_defconfig
@@ -1,9 +1,25 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc7
-# Sun Jul  1 23:56:55 2007
+# Linux kernel version: 2.6.22
+# Tue Jul 17 20:26:49 2007
 #
 # CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+CONFIG_6xx=y
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_PPC_FPU=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
+CONFIG_NOT_COHERENT_CACHE=y
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -25,27 +41,8 @@ CONFIG_PPC_OF=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 CONFIG_DEFAULT_UIMAGE=y
-
-#
-# Processor support
-#
-# CONFIG_CLASSIC32 is not set
-CONFIG_PPC_82xx=y
-# CONFIG_PPC_83xx is not set
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-# CONFIG_PPC_8xx is not set
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_6xx=y
-CONFIG_PPC_FPU=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-CONFIG_PPC_STD_MMU=y
-CONFIG_PPC_STD_MMU_32=y
-# CONFIG_PPC_MM_SLICES is not set
-# CONFIG_SMP is not set
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -104,10 +101,6 @@ CONFIG_BASE_SMALL=0
 # Loadable module support
 #
 # CONFIG_MODULES is not set
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
@@ -129,14 +122,20 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Platform support
 #
+# CONFIG_PPC_MULTIPLATFORM is not set
+# CONFIG_EMBEDDED6xx is not set
+CONFIG_PPC_82xx=y
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_86xx is not set
 # CONFIG_PPC_MPC52xx is not set
 # CONFIG_PPC_MPC5200 is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
-CONFIG_MPC82xx_ADS=y
+CONFIG_MPC8272ADS=y
 CONFIG_PQ2ADS=y
 CONFIG_8260=y
 CONFIG_8272=y
+CONFIG_PQ2_ADS_PCI_PIC=y
 # CONFIG_MPIC is not set
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -176,17 +175,24 @@ CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 CONFIG_SECCOMP=y
-# CONFIG_WANT_DEVICE_TREE is not set
+CONFIG_WANT_DEVICE_TREE=y
+CONFIG_DEVICE_TREE="mpc8272ads.dts"
 CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
 CONFIG_ZONE_DMA=y
+CONFIG_PPC_INDIRECT_PCI=y
+# CONFIG_PPC_INDIRECT_PCI_BE is not set
 CONFIG_FSL_SOC=y
-# CONFIG_PCI is not set
-# CONFIG_PCI_DOMAINS is not set
-# CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_8260=y
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+# CONFIG_PCI_MSI is not set
+# CONFIG_PCI_DEBUG is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -205,6 +211,8 @@ CONFIG_HIGHMEM_START=0xfe000000
 CONFIG_LOWMEM_SIZE=0x30000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_TASK_SIZE=0x80000000
+CONFIG_CONSISTENT_START=0xff100000
+CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_BOOT_LOAD=0x00400000
 
 #
@@ -335,15 +343,16 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # Plug and Play support
 #
 # CONFIG_PNPACPI is not set
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
@@ -351,7 +360,9 @@ CONFIG_BLK_DEV_LOOP=y
 #
 # Misc devices
 #
-# CONFIG_BLINK is not set
+# CONFIG_PHANTOM is not set
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_SGI_IOC4 is not set
 CONFIG_IDE=y
 CONFIG_IDE_MAX_HWIFS=4
 CONFIG_BLK_DEV_IDE=y
@@ -371,6 +382,7 @@ CONFIG_IDE_PROC_FS=y
 # IDE chipset support/bugfixes
 #
 # CONFIG_IDE_GENERIC is not set
+# CONFIG_BLK_DEV_IDEPCI is not set
 # CONFIG_IDEPCI_PCIBUS_ORDER is not set
 # CONFIG_IDE_ARM is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
@@ -388,16 +400,32 @@ CONFIG_IDE_PROC_FS=y
 # Multi-device support (RAID and LVM)
 #
 # CONFIG_MD is not set
-# CONFIG_MACINTOSH_DRIVERS is not set
 
 #
-# Network device support
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
 #
+# IEEE 1394 (FireWire) support
+#
+
+#
+# An alternative FireWire stack is available with EXPERIMENTAL=y
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
 CONFIG_TUN=y
+# CONFIG_ARCNET is not set
 CONFIG_PHYLIB=y
 
 #
@@ -411,18 +439,43 @@ CONFIG_DAVICOM_PHY=y
 # CONFIG_VITESSE_PHY is not set
 # CONFIG_SMSC_PHY is not set
 # CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
 # CONFIG_FIXED_PHY is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_PCI is not set
 CONFIG_FS_ENET=y
 # CONFIG_FS_ENET_HAS_SCC is not set
 CONFIG_FS_ENET_HAS_FCC=y
 CONFIG_NETDEV_1000=y
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_QLA3XXX is not set
 CONFIG_NETDEV_10000=y
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+# CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
+# CONFIG_MLX4_CORE is not set
+# CONFIG_TR is not set
 
 #
 # Wireless LAN
@@ -430,6 +483,7 @@ CONFIG_NETDEV_10000=y
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
 # CONFIG_WAN is not set
+# CONFIG_FDDI is not set
 CONFIG_PPP=y
 # CONFIG_PPP_FILTER is not set
 CONFIG_PPP_ASYNC=y
@@ -489,6 +543,7 @@ CONFIG_MOUSE_PS2_LIFEBOOK=y
 CONFIG_MOUSE_PS2_TRACKPOINT=y
 # CONFIG_MOUSE_PS2_TOUCHKIT is not set
 # CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_APPLETOUCH is not set
 # CONFIG_MOUSE_VSXXXAA is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
@@ -501,6 +556,7 @@ CONFIG_MOUSE_PS2_TRACKPOINT=y
 CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_PCIPS2 is not set
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
@@ -530,6 +586,7 @@ CONFIG_SERIAL_CPM_SCC1=y
 CONFIG_SERIAL_CPM_SCC4=y
 # CONFIG_SERIAL_CPM_SMC1 is not set
 # CONFIG_SERIAL_CPM_SMC2 is not set
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -543,11 +600,15 @@ CONFIG_HW_RANDOM=y
 # CONFIG_NVRAM is not set
 # CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 
 #
 # TPM devices
 #
+CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
 
 #
@@ -560,6 +621,7 @@ CONFIG_HW_RANDOM=y
 # Dallas's 1-wire bus
 #
 # CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 
 #
@@ -591,19 +653,17 @@ CONFIG_DAB=y
 # Sound
 #
 # CONFIG_SOUND is not set
-
-#
-# HID Devices
-#
+CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
 
 #
 # USB support
 #
-# CONFIG_USB_ARCH_HAS_HCD is not set
-# CONFIG_USB_ARCH_HAS_OHCI is not set
-# CONFIG_USB_ARCH_HAS_EHCI is not set
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+# CONFIG_USB is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -614,15 +674,23 @@ CONFIG_HID=y
 #
 CONFIG_USB_GADGET=y
 # CONFIG_USB_GADGET_DEBUG_FILES is not set
+CONFIG_USB_GADGET_SELECTED=y
 # CONFIG_USB_GADGET_FSL_USB2 is not set
-# CONFIG_USB_GADGET_NET2280 is not set
+CONFIG_USB_GADGET_NET2280=y
+CONFIG_USB_NET2280=y
 # CONFIG_USB_GADGET_PXA2XX is not set
 # CONFIG_USB_GADGET_GOKU is not set
 # CONFIG_USB_GADGET_LH7A40X is not set
 # CONFIG_USB_GADGET_OMAP is not set
 # CONFIG_USB_GADGET_AT91 is not set
 # CONFIG_USB_GADGET_DUMMY_HCD is not set
-# CONFIG_USB_GADGET_DUALSPEED is not set
+CONFIG_USB_GADGET_DUALSPEED=y
+# CONFIG_USB_ZERO is not set
+CONFIG_USB_ETH=y
+# CONFIG_USB_GADGETFS is not set
+# CONFIG_USB_FILE_STORAGE is not set
+# CONFIG_USB_G_SERIAL is not set
+# CONFIG_USB_MIDI_GADGET is not set
 # CONFIG_MMC is not set
 
 #
@@ -641,6 +709,7 @@ CONFIG_USB_GADGET=y
 #
 # InfiniBand support
 #
+# CONFIG_INFINIBAND is not set
 
 #
 # EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
@@ -846,6 +915,7 @@ CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
 CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
-- 
1.5.0.3
