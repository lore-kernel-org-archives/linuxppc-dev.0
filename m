Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E20BBDE01C
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 00:21:50 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l9BELkQK020204
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 09:21:47 -0500
Date: Thu, 11 Oct 2007 09:21:12 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 85xx: Enable FP emulation in MPC8560 ADS defconfig
Message-ID: <Pine.LNX.4.64.0710110920501.11335@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---
 arch/powerpc/configs/mpc8560_ads_defconfig |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/configs/mpc8560_ads_defconfig b/arch/powerpc/configs/mpc8560_ads_defconfig
index 0fb54c7..3d68c65 100644
--- a/arch/powerpc/configs/mpc8560_ads_defconfig
+++ b/arch/powerpc/configs/mpc8560_ads_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc4
-# Tue Aug 28 21:24:43 2007
+# Linux kernel version: 2.6.23-rc9
+# Thu Oct 11 09:16:32 2007
 #
 # CONFIG_PPC64 is not set

@@ -22,8 +22,13 @@ CONFIG_FSL_BOOKE=y
 CONFIG_SPE=y
 # CONFIG_PPC_MM_SLICES is not set
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
@@ -86,7 +91,6 @@ CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
@@ -128,7 +132,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 CONFIG_MPC8560_ADS=y
 # CONFIG_MPC85xx_CDS is not set
 # CONFIG_MPC85xx_MDS is not set
-# CONFIG_MPC8544_DS is not set
+# CONFIG_MPC85xx_DS is not set
 CONFIG_MPC8560=y
 CONFIG_MPC85xx=y
 CONFIG_MPIC=y
@@ -142,12 +146,17 @@ CONFIG_MPIC=y
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
 CONFIG_CPM2=y
+CONFIG_PPC_CPM_NEW_BINDING=y
 # CONFIG_FSL_ULI1575 is not set
+CONFIG_CPM=y

 #
 # Kernel options
 #
 # CONFIG_HIGHMEM is not set
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
@@ -158,7 +167,7 @@ CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT is not set
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
-# CONFIG_MATH_EMULATION is not set
+CONFIG_MATH_EMULATION=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
@@ -177,6 +186,8 @@ CONFIG_VIRT_TO_BUS=y
 # CONFIG_PROC_DEVICETREE is not set
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_HIBERNATION_UP_POSSIBLE=y
 # CONFIG_SECCOMP is not set
 CONFIG_WANT_DEVICE_TREE=y
 CONFIG_DEVICE_TREE=""
@@ -415,6 +426,7 @@ CONFIG_E1000_NAPI=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
@@ -807,3 +819,4 @@ CONFIG_FORCED_INLINING=y
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 # CONFIG_CRYPTO is not set
+# CONFIG_PPC_CLOCK is not set
-- 
1.5.2.4
