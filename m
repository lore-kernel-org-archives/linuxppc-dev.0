Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4456DDEDA
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 07:20:04 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] via-pmu: Fix typo in printk
Date: Sun, 12 Aug 2007 22:38:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708122238.34985.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes a typo in a printk message.

Signed-off-by: Michael Buesch <mb@bu3sch.de>


Index: linux-2.6/drivers/macintosh/via-pmu.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/via-pmu.c	2007-05-26 19:56:27.000000000 +0200
+++ linux-2.6/drivers/macintosh/via-pmu.c	2007-08-12 22:36:27.000000000 +0200
@@ -410,7 +410,7 @@ static int __init via_pmu_start(void)
 
 	irq = irq_of_parse_and_map(vias, 0);
 	if (irq == NO_IRQ) {
-		printk(KERN_ERR "via-pmu: can't map interruptn");
+		printk(KERN_ERR "via-pmu: can't map interrupt\n");
 		return -ENODEV;
 	}
 	if (request_irq(irq, via_pmu_interrupt, 0, "VIA-PMU", (void *)0)) {

-- 
Greetings Michael.
