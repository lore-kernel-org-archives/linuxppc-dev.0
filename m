Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id E3B5C67C0D
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 00:30:35 +1100 (EST)
Message-Id: <20061102125626.263838000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
Date: Thu, 02 Nov 2006 13:56:01 +0100
From: s.hauer@pengutronix.de
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 06/16] powerpc: remove _machine
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The _machine macro was once used for compatibility with ARCH=ppc
drivers. It is unused in current kernels

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: include/asm-powerpc/processor.h
===================================================================
--- a/include/asm-powerpc/processor.h.orig
+++ b/include/asm-powerpc/processor.h
@@ -53,10 +53,6 @@ extern unsigned char ucBoardRevMaj, ucBo
 
 #endif /* CONFIG_PPC_PREP */
 
-#ifndef CONFIG_PPC_MULTIPLATFORM
-#define _machine 0
-#endif /* CONFIG_PPC_MULTIPLATFORM */
-
 #endif /* defined(__KERNEL__) && defined(CONFIG_PPC32) */
 
 /*

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
