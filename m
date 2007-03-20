Return-Path: <anton@ozlabs.org>
Date: Tue, 20 Mar 2007 10:07:12 -0500
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Remove _get_SP
Message-ID: <20070320150712.GH31173@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We already have an inline __get_SP, no need for yet another one.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/misc_32.S
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/misc_32.S	2007-03-12 07:54:00.000000000 -0500
+++ linux-2.6/arch/powerpc/kernel/misc_32.S	2007-03-20 09:49:58.000000000 -0500
@@ -734,10 +734,6 @@
 	sub	r3,r3,r4
 	blr
 
-_GLOBAL(_get_SP)
-	mr	r3,r1		/* Close enough */
-	blr
-
 /*
  * Create a kernel thread
  *   kernel_thread(fn, arg, flags)
