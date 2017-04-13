Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3WwD67MXzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 17:03:24 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id g2so9439537pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 00:03:24 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH] powerpc/configs: Enable function trace by default
Date: Thu, 13 Apr 2017 17:03:09 +1000
Message-Id: <20170413070309.10497-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We expect to have these configs on by default, most
distros turn them off, its always good to have them on
so that we can use them and hopefully not break them

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/configs/powernv_defconfig | 4 ++++
 arch/powerpc/configs/ppc64_defconfig   | 3 +++
 arch/powerpc/configs/pseries_defconfig | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 0695ce0..eff3968 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -295,7 +295,11 @@ CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_LOCKUP_DETECTOR=y
 CONFIG_LATENCYTOP=y
+CONFIG_FTRACE=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_FUNCTION_GRAPH_TRACER=y
 CONFIG_SCHED_TRACER=y
+CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_UPROBE_EVENT=y
 CONFIG_CODE_PATCHING_SELFTEST=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index e353168f9..17c6c12 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -328,6 +328,9 @@ CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_LOCKUP_DETECTOR=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_LATENCYTOP=y
+CONFIG_FTRACE=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_FUNCTION_GRAPH_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_UPROBE_EVENT=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 1a61aa2..a445960 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -293,6 +293,9 @@ CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_LOCKUP_DETECTOR=y
 CONFIG_LATENCYTOP=y
+CONFIG_FTRACE=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_FUNCTION_GRAPH_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_UPROBE_EVENT=y
-- 
2.9.3
