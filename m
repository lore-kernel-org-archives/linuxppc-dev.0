Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C34C9DDF9A
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 01:45:17 +1100 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id m1LEhI9m019456
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 17:43:18 +0300
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id m1LEhILc019453
	for linuxppc-dev@ozlabs.org; Thu, 21 Feb 2008 17:43:18 +0300
Date: Thu, 21 Feb 2008 17:43:17 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC 44x: add missing define TARGET_4xx to cuboot-taishan.c
Message-ID: <20080221144317.GA19395@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In order to get the proper bd_info structure for PowerPC 440,
both TARGET_4xx and TARGET_44x should be defined.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/cuboot-taishan.c |    1 +
 1 files changed, 1 insertion(+)

diff -pruN linux-2.6.orig/arch/powerpc/boot/cuboot-taishan.c linux-2.6/arch/powerpc/boot/cuboot-taishan.c
--- linux-2.6.orig/arch/powerpc/boot/cuboot-taishan.c	2008-02-21 16:46:11.000000000 +0300
+++ linux-2.6/arch/powerpc/boot/cuboot-taishan.c	2008-02-21 16:48:43.000000000 +0300
@@ -21,6 +21,7 @@
 #include "dcr.h"
 #include "4xx.h"
 
+#define TARGET_4xx
 #define TARGET_44x
 #include "ppcboot.h"
 
