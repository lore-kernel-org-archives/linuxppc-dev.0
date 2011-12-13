Return-Path: <anton@samba.org>
Date: Tue, 13 Dec 2011 17:16:36 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Fix comment explaining our VSID layout
Message-ID: <20111213171636.3e8b8ac6@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We support 16TB of user address space and half a million contexts
so update the comment to reflect this.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/include/asm/mmu-hash64.h
===================================================================
--- linux-powerpc.orig/arch/powerpc/include/asm/mmu-hash64.h	2011-12-13 14:47:14.498301148 +1100
+++ linux-powerpc/arch/powerpc/include/asm/mmu-hash64.h	2011-12-13 14:58:01.085510915 +1100
@@ -312,10 +312,9 @@ extern void slb_set_size(u16 size);
  * (i.e. everything above 0xC000000000000000), except the very top
  * segment, which simplifies several things.
  *
- * 	- We allow for 15 significant bits of ESID and 20 bits of
- * context for user addresses.  i.e. 8T (43 bits) of address space for
- * up to 1M contexts (although the page table structure and context
- * allocation will need changes to take advantage of this).
+ *	- We allow for 16 significant bits of ESID and 19 bits of
+ * context for user addresses.  i.e. 16T (44 bits) of address space for
+ * up to half a million contexts.
  *
  * 	- The scramble function gives robust scattering in the hash
  * table (at least based on some initial results).  The previous
