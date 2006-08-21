Return-Path: <olaf@ibook.aepfle.de>
Received: from natblert.rzone.de (natblert.rzone.de [81.169.145.181])
	by ozlabs.org (Postfix) with ESMTP id 8ECF667B83
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 22:43:34 +1000 (EST)
Date: Mon, 21 Aug 2006 14:43:23 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
Subject: [PATCH] update pmac32_defconfig
Message-ID: <20060821124323.GA28970@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


disable unused winbond IDE driver
disable usbmon, seccomp and rmmod -f
enable windfarm, pppoe, pegasus, Euro nls and magic sysrq.
optimize for size

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/configs/pmac32_defconfig |   51 ++++++++++++++++------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

Index: linux-2.6.18-rc4/arch/powerpc/configs/pmac32_defconfig
===================================================================
--- linux-2.6.18-rc4.orig/arch/powerpc/configs/pmac32_defconfig
+++ linux-2.6.18-rc4/arch/powerpc/configs/pmac32_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.17
-# Mon Jul  3 14:20:49 2006
+# Linux kernel version: 2.6.18-rc4-git1
+# Mon Aug 21 13:46:05 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -60,13 +60,14 @@ CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
@@ -91,7 +92,7 @@ CONFIG_BASE_SMALL=0
 #
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
@@ -182,7 +183,7 @@ CONFIG_PM=y
 CONFIG_PM_DEBUG=y
 CONFIG_SOFTWARE_SUSPEND=y
 CONFIG_PM_STD_PARTITION=""
-CONFIG_SECCOMP=y
+# CONFIG_SECCOMP is not set
 CONFIG_ISA_DMA_API=y
 
 #
@@ -515,7 +516,7 @@ CONFIG_WIRELESS_EXT=y
 #
 # Generic Driver Options
 #
-# CONFIG_STANDALONE is not set
+CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
@@ -559,6 +560,7 @@ CONFIG_BLK_DEV_UB=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
@@ -591,7 +593,7 @@ CONFIG_IDEPCI_SHARE_IRQ=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
-CONFIG_BLK_DEV_SL82C105=y
+# CONFIG_BLK_DEV_SL82C105 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
@@ -793,7 +795,7 @@ CONFIG_INPUT_ADBHID=y
 CONFIG_MAC_EMUMOUSEBTN=y
 CONFIG_THERM_WINDTUNNEL=m
 CONFIG_THERM_ADT746X=m
-# CONFIG_WINDFARM is not set
+CONFIG_WINDFARM=m
 # CONFIG_ANSLCD is not set
 
 #
@@ -952,7 +954,7 @@ CONFIG_PPP_SYNC_TTY=m
 CONFIG_PPP_DEFLATE=y
 CONFIG_PPP_BSDCOMP=m
 # CONFIG_PPP_MPPE is not set
-# CONFIG_PPPOE is not set
+CONFIG_PPPOE=m
 # CONFIG_SLIP is not set
 # CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
@@ -979,7 +981,7 @@ CONFIG_INPUT=y
 # Userland interfaces
 #
 CONFIG_INPUT_MOUSEDEV=y
-CONFIG_INPUT_MOUSEDEV_PSAUX=y
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
@@ -1007,11 +1009,7 @@ CONFIG_INPUT_MOUSE=y
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-# CONFIG_SERIO_SERPORT is not set
-# CONFIG_SERIO_PCIPS2 is not set
-# CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
@@ -1479,7 +1477,7 @@ CONFIG_USB_APPLETOUCH=y
 #
 # CONFIG_USB_CATC is not set
 # CONFIG_USB_KAWETH is not set
-# CONFIG_USB_PEGASUS is not set
+CONFIG_USB_PEGASUS=m
 # CONFIG_USB_RTL8150 is not set
 CONFIG_USB_USBNET=m
 CONFIG_USB_NET_AX8817X=m
@@ -1490,7 +1488,7 @@ CONFIG_USB_NET_NET1080=m
 # CONFIG_USB_NET_RNDIS_HOST is not set
 # CONFIG_USB_NET_CDC_SUBSET is not set
 CONFIG_USB_NET_ZAURUS=m
-CONFIG_USB_MON=y
+# CONFIG_USB_MON is not set
 
 #
 # USB port drivers
@@ -1502,7 +1500,6 @@ CONFIG_USB_MON=y
 CONFIG_USB_SERIAL=m
 # CONFIG_USB_SERIAL_GENERIC is not set
 # CONFIG_USB_SERIAL_AIRPRIME is not set
-# CONFIG_USB_SERIAL_ANYDATA is not set
 # CONFIG_USB_SERIAL_ARK3116 is not set
 # CONFIG_USB_SERIAL_BELKIN is not set
 # CONFIG_USB_SERIAL_WHITEHEAT is not set
@@ -1540,6 +1537,7 @@ CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
 # CONFIG_USB_SERIAL_PL2303 is not set
 # CONFIG_USB_SERIAL_HP4X is not set
 # CONFIG_USB_SERIAL_SAFE is not set
+# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
 # CONFIG_USB_SERIAL_TI is not set
 # CONFIG_USB_SERIAL_CYBERJACK is not set
 # CONFIG_USB_SERIAL_XIRCOM is not set
@@ -1557,7 +1555,7 @@ CONFIG_USB_EZUSB=y
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
-# CONFIG_USB_CY7C63 is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
 # CONFIG_USB_PHIDGETKIT is not set
 # CONFIG_USB_PHIDGETSERVO is not set
@@ -1728,7 +1726,6 @@ CONFIG_RPCSEC_GSS_KRB5=y
 CONFIG_SMB_FS=m
 # CONFIG_SMB_NLS_DEFAULT is not set
 # CONFIG_CIFS is not set
-# CONFIG_CIFS_DEBUG2 is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
@@ -1763,8 +1760,8 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 CONFIG_NLS_CODEPAGE_437=m
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
-# CONFIG_NLS_CODEPAGE_850 is not set
-# CONFIG_NLS_CODEPAGE_852 is not set
+CONFIG_NLS_CODEPAGE_850=m
+CONFIG_NLS_CODEPAGE_852=m
 # CONFIG_NLS_CODEPAGE_855 is not set
 # CONFIG_NLS_CODEPAGE_857 is not set
 # CONFIG_NLS_CODEPAGE_860 is not set
@@ -1781,7 +1778,7 @@ CONFIG_NLS_CODEPAGE_437=m
 # CONFIG_NLS_CODEPAGE_949 is not set
 # CONFIG_NLS_CODEPAGE_874 is not set
 # CONFIG_NLS_ISO8859_8 is not set
-# CONFIG_NLS_CODEPAGE_1250 is not set
+CONFIG_NLS_CODEPAGE_1250=m
 # CONFIG_NLS_CODEPAGE_1251 is not set
 # CONFIG_NLS_ASCII is not set
 CONFIG_NLS_ISO8859_1=m
@@ -1794,7 +1791,7 @@ CONFIG_NLS_ISO8859_1=m
 # CONFIG_NLS_ISO8859_9 is not set
 # CONFIG_NLS_ISO8859_13 is not set
 # CONFIG_NLS_ISO8859_14 is not set
-# CONFIG_NLS_ISO8859_15 is not set
+CONFIG_NLS_ISO8859_15=m
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
 CONFIG_NLS_UTF8=m
@@ -1824,18 +1821,20 @@ CONFIG_OPROFILE=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
-# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
-# CONFIG_DEBUG_MUTEXES is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_RWSEMS is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_FS is not set
