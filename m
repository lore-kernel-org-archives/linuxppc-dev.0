Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37A75679F7
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2006 07:26:34 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3JLQWtR022358
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2006 17:26:32 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3JLQWLx231262
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2006 17:26:32 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3JLQVWR014446
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2006 17:26:31 -0400
Subject: [PATCH] update {g5,iseries,pseries}_defconfigs
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Content-Type: text/plain
Date: Wed, 19 Apr 2006 16:26:22 -0500
Message-Id: <1145481982.22798.12.camel@localhost.localdomain>
Mime-Version: 1.0
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, 
This patch is cosmetic, makes a handful of "nonexistent symbol" warnings
go away.     Systems I have access to are clearly pseries or g5.  I am
not sure if ppc64_defconfig is redundant or meant for a subset, so I
didnt touch that one. 

Default choices for all.

Signed-off-by: Will Schmidt <willschm@us.ibm.com>


diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 2c3fd20..a456275 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16-rc2
-# Fri Feb 10 17:33:08 2006
+# Linux kernel version: 2.6.17-rc1
+# Wed Apr 19 13:24:37 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -9,6 +9,7 @@ CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
@@ -29,6 +30,7 @@ CONFIG_POWER4=y
 CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
+CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=4
 
@@ -53,6 +55,7 @@ CONFIG_SYSCTL=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_EMBEDDED is not set
@@ -67,10 +70,6 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -82,7 +81,6 @@ CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_KMOD=y
@@ -91,6 +89,7 @@ CONFIG_STOP_MACHINE=y
 #
 # Block layer
 #
+# CONFIG_BLK_DEV_IO_TRACE is not set
 
 #
 # IO Schedulers
@@ -185,7 +184,6 @@ CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
-CONFIG_PCI_LEGACY_PROC=y
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -227,6 +225,7 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
+CONFIG_INET_XFRM_TUNNEL=m
 CONFIG_INET_TUNNEL=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
@@ -238,6 +237,8 @@ CONFIG_TCP_CONG_BIC=y
 #
 # CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
 
@@ -261,6 +262,7 @@ CONFIG_IP_NF_IRC=m
 CONFIG_IP_NF_TFTP=m
 CONFIG_IP_NF_AMANDA=m
 # CONFIG_IP_NF_PPTP is not set
+# CONFIG_IP_NF_H323 is not set
 CONFIG_IP_NF_QUEUE=m
 
 #
@@ -513,6 +515,7 @@ CONFIG_MD_RAID0=y
 CONFIG_MD_RAID1=y
 CONFIG_MD_RAID10=m
 CONFIG_MD_RAID5=y
+# CONFIG_MD_RAID5_RESHAPE is not set
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
@@ -761,7 +764,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
-# CONFIG_RTC is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_DTLK is not set
@@ -772,6 +774,7 @@ CONFIG_GEN_RTC=y
 # Ftape, the floppy tape device driver
 #
 CONFIG_AGP=m
+# CONFIG_AGP_VIA is not set
 CONFIG_AGP_UNINORTH=m
 # CONFIG_DRM is not set
 CONFIG_RAW_DRIVER=y
@@ -813,7 +816,6 @@ CONFIG_I2C_POWERMAC=y
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
-# CONFIG_SCx200_ACB is not set
 # CONFIG_I2C_SIS5595 is not set
 # CONFIG_I2C_SIS630 is not set
 # CONFIG_I2C_SIS96X is not set
@@ -832,9 +834,7 @@ CONFIG_I2C_POWERMAC=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_RTC8564 is not set
 # CONFIG_SENSORS_MAX6875 is not set
-# CONFIG_RTC_X1205_I2C is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
@@ -862,10 +862,6 @@ CONFIG_I2C_POWERMAC=y
 #
 
 #
-# Multimedia Capabilities Port drivers
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -874,6 +870,7 @@ CONFIG_I2C_POWERMAC=y
 # Digital Video Broadcasting Devices
 #
 # CONFIG_DVB is not set
+# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
@@ -883,6 +880,7 @@ CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
 CONFIG_FB_MACMODES=y
+CONFIG_FB_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
 # CONFIG_FB_CIRRUS is not set
@@ -901,7 +899,6 @@ CONFIG_FB_NVIDIA=y
 CONFIG_FB_NVIDIA_I2C=y
 # CONFIG_FB_RIVA is not set
 # CONFIG_FB_MATROX is not set
-# CONFIG_FB_RADEON_OLD is not set
 CONFIG_FB_RADEON=y
 CONFIG_FB_RADEON_I2C=y
 # CONFIG_FB_RADEON_DEBUG is not set
@@ -958,9 +955,11 @@ CONFIG_SND_SEQUENCER=m
 CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
+CONFIG_SND_PCM_OSS_PLUGINS=y
 CONFIG_SND_SEQUENCER_OSS=y
 # CONFIG_SND_DYNAMIC_MINORS is not set
 CONFIG_SND_SUPPORT_OLD_API=y
+CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_VERBOSE_PRINTK is not set
 # CONFIG_SND_DEBUG is not set
 
@@ -977,6 +976,7 @@ CONFIG_SND_SUPPORT_OLD_API=y
 # PCI devices
 #
 # CONFIG_SND_AD1889 is not set
+# CONFIG_SND_ALS300 is not set
 # CONFIG_SND_ALS4000 is not set
 # CONFIG_SND_ALI5451 is not set
 # CONFIG_SND_ATIIXP is not set
@@ -1009,6 +1009,7 @@ CONFIG_SND_SUPPORT_OLD_API=y
 # CONFIG_SND_MIXART is not set
 # CONFIG_SND_NM256 is not set
 # CONFIG_SND_PCXHR is not set
+# CONFIG_SND_RIPTIDE is not set
 # CONFIG_SND_RME32 is not set
 # CONFIG_SND_RME96 is not set
 # CONFIG_SND_RME9652 is not set
@@ -1041,6 +1042,7 @@ CONFIG_SND_USB_AUDIO=m
 #
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=y
 # CONFIG_USB_DEBUG is not set
 
@@ -1068,7 +1070,6 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 #
 # USB Device Class drivers
 #
-# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
 CONFIG_USB_ACM=m
 CONFIG_USB_PRINTER=y
 
@@ -1126,15 +1127,6 @@ CONFIG_USB_HIDDEV=y
 # CONFIG_USB_MICROTEK is not set
 
 #
-# USB Multimedia devices
-#
-# CONFIG_USB_DABUSB is not set
-
-#
-# Video4Linux support is needed for USB Multimedia device support
-#
-
-#
 # USB Network Adapters
 #
 CONFIG_USB_CATC=m
@@ -1194,6 +1186,7 @@ CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
 CONFIG_USB_SERIAL_KLSI=m
 CONFIG_USB_SERIAL_KOBIL_SCT=m
 CONFIG_USB_SERIAL_MCT_U232=m
+# CONFIG_USB_SERIAL_NAVMAN is not set
 CONFIG_USB_SERIAL_PL2303=m
 # CONFIG_USB_SERIAL_HP4X is not set
 CONFIG_USB_SERIAL_SAFE=m
@@ -1237,17 +1230,23 @@ CONFIG_USB_EZUSB=y
 # CONFIG_MMC is not set
 
 #
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
 # InfiniBand support
 #
 # CONFIG_INFINIBAND is not set
 
 #
-# SN Devices
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
 #
 
 #
-# EDAC - error detection and reporting (RAS)
+# Real Time Clock
 #
+# CONFIG_RTC_CLASS is not set
 
 #
 # File systems
@@ -1319,7 +1318,6 @@ CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
 CONFIG_HUGETLB_PAGE=y
 CONFIG_RAMFS=y
-# CONFIG_RELAYFS_FS is not set
 # CONFIG_CONFIGFS_FS is not set
 
 #
diff --git a/arch/powerpc/configs/iseries_defconfig b/arch/powerpc/configs/iseries_defconfig
index 1816a46..a95e455 100644
--- a/arch/powerpc/configs/iseries_defconfig
+++ b/arch/powerpc/configs/iseries_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16-rc6
-# Wed Mar 15 16:19:52 2006
+# Linux kernel version: 2.6.17-rc1
+# Wed Apr 19 11:46:44 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -9,6 +9,7 @@ CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
@@ -30,6 +31,7 @@ CONFIG_POWER4=y
 CONFIG_PPC_FPU=y
 # CONFIG_ALTIVEC is not set
 CONFIG_PPC_STD_MMU=y
+CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=32
 
@@ -55,6 +57,7 @@ CONFIG_AUDITSYSCALL=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_EMBEDDED is not set
@@ -69,10 +72,6 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -84,7 +83,6 @@ CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_KMOD=y
@@ -93,6 +91,7 @@ CONFIG_STOP_MACHINE=y
 #
 # Block layer
 #
+# CONFIG_BLK_DEV_IO_TRACE is not set
 
 #
 # IO Schedulers
@@ -165,7 +164,6 @@ CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
-CONFIG_PCI_LEGACY_PROC=y
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -207,6 +205,7 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
+CONFIG_INET_XFRM_TUNNEL=m
 CONFIG_INET_TUNNEL=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
@@ -218,6 +217,8 @@ CONFIG_TCP_CONG_BIC=y
 #
 # CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
 
@@ -236,11 +237,14 @@ CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
 CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
 # CONFIG_NETFILTER_XT_MATCH_DCCP is not set
+# CONFIG_NETFILTER_XT_MATCH_ESP is not set
 CONFIG_NETFILTER_XT_MATCH_HELPER=m
 CONFIG_NETFILTER_XT_MATCH_LENGTH=m
 CONFIG_NETFILTER_XT_MATCH_LIMIT=m
 CONFIG_NETFILTER_XT_MATCH_MAC=m
 CONFIG_NETFILTER_XT_MATCH_MARK=m
+# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
+# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
 CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
 CONFIG_NETFILTER_XT_MATCH_REALM=m
 CONFIG_NETFILTER_XT_MATCH_SCTP=m
@@ -262,20 +266,19 @@ CONFIG_IP_NF_IRC=m
 CONFIG_IP_NF_TFTP=m
 CONFIG_IP_NF_AMANDA=m
 # CONFIG_IP_NF_PPTP is not set
+# CONFIG_IP_NF_H323 is not set
 CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_IPRANGE=m
-CONFIG_IP_NF_MATCH_MULTIPORT=m
 CONFIG_IP_NF_MATCH_TOS=m
 CONFIG_IP_NF_MATCH_RECENT=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_DSCP=m
-CONFIG_IP_NF_MATCH_AH_ESP=m
+# CONFIG_IP_NF_MATCH_AH is not set
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_MATCH_OWNER=m
 CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_HASHLIMIT=m
-CONFIG_IP_NF_MATCH_POLICY=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_LOG=m
@@ -479,6 +482,7 @@ CONFIG_MD_RAID0=y
 CONFIG_MD_RAID1=y
 CONFIG_MD_RAID10=m
 CONFIG_MD_RAID5=y
+# CONFIG_MD_RAID5_RESHAPE is not set
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
@@ -702,7 +706,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
-# CONFIG_RTC is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_DTLK is not set
@@ -751,10 +754,6 @@ CONFIG_MAX_RAW_DEVS=256
 #
 
 #
-# Multimedia Capabilities Port drivers
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -779,6 +778,7 @@ CONFIG_MAX_RAW_DEVS=256
 #
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_USB is not set
 
 #
@@ -796,6 +796,11 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_MMC is not set
 
 #
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
 # InfiniBand support
 #
 # CONFIG_INFINIBAND is not set
@@ -805,6 +810,11 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 #
 
 #
+# Real Time Clock
+#
+# CONFIG_RTC_CLASS is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -878,7 +888,6 @@ CONFIG_TMPFS=y
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-# CONFIG_RELAYFS_FS is not set
 # CONFIG_CONFIGFS_FS is not set
 
 #
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index daaf038..58e68ce 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16-rc2
-# Fri Feb 10 17:33:32 2006
+# Linux kernel version: 2.6.17-rc1
+# Wed Apr 19 11:48:00 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -9,6 +9,7 @@ CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
@@ -30,6 +31,7 @@ CONFIG_POWER4=y
 CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
+CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=128
 
@@ -55,6 +57,7 @@ CONFIG_AUDITSYSCALL=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CPUSETS=y
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_EMBEDDED is not set
@@ -69,10 +72,6 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -84,7 +83,6 @@ CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_KMOD=y
@@ -93,6 +91,7 @@ CONFIG_STOP_MACHINE=y
 #
 # Block layer
 #
+# CONFIG_BLK_DEV_IO_TRACE is not set
 
 #
 # IO Schedulers
@@ -188,7 +187,6 @@ CONFIG_PPC_I8259=y
 # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
-CONFIG_PCI_LEGACY_PROC=y
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -235,6 +233,7 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
+CONFIG_INET_XFRM_TUNNEL=m
 CONFIG_INET_TUNNEL=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
@@ -246,6 +245,8 @@ CONFIG_TCP_CONG_BIC=y
 #
 # CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
 
@@ -272,6 +273,7 @@ CONFIG_IP_NF_IRC=m
 CONFIG_IP_NF_TFTP=m
 CONFIG_IP_NF_AMANDA=m
 # CONFIG_IP_NF_PPTP is not set
+# CONFIG_IP_NF_H323 is not set
 CONFIG_IP_NF_QUEUE=m
 
 #
@@ -519,6 +521,7 @@ CONFIG_MD_RAID0=y
 CONFIG_MD_RAID1=y
 CONFIG_MD_RAID10=m
 CONFIG_MD_RAID5=y
+# CONFIG_MD_RAID5_RESHAPE is not set
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
@@ -750,6 +753,7 @@ CONFIG_HW_CONSOLE=y
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
@@ -767,7 +771,9 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_PRINTER is not set
 # CONFIG_PPDEV is not set
 # CONFIG_TIPAR is not set
+CONFIG_HVC_DRIVER=y
 CONFIG_HVC_CONSOLE=y
+# CONFIG_HVC_RTAS is not set
 CONFIG_HVCS=m
 
 #
@@ -779,7 +785,6 @@ CONFIG_HVCS=m
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
-# CONFIG_RTC is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_DTLK is not set
@@ -830,7 +835,6 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
-# CONFIG_SCx200_ACB is not set
 # CONFIG_I2C_SIS5595 is not set
 # CONFIG_I2C_SIS630 is not set
 # CONFIG_I2C_SIS96X is not set
@@ -849,9 +853,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_RTC8564 is not set
 # CONFIG_SENSORS_MAX6875 is not set
-# CONFIG_RTC_X1205_I2C is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
@@ -879,10 +881,6 @@ CONFIG_I2C_ALGOBIT=y
 #
 
 #
-# Multimedia Capabilities Port drivers
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -891,6 +889,7 @@ CONFIG_I2C_ALGOBIT=y
 # Digital Video Broadcasting Devices
 #
 # CONFIG_DVB is not set
+# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
@@ -900,6 +899,7 @@ CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
 CONFIG_FB_MACMODES=y
+CONFIG_FB_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
 # CONFIG_FB_CIRRUS is not set
@@ -919,7 +919,6 @@ CONFIG_FB_MATROX_MYSTIQUE=y
 CONFIG_FB_MATROX_G=y
 # CONFIG_FB_MATROX_I2C is not set
 CONFIG_FB_MATROX_MULTIHEAD=y
-# CONFIG_FB_RADEON_OLD is not set
 CONFIG_FB_RADEON=y
 CONFIG_FB_RADEON_I2C=y
 # CONFIG_FB_RADEON_DEBUG is not set
@@ -968,6 +967,7 @@ CONFIG_LCD_DEVICE=y
 #
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=y
 # CONFIG_USB_DEBUG is not set
 
@@ -1048,15 +1048,6 @@ CONFIG_USB_HIDDEV=y
 # CONFIG_USB_MICROTEK is not set
 
 #
-# USB Multimedia devices
-#
-# CONFIG_USB_DABUSB is not set
-
-#
-# Video4Linux support is needed for USB Multimedia device support
-#
-
-#
 # USB Network Adapters
 #
 # CONFIG_USB_CATC is not set
@@ -1109,6 +1100,11 @@ CONFIG_USB_MON=y
 # CONFIG_MMC is not set
 
 #
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
 # InfiniBand support
 #
 CONFIG_INFINIBAND=m
@@ -1121,12 +1117,13 @@ CONFIG_INFINIBAND_IPOIB=m
 # CONFIG_INFINIBAND_SRP is not set
 
 #
-# SN Devices
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
 #
 
 #
-# EDAC - error detection and reporting (RAS)
+# Real Time Clock
 #
+# CONFIG_RTC_CLASS is not set
 
 #
 # File systems
@@ -1202,7 +1199,6 @@ CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
 CONFIG_HUGETLB_PAGE=y
 CONFIG_RAMFS=y
-# CONFIG_RELAYFS_FS is not set
 # CONFIG_CONFIGFS_FS is not set
 
 #
