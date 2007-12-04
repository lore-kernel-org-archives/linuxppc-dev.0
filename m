Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2BFB1DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 19:41:15 +1100 (EST)
Date: Tue, 04 Dec 2007 17:41:07 +0900 (JST)
Message-Id: <20071204.174107.-1625850822.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 3/3] update celleb_defconfig to support for native CBE
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch updates celleb_defconfig to support for native CBE.

Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/configs/celleb_defconfig
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/configs/celleb_defconfig
+++ linux-powerpc-git/arch/powerpc/configs/celleb_defconfig
@@ -44,7 +44,8 @@ CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 # CONFIG_DEFAULT_UIMAGE is not set
 # CONFIG_PPC_DCR_NATIVE is not set
-# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_PPC_DCR_MMIO=y
+CONFIG_PPC_DCR=y
 CONFIG_PPC_OF_PLATFORM_PCI=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
@@ -141,7 +142,7 @@ CONFIG_PPC_MULTIPLATFORM=y
 CONFIG_PPC_CELLEB=y
 # CONFIG_PPC_PS3 is not set
 CONFIG_PPC_CELL=y
-# CONFIG_PPC_CELL_NATIVE is not set
+CONFIG_PPC_CELL_NATIVE=y
 # CONFIG_PPC_IBM_CELL_BLADE is not set
 
 #
@@ -150,18 +151,24 @@ CONFIG_PPC_CELL=y
 CONFIG_SPU_FS=y
 CONFIG_SPU_FS_64K_LS=y
 CONFIG_SPU_BASE=y
+CONFIG_CBE_RAS=y
+# CONFIG_CBE_THERM is not set
 # CONFIG_PQ2ADS is not set
+CONFIG_PPC_NATIVE=y
+CONFIG_UDBG_RTAS_CONSOLE=y
 CONFIG_PPC_UDBG_BEAT=y
-# CONFIG_MPIC is not set
+CONFIG_MPIC=y
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
 # CONFIG_U3_DART is not set
-# CONFIG_PPC_RTAS is not set
+CONFIG_PPC_RTAS=y
+# CONFIG_RTAS_ERROR_LOGGING is not set
+# CONFIG_RTAS_PROC is not set
 # CONFIG_MMIO_NVRAM is not set
 # CONFIG_PPC_MPC106 is not set
 # CONFIG_PPC_970_NAP is not set
-# CONFIG_PPC_INDIRECT_IO is not set
-# CONFIG_GENERIC_IOMAP is not set
+CONFIG_PPC_INDIRECT_IO=y
+CONFIG_GENERIC_IOMAP=y
 # CONFIG_CPU_FREQ is not set
 # CONFIG_CPM2 is not set
 # CONFIG_FSL_ULI1575 is not set
@@ -723,6 +730,7 @@ CONFIG_SERIAL_TXX9_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_HVC_DRIVER=y
+CONFIG_HVC_RTAS=y
 CONFIG_HVC_BEAT=y
 # CONFIG_IPMI_HANDLER is not set
 CONFIG_WATCHDOG=y
@@ -732,6 +740,7 @@ CONFIG_WATCHDOG=y
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
+# CONFIG_WATCHDOG_RTAS is not set
 
 #
 # PCI-based Watchdog Cards
@@ -1243,16 +1252,7 @@ CONFIG_XMON_DEFAULT=y
 CONFIG_XMON_DISASSEMBLY=y
 CONFIG_IRQSTACKS=y
 # CONFIG_BOOTX_TEXT is not set
-CONFIG_PPC_EARLY_DEBUG=y
-# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
-# CONFIG_PPC_EARLY_DEBUG_G5 is not set
-# CONFIG_PPC_EARLY_DEBUG_RTAS_PANEL is not set
-# CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE is not set
-# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
-# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
-# CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE is not set
-CONFIG_PPC_EARLY_DEBUG_BEAT=y
-# CONFIG_PPC_EARLY_DEBUG_44x is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
 
 #
 # Security options
