Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id EBC1BDDECC
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 04:51:33 +1100 (EST)
Date: Wed, 3 Jan 2007 18:33:56 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] disable PReP and EFIKA during make oldconfig
Message-ID: <20070103173356.GA26130@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


New boards should not be enabled per default.
Disable EFIKA and PReP per default.
Anyone who really needes the new code can enable it during make oldconfig.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
@@ -436,7 +436,7 @@ config PPC_EFIKA
 	select RTAS_PROC
 	select PPC_MPC52xx
 	select PPC_NATIVE
-	default y
+	default n
 
 config PPC_LITE5200
 	bool "Freescale Lite5200 Eval Board"
@@ -471,7 +471,7 @@ config PPC_PREP
 	select PPC_INDIRECT_PCI
 	select PPC_UDBG_16550
 	select PPC_NATIVE
-	default y
+	default n
 
 config PPC_MAPLE
 	depends on PPC_MULTIPLATFORM && PPC64
