Return-Path: <Lijun.Pan@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4E041A086D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 09:14:14 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0109.outbound.protection.outlook.com [157.56.111.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EEC6B140079
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2015 09:14:13 +1100 (AEDT)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/4] powerpc/corenet: miscellaneous changes on
 corenet64_smp_defconfig
Date: Thu, 2 Apr 2015 16:37:54 -0500
Message-ID: <1428010674-25361-4-git-send-email-Lijun.Pan@freescale.com>
In-Reply-To: <1428010674-25361-1-git-send-email-Lijun.Pan@freescale.com>
References: <1428010674-25361-1-git-send-email-Lijun.Pan@freescale.com>
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

Merge Freescale's Internal corenet64_smp_defconfig with upstream's.
Run savedefconfig to get the minimal change.

Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
---
 arch/powerpc/configs/corenet64_smp_defconfig | 42 ++++++++++++++++------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 33cd1df..f423271 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -4,7 +4,7 @@ CONFIG_ALTIVEC=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=24
 CONFIG_SYSVIPC=y
-CONFIG_FHANDLE=y
+CONFIG_POSIX_MQUEUE=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -12,13 +12,12 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CGROUPS=y
-CONFIG_CPUSETS=y
-CONFIG_CGROUP_CPUACCT=y
-CONFIG_CGROUP_SCHED=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+CONFIG_SLAB=y
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
@@ -26,6 +25,7 @@ CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
+CONFIG_PPC_QEMU_E500=y
 CONFIG_CORENET_GENERIC=y
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_BINFMT_MISC=m
@@ -33,13 +33,14 @@ CONFIG_MATH_EMULATION=y
 CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_MSI=y
-CONFIG_RAPIDIO=y
-CONFIG_FSL_RIO=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=y
+CONFIG_XFRM_SUB_POLICY=y
+CONFIG_XFRM_STATISTICS=y
 CONFIG_NET_KEY=y
+CONFIG_NET_KEY_MIGRATE=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_ADVANCED_ROUTER=y
@@ -54,11 +55,14 @@ CONFIG_NET_IPIP=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
+CONFIG_INET_AH=y
 CONFIG_INET_ESP=y
+CONFIG_INET_IPCOMP=y
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_LRO is not set
 CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
+CONFIG_VLAN_8021Q=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
@@ -73,19 +77,23 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_NAND_FSL_IFC=y
-CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
 CONFIG_EEPROM_LEGACY=y
 CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
-CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=y
+CONFIG_SCSI_LOGGING=y
+CONFIG_SCSI_SPI_ATTRS=y
 CONFIG_ATA=y
 CONFIG_SATA_FSL=y
 CONFIG_SATA_SIL24=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_MD=y
+CONFIG_MD_RAID456=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
 CONFIG_FSL_PQ_MDIO=y
@@ -109,8 +117,6 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
-CONFIG_I2C_MUX=y
-CONFIG_I2C_MUX_PCA954x=y
 CONFIG_SPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_SPI_FSL_SPI=y
@@ -125,18 +131,19 @@ CONFIG_USB_EHCI_FSL=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
-CONFIG_RTC_DRV_DS1374=y
 CONFIG_RTC_DRV_DS3232=y
+CONFIG_RTC_DRV_CMOS=y
 CONFIG_DMADEVICES=y
-CONFIG_FSL_DMA=y
+CONFIG_ASYNC_TX_DMA=y
+CONFIG_UIO=y
 CONFIG_VIRT_DRIVERS=y
 CONFIG_FSL_HV_MANAGER=y
-CONFIG_CLK_QORIQ=y
-CONFIG_FSL_CORENET_CF=y
+CONFIG_STAGING=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_ISO9660_FS=m
@@ -152,12 +159,11 @@ CONFIG_HUGETLBFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=1
 CONFIG_UBIFS_FS=y
+CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=m
 CONFIG_CRC_T10DIF=y
-- 
1.9.3
