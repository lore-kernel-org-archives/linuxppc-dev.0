Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57673DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 08:43:48 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lA5Lhh57017702
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 14:43:44 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lA5LhhwB011165
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 15:43:43 -0600 (CST)
Subject: [PATCH] 4xx; Replace #includes of asm/of_platform.h with
	linux/of_platform.h.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1194299023.7158.59.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 05 Nov 2007 15:43:43 -0600
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
Chip away at some janitor work.

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
1.5.3
