Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id AE7AB67BDD
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 00:30:27 +1100 (EST)
Message-Id: <20061102125624.134898000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
Date: Thu, 02 Nov 2006 13:55:56 +0100
From: s.hauer@pengutronix.de
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 01/16] remove inclusion of asm/processor.h for powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove inclusion of asm/processor.h for powerpc. It was used for
some ppc specific hook in this file, but the hook is gone

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: linux-2.6/drivers/ide/pci/via82cxxx.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/via82cxxx.c
+++ linux-2.6/drivers/ide/pci/via82cxxx.c
@@ -35,10 +35,6 @@
 #include <linux/ide.h>
 #include <asm/io.h>
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
-#include <asm/processor.h>
-#endif
-
 #include "ide-timing.h"
 
 #define DISPLAY_VIA_TIMINGS

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
