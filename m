Return-Path: <arnd@arndb.de>
Message-Id: <20060429004327.792967000@localhost.localdomain>
References: <20060429004019.126937000@localhost.localdomain>
Date: Sat, 29 Apr 2006 02:40:22 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/3] powerpc: update cell_defconfig
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

reflect the changes to Kconfig since the last update.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/arch/powerpc/configs/cell_defconfig
===================================================================
--- linus-2.6.orig/arch/powerpc/configs/cell_defconfig	2006-04-29 01:50:25.000000000 +0200
+++ linus-2.6/arch/powerpc/configs/cell_defconfig	2006-04-29 02:05:56.000000000 +0200
@@ -9,6 +9,7 @@
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
@@ -55,6 +56,7 @@
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_EMBEDDED is not set
@@ -69,10 +71,6 @@
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -84,7 +82,6 @@
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
@@ -93,6 +90,7 @@
 #
 # Block layer
 #
+# CONFIG_BLK_DEV_IO_TRACE is not set
 
 #
 # IO Schedulers
@@ -126,6 +124,7 @@
 CONFIG_MMIO_NVRAM=y
 CONFIG_CELL_IIC=y
 # CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
 # CONFIG_CPU_FREQ is not set
 # CONFIG_WANT_EARLY_SERIAL is not set
 
@@ -167,7 +166,6 @@
 CONFIG_SPARSEMEM_EXTREME=y
 # CONFIG_MEMORY_HOTPLUG is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
-CONFIG_MIGRATION=y
 # CONFIG_PPC_64K_PAGES is not set
 CONFIG_SCHED_SMT=y
 CONFIG_PROC_DEVICETREE=y
@@ -184,7 +182,6 @@
 # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
-CONFIG_PCI_LEGACY_PROC=y
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -226,6 +223,7 @@
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
 CONFIG_INET_TUNNEL=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
@@ -242,6 +240,7 @@
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
+CONFIG_INET6_XFRM_TUNNEL=m
 CONFIG_INET6_TUNNEL=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_NETFILTER=y
@@ -632,6 +631,7 @@
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
@@ -717,7 +717,6 @@
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
-# CONFIG_SCx200_ACB is not set
 # CONFIG_I2C_SIS5595 is not set
 # CONFIG_I2C_SIS630 is not set
 # CONFIG_I2C_SIS96X is not set
@@ -736,9 +735,7 @@
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_RTC8564 is not set
 # CONFIG_SENSORS_MAX6875 is not set
-# CONFIG_RTC_X1205_I2C is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
@@ -766,10 +763,6 @@
 #
 
 #
-# Multimedia Capabilities Port drivers
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -818,6 +811,19 @@
 # CONFIG_MMC is not set
 
 #
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
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
@@ -834,6 +840,11 @@
 #
 
 #
+# Real Time Clock
+#
+# CONFIG_RTC_CLASS is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -889,7 +900,6 @@
 CONFIG_HUGETLBFS=y
 CONFIG_HUGETLB_PAGE=y
 CONFIG_RAMFS=y
-# CONFIG_RELAYFS_FS is not set
 # CONFIG_CONFIGFS_FS is not set
 
 #

--
