Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D20667B3B
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Apr 2005 16:04:28 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1DPwhg-0007Rm-WA@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Mon, 25 Apr 2005 07:04:20 +0100
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc iomem annotations: ebony_setup_pcix()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc3-io_virt_base/arch/ppc/platforms/4xx/ebony.c RC12-rc3-ebony/arch/ppc/platforms/4xx/ebony.c
--- RC12-rc3-io_virt_base/arch/ppc/platforms/4xx/ebony.c	Mon Apr 25 00:40:04 2005
+++ RC12-rc3-ebony/arch/ppc/platforms/4xx/ebony.c	Mon Apr 25 00:40:06 2005
@@ -149,7 +149,7 @@
 static void __init
 ebony_setup_pcix(void)
 {
-	void *pcix_reg_base;
+	void __iomem *pcix_reg_base;
 
 	pcix_reg_base = ioremap64(PCIX0_REG_BASE, PCIX_REG_SIZE);
 
