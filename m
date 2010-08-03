Return-Path: <anton@ozlabs.org>
Date: Tue, 3 Aug 2010 16:35:18 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/mm: Fix vsid_scrample typo
Message-ID: <20100803063518.GL29316@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The code is wrapped in an #if 0, but it's wrong so we may as well fix it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/include/asm/mmu-hash64.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/mmu-hash64.h	2010-06-29 05:03:49.000000000 +1000
+++ linux-2.6/arch/powerpc/include/asm/mmu-hash64.h	2010-06-29 05:04:21.000000000 +1000
@@ -431,7 +431,7 @@ typedef struct {
  * with.  However gcc is not clever enough to compute the
  * modulus (2^n-1) without a second multiply.
  */
-#define vsid_scrample(protovsid, size) \
+#define vsid_scramble(protovsid, size) \
 	((((protovsid) * VSID_MULTIPLIER_##size) % VSID_MODULUS_##size))
 
 #else /* 1 */
