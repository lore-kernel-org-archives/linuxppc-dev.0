Return-Path: <B36685@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 36B3F2C0204
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 21:01:21 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc/fsl: Update corenet64_smp_defconfig
Date: Wed, 11 Jul 2012 18:40:05 +0800
Message-ID: <1342003205-23378-2-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1342003205-23378-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1342003205-23378-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable USB, MMC, SATA, LBC, MTD, NAND, SPI, PCIe, EDAC, VFAT, NFS, etc.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/configs/corenet64_smp_defconfig |   59 ++++++++++++++++++++++++-
 1 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 6798343..7340be3 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -25,6 +25,9 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BINFMT_MISC=m
 CONFIG_RAPIDIO=y
 CONFIG_FSL_RIO=y
+CONFIG_FSL_LBC=y
+CONFIG_PCIEPORTBUS=y
+CONFIG_PCI_MSI=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -51,6 +54,19 @@ CONFIG_INET_ESP=y
 CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_NAND_ECC=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_FSL_IFC=y
+CONFIG_MTD_NAND_FSL_ELBC=y
+CONFIG_MTD_M25P80=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -58,6 +74,9 @@ CONFIG_BLK_DEV_RAM_SIZE=131072
 CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_NETDEVICES=y
+CONFIG_ATA=y
+CONFIG_SATA_FSL=y
+CONFIG_SATA_SIL24=y
 CONFIG_DUMMY=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
@@ -73,32 +92,66 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
+CONFIG_SPI=y
+CONFIG_SPI_GPIO=y
+CONFIG_SPI_FSL_SPI=y
+CONFIG_SPI_FSL_ESPI=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=y
-# CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB_HID=m
+CONFIG_USB=y
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_MON=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_FSL=y
+CONFIG_USB_STORAGE=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_OF=y
+CONFIG_MMC_SDHCI_OF_ESDHC=y
+CONFIG_EDAC=y
+CONFIG_EDAC_MM_EDAC=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=y
+CONFIG_NTFS_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
+CONFIG_JFFS2_FS=y
+CONFIG_CRAMFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=m
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
 CONFIG_NLS=y
+CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=m
 CONFIG_CRC_T10DIF=y
 CONFIG_CRC_ITU_T=m
 CONFIG_FRAME_WARN=1024
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_SHIRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_INFO=y
 CONFIG_SYSCTL_SYSCALL_CHECK=y
+CONFIG_CRYPTO_NULL=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_AES=y
-- 
1.6.4
