Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A1B0067A63
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2005 12:50:30 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 12:50:11 +1100
Message-Id: <1106013011.4499.48.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] ppc32: Add missing prototype
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This patch fixes a warning by adding a missing function prototype
for enable_kernel_altivec().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/asm-ppc/system.h
===================================================================
--- linux-work.orig/include/asm-ppc/system.h	2004-11-22 11:50:50.000000000 +1100
+++ linux-work/include/asm-ppc/system.h	2005-01-17 13:49:51.633302712 +1100
@@ -74,6 +74,7 @@
 extern void pmac_find_display(void);
 extern void giveup_fpu(struct task_struct *);
 extern void enable_kernel_fp(void);
+extern void enable_kernel_altivec(void);
 extern void giveup_altivec(struct task_struct *);
 extern void load_up_altivec(struct task_struct *);
 extern void giveup_spe(struct task_struct *);
