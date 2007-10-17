Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 51F99DDED8
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 02:56:24 +1000 (EST)
Received: from pd3mr3so.prod.shaw.ca
	(pd3mr3so-qfe3.prod.shaw.ca [10.0.141.179]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQ2002Q2F18ND40@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 17 Oct 2007 10:55:56 -0600 (MDT)
Received: from pn2ml4so.prod.shaw.ca ([10.0.121.148])
	by pd3mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQ200E5SF17OZD0@pd3mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 17 Oct 2007 10:55:57 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQ200L5DF16KFR2@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 17 Oct 2007 10:55:54 -0600 (MDT)
Date: Wed, 17 Oct 2007 10:55:59 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] lite5200: Add bestcomm to defconfigs
To: linuxppc-dev@ozlabs.org
Message-id: <20071017165559.25509.42109.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Add bestcomm to lite5200 defconfig

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/configs/lite5200_defconfig |   56 ++++++++++++++++++++++++-------
 1 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/configs/lite5200_defconfig b/arch/powerpc/configs/lite5200_defconfig
index d42e226..f231f44 100644
--- a/arch/powerpc/configs/lite5200_defconfig
+++ b/arch/powerpc/configs/lite5200_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc4
-# Tue Aug 28 21:24:38 2007
+# Linux kernel version: 2.6.23
+# Wed Oct 17 10:25:12 2007
 #
 # CONFIG_PPC64 is not set
 
@@ -21,8 +21,13 @@ CONFIG_PPC_STD_MMU_32=y
 # CONFIG_PPC_MM_SLICES is not set
 # CONFIG_SMP is not set
 CONFIG_PPC32=y
+CONFIG_WORD_SIZE=32
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -65,6 +70,8 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -83,7 +90,6 @@ CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
 # CONFIG_EPOLL is not set
 CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
@@ -122,7 +128,6 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 CONFIG_PPC_MULTIPLATFORM=y
-# CONFIG_EMBEDDED6xx is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 # CONFIG_PPC_86xx is not set
@@ -137,6 +142,7 @@ CONFIG_PPC_LITE5200=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PQ2ADS is not set
+# CONFIG_EMBEDDED6xx is not set
 # CONFIG_MPIC is not set
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -150,11 +156,19 @@ CONFIG_PPC_LITE5200=y
 # CONFIG_TAU is not set
 # CONFIG_CPM2 is not set
 # CONFIG_FSL_ULI1575 is not set
+CONFIG_PPC_BESTCOMM=y
+CONFIG_PPC_BESTCOMM_ATA=y
+CONFIG_PPC_BESTCOMM_FEC=y
+CONFIG_PPC_BESTCOMM_GEN_BD=y
 
 #
 # Kernel options
 #
 # CONFIG_HIGHMEM is not set
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
@@ -187,10 +201,13 @@ CONFIG_PM=y
 # CONFIG_PM_LEGACY is not set
 # CONFIG_PM_DEBUG is not set
 CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND_UP_POSSIBLE=y
 CONFIG_SUSPEND=y
+CONFIG_HIBERNATION_UP_POSSIBLE=y
 # CONFIG_HIBERNATION is not set
 CONFIG_SECCOMP=y
-# CONFIG_WANT_DEVICE_TREE is not set
+CONFIG_WANT_DEVICE_TREE=y
+CONFIG_DEVICE_TREE=""
 CONFIG_ISA_DMA_API=y
 
 #
@@ -225,7 +242,7 @@ CONFIG_ARCH_SUPPORTS_MSI=y
 CONFIG_HIGHMEM_START=0xfe000000
 CONFIG_LOWMEM_SIZE=0x30000000
 CONFIG_KERNEL_START=0xc0000000
-CONFIG_TASK_SIZE=0x80000000
+CONFIG_TASK_SIZE=0xc0000000
 CONFIG_BOOT_LOAD=0x00800000
 
 #
@@ -265,6 +282,7 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -322,6 +340,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
@@ -392,6 +411,7 @@ CONFIG_SCSI_WAIT_SCAN=m
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
 CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
@@ -403,6 +423,7 @@ CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_AIC94XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
@@ -471,6 +492,7 @@ CONFIG_PATA_MPC52xx=y
 # CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_NETCELL is not set
 # CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_NS87415 is not set
 # CONFIG_PATA_OPTI is not set
 # CONFIG_PATA_OPTIDMA is not set
 # CONFIG_PATA_PDC_OLD is not set
@@ -485,14 +507,7 @@ CONFIG_PATA_MPC52xx=y
 # CONFIG_PATA_WINBOND is not set
 # CONFIG_PATA_PLATFORM is not set
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
 # CONFIG_FUSION is not set
-# CONFIG_FUSION_SPI is not set
-# CONFIG_FUSION_FC is not set
-# CONFIG_FUSION_SAS is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -508,12 +523,15 @@ CONFIG_NETDEVICES=y
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_IP1000 is not set
 # CONFIG_ARCNET is not set
 # CONFIG_NET_ETHERNET is not set
 CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
 # CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
@@ -521,6 +539,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
@@ -530,11 +549,14 @@ CONFIG_NETDEV_1000=y
 CONFIG_NETDEV_10000=y
 # CONFIG_CHELSIO_T1 is not set
 # CONFIG_CHELSIO_T3 is not set
+# CONFIG_IXGBE is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
 # CONFIG_NETXEN_NIC is not set
+# CONFIG_NIU is not set
 # CONFIG_MLX4_CORE is not set
+# CONFIG_TEHUTI is not set
 # CONFIG_TR is not set
 
 #
@@ -614,6 +636,12 @@ CONFIG_DEVPORT=y
 # CONFIG_HWMON is not set
 
 #
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
+
+#
 # Multifunction device drivers
 #
 # CONFIG_MFD_SM501 is not set
@@ -845,3 +873,5 @@ CONFIG_FORCED_INLINING=y
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 # CONFIG_CRYPTO is not set
+CONFIG_PPC_CLOCK=y
+CONFIG_PPC_LIB_RHEAP=y
