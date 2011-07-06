Return-Path: <anton@samba.org>
Message-Id: <20110706231337.169551286@samba.org>
Date: Thu, 07 Jul 2011 09:13:15 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 2/4] powerpc: Disable IRQs off tracer in ppc64 defconfig
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

The IRQs off tracer enables mcount which has a big impact on
performance. Disable it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-powerpc.orig/arch/powerpc/configs/ppc64_defconfig	2011-07-07 09:07:26.482898262 +1000
+++ linux-powerpc/arch/powerpc/configs/ppc64_defconfig	2011-07-07 09:07:29.932959288 +1000
@@ -446,7 +446,6 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_LATENCYTOP=y
 CONFIG_SYSCTL_SYSCALL_CHECK=y
-CONFIG_IRQSOFF_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_DEBUG_STACKOVERFLOW=y
