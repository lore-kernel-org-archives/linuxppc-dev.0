Return-Path: <tglx@linutronix.de>
Received: from tglx.tec.linutronix.de (pD953A967.dip.t-dialin.net
	[217.83.169.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3AECE2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Jan 2005 23:27:49 +1100 (EST)
Date: Sun, 9 Jan 2005 13:27:27 +0100
From: tglx@linutronix.de
Message-ID: <20050109132725.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain
To: trini@kernel.crashing.org
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH 2.6.10-mm2] Include missing header (PPC)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Include missing header to avoid implicit function declaration warnings

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 init.c |    1 +
 1 files changed, 1 insertion(+)
---
Index: 2.6.10-mm2/arch/ppc/mm/init.c
===================================================================
--- 2.6.10-mm2/arch/ppc/mm/init.c	(revision 141)
+++ 2.6.10-mm2/arch/ppc/mm/init.c	(working copy)
@@ -31,6 +31,7 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/initrd.h>
+#include <linux/pagemap.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
