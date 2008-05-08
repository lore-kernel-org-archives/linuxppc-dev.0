Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ac0257defcf9ed41b9f990b2ca5bdfe2e79b3ce7.1210220828.git.michael@ellerman.id.au>
In-Reply-To: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
References: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 03/12] Move declaration of tce variables into mmu-hash64.h
Date: Thu,  8 May 2008 14:27:08 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/hash_utils_64.c  |    2 --
 include/asm-powerpc/mmu-hash64.h |    1 +
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 1a4b4b3..05f955f 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -509,8 +509,6 @@ void __init htab_initialize(void)
 	unsigned long base = 0, size = 0, limit;
 	int i;
 
-	extern unsigned long tce_alloc_start, tce_alloc_end;
-
 	DBG(" -> htab_initialize()\n");
 
 	/* Initialize segment sizes */
diff --git a/include/asm-powerpc/mmu-hash64.h b/include/asm-powerpc/mmu-hash64.h
index 0dff767..f35d1e1 100644
--- a/include/asm-powerpc/mmu-hash64.h
+++ b/include/asm-powerpc/mmu-hash64.h
@@ -181,6 +181,7 @@ extern int mmu_io_psize;
 extern int mmu_kernel_ssize;
 extern int mmu_highuser_ssize;
 extern u16 mmu_slb_size;
+extern unsigned long tce_alloc_start, tce_alloc_end;
 
 /*
  * If the processor supports 64k normal pages but not 64k cache
-- 
1.5.5
