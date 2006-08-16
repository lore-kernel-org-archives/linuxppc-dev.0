Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 16 Aug 2006 14:16:16 +1000
Subject: [PATCH] Add CONFIG_POWERPC
Message-Id: <20060816041617.690EB67A3F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We don't seem to have a top-level config symbol like other archs do. We have
PPC64 and PPC, but I think it'd be cleaner to have just one for cases where
we really mean PPC64 and/or PPC.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

Index: git/arch/powerpc/Kconfig
===================================================================
--- git.orig/arch/powerpc/Kconfig
+++ git/arch/powerpc/Kconfig
@@ -11,6 +11,10 @@ config PPC64
 	  This option selects whether a 32-bit or a 64-bit kernel
 	  will be built.
 
+config POWERPC
+	bool
+	default y
+
 config PPC32
 	bool
 	default y if !PPC64
