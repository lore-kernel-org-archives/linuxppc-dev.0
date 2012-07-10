Return-Path: <B36685@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32D9C2C030F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 21:01:21 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/fsl: Update corenet64_smp_defconfig
Date: Tue, 10 Jul 2012 18:40:02 +0800
Message-ID: <1341916802-19619-2-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1341916802-19619-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1341916802-19619-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Harninder Rai <harninder.rai@freescale.com>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Laurentiu Tudor <Laurentiu.Tudor@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 * Enable USB, MMC, SATA, MTD, NAND, PAMU, RTC
 * Enable FSL RAID on P5020
 * Enable general RAID features (MD + async-tx)
 * Enable RTC on P2041RDB
 * Enable UIO SRIO & UIO DMA
 * Enable USDPAA SHMEM driver
 * Enable ePAPR HV support
 * Enable PCI-E support

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/configs/corenet64_smp_defconfig |   94 ++++++++++++++++++++=
++++--
 1 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/=
configs/corenet64_smp_defconfig
index 6798343..14bbae7 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -5,14 +5,21 @@ CONFIG_SMP=3Dy
 CONFIG_NR_CPUS=3D2
 CONFIG_EXPERIMENTAL=3Dy
 CONFIG_SYSVIPC=3Dy
+CONFIG_POSIX_MQUEUE=3Dy
 CONFIG_BSD_PROCESS_ACCT=3Dy
+CONFIG_AUDIT=3Dy
 CONFIG_SPARSE_IRQ=3Dy
+CONFIG_RCU_TRACE=3Dy
+CONFIG_RCU_FANOUT=3D32
 CONFIG_IKCONFIG=3Dy
 CONFIG_IKCONFIG_PROC=3Dy
 CONFIG_LOG_BUF_SHIFT=3D14
 CONFIG_BLK_DEV_INITRD=3Dy
 CONFIG_EXPERT=3Dy
 CONFIG_KALLSYMS_ALL=3Dy
+CONFIG_EMBEDDED=3Dy
+CONFIG_PERF_EVENTS=3Dy
+CONFIG_SLAB=3Dy
 CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
 CONFIG_MODULE_FORCE_UNLOAD=3Dy
@@ -25,11 +32,18 @@ CONFIG_HIGH_RES_TIMERS=3Dy
 CONFIG_BINFMT_MISC=3Dm
 CONFIG_RAPIDIO=3Dy
 CONFIG_FSL_RIO=3Dy
+CONFIG_FSL_LBC=3Dy
+CONFIG_FSL_PAMU=3Dy
+CONFIG_PCIEPORTBUS=3Dy
+CONFIG_PCI_MSI=3Dy
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_UNIX=3Dy
 CONFIG_XFRM_USER=3Dy
+CONFIG_XFRM_SUB_POLICY=3Dy
+CONFIG_XFRM_STATISTICS=3Dy
 CONFIG_NET_KEY=3Dy
+CONFIG_NET_KEY_MIGRATE=3Dy
 CONFIG_INET=3Dy
 CONFIG_IP_MULTICAST=3Dy
 CONFIG_IP_ADVANCED_ROUTER=3Dy
@@ -45,60 +59,130 @@ CONFIG_IP_MROUTE=3Dy
 CONFIG_IP_PIMSM_V1=3Dy
 CONFIG_IP_PIMSM_V2=3Dy
 CONFIG_ARPD=3Dy
+CONFIG_INET_AH=3Dy
 CONFIG_INET_ESP=3Dy
+CONFIG_INET_IPCOMP=3Dy
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_LRO is not set
 CONFIG_IPV6=3Dy
 CONFIG_IP_SCTP=3Dm
 CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
+CONFIG_MTD=3Dy
+CONFIG_MTD_CMDLINE_PARTS=3Dy
+CONFIG_MTD_CHAR=3Dy
+CONFIG_MTD_BLOCK=3Dy
+CONFIG_MTD_CFI=3Dy
+CONFIG_MTD_CFI_AMDSTD=3Dy
+CONFIG_MTD_PHYSMAP_OF=3Dy
+CONFIG_MTD_M25P80=3Dy
 CONFIG_PROC_DEVICETREE=3Dy
 CONFIG_BLK_DEV_LOOP=3Dy
 CONFIG_BLK_DEV_RAM=3Dy
-CONFIG_BLK_DEV_RAM_SIZE=3D131072
+CONFIG_BLK_DEV_RAM_SIZE=3D262144
 CONFIG_MISC_DEVICES=3Dy
 CONFIG_EEPROM_LEGACY=3Dy
-CONFIG_NETDEVICES=3Dy
+CONFIG_BLK_DEV_SD=3Dy
+CONFIG_CHR_DEV_ST=3Dy
+CONFIG_BLK_DEV_SR=3Dy
+CONFIG_CHR_DEV_SG=3Dy
+CONFIG_SCSI_MULTI_LUN=3Dy
+CONFIG_SCSI_LOGGING=3Dy
+CONFIG_SCSI_SPI_ATTRS=3Dy
+CONFIG_ATA=3Dy
+CONFIG_SATA_FSL=3Dy
+CONFIG_SATA_SIL24=3Dy
+CONFIG_MD=3Dy
+CONFIG_BLK_DEV_MD=3Dy
+CONFIG_MD_RAID456=3Dy
+CONFIG_MULTICORE_RAID456=3Dy
 CONFIG_DUMMY=3Dy
 CONFIG_INPUT_FF_MEMLESS=3Dm
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_SERIO_LIBPS2=3Dy
+CONFIG_PPC_EPAPR_HV_BYTECHAN=3Dy
 CONFIG_SERIAL_8250=3Dy
 CONFIG_SERIAL_8250_CONSOLE=3Dy
 CONFIG_SERIAL_8250_EXTENDED=3Dy
 CONFIG_SERIAL_8250_MANY_PORTS=3Dy
 CONFIG_SERIAL_8250_DETECT_IRQ=3Dy
 CONFIG_SERIAL_8250_RSA=3Dy
+CONFIG_HW_RANDOM=3Dy
 CONFIG_I2C=3Dy
 CONFIG_I2C_CHARDEV=3Dy
 CONFIG_I2C_MPC=3Dy
+CONFIG_SPI=3Dy
+CONFIG_SPI_GPIO=3Dy
+CONFIG_SPI_FSL_SPI=3Dy
+CONFIG_SPI_FSL_ESPI=3Dy
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=3Dy
-# CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB_HID=3Dm
+CONFIG_USB=3Dy
+CONFIG_USB_DEVICEFS=3Dy
+CONFIG_USB_MON=3Dy
+CONFIG_USB_EHCI_HCD=3Dy
+CONFIG_USB_EHCI_FSL=3Dy
+CONFIG_USB_STORAGE=3Dy
+CONFIG_MMC=3Dy
+CONFIG_MMC_SDHCI=3Dy
+CONFIG_MMC_SDHCI_OF=3Dy
+CONFIG_MMC_SDHCI_OF_ESDHC=3Dy
+CONFIG_EDAC=3Dy
+CONFIG_EDAC_MM_EDAC=3Dy
+CONFIG_RTC_CLASS=3Dy
+CONFIG_RTC_DRV_DS3232=3Dy
+CONFIG_RTC_DRV_CMOS=3Dy
 CONFIG_DMADEVICES=3Dy
 CONFIG_FSL_DMA=3Dy
+CONFIG_FSL_RAID=3Dy
+CONFIG_ASYNC_TX_DMA=3Dy
+CONFIG_UIO=3Dy
+CONFIG_UIO_FSL_SRIO=3Dy
+CONFIG_UIO_FSL_DMA=3Dy
+CONFIG_STAGING=3Dy
+CONFIG_VIRT_DRIVERS=3Dy
+CONFIG_FSL_HV_MANAGER=3Dy
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT3_FS=3Dy
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_ISO9660_FS=3Dm
+CONFIG_JOLIET=3Dy
+CONFIG_ZISOFS=3Dy
+CONFIG_UDF_FS=3Dm
+CONFIG_MSDOS_FS=3Dm
+CONFIG_VFAT_FS=3Dy
+CONFIG_NTFS_FS=3Dy
 CONFIG_PROC_KCORE=3Dy
 CONFIG_TMPFS=3Dy
 CONFIG_HUGETLBFS=3Dy
+CONFIG_JFFS2_FS=3Dy
+CONFIG_CRAMFS=3Dy
+CONFIG_NFS_FS=3Dy
+CONFIG_NFS_V3=3Dy
+CONFIG_NFS_V4=3Dy
+CONFIG_ROOT_NFS=3Dy
+CONFIG_NFSD=3Dm
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_PARTITION_ADVANCED=3Dy
 CONFIG_MAC_PARTITION=3Dy
 CONFIG_NLS=3Dy
+CONFIG_NLS_ISO8859_1=3Dy
 CONFIG_NLS_UTF8=3Dm
 CONFIG_CRC_T10DIF=3Dy
 CONFIG_CRC_ITU_T=3Dm
 CONFIG_FRAME_WARN=3D1024
+CONFIG_MAGIC_SYSRQ=3Dy
+CONFIG_DEBUG_KERNEL=3Dy
+CONFIG_DEBUG_SHIRQ=3Dy
 CONFIG_DEBUG_FS=3Dy
 CONFIG_DETECT_HUNG_TASK=3Dy
 CONFIG_DEBUG_INFO=3Dy
 CONFIG_SYSCTL_SYSCALL_CHECK=3Dy
+CONFIG_CRYPTO_NULL=3Dy
 CONFIG_IRQ_DOMAIN_DEBUG=3Dy
 CONFIG_CRYPTO_PCBC=3Dm
+CONFIG_CRYPTO_MD4=3Dy
 CONFIG_CRYPTO_SHA256=3Dy
 CONFIG_CRYPTO_SHA512=3Dy
 CONFIG_CRYPTO_AES=3Dy
--=20
1.6.4
