Return-Path: <segher@gcc12.fsffrance.org>
Received: from snail.fsffrance.org (eucd.info [88.191.250.43])
	by ozlabs.org (Postfix) with ESMTP id E28B8DDEDD
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 08:58:57 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] ppc: Include <asm/cacheflush.h> in kernel/ppc_ksyms.c
Date: Wed,  7 May 2008 00:58:49 +0200
Message-Id: <3b9b7dce6551e43c8fca4a1a3d4bff5a5b78312b.1210114487.git.segher@kernel.crashing.org>
In-Reply-To: <cf74cd88187bdd9378fbb0a0ff7d53ac3a7b23d2.1210114487.git.segher@kernel.crashing.org>
References: <1210114730-5047-1-git-send-email-segher@kernel.crashing.org>
	<cf74cd88187bdd9378fbb0a0ff7d53ac3a7b23d2.1210114487.git.segher@kernel.crashing.org>
In-Reply-To: <cf74cd88187bdd9378fbb0a0ff7d53ac3a7b23d2.1210114487.git.segher@kernel.crashing.org>
References: <cf74cd88187bdd9378fbb0a0ff7d53ac3a7b23d2.1210114487.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It needs it:

	arch/ppc/kernel/ppc_ksyms.c:152: error: '__flush_icache_range'
	undeclared here (not in a function)

and a few more like that.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/ppc/kernel/ppc_ksyms.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index 16ac11c..602c268 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -24,6 +24,7 @@
 #include <asm/checksum.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
 #include <linux/adb.h>
 #include <linux/cuda.h>
 #include <linux/pmu.h>
-- 
1.5.5.23.g2a5f.dirty
