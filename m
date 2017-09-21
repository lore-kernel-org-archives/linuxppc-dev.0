Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyQ6G3554zDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 15:24:54 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	mikey@neuling.org
Subject: [PATCH] powerpc: Add PPC_EMULATED_STATS to powernv_defconfig
Date: Thu, 21 Sep 2017 15:24:49 +1000
Message-Id: <20170921052449.20057-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is useful, especially for developers.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/configs/powernv_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index caee834760..3fb2a7ab54 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -295,6 +295,7 @@ CONFIG_FUNCTION_GRAPH_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_PPC_EMULATED_STATS=y
 CONFIG_CODE_PATCHING_SELFTEST=y
 CONFIG_FTR_FIXUP_SELFTEST=y
 CONFIG_MSI_BITMAP_SELFTEST=y
-- 
2.11.0
