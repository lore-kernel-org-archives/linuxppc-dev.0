Return-Path: <ivan@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRLVN0ZlKzDqbw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 23:08:11 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4FD40mE059543
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 09:08:06 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2afcnkh3fa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 09:08:05 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ivan@de.ibm.com>;
 Mon, 15 May 2017 14:08:03 +0100
From: Ivan Mikhaylov <ivan@de.ibm.com>
To: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@ozlabs.au.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3/4] arch/powerpc/44x/fsp2: add defconfig for fsp2 board
Date: Mon, 15 May 2017 16:07:53 +0300
Message-Id: <20170515130754.59363-4-ivan@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

this patch adds default fsp2 config for main usage.

Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
---
 arch/powerpc/configs/44x/fsp2_defconfig |  126 +++++++++++++++++++++++++++++++
 1 files changed, 126 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/configs/44x/fsp2_defconfig

diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
new file mode 100644
index 0000000..e8e6a69
--- /dev/null
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -0,0 +1,126 @@
+CONFIG_44x=y
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+# CONFIG_FHANDLE is not set
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=16
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+CONFIG_KALLSYMS_ALL=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_EMBEDDED=y
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PPC_47x=y
+# CONFIG_EBONY is not set
+CONFIG_FSP2=y
+CONFIG_476FPE_ERR46=y
+CONFIG_SWIOTLB=y
+CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="ip=on rw"
+# CONFIG_SUSPEND is not set
+# CONFIG_PCI is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_IPV6 is not set
+CONFIG_VLAN_8021Q=m
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_CONNECTOR=y
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=35000
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+# CONFIG_SATA_PMP is not set
+# CONFIG_ATA_SFF is not set
+CONFIG_NETDEVICES=y
+CONFIG_BONDING=m
+CONFIG_IBM_EMAC=m
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=32
+CONFIG_SERIAL_8250_RUNTIME_UARTS=32
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_IBM_IIC=y
+CONFIG_PTP_1588_CLOCK=y
+# CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_BOOKE_WDT=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_MMC=y
+CONFIG_MMC_DEBUG=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_ARASAN=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_M41T80=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_WBUF_VERIFY=y
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_JFFS2_FS_XATTR=y
+CONFIG_CRAMFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_DEFAULT="n"
+CONFIG_XZ_DEC=y
+CONFIG_PRINTK_TIME=y
+CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_PCBC=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_HW is not set
-- 
1.7.1
