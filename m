Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Tue, 10 Jun 2008 18:01:18 -0400
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20080610220118.10257.31835.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20080610220055.10257.84465.sendpatchset@norville.austin.ibm.com>
References: <20080610220055.10257.84465.sendpatchset@norville.austin.ibm.com>
Subject: [RFC:PATCH 04/06] powerpc: Define CPU_FTR_SAO
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: Define CPU_FTR_SAO

This is just a placeholder to make the patchset compilable.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 include/asm-powerpc/cputable.h |    1 +
 1 file changed, 1 insertion(+)

diff -Nurp linux003/include/asm-powerpc/cputable.h linux004/include/asm-powerpc/cputable.h
--- linux003/include/asm-powerpc/cputable.h	2008-04-16 21:49:44.000000000 -0500
+++ linux004/include/asm-powerpc/cputable.h	2008-06-10 16:48:59.000000000 -0500
@@ -180,6 +180,7 @@ extern void do_feature_fixups(unsigned l
 #define CPU_FTR_DSCR			LONG_ASM_CONST(0x0002000000000000)
 #define CPU_FTR_1T_SEGMENT		LONG_ASM_CONST(0x0004000000000000)
 #define CPU_FTR_NO_SLBIE_B		LONG_ASM_CONST(0x0008000000000000)
+#define CPU_FTR_SAO			LONG_ASM_CONST(0x0010000000000000)
 
 #ifndef __ASSEMBLY__
 
