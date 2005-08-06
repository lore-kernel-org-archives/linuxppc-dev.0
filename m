Return-Path: <aris@cathedrallabs.org>
Received: from panda.sul.com.br (panda.sul.com.br [200.219.150.4])
	by ozlabs.org (Postfix) with ESMTP id C1E7467F2B
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  7 Aug 2005 04:05:51 +1000 (EST)
Date: Sat, 6 Aug 2005 15:05:50 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050806180550.GY5210@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] 8xx: kill unused variable in commproc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

8xx: commproc.c: kill unused variable

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

Index: 2.6-8xx/arch/ppc/8xx_io/commproc.c
===================================================================
--- 2.6-8xx.orig/arch/ppc/8xx_io/commproc.c	2005-08-05 17:16:15.000000000 -0300
+++ 2.6-8xx/arch/ppc/8xx_io/commproc.c	2005-08-05 17:20:12.000000000 -0300
@@ -384,8 +384,6 @@
 
 void m8xx_cpm_dpinit(void)
 {
-	cpm8xx_t *cp = &((immap_t *)IMAP_ADDR)->im_cpm;
-
 	spin_lock_init(&cpm_dpmem_lock);
 
 	/* Initialize the info header */
