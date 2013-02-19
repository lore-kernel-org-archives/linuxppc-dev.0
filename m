Return-Path: <hrai@nmglablinux22.freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A817D2C03B5
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2013 20:14:59 +1100 (EST)
Received: from mail37-co1 (localhost [127.0.0.1])	by mail37-co1-R.bigfish.com
 (Postfix) with ESMTP id 737CCB0007A	for <linuxppc-dev@ozlabs.org>;
 Tue, 19 Feb 2013 09:14:56 +0000 (UTC)
Received: from CO1EHSMHS005.bigfish.com (unknown [10.243.78.220])	by
 mail37-co1.bigfish.com (Postfix) with ESMTP id F1A7D6A0046	for
 <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2013 09:14:53 +0000 (UTC)
From: Harninder Rai <harninder.rai@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] bsc913x:defconfig: Add new defconfig file for BSC913x
 platforms
Date: Tue, 19 Feb 2013 14:44:50 +0530
Message-ID: <1361265290-28206-1-git-send-email-harninder.rai@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Harninder Rai <harninder.rai@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BSC913x are heterogeneous platforms having DSP and PowerPC.
* Lot of new IPs like AIC (Antenna Interface Controller), RF (radio) etc
* Such IPs are not present in any other 85xx platform
* Lot of optimizations related to ethernet/ASF (Application Specific Fastpath)
  are enabled in this config
* IPC for inter-domain communication (DSP and PA) is present

Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
---
 arch/powerpc/configs/qoriq_sdk_asf_term_defconfig |  209 +++++++++++++++++++++
 1 files changed, 209 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/configs/qoriq_sdk_asf_term_defconfig

diff --git a/arch/powerpc/configs/qoriq_sdk_asf_term_defconfig b/arch/powerpc/configs/qoriq_sdk_asf_term_defconfig
new file mode 100644
index 0000000..6ded6af
--- /dev/null
+++ b/arch/powerpc/configs/qoriq_sdk_asf_term_defconfig
@@ -0,0 +1,209 @@
+CONFIG_PPC_85xx=y
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_AUDIT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_PERF_EVENTS is not set
+CONFIG_SLAB=y
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_MAC_PARTITION=y
+# CONFIG_EFI_PARTITION is not set
+CONFIG_BSC9131_RDB=y
+CONFIG_HIGHMEM=y
+CONFIG_PREEMPT=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_MATH_EMULATION=y
+CONFIG_SWIOTLB=y
+CONFIG_PCI=y
+CONFIG_PCIEPORTBUS=y
+# CONFIG_PCIEAER is not set
+# CONFIG_PCIEASPM is not set
+CONFIG_PCI_MSI=y
+CONFIG_ADVANCED_OPTIONS=y
+CONFIG_LOWMEM_CAM_NUM_BOOL=y
+CONFIG_LOWMEM_CAM_NUM=6
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM_USER=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_NET_IPIP=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_ARPD=y
+CONFIG_INET_AH=y
+CONFIG_INET_ESP=y
+CONFIG_INET_IPCOMP=y
+# CONFIG_INET_LRO is not set
+CONFIG_IPV6=y
+CONFIG_INET6_AH=y
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CONNTRACK_EVENTS=y
+CONFIG_NF_CONNTRACK_FTP=y
+CONFIG_NF_CONNTRACK_TFTP=y
+CONFIG_NETFILTER_XT_MATCH_HL=y
+CONFIG_NF_CONNTRACK_IPV4=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP_NF_FILTER=y
+CONFIG_IP_NF_TARGET_REJECT=y
+CONFIG_IP_NF_MANGLE=y
+CONFIG_BRIDGE=y
+CONFIG_VLAN_8021Q=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_FTL=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_PLATFORM=y
+CONFIG_MTD_NAND_FSL_ELBC=y
+CONFIG_MTD_NAND_FSL_IFC=y
+CONFIG_MTD_NAND_FSL_UPM=y
+CONFIG_MTD_UBI=y
+CONFIG_PROC_DEVICETREE=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_ST=y
+CONFIG_BLK_DEV_SR=y
+CONFIG_CHR_DEV_SG=y
+CONFIG_SCSI_MULTI_LUN=y
+CONFIG_SCSI_LOGGING=y
+CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
+CONFIG_SATA_FSL=y
+CONFIG_SATA_SIL24=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_MD=y
+# CONFIG_MD_AUTODETECT is not set
+CONFIG_MD_RAID456=y
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=y
+CONFIG_MII=y
+# CONFIG_NET_VENDOR_3COM is not set
+CONFIG_GIANFAR=y
+CONFIG_E1000E=y
+CONFIG_VITESSE_PHY=y
+CONFIG_FIXED_PHY=y
+CONFIG_PPP=y
+CONFIG_PPPOE=y
+CONFIG_PPP_ASYNC=y
+CONFIG_INPUT_FF_MEMLESS=m
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_SERIO_LIBPS2=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_DETECT_IRQ=y
+CONFIG_SERIAL_8250_RSA=y
+CONFIG_NVRAM=y
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MPC=y
+CONFIG_SPI=y
+CONFIG_SPI_BITBANG=y
+CONFIG_SPI_FSL_SPI=y
+CONFIG_SPI_FSL_ESPI=y
+CONFIG_GPIOLIB=y
+# CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_NOWAYOUT=y
+CONFIG_BOOKE_WDT=y
+CONFIG_VIDEO_OUTPUT_CONTROL=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_FSL=y
+CONFIG_USB_STORAGE=y
+CONFIG_MMC=y
+CONFIG_MMC_UNSAFE_RESUME=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_ESDHC=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_DS3232=y
+CONFIG_RTC_DRV_CMOS=y
+CONFIG_DMADEVICES=y
+CONFIG_FSL_DMA=y
+# CONFIG_NET_DMA is not set
+CONFIG_ASYNC_TX_DMA=y
+CONFIG_UIO=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_XFS_FS=y
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=y
+CONFIG_NTFS_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=1
+CONFIG_JFFS2_FS_WBUF_VERIFY=y
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_JFFS2_FS_XATTR=y
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RUBIN=y
+CONFIG_UBIFS_FS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=y
+CONFIG_CIFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_CRC_T10DIF=y
+# CONFIG_FTRACE is not set
+CONFIG_CRYPTO_NULL=y
+CONFIG_CRYPTO_CTR=y
+CONFIG_CRYPTO_PCBC=y
+CONFIG_CRYPTO_XCBC=y
+CONFIG_CRYPTO_SHA512=y
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_DEV_FSL_CAAM=y
+CONFIG_CRYPTO_DEV_FSL_CAAM_INTC=y
-- 
1.7.6.GIT
