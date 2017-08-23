Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnD3Tr1zDqHc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 22/46] powerpc/configs: Drop MEMORY_HOTREMOVE from ppc64/cell
Date: Wed, 23 Aug 2017 15:37:42 +1000
Message-Id: <1503466686-10932-23-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
References: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

xxxx

In commit 577ec789a79e ("powerpc/cell: Drop select of MEMORY_HOTPLUG")
we removed the last traces of any dependency between
---
 arch/powerpc/configs/cell_defconfig  | 1 -
 arch/powerpc/configs/ppc64_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index 65299b2846bb..c6fb2092af38 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -37,7 +37,6 @@ CONFIG_GEN_RTC=y
 CONFIG_BINFMT_MISC=m
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_NUMA=y
-CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_PPC_64K_PAGES=y
 CONFIG_SCHED_SMT=y
 CONFIG_PCIEPORTBUS=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index a5bd462bc61f..c3ff99646dcd 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -49,7 +49,6 @@ CONFIG_KEXEC=y
 CONFIG_KEXEC_FILE=y
 CONFIG_CRASH_DUMP=y
 CONFIG_IRQ_ALL_CPUS=y
-CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
 CONFIG_SCHED_SMT=y
 CONFIG_HOTPLUG_PCI=y
-- 
2.7.4
