Return-Path: <mikey@ozlabs.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] Update lppaca offset comments
Date: Mon, 07 Aug 2006 17:34:50 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060807073451.A055D67A3F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update offset comments.  No functional change. 

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 include/asm-powerpc/lppaca.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/include/asm-powerpc/lppaca.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/lppaca.h
+++ linux-2.6-ozlabs/include/asm-powerpc/lppaca.h
@@ -114,7 +114,7 @@ struct lppaca {
 
 
 //=============================================================================
-// CACHE_LINE_3 0x0100 - 0x007F: This line is shared with other processors
+// CACHE_LINE_3 0x0100 - 0x017F: This line is shared with other processors
 //=============================================================================
 	// This is the yield_count.  An "odd" value (low bit on) means that
 	// the processor is yielded (either because of an OS yield or a PLIC
@@ -126,7 +126,7 @@ struct lppaca {
 	u8	reserved6[124];		// Reserved                     x04-x7F
 
 //=============================================================================
-// CACHE_LINE_4-5 0x0100 - 0x01FF Contains PMC interrupt data
+// CACHE_LINE_4-5 0x0180 - 0x027F Contains PMC interrupt data
 //=============================================================================
 	u8	pmc_save_area[256];	// PMC interrupt Area           x00-xFF
 } __attribute__((__aligned__(0x400)));
