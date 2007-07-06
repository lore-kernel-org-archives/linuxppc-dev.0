Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 541D5DE087
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 06:04:19 +1000 (EST)
Date: Fri, 6 Jul 2007 15:15:14 -0500
To: paulus@samba.org
Subject: [PATCH] pasemi: don't auto-select CONFIG_EMBEDDED
Message-ID: <20070706201514.GA30610@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Disable auto-select of CONFIG_EMBEDDED. ELECTRA_IDE selects PATA_PLATFORM
which should be sufficient.

Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platforms/pasemi/Kconfig
index 4275ff8..95cd90f 100644
--- a/arch/powerpc/platforms/pasemi/Kconfig
+++ b/arch/powerpc/platforms/pasemi/Kconfig
@@ -5,7 +5,6 @@ config PPC_PASEMI
 	select MPIC
 	select PPC_UDBG_16550
 	select PPC_NATIVE
-	select EMBEDDED
 	help
 	  This option enables support for PA Semi's PWRficient line
 	  of SoC processors, including PA6T-1682M
