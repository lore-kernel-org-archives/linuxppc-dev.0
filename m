Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 10F9DDE100
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 04:13:19 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lADHDALt002653
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 10:13:13 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lADHD9Jd003652
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 11:13:09 -0600 (CST)
Subject: [PATCH] POWERPC: Clean out asm/of_{platform, device}.h from sysdev/.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1194973989.12888.19.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 13 Nov 2007 11:13:09 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Convert #include of asm/of_{platform, device}.h into
linux/of_{platform,device}.h for remaining arch/powerpc files.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/sysdev/axonram.c |    5 +++--
 arch/powerpc/sysdev/pmi.c     |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index 5eaf3e3..d359d6e 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -42,8 +42,9 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+
 #include <asm/page.h>
 #include <asm/prom.h>
 
diff --git a/arch/powerpc/sysdev/pmi.c b/arch/powerpc/sysdev/pmi.c
index 20edd1e..c858749 100644
--- a/arch/powerpc/sysdev/pmi.c
+++ b/arch/powerpc/sysdev/pmi.c
@@ -28,9 +28,9 @@
 #include <linux/completion.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
 #include <asm/io.h>
 #include <asm/pmi.h>
 #include <asm/prom.h>
-- 
1.5.3
