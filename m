Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/16] Remove ibm4{xx,4x}.h from arch/powerpc
In-Reply-To: <20070213060904.GA6214@localhost.localdomain>
Message-Id: <20070213061024.4A283DDD0C@ozlabs.org>
Date: Tue, 13 Feb 2007 17:10:24 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ARCH=powerpc should not use the ghastly un-multiplatformable tangle of
includes that starts with asm-ppc/ibm4xx.h.  This patch removes a
compile-breaking include of it from head_44x.S.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/kernel/head_44x.S |    2 --
 1 file changed, 2 deletions(-)

Index: working-2.6/arch/powerpc/kernel/head_44x.S
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-01-12 17:22:42.000000000 +1100
+++ working-2.6/arch/powerpc/kernel/head_44x.S	2007-01-12 17:37:39.000000000 +1100
@@ -32,8 +32,6 @@
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
-#include <asm/ibm4xx.h>
-#include <asm/ibm44x.h>
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
