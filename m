Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 809FCDF1B0
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:19 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1aEBs027768
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:36:14 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1aDZP001602
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:13 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BW1B007998
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:32 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 8DFC3AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:12 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1aCOc015478
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:36:12 -0500
Date: Tue, 17 Jul 2007 20:36:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 54/61] Update mpc885ads defconfig.
Message-ID: <20070718013612.GZ15238@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/configs/mpc885_ads_defconfig |   78 +++++++++-------------------
 1 files changed, 25 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
index fc4f9b7..6a4f616 100644
--- a/arch/powerpc/configs/mpc885_ads_defconfig
+++ b/arch/powerpc/configs/mpc885_ads_defconfig
@@ -1,9 +1,22 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc7
-# Sun Jul  1 23:57:01 2007
+# Linux kernel version: 2.6.22
+# Tue Jul 17 15:31:50 2007
 #
 # CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+# CONFIG_6xx is not set
+# CONFIG_PPC_85xx is not set
+CONFIG_PPC_8xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_8xx=y
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_NOT_COHERENT_CACHE=y
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -24,24 +37,8 @@ CONFIG_PPC_OF=y
 # CONFIG_GENERIC_TBSYNC is not set
 CONFIG_AUDIT_ARCH=y
 # CONFIG_DEFAULT_UIMAGE is not set
-
-#
-# Processor support
-#
-# CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_82xx is not set
-# CONFIG_PPC_83xx is not set
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-CONFIG_PPC_8xx=y
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_8xx=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-# CONFIG_PPC_MM_SLICES is not set
-CONFIG_NOT_COHERENT_CACHE=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -100,10 +97,6 @@ CONFIG_BASE_SMALL=1
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
@@ -150,6 +143,7 @@ CONFIG_MPC8xx_SECOND_ETH_FEC2=y
 #
 CONFIG_8xx_COPYBACK=y
 # CONFIG_8xx_CPU6 is not set
+CONFIG_8xx_CPU15=y
 CONFIG_NO_UCODE_PATCH=y
 # CONFIG_USB_SOF_UCODE_PATCH is not set
 # CONFIG_I2C_SPI_UCODE_PATCH is not set
@@ -181,7 +175,7 @@ CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT is not set
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-CONFIG_MATH_EMULATION=y
+# CONFIG_MATH_EMULATION is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
@@ -199,7 +193,8 @@ CONFIG_ZONE_DMA_FLAG=1
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 # CONFIG_SECCOMP is not set
-# CONFIG_WANT_DEVICE_TREE is not set
+CONFIG_WANT_DEVICE_TREE=y
+CONFIG_DEVICE_TREE="mpc885ads.dts"
 CONFIG_ISA_DMA_API=y
 
 #
@@ -344,23 +339,12 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # Plug and Play support
 #
 # CONFIG_PNPACPI is not set
-
-#
-# Block devices
-#
-# CONFIG_BLK_DEV_FD is not set
-# CONFIG_BLK_DEV_COW_COMMON is not set
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_RAM is not set
-# CONFIG_CDROM_PKTCDVD is not set
-# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV is not set
 
 #
 # Misc devices
 #
-# CONFIG_BLINK is not set
+# CONFIG_EEPROM_93CX6 is not set
 # CONFIG_IDE is not set
 
 #
@@ -376,10 +360,6 @@ CONFIG_BLK_DEV_LOOP=y
 #
 # CONFIG_MD is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
-
-#
-# Network device support
-#
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
@@ -398,16 +378,10 @@ CONFIG_DAVICOM_PHY=y
 # CONFIG_VITESSE_PHY is not set
 # CONFIG_SMSC_PHY is not set
 # CONFIG_BROADCOM_PHY is not set
-CONFIG_FIXED_PHY=y
-CONFIG_FIXED_MII_10_FDX=y
-# CONFIG_FIXED_MII_100_FDX is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_FIXED_PHY is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
-# CONFIG_FEC_8XX is not set
 CONFIG_FS_ENET=y
 CONFIG_FS_ENET_HAS_SCC=y
 CONFIG_FS_ENET_HAS_FEC=y
@@ -547,6 +521,7 @@ CONFIG_GEN_RTC=y
 # Dallas's 1-wire bus
 #
 # CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
 # CONFIG_SENSORS_ABITUGURU is not set
@@ -587,10 +562,7 @@ CONFIG_DAB=y
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
 
-- 
1.5.0.3
