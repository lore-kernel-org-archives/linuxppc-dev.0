Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2E0267C36
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 16:09:01 +1100 (EST)
Message-ID: <454ACEDD.70309@am.sony.com>
Date: Thu, 02 Nov 2006 21:08:45 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cell: set ARCH_SPARSEMEM_DEFAULT in Kconfig
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current cell processor support needs sparsemem, so set it as
the default memory model.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

--

As noted by Benjamin Herrenschmidt.

Index: cell--common--6/arch/powerpc/Kconfig
===================================================================
--- cell--common--6.orig/arch/powerpc/Kconfig
+++ cell--common--6/arch/powerpc/Kconfig
@@ -734,7 +743,7 @@
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
-	depends on SMP && PPC_PSERIES
+	depends on (SMP && PPC_PSERIES) || PPC_CELL
 
 config ARCH_POPULATES_NODE_MAP
 	def_bool y
