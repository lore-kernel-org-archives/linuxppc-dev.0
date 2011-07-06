Return-Path: <anton@samba.org>
Message-Id: <20110706231337.327165192@samba.org>
Date: Thu, 07 Jul 2011 09:13:17 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 4/4] powerpc: Enable lockup and hung task detectors in pseries
	and ppc64 defeconfigs
References: <20110706231313.260037641@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As a result of changes to Kconfig files, we no longer enable
the lockup and hung task detectors. Both are very light weight
and provide useful information in the event of a hang, so
reenable them.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-powerpc.orig/arch/powerpc/configs/ppc64_defconfig	2011-07-07 09:07:31.242982461 +1000
+++ linux-powerpc/arch/powerpc/configs/ppc64_defconfig	2011-07-07 09:07:32.693008109 +1000
@@ -443,6 +443,8 @@ CONFIG_NLS_KOI8_U=m
 CONFIG_CRC_T10DIF=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_LOCKUP_DETECTOR=y
+CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_LATENCYTOP=y
Index: linux-powerpc/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux-powerpc.orig/arch/powerpc/configs/pseries_defconfig	2011-07-07 09:07:31.242982461 +1000
+++ linux-powerpc/arch/powerpc/configs/pseries_defconfig	2011-07-07 09:07:32.693008109 +1000
@@ -321,6 +321,8 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_CRC_T10DIF=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_LOCKUP_DETECTOR=y
+CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_LATENCYTOP=y
 CONFIG_SYSCTL_SYSCALL_CHECK=y
