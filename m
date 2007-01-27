Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A56BDDE672
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 14:08:21 +1100 (EST)
Message-ID: <45BAC200.3040303@am.sony.com>
Date: Fri, 26 Jan 2007 19:07:44 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/16] ps3: inform incomplete
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a comment to the PS3 config option to inform users that the current
implementation is not yet complete.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/Kconfig |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

--- ps3-linux-dev.orig/arch/powerpc/Kconfig
+++ ps3-linux-dev/arch/powerpc/Kconfig
@@ -525,12 +525,15 @@ config PPC_IBM_CELL_BLADE
 	select UDBG_RTAS_CONSOLE
 
 config PPC_PS3
-	bool "Sony PS3"
+	bool "Sony PS3 (incomplete)"
 	depends on PPC_MULTIPLATFORM && PPC64
 	select PPC_CELL
 	help
 	  This option enables support for the Sony PS3 game console
 	  and other platforms using the PS3 hypervisor.
+	  Support for this platform is not yet complete, so
+	  enabling this will not result in a bootable kernel on a
+	  PS3 system.
 
 config PPC_NATIVE
 	bool
