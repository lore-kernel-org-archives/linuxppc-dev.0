Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8550CDDE1E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 06:00:15 +1000 (EST)
Date: Mon, 14 May 2007 15:03:09 -0500
To: paulus@samba.org
Subject: [PATCH] pasemi: CONFIG_CENERIG_TBSYNC no longer needed
Message-ID: <20070514200309.GA2237@lixom.net>
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

Current kernel implements proper TB sync, no need to keep GENERIC_TBSYNC
enabled.

Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platforms/pasemi/Kconfig
index eb4dbc7..7c5076e 100644
--- a/arch/powerpc/platforms/pasemi/Kconfig
+++ b/arch/powerpc/platforms/pasemi/Kconfig
@@ -4,7 +4,6 @@ config PPC_PASEMI
 	default n
 	select MPIC
 	select PPC_UDBG_16550
-	select GENERIC_TBSYNC
 	select PPC_NATIVE
 	help
 	  This option enables support for PA Semi's PWRficient line
