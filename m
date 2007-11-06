Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 973B2DDDF8
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 05:13:09 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1IpSvA-0003m2-1v
	for linuxppc-dev@ozlabs.org; Tue, 06 Nov 2007 12:13:05 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH Rev 2] 4xx: Replace #includes of asm/of_platform.h with
	linux/of_platform.h.
Date: Tue, 06 Nov 2007 12:13:04 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IpSvA-0003m2-1v@jdl.com>
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
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
Chip away at some janitor work.
Add sfr's ACK.

 arch/powerpc/platforms/40x/walnut.c  |    3 ++-
 arch/powerpc/platforms/44x/bamboo.c  |    3 ++-
 arch/powerpc/platforms/44x/ebony.c   |    3 ++-
 arch/powerpc/platforms/44x/sequoia.c |    3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/40x/walnut.c b/arch/powerpc/platforms/40x/walnut.c
index eb0c136..ff6db24 100644
--- a/arch/powerpc/platforms/40x/walnut.c
+++ b/arch/powerpc/platforms/40x/walnut.c
@@ -17,12 +17,13 @@
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
 
 static struct of_device_id walnut_of_bus[] = {
 	{ .compatible = "ibm,plb3", },
diff --git a/arch/powerpc/platforms/44x/bamboo.c b/arch/powerpc/platforms/44x/bamboo.c
index 470e1a3..be23f11 100644
--- a/arch/powerpc/platforms/44x/bamboo.c
+++ b/arch/powerpc/platforms/44x/bamboo.c
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
 #include "44x.h"
 
 static struct of_device_id bamboo_of_bus[] = {
diff --git a/arch/powerpc/platforms/44x/ebony.c b/arch/powerpc/platforms/44x/ebony.c
index 40e18fc..6cd3476 100644
--- a/arch/powerpc/platforms/44x/ebony.c
+++ b/arch/powerpc/platforms/44x/ebony.c
@@ -17,12 +17,13 @@
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
 
 #include "44x.h"
 
diff --git a/arch/powerpc/platforms/44x/sequoia.c b/arch/powerpc/platforms/44x/sequoia.c
index 30700b3..21a9dd1 100644
--- a/arch/powerpc/platforms/44x/sequoia.c
+++ b/arch/powerpc/platforms/44x/sequoia.c
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
 #include "44x.h"
 
 static struct of_device_id sequoia_of_bus[] = {
-- 
1.5.3.1.139.g9346b
