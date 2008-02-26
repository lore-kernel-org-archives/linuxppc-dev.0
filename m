Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF243DDE17
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 02:01:09 +1100 (EST)
Date: Tue, 26 Feb 2008 17:58:53 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Subject: [PATCH] PowerPC 44x: add missing define TARGET_4xx and TARGET_440GX
	to cuboot-taishan.c
Message-ID: <20080226145853.GA18212@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080224123656.760338da@zod.rchland.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In order to get the proper boad info (bd_info) structure defined in ppcboot.h
both TARGET_4xx and TARGET_44x should be defined for all PowerPC 440 boards.
The 440GX boards also need TARGET_440GX defined since they have 4 EMACs and
there are 4 MAC addesses in bd_info passed by u-boot.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/cuboot-taishan.c |    2 ++
 1 files changed, 2 insertions(+)

diff -pruN linux-2.6.orig/arch/powerpc/boot/cuboot-taishan.c linux-2.6/arch/powerpc/boot/cuboot-taishan.c
--- linux-2.6.orig/arch/powerpc/boot/cuboot-taishan.c	2008-02-26 16:02:36.000000000 +0300
+++ linux-2.6/arch/powerpc/boot/cuboot-taishan.c	2008-02-26 16:21:08.000000000 +0300
@@ -21,7 +21,9 @@
 #include "dcr.h"
 #include "4xx.h"
 
+#define TARGET_4xx
 #define TARGET_44x
+#define TARGET_440GX
 #include "ppcboot.h"
 
 static bd_t bd;
