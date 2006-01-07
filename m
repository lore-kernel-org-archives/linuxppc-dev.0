Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 11:46:37 +1100
Message-Id: <1136594797.4840.183.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [PATCH] 5/5 powerpc: Update g5 defconfig
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is just a deconfig update so that the Quad G5 works better with the
default config.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/configs/g5_defconfig
===================================================================
--- linux-work.orig/arch/powerpc/configs/g5_defconfig	2005-11-24 17:18:42.000000000 +1100
+++ linux-work/arch/powerpc/configs/g5_defconfig	2006-01-06 15:03:26.000000000 +1100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.15-rc1
-# Tue Nov 15 14:39:20 2005
+# Linux kernel version: 2.6.15-rc6
+# Fri Jan  6 15:03:09 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -26,7 +26,7 @@ CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
 CONFIG_SMP=y
-CONFIG_NR_CPUS=2
+CONFIG_NR_CPUS=4
 
 #
 # Code maturity level options
@@ -53,6 +53,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
@@ -116,6 +117,8 @@ CONFIG_U3_DART=y
 CONFIG_MPIC=y
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
+CONFIG_MPIC_BROKEN_U3=y
+# CONFIG_CRASH_DUMP is not set
 # CONFIG_PPC_MPC106 is not set
 CONFIG_GENERIC_TBSYNC=y
 CONFIG_CPU_FREQ=y
@@ -162,7 +165,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
-CONFIG_SPLIT_PTLOCK_CPUS=4096
+CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_PPC_64K_PAGES is not set
 # CONFIG_SCHED_SMT is not set
 CONFIG_PROC_DEVICETREE=y
@@ -629,6 +632,7 @@ CONFIG_THERM_PM72=y
 CONFIG_WINDFARM=y
 CONFIG_WINDFARM_PM81=y
 CONFIG_WINDFARM_PM91=y
+CONFIG_WINDFARM_PM112=y
 
 #
 # Network device support
@@ -681,7 +685,7 @@ CONFIG_E1000=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SK98LIN is not set
-CONFIG_TIGON3=m
+CONFIG_TIGON3=y
 # CONFIG_BNX2 is not set
 # CONFIG_MV643XX_ETH is not set
 
@@ -1141,6 +1145,7 @@ CONFIG_USB_STORAGE_JUMPSHOT=y
 #
 CONFIG_USB_HID=y
 CONFIG_USB_HIDINPUT=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
 CONFIG_HID_FF=y
 CONFIG_HID_PID=y
 CONFIG_LOGITECH_FF=y
@@ -1203,6 +1208,7 @@ CONFIG_USB_MON=y
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 # CONFIG_USB_SERIAL_AIRPRIME is not set
+# CONFIG_USB_SERIAL_ANYDATA is not set
 CONFIG_USB_SERIAL_BELKIN=m
 CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
 # CONFIG_USB_SERIAL_CP2101 is not set
@@ -1233,7 +1239,6 @@ CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
 CONFIG_USB_SERIAL_KLSI=m
 CONFIG_USB_SERIAL_KOBIL_SCT=m
 CONFIG_USB_SERIAL_MCT_U232=m
-# CONFIG_USB_SERIAL_NOKIA_DKU2 is not set
 CONFIG_USB_SERIAL_PL2303=m
 # CONFIG_USB_SERIAL_HP4X is not set
 CONFIG_USB_SERIAL_SAFE=m
