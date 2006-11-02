Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id D2DC167C6E
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 00:30:31 +1100 (EST)
Message-Id: <20061102125627.149261000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
Date: Thu, 02 Nov 2006 13:56:03 +0100
From: s.hauer@pengutronix.de
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 08/16] powerpc: remove EMBEDDED6xx Kconfig entry
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

remove EMBEDDED6xx Kconfig entry

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
@@ -338,10 +338,6 @@ config PPC_MULTIPLATFORM
 	  RS/6000 machine, an Apple machine, or a PReP, CHRP,
 	  Maple or Cell-based machine.
 
-config EMBEDDED6xx
-	bool "Embedded 6xx/7xx/7xxx-based board"
-	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
-
 config APUS
 	bool "Amiga-APUS"
 	depends on PPC32 && BROKEN

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
