Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 Jan 2009 14:56:51 +1100
Subject: [PATCH] powerpc: Fix missing semicolons in mmu_decl.h
Message-Id: <20090107035702.C9114474D7@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a brown paper bag from one of my earlier patches that
breaks build on 40x and 8xx.

And yes, I've now added 40x and 8xx to my list of test configs :-)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/mm/mmu_decl.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-work.orig/arch/powerpc/mm/mmu_decl.h	2009-01-07 14:52:33.000000000 +1100
+++ linux-work/arch/powerpc/mm/mmu_decl.h	2009-01-07 14:52:43.000000000 +1100
@@ -30,11 +30,11 @@
 #if defined(CONFIG_40x) || defined(CONFIG_8xx)
 static inline void _tlbil_all(void)
 {
-	asm volatile ("sync; tlbia; isync" : : : "memory")
+	asm volatile ("sync; tlbia; isync" : : : "memory");
 }
 static inline void _tlbil_pid(unsigned int pid)
 {
-	asm volatile ("sync; tlbia; isync" : : : "memory")
+	asm volatile ("sync; tlbia; isync" : : : "memory");
 }
 #else /* CONFIG_40x || CONFIG_8xx */
 extern void _tlbil_all(void);
@@ -47,7 +47,7 @@ extern void _tlbil_pid(unsigned int pid)
 #ifdef CONFIG_8xx
 static inline void _tlbil_va(unsigned long address, unsigned int pid)
 {
-	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory")
+	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory");
 }
 #else /* CONFIG_8xx */
 extern void _tlbil_va(unsigned long address, unsigned int pid);
