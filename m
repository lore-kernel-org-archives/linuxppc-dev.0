Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C3720B6F56
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 08:47:32 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 616B9DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 08:47:32 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Fri, 11 Sep 2009 00:47:20 +0200
Message-Id: <1252622840-24731-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH] powerpc/include/asm/irq.h: improve nanodoc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The OF helpers look like nanodoc but are missing the header. Fix this and a
typo (s/nad/and/) while we are here.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/irq.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 0a51376..bbcd1aa 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -302,7 +302,8 @@ extern void irq_free_virt(unsigned int virq, unsigned int count);
 
 /* -- OF helpers -- */
 
-/* irq_create_of_mapping - Map a hardware interrupt into linux virq space
+/**
+ * irq_create_of_mapping - Map a hardware interrupt into linux virq space
  * @controller: Device node of the interrupt controller
  * @inspec: Interrupt specifier from the device-tree
  * @intsize: Size of the interrupt specifier from the device-tree
@@ -314,8 +315,8 @@ extern void irq_free_virt(unsigned int virq, unsigned int count);
 extern unsigned int irq_create_of_mapping(struct device_node *controller,
 					  u32 *intspec, unsigned int intsize);
 
-
-/* irq_of_parse_and_map - Parse nad Map an interrupt into linux virq space
+/**
+ * irq_of_parse_and_map - Parse and Map an interrupt into linux virq space
  * @device: Device node of the device whose interrupt is to be mapped
  * @index: Index of the interrupt to map
  *
-- 
1.6.3.3
