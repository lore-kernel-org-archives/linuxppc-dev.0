Return-Path: <michael@ozlabs.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 02 May 2006 19:54:04 +1000
Subject: [PATCH 3/3] powerpc: Update cell_defconfig for xmon & early debugging
Message-Id: <20060502095407.9446467B3D@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update cell_defconfig for xmon & early debugging options. There's probably
no point merging this yet, there'll be lots of new stuff before 2.6.18, just
a heads up.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/configs/cell_defconfig |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

Index: cell/arch/powerpc/configs/cell_defconfig
===================================================================
--- cell.orig/arch/powerpc/configs/cell_defconfig
+++ cell/arch/powerpc/configs/cell_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.17-rc1
-# Wed Apr 12 15:40:32 2006
+# Linux kernel version: 2.6.17-rc2
+# Mon May  1 17:04:39 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -61,7 +61,7 @@ CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_ALL is not set
+CONFIG_KALLSYMS_ALL=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
@@ -125,6 +125,7 @@ CONFIG_RTAS_FLASH=y
 CONFIG_MMIO_NVRAM=y
 CONFIG_CELL_IIC=y
 # CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
 # CONFIG_CPU_FREQ is not set
 # CONFIG_WANT_EARLY_SERIAL is not set
 
@@ -154,6 +155,7 @@ CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_NUMA=y
+CONFIG_NODES_SHIFT=4
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
 CONFIG_SELECT_MEMORY_MODEL=y
@@ -823,6 +825,14 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_NEW_LEDS is not set
 
 #
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
 # InfiniBand support
 #
 CONFIG_INFINIBAND=y
@@ -1050,11 +1060,13 @@ CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 CONFIG_DEBUGGER=y
-# CONFIG_XMON is not set
+CONFIG_XMON=y
+# CONFIG_XMON_DEFAULT is not set
 CONFIG_IRQSTACKS=y
 # CONFIG_BOOTX_TEXT is not set
 # CONFIG_PPC_EARLY_DEBUG_LPAR is not set
 # CONFIG_PPC_EARLY_DEBUG_G5 is not set
+# CONFIG_PPC_EARLY_DEBUG_CELL is not set
 # CONFIG_PPC_EARLY_DEBUG_RTAS is not set
 # CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
 # CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
