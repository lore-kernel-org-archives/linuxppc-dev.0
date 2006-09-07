Return-Path: <jdub@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8144467B9C
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 22:34:58 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k87CYuMZ024998
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 08:34:56 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k87CYtog234534
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 06:34:55 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k87CYtUg007813
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 06:34:55 -0600
Subject: [PATCH] PPC: Fix Kconfig whitespace warnings
From: Josh Boyer <jdub@us.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Thu, 07 Sep 2006 07:36:24 -0500
Message-Id: <1157632584.6098.35.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix the following whitespace warnings when compiling with ARCH=ppc

arch/ppc/Kconfig:1207:warning: leading whitespace ignored
arch/ppc/Kconfig:1226:warning: leading whitespace ignored
arch/ppc/Kconfig:1231:warning: leading whitespace ignored

Signed-off-by: Josh Boyer <jdub@us.ibm.com>

---
 arch/ppc/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.orig/arch/ppc/Kconfig
+++ linux-2.6/arch/ppc/Kconfig
@@ -1204,7 +1204,7 @@ config PCI_DOMAINS
 	default PCI
 
 config MPC83xx_PCI2
-	bool "  Supprt for 2nd PCI host controller"
+	bool "Supprt for 2nd PCI host controller"
 	depends on PCI && MPC834x
 	default y if MPC834x_SYS
 
@@ -1223,12 +1223,12 @@ config PCI_8260
 	default y
 
 config 8260_PCI9
-	bool "  Enable workaround for MPC826x erratum PCI 9"
+	bool "Enable workaround for MPC826x erratum PCI 9"
 	depends on PCI_8260 && !ADS8272
 	default y
 
 choice
-	prompt "  IDMA channel for PCI 9 workaround"
+	prompt "IDMA channel for PCI 9 workaround"
 	depends on 8260_PCI9
 
 config 8260_PCI9_IDMA1
