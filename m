Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E890EDDECE
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 05:07:19 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1JBwNX-0006XF-26
	for linuxppc-dev@ozlabs.org; Mon, 07 Jan 2008 12:07:16 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Use <linux/of_{platform,
	device}.h> and not <asm/...> variants.
Date: Mon, 07 Jan 2008 12:07:15 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JBwNX-0006XF-26@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jon Loeliger <jdl@freescale.com>

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

Paul,

Continue to fight the Good Fight by removing
old include file references that managed to
creep in recently.

These are the last few in arch/powerpc directly.
If you could pick this up for .25, that be good!

jdl



 arch/powerpc/kernel/of_device.c      |    2 +-
 arch/powerpc/platforms/44x/rainier.c |    3 ++-
 arch/powerpc/platforms/maple/setup.c |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index 3388ad6..5748ddb 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -5,10 +5,10 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 
 #include <asm/errno.h>
 #include <asm/dcr.h>
-#include <asm/of_device.h>
 
 static void of_device_make_bus_id(struct of_device *dev)
 {
diff --git a/arch/powerpc/platforms/44x/rainier.c b/arch/powerpc/platforms/44x/rainier.c
index a4ce5ba..a7fae1c 100644
--- a/arch/powerpc/platforms/44x/rainier.c
+++ b/arch/powerpc/platforms/44x/rainier.c
@@ -14,12 +14,13 @@
  * option) any later version.
  */
 #include <linux/init.h>
+#include <linux/of_platform.h>
+
 #include <asm/machdep.h>
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/time.h>
 #include <asm/uic.h>
-#include <asm/of_platform.h>
 #include <asm/pci-bridge.h>
 #include "44x.h"
 
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 144177d..3ce2d73 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -42,6 +42,7 @@
 #include <linux/serial.h>
 #include <linux/smp.h>
 #include <linux/bitops.h>
+#include <linux/of_device.h>
 
 #include <asm/processor.h>
 #include <asm/sections.h>
@@ -56,7 +57,6 @@
 #include <asm/dma.h>
 #include <asm/cputable.h>
 #include <asm/time.h>
-#include <asm/of_device.h>
 #include <asm/lmb.h>
 #include <asm/mpic.h>
 #include <asm/rtas.h>
-- 
1.5.4.rc0
