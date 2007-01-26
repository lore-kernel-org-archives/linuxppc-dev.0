Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8CB00DE03B
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 13:07:22 +1100 (EST)
Message-ID: <45B96252.5000006@am.sony.com>
Date: Thu, 25 Jan 2007 18:07:14 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH] ps3: add not complete comment to kconfig
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
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

Paul,

It seems there are Linux enthusiasts out there who are trying to build
and run the 2.6.20-rc kernels on their consoles, but don't realize 
there are no drivers...

It would be nice if this could go into 2.6.20, but I can understand
if you can't at such a late date.

-Geoff 

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
