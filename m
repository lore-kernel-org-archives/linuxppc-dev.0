Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B3354DDED7
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 02:39:13 +1000 (EST)
Message-ID: <46B9F1A6.9070004@am.sony.com>
Date: Wed, 08 Aug 2007 09:39:02 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 2/3 v2] PS3: Remove incomplete message
References: <20070808033119.833895506@am.sony.com>
	<20070808033120.055823394@am.sony.com>
In-Reply-To: <20070808033120.055823394@am.sony.com>
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

Remove the Kconfig message that indicates the PS3 platform support is
incomplete.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
v2 changes: 
 o Fix typo pointed out by Geert

 arch/powerpc/platforms/ps3/Kconfig |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -1,5 +1,5 @@
 config PPC_PS3
-	bool "Sony PS3 (incomplete)"
+	bool "Sony PS3"
 	depends on PPC_MULTIPLATFORM && PPC64
 	select PPC_CELL
 	select USB_ARCH_HAS_OHCI
@@ -10,10 +10,10 @@ config PPC_PS3
 	select MEMORY_HOTPLUG
 	help
 	  This option enables support for the Sony PS3 game console
-	  and other platforms using the PS3 hypervisor.
-	  Support for this platform is not yet complete, so
-	  enabling this will not result in a bootable kernel on a
-	  PS3 system.
+	  and other platforms using the PS3 hypervisor.  Enabling this
+	  option will allow building otheros.bld, a kernel image suitable
+	  for programming into flash memory, and vmlinux, a kernel image
+	  suitable for loading via kexec.
 
 menu "PS3 Platform Options"
 	depends on PPC_PS3
