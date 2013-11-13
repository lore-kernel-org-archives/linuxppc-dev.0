Return-Path: <Lijun.Pan@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 687212C00A9
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Nov 2013 10:25:12 +1100 (EST)
Received: from mail7-co1 (localhost [127.0.0.1])	by mail7-co1-R.bigfish.com
 (Postfix) with ESMTP id 0AFC38C0A54	for <linuxppc-dev@ozlabs.org>; Wed, 13
 Nov 2013 23:25:08 +0000 (UTC)
Received: from CO1EHSMHS026.bigfish.com (unknown [10.243.78.239])	by
 mail7-co1.bigfish.com (Postfix) with ESMTP id EE0336A02D8	for
 <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 23:25:05 +0000 (UTC)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH v3] powerpc/85xx: Merge 85xx/p1023_defconfig into
 mpc85xx_smp_defconfig and mpc85xx_defconfig
Date: Wed, 13 Nov 2013 17:24:59 -0600
Message-ID: <1384385099-27051-1-git-send-email-Lijun.Pan@freescale.com>
In-Reply-To: <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>
References: <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Lijun Pan <Lijun.Pan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc85xx_smp_defconfig and mpc85xx_defconfig already have CONFIG_P1023RDS=y.
Merge CONFIG_P1023RDB=y and other relevant configurations into mpc85xx_smp_defconfig and mpc85_defconfig.

Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
---
 arch/powerpc/configs/85xx/p1023_defconfig  |  188 ----------------------------
 arch/powerpc/configs/mpc85xx_defconfig     |    3 +
 arch/powerpc/configs/mpc85xx_smp_defconfig |    3 +
 3 files changed, 6 insertions(+), 188 deletions(-)
 delete mode 100644 arch/powerpc/configs/85xx/p1023_defconfig

diff --git a/arch/powerpc/configs/85xx/p1023_defconfig b/arch/powerpc/configs/85xx/p1023_defconfig
deleted file mode 100644
index b06d37d..0000000
--- a/arch/powerpc/configs/85xx/p1023_defconfig
+++ /dev/null
@@ -1,188 +0,0 @@
-CONFIG_PPC_85xx=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=2
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_AUDIT=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_RCU_FANOUT=32
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_EMBEDDED=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_MAC_PARTITION=y
-CONFIG_PHYSICAL_START=0x00000000
-CONFIG_P1023_RDB=y
-CONFIG_P1023_RDS=y
-CONFIG_QUICC_ENGINE=y
-CONFIG_QE_GPIO=y
-CONFIG_CPM2=y
-CONFIG_HIGHMEM=y
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_BINFMT_MISC=m
-CONFIG_MATH_EMULATION=y
-CONFIG_SWIOTLB=y
-CONFIG_PCI=y
-CONFIG_PCIEPORTBUS=y
-# CONFIG_PCIEAER is not set
-# CONFIG_PCIEASPM is not set
-CONFIG_PCI_MSI=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_XFRM_USER=y
-CONFIG_NET_KEY=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_ROUTE_MULTIPATH=y
-CONFIG_IP_ROUTE_VERBOSE=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-CONFIG_NET_IPIP=y
-CONFIG_IP_MROUTE=y
-CONFIG_IP_PIMSM_V1=y
-CONFIG_IP_PIMSM_V2=y
-CONFIG_ARPD=y
-CONFIG_INET_ESP=y
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-CONFIG_IPV6=y
-CONFIG_IP_SCTP=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_FSL_ELBC=y
-CONFIG_PROC_DEVICETREE=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=131072
-CONFIG_EEPROM_AT24=y
-CONFIG_EEPROM_LEGACY=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_ST=y
-CONFIG_BLK_DEV_SR=y
-CONFIG_CHR_DEV_SG=y
-CONFIG_SCSI_MULTI_LUN=y
-CONFIG_SCSI_LOGGING=y
-CONFIG_ATA=y
-CONFIG_SATA_FSL=y
-CONFIG_SATA_SIL24=y
-CONFIG_NETDEVICES=y
-CONFIG_DUMMY=y
-CONFIG_FS_ENET=y
-CONFIG_FSL_PQ_MDIO=y
-CONFIG_E1000E=y
-CONFIG_PHYLIB=y
-CONFIG_AT803X_PHY=y
-CONFIG_MARVELL_PHY=y
-CONFIG_DAVICOM_PHY=y
-CONFIG_CICADA_PHY=y
-CONFIG_VITESSE_PHY=y
-CONFIG_FIXED_PHY=y
-CONFIG_INPUT_FF_MEMLESS=m
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_SERIO_LIBPS2=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=2
-CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-CONFIG_SERIAL_8250_EXTENDED=y
-CONFIG_SERIAL_8250_MANY_PORTS=y
-CONFIG_SERIAL_8250_SHARE_IRQ=y
-CONFIG_SERIAL_8250_DETECT_IRQ=y
-CONFIG_SERIAL_8250_RSA=y
-CONFIG_HW_RANDOM=y
-CONFIG_NVRAM=y
-CONFIG_I2C=y
-CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_CPM=m
-CONFIG_I2C_MPC=y
-CONFIG_GPIO_MPC8XXX=y
-# CONFIG_HWMON is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=y
-CONFIG_SOUND=y
-CONFIG_SND=y
-CONFIG_SND_MIXER_OSS=y
-CONFIG_SND_PCM_OSS=y
-# CONFIG_SND_SUPPORT_OLD_API is not set
-CONFIG_USB=y
-CONFIG_USB_DEVICEFS=y
-CONFIG_USB_MON=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_STORAGE=y
-CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_DS1307=y
-CONFIG_RTC_DRV_CMOS=y
-CONFIG_DMADEVICES=y
-CONFIG_FSL_DMA=y
-# CONFIG_NET_DMA is not set
-CONFIG_STAGING=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_ISO9660_FS=m
-CONFIG_JOLIET=y
-CONFIG_ZISOFS=y
-CONFIG_UDF_FS=m
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=y
-CONFIG_NTFS_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_ADFS_FS=m
-CONFIG_AFFS_FS=m
-CONFIG_HFS_FS=m
-CONFIG_HFSPLUS_FS=m
-CONFIG_BEFS_FS=m
-CONFIG_BFS_FS=m
-CONFIG_EFS_FS=m
-CONFIG_CRAMFS=y
-CONFIG_VXFS_FS=m
-CONFIG_HPFS_FS=m
-CONFIG_QNX4FS_FS=m
-CONFIG_SYSV_FS=m
-CONFIG_UFS_FS=m
-CONFIG_NFS_FS=y
-CONFIG_NFS_V4=y
-CONFIG_ROOT_NFS=y
-CONFIG_NFSD=y
-CONFIG_CRC_T10DIF=y
-CONFIG_FRAME_WARN=8092
-CONFIG_DEBUG_FS=y
-CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_DEBUG_INFO=y
-CONFIG_STRICT_DEVMEM=y
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_SHA256=y
-CONFIG_CRYPTO_SHA512=y
-CONFIG_CRYPTO_AES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRYPTO_DEV_FSL_CAAM=y
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index d2e0fab..83d3550 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -31,6 +31,7 @@ CONFIG_C293_PCIE=y
 CONFIG_P1010_RDB=y
 CONFIG_P1022_DS=y
 CONFIG_P1022_RDK=y
+CONFIG_P1023_RDB=y
 CONFIG_P1023_RDS=y
 CONFIG_SOCRATES=y
 CONFIG_KSI8560=y
@@ -113,6 +114,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
@@ -211,6 +213,7 @@ CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
+CONFIG_RTC_DRV_DS1307=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
 # CONFIG_NET_DMA is not set
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 4cb7b59..4b68629 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -34,6 +34,7 @@ CONFIG_C293_PCIE=y
 CONFIG_P1010_RDB=y
 CONFIG_P1022_DS=y
 CONFIG_P1022_RDK=y
+CONFIG_P1023_RDB=y
 CONFIG_P1023_RDS=y
 CONFIG_SOCRATES=y
 CONFIG_KSI8560=y
@@ -116,6 +117,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
@@ -212,6 +214,7 @@ CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
+CONFIG_RTC_DRV_DS1307=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
 # CONFIG_NET_DMA is not set
-- 
1.7.9.7
