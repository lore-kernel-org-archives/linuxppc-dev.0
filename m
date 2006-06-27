Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 94F9967A3E
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 04:15:01 +1000 (EST)
Date: Tue, 27 Jun 2006 11:14:03 -0700
To: paulus@samba.org
Subject: [PATCH] powerpc: remove kconfig warning
Message-ID: <20060627181403.GA5130@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

scripts/kconfig/conf -s arch/powerpc/Kconfig
arch/powerpc/Kconfig:416:warning: leading whitespace ignored

Signed-off-by: Olof Johansson <olof@lixom.net>

Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
@@ -413,7 +413,7 @@ config PPC_CELL_NATIVE
 	default n
 
 config PPC_IBM_CELL_BLADE
-	bool "  IBM Cell Blade"
+	bool "IBM Cell Blade"
 	depends on PPC_MULTIPLATFORM && PPC64
 	select PPC_CELL_NATIVE
 	select PPC_RTAS
