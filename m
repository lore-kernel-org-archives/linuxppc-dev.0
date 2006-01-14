Return-Path: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Update pmac32_defconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 16:46:47 +1100
Message-Id: <1137217608.4854.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Index: linux-work/arch/powerpc/configs/pmac32_defconfig
===================================================================
--- linux-work.orig/arch/powerpc/configs/pmac32_defconfig	2006-01-14 14:43:22.000000000 +1100
+++ linux-work/arch/powerpc/configs/pmac32_defconfig	2006-01-14 16:45:22.000000000 +1100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.15-rc5
-# Tue Dec 13 17:24:05 2005
+# Linux kernel version: 2.6.15
+# Sat Jan 14 16:26:08 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -15,11 +15,15 @@ CONFIG_EARLY_PRINTK=y
 CONFIG_GENERIC_NVRAM=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+# CONFIG_PPC_UDBG_16550 is not set
+# CONFIG_CRASH_DUMP is not set
+# CONFIG_GENERIC_TBSYNC is not set
 
 #
 # Processor support
 #
-CONFIG_6xx=y
+CONFIG_CLASSIC32=y
 # CONFIG_PPC_52xx is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
@@ -28,6 +32,7 @@ CONFIG_6xx=y
 # CONFIG_8xx is not set
 # CONFIG_E200 is not set
 # CONFIG_E500 is not set
+CONFIG_6xx=y
 CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
@@ -53,17 +58,18 @@ CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_HOTPLUG=y
-CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
+CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -72,8 +78,10 @@ CONFIG_CC_ALIGN_FUNCTIONS=0
 CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
 
 #
 # Loadable module support
@@ -113,13 +121,10 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_APUS is not set
 # CONFIG_PPC_CHRP is not set
 CONFIG_PPC_PMAC=y
-CONFIG_PPC_OF=y
 CONFIG_MPIC=y
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
-# CONFIG_CRASH_DUMP is not set
 CONFIG_PPC_MPC106=y
-# CONFIG_GENERIC_TBSYNC is not set
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_TABLE=y
 # CONFIG_CPU_FREQ_DEBUG is not set
@@ -195,6 +200,11 @@ CONFIG_CARDBUS=y
 # PC-card bridges
 #
 CONFIG_YENTA=m
+CONFIG_YENTA_O2=y
+CONFIG_YENTA_RICOH=y
+CONFIG_YENTA_TI=y
+CONFIG_YENTA_ENE_TUNE=y
+CONFIG_YENTA_TOSHIBA=y
 # CONFIG_PD6729 is not set
 # CONFIG_I82092 is not set
 CONFIG_PCCARD_NONSTATIC=m
@@ -464,7 +474,7 @@ CONFIG_IEEE80211_CRYPT_TKIP=m
 #
 # CONFIG_STANDALONE is not set
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-CONFIG_FW_LOADER=m
+CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -491,7 +501,7 @@ CONFIG_PROC_EVENTS=y
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
-CONFIG_MAC_FLOPPY=y
+CONFIG_MAC_FLOPPY=m
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
@@ -603,7 +613,7 @@ CONFIG_SCSI_CONSTANTS=y
 # SCSI Transport Attributes
 #
 CONFIG_SCSI_SPI_ATTRS=y
-# CONFIG_SCSI_FC_ATTRS is not set
+CONFIG_SCSI_FC_ATTRS=y
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
 
@@ -645,12 +655,7 @@ CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
 # CONFIG_SCSI_QLOGIC_FC is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 CONFIG_SCSI_QLA2XXX=y
-# CONFIG_SCSI_QLA21XX is not set
-# CONFIG_SCSI_QLA22XX is not set
-# CONFIG_SCSI_QLA2300 is not set
-# CONFIG_SCSI_QLA2322 is not set
-# CONFIG_SCSI_QLA6312 is not set
-# CONFIG_SCSI_QLA24XX is not set
+# CONFIG_SCSI_QLA2XXX_EMBEDDED_FIRMWARE is not set
 # CONFIG_SCSI_LPFC is not set
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
@@ -658,7 +663,7 @@ CONFIG_SCSI_QLA2XXX=y
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_SCSI_MESH=y
 CONFIG_SCSI_MESH_SYNC_RATE=5
-CONFIG_SCSI_MESH_RESET_DELAY_MS=1000
+CONFIG_SCSI_MESH_RESET_DELAY_MS=4000
 CONFIG_SCSI_MAC53C94=y
 
 #
@@ -727,7 +732,6 @@ CONFIG_IEEE1394_SBP2=m
 CONFIG_IEEE1394_ETH1394=m
 CONFIG_IEEE1394_DV1394=m
 CONFIG_IEEE1394_RAWIO=m
-# CONFIG_IEEE1394_CMP is not set
 
 #
 # I2O device support
@@ -740,7 +744,7 @@ CONFIG_IEEE1394_RAWIO=m
 CONFIG_ADB=y
 CONFIG_ADB_CUDA=y
 CONFIG_ADB_PMU=y
-CONFIG_PMAC_APM_EMU=y
+CONFIG_PMAC_APM_EMU=m
 CONFIG_PMAC_MEDIABAY=y
 CONFIG_PMAC_BACKLIGHT=y
 CONFIG_INPUT_ADBHID=y
@@ -819,6 +823,7 @@ CONFIG_PCNET32=y
 # CONFIG_R8169 is not set
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
 # CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
@@ -978,14 +983,14 @@ CONFIG_HW_CONSOLE=y
 CONFIG_SERIAL_8250=m
 # CONFIG_SERIAL_8250_CS is not set
 CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
 
 #
 # Non-8250 serial port support
 #
 CONFIG_SERIAL_CORE=m
-# CONFIG_SERIAL_PMACZILOG is not set
-# CONFIG_SERIAL_JSM is not set
+CONFIG_SERIAL_PMACZILOG=m
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -1058,7 +1063,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
 # CONFIG_I2C_PIIX4 is not set
-CONFIG_I2C_KEYWEST=m
+CONFIG_I2C_POWERMAC=y
 # CONFIG_I2C_MPC is not set
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
@@ -1160,7 +1165,6 @@ CONFIG_FB_ATY128=y
 CONFIG_FB_ATY=y
 CONFIG_FB_ATY_CT=y
 # CONFIG_FB_ATY_GENERIC_LCD is not set
-# CONFIG_FB_ATY_XL_INIT is not set
 CONFIG_FB_ATY_GX=y
 # CONFIG_FB_SAVAGE is not set
 # CONFIG_FB_SIS is not set
@@ -1169,7 +1173,6 @@ CONFIG_FB_ATY_GX=y
 CONFIG_FB_3DFX=y
 # CONFIG_FB_3DFX_ACCEL is not set
 # CONFIG_FB_VOODOO1 is not set
-# CONFIG_FB_CYBLA is not set
 # CONFIG_FB_TRIDENT is not set
 # CONFIG_FB_VIRTUAL is not set
 
@@ -1214,9 +1217,10 @@ CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
 CONFIG_SND_SEQUENCER_OSS=y
+# CONFIG_SND_DYNAMIC_MINORS is not set
+CONFIG_SND_SUPPORT_OLD_API=y
 # CONFIG_SND_VERBOSE_PRINTK is not set
 # CONFIG_SND_DEBUG is not set
-CONFIG_SND_GENERIC_DRIVER=y
 
 #
 # Generic devices
@@ -1230,6 +1234,8 @@ CONFIG_SND_DUMMY=m
 #
 # PCI devices
 #
+# CONFIG_SND_AD1889 is not set
+# CONFIG_SND_ALS4000 is not set
 # CONFIG_SND_ALI5451 is not set
 # CONFIG_SND_ATIIXP is not set
 # CONFIG_SND_ATIIXP_MODEM is not set
@@ -1238,45 +1244,44 @@ CONFIG_SND_DUMMY=m
 # CONFIG_SND_AU8830 is not set
 # CONFIG_SND_AZT3328 is not set
 # CONFIG_SND_BT87X is not set
-# CONFIG_SND_CS46XX is not set
+# CONFIG_SND_CA0106 is not set
+# CONFIG_SND_CMIPCI is not set
 # CONFIG_SND_CS4281 is not set
+# CONFIG_SND_CS46XX is not set
 # CONFIG_SND_EMU10K1 is not set
 # CONFIG_SND_EMU10K1X is not set
-# CONFIG_SND_CA0106 is not set
-# CONFIG_SND_KORG1212 is not set
-# CONFIG_SND_MIXART is not set
-# CONFIG_SND_NM256 is not set
-# CONFIG_SND_RME32 is not set
-# CONFIG_SND_RME96 is not set
-# CONFIG_SND_RME9652 is not set
-# CONFIG_SND_HDSP is not set
-# CONFIG_SND_HDSPM is not set
-# CONFIG_SND_TRIDENT is not set
-# CONFIG_SND_YMFPCI is not set
-# CONFIG_SND_AD1889 is not set
-# CONFIG_SND_ALS4000 is not set
-# CONFIG_SND_CMIPCI is not set
 # CONFIG_SND_ENS1370 is not set
 # CONFIG_SND_ENS1371 is not set
 # CONFIG_SND_ES1938 is not set
 # CONFIG_SND_ES1968 is not set
-# CONFIG_SND_MAESTRO3 is not set
 # CONFIG_SND_FM801 is not set
+# CONFIG_SND_HDA_INTEL is not set
+# CONFIG_SND_HDSP is not set
+# CONFIG_SND_HDSPM is not set
 # CONFIG_SND_ICE1712 is not set
 # CONFIG_SND_ICE1724 is not set
 # CONFIG_SND_INTEL8X0 is not set
 # CONFIG_SND_INTEL8X0M is not set
+# CONFIG_SND_KORG1212 is not set
+# CONFIG_SND_MAESTRO3 is not set
+# CONFIG_SND_MIXART is not set
+# CONFIG_SND_NM256 is not set
+# CONFIG_SND_PCXHR is not set
+# CONFIG_SND_RME32 is not set
+# CONFIG_SND_RME96 is not set
+# CONFIG_SND_RME9652 is not set
 # CONFIG_SND_SONICVIBES is not set
+# CONFIG_SND_TRIDENT is not set
 # CONFIG_SND_VIA82XX is not set
 # CONFIG_SND_VIA82XX_MODEM is not set
 # CONFIG_SND_VX222 is not set
-# CONFIG_SND_HDA_INTEL is not set
+# CONFIG_SND_YMFPCI is not set
 
 #
 # ALSA PowerMac devices
 #
 CONFIG_SND_POWERMAC=m
-# CONFIG_SND_POWERMAC_AUTO_DRC is not set
+CONFIG_SND_POWERMAC_AUTO_DRC=y
 
 #
 # USB devices
@@ -1336,6 +1341,7 @@ CONFIG_USB_PRINTER=m
 # may also be needed; see USB_STORAGE Help for more information
 #
 # CONFIG_USB_STORAGE is not set
+# CONFIG_USB_LIBUSUAL is not set
 
 #
 # USB Input Devices
@@ -1355,6 +1361,7 @@ CONFIG_USB_HIDINPUT=y
 # CONFIG_USB_YEALINK is not set
 # CONFIG_USB_XPAD is not set
 # CONFIG_USB_ATI_REMOTE is not set
+# CONFIG_USB_ATI_REMOTE2 is not set
 # CONFIG_USB_KEYSPAN_REMOTE is not set
 CONFIG_USB_APPLETOUCH=y
 
@@ -1501,6 +1508,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_INOTIFY=y
@@ -1540,6 +1548,7 @@ CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 CONFIG_RELAYFS_FS=m
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -1670,12 +1679,13 @@ CONFIG_OPROFILE=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
-CONFIG_DEBUG_KERNEL=y
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_MUTEXES is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1688,6 +1698,11 @@ CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 # CONFIG_BDI_SWITCH is not set
 CONFIG_BOOTX_TEXT=y
+# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
+# CONFIG_PPC_EARLY_DEBUG_G5 is not set
+# CONFIG_PPC_EARLY_DEBUG_RTAS is not set
+# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
+# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
 
 #
 # Security options
