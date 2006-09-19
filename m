Return-Path: <Amy.Fong@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 8792C67B64
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 17:08:13 +1000 (EST)
Received: from ala-mail04.corp.ad.wrs.com (ala-mail04 [147.11.57.145])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id k8J36QHa020384
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Sep 2006 20:06:26 -0700 (PDT)
Received: from afong by lucciola with local (Exim 4.63)
	(envelope-from <amy.fong@windriver.com>) id 1GPVwH-0006UY-9Z
	for linuxppc-dev@ozlabs.org; Mon, 18 Sep 2006 23:06:25 -0400
Date: Mon, 18 Sep 2006 23:06:25 -0400
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix error in cpm2
Message-ID: <20060919030625.GA24944@lucciola.windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Amy Fong <amy.fong@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch fixes a typo in cpm2.h resulting in a compile error.

Signed-off-by: Amy Fong <amy.fong@windriver.com>

Index: linux-2.6.18-rc6/include/asm-ppc/cpm2.h
===================================================================
--- linux-2.6.18-rc6.orig/include/asm-ppc/cpm2.h
+++ linux-2.6.18-rc6/include/asm-ppc/cpm2.h
@@ -1186,7 +1186,7 @@
 #define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
 #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
 #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
-#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(2)
+#define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
 
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */
