Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 85CAADE01E
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 04:09:25 +1000 (EST)
Date: Sat, 12 Apr 2008 14:09:23 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/5] Defconfig
Message-ID: <20080412140923.4645e4b6@lappy.seanm.ca>
In-Reply-To: <20080412134831.424480cf@lappy.seanm.ca>
References: <20080412134831.424480cf@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

diff --git a/arch/powerpc/configs/warp_defconfig b/arch/powerpc/configs/warp_defconfig
index 2313c3e..91b9fb1 100644
--- a/arch/powerpc/configs/warp_defconfig
+++ b/arch/powerpc/configs/warp_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc2
-# Fri Feb 15 21:54:43 2008
+# Linux kernel version: 2.6.25-rc6
+# Tue Apr  8 02:27:53 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -79,6 +79,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -112,6 +113,7 @@ CONFIG_SLAB=y
 CONFIG_HAVE_OPROFILE=y
 # CONFIG_KPROBES is not set
 CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
 CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
@@ -142,7 +144,6 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
 CONFIG_CLASSIC_RCU=y
-# CONFIG_PREEMPT_RCU is not set
 
 #
 # Platform support
@@ -159,6 +160,8 @@ CONFIG_CLASSIC_RCU=y
 # CONFIG_KATMAI is not set
 # CONFIG_RAINIER is not set
 CONFIG_WARP=y
+# CONFIG_CANYONLANDS is not set
+# CONFIG_YOSEMITE is not set
 CONFIG_440EP=y
 CONFIG_IBM440EP_ERR42=y
 # CONFIG_IPIC is not set
@@ -191,7 +194,6 @@ CONFIG_HZ=1000
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
-CONFIG_RCU_TRACE=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_MATH_EMULATION is not set
@@ -224,6 +226,7 @@ CONFIG_ISA_DMA_API=y
 # Bus options
 #
 CONFIG_ZONE_DMA=y
+CONFIG_4xx_SOC=y
 # CONFIG_PCI is not set
 # CONFIG_PCI_DOMAINS is not set
 # CONFIG_PCI_SYSCALL is not set
@@ -380,7 +383,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
-CONFIG_MTD_OOPS=m
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -434,6 +437,7 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ECC_SMC=y
 # CONFIG_MTD_NAND_MUSEUM_IDS is not set
 CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_NDFC=y
 # CONFIG_MTD_NAND_DISKONCHIP is not set
 # CONFIG_MTD_NAND_NANDSIM is not set
 # CONFIG_MTD_NAND_PLATFORM is not set
@@ -493,7 +497,7 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
-CONFIG_SCSI_WAIT_SCAN=m
+# CONFIG_SCSI_WAIT_SCAN is not set
 
 #
 # SCSI Transports
@@ -617,6 +621,7 @@ CONFIG_I2C_BOARDINFO=y
 #
 # I2C Hardware Bus support
 #
+CONFIG_I2C_IBM_IIC=y
 # CONFIG_I2C_MPC is not set
 # CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
@@ -650,6 +655,7 @@ CONFIG_SENSORS_EEPROM=y
 # CONFIG_POWER_SUPPLY is not set
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
+CONFIG_SENSORS_AD7414=y
 # CONFIG_SENSORS_AD7418 is not set
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
@@ -658,6 +664,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_ADM1031 is not set
 # CONFIG_SENSORS_ADM9240 is not set
 # CONFIG_SENSORS_ADT7470 is not set
+# CONFIG_SENSORS_ADT7473 is not set
 # CONFIG_SENSORS_ATXP1 is not set
 # CONFIG_SENSORS_DS1621 is not set
 # CONFIG_SENSORS_F71805F is not set
@@ -698,7 +705,20 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
 CONFIG_THERMAL=y
-# CONFIG_WATCHDOG is not set
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+# CONFIG_BOOKE_WDT is not set
+CONFIG_PIKA_WDT=y
+
+#
+# USB-based Watchdog Cards
+#
+# CONFIG_USBPCWATCHDOG is not set
 
 #
 # Sonics Silicon Backplane
@@ -826,14 +846,14 @@ CONFIG_USB_MON=y
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_GADGET is not set
-CONFIG_MMC=m
+CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
 # CONFIG_MMC_UNSAFE_RESUME is not set
 
 #
 # MMC/SD Card Drivers
 #
-CONFIG_MMC_BLOCK=m
+CONFIG_MMC_BLOCK=y
 CONFIG_MMC_BLOCK_BOUNCE=y
 # CONFIG_SDIO_UART is not set
 
@@ -841,10 +861,23 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 # MMC/SD Host Controller Drivers
 #
 # CONFIG_MMC_WBSD is not set
+CONFIG_MMC_PIKASD=y
 # CONFIG_MEMSTICK is not set
-# CONFIG_NEW_LEDS is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+#
+# LED drivers
+#
+CONFIG_LEDS_WARP=y
+
+#
+# LED Triggers
+#
+# CONFIG_LEDS_TRIGGERS is not set
 # CONFIG_EDAC is not set
 # CONFIG_RTC_CLASS is not set
+# CONFIG_DMADEVICES is not set
 
 #
 # Userspace I/O
@@ -896,7 +929,8 @@ CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
-# CONFIG_TMPFS is not set
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 # CONFIG_CONFIGFS_FS is not set
 
@@ -1013,6 +1047,7 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
 
 #
 # Kernel hacking
@@ -1022,7 +1057,7 @@ CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
-CONFIG_DEBUG_FS=y
+# CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
@@ -1052,7 +1087,6 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_DEBUGGER is not set
-# CONFIG_VIRQ_DEBUG is not set
 CONFIG_BDI_SWITCH=y
 # CONFIG_PPC_EARLY_DEBUG is not set
 
