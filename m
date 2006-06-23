Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 23 Jun 2006 18:20:24 +1000
Subject: [PATCH 8/8] Enable XMON in cell_defconfig
Message-Id: <20060623082023.8D3D867AC6@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that we have the udbg callbacks we can enable XMON by default.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/configs/cell_defconfig |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: to-merge/arch/powerpc/configs/cell_defconfig
===================================================================
--- to-merge.orig/arch/powerpc/configs/cell_defconfig
+++ to-merge/arch/powerpc/configs/cell_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.17
-# Mon Jun 19 17:23:03 2006
+# Linux kernel version: 2.6.17-rc6
+# Thu Jun 22 15:28:36 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -1063,7 +1063,8 @@ CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 CONFIG_DEBUGGER=y
-# CONFIG_XMON is not set
+CONFIG_XMON=y
+CONFIG_XMON_DEFAULT=y
 CONFIG_IRQSTACKS=y
 # CONFIG_BOOTX_TEXT is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
