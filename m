Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Maynard Johnson <maynardj@us.ibm.com>, Carl Love <carll@us.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] powerpc/cell: add missing #include for oprofile
MIME-Version: 1.0
Date: Mon, 09 Feb 2009 10:04:14 +1100
Message-ID: <26307.1234134254@neuling.org>
Sender: mikey@neuling.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/oprofile/cell/spu_profiler.c is missing a asm/time.h
include which is required for ppc_proc_freq.  This can cause compile
failures for some config combinations.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
This is against mainline, so should be pushed up soon-ish

 arch/powerpc/oprofile/cell/spu_profiler.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6-ozlabs/arch/powerpc/oprofile/cell/spu_profiler.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/oprofile/cell/spu_profiler.c
+++ linux-2.6-ozlabs/arch/powerpc/oprofile/cell/spu_profiler.c
@@ -16,6 +16,7 @@
 #include <linux/smp.h>
 #include <linux/slab.h>
 #include <asm/cell-pmu.h>
+#include <asm/time.h>
 #include "pr_util.h"
 
 #define SCALE_SHIFT 14
