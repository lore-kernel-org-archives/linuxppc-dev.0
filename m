Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B30F67A67
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 14:30:19 +1000 (EST)
Subject: [PATCH] powerpc: Fix warning in cell setup.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 14:30:04 +1000
Message-Id: <1151814604.19419.20.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixes a warning due to a missing #include on cell

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/cell/setup.c	2006-07-01 15:25:33.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/cell/setup.c	2006-07-01 15:25:36.000000000 +1000
@@ -49,6 +49,7 @@
 #include <asm/irq.h>
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
+#include <asm/udbg.h>
 
 #include "interrupt.h"
 #include "iommu.h"
