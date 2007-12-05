Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 541A1DE09E
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 18:13:49 +1100 (EST)
Message-ID: <47564FA2.6000004@am.sony.com>
Date: Tue, 04 Dec 2007 23:13:38 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: PS3: Update ps3_defconfig
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update ps3_defconfig.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/configs/ps3_defconfig |  177 ++++++++++++++++++-------------------
 1 file changed, 89 insertions(+), 88 deletions(-)

--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc2
-# Tue Aug  7 19:17:26 2007
+# Linux kernel version: 2.6.24-rc4
+# Tue Dec  4 22:49:57 2007
 #
 CONFIG_PPC64=y
 
@@ -11,6 +11,7 @@ CONFIG_PPC64=y
 # CONFIG_POWER4_ONLY is not set
 CONFIG_POWER3=y
 CONFIG_POWER4=y
+CONFIG_TUNE_CELL=y
 CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
@@ -19,8 +20,13 @@ CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_64BIT=y
+CONFIG_WORD_SIZE=64
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -59,14 +65,18 @@ CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_SYSVIPC_SYSCTL=y
-# CONFIG_POSIX_MQUEUE is not set
+CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=17
-# CONFIG_CPUSETS is not set
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -87,13 +97,11 @@ CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLUB_DEBUG=y
-# CONFIG_SLAB is not set
-CONFIG_SLUB=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -108,6 +116,7 @@ CONFIG_STOP_MACHINE=y
 CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 CONFIG_BLK_DEV_BSG=y
+CONFIG_BLOCK_COMPAT=y
 
 #
 # IO Schedulers
@@ -126,7 +135,6 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 CONFIG_PPC_MULTIPLATFORM=y
-# CONFIG_EMBEDDED6xx is not set
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 # CONFIG_PPC_86xx is not set
@@ -176,10 +184,15 @@ CONFIG_SPU_BASE=y
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
 # CONFIG_CPM2 is not set
+# CONFIG_FSL_ULI1575 is not set
 
 #
 # Kernel options
 #
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
@@ -211,6 +224,8 @@ CONFIG_SPARSEMEM=y
 CONFIG_HAVE_MEMORY_PRESENT=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPARSEMEM_EXTREME=y
+CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
+CONFIG_SPARSEMEM_VMEMMAP=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTPLUG_SPARSE=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
@@ -237,10 +252,6 @@ CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_PCI_DOMAINS is not set
 # CONFIG_PCI_SYSCALL is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
 # CONFIG_PCCARD is not set
 CONFIG_KERNEL_START=0xc000000000000000
 
@@ -280,6 +291,7 @@ CONFIG_INET_TUNNEL=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
@@ -318,10 +330,6 @@ CONFIG_IPV6_SIT=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -330,26 +338,7 @@ CONFIG_IPV6_SIT=y
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
-CONFIG_BT=m
-CONFIG_BT_L2CAP=m
-CONFIG_BT_SCO=m
-CONFIG_BT_RFCOMM=m
-CONFIG_BT_RFCOMM_TTY=y
-# CONFIG_BT_BNEP is not set
-CONFIG_BT_HIDP=m
-
-#
-# Bluetooth device drivers
-#
-CONFIG_BT_HCIUSB=m
-CONFIG_BT_HCIUSB_SCO=y
-CONFIG_BT_HCIUART=m
-CONFIG_BT_HCIUART_H4=y
-CONFIG_BT_HCIUART_BCSP=y
-# CONFIG_BT_HCIBCM203X is not set
-# CONFIG_BT_HCIBPA10X is not set
-# CONFIG_BT_HCIBFUSB is not set
-# CONFIG_BT_HCIVHCI is not set
+# CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
 
 #
@@ -358,7 +347,13 @@ CONFIG_BT_HCIUART_BCSP=y
 # CONFIG_CFG80211 is not set
 CONFIG_WIRELESS_EXT=y
 # CONFIG_MAC80211 is not set
-# CONFIG_IEEE80211 is not set
+CONFIG_IEEE80211=m
+# CONFIG_IEEE80211_DEBUG is not set
+CONFIG_IEEE80211_CRYPT_WEP=m
+CONFIG_IEEE80211_CRYPT_CCMP=m
+CONFIG_IEEE80211_CRYPT_TKIP=m
+CONFIG_IEEE80211_SOFTMAC=m
+# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
 
@@ -369,9 +364,10 @@ CONFIG_WIRELESS_EXT=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
+CONFIG_FW_LOADER=m
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
@@ -434,6 +430,7 @@ CONFIG_SCSI_WAIT_SCAN=m
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
@@ -445,8 +442,15 @@ CONFIG_NETDEVICES=y
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-# CONFIG_NET_ETHERNET is not set
+# CONFIG_VETH is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
 CONFIG_MII=m
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_B44 is not set
 CONFIG_NETDEV_1000=y
 CONFIG_GELIC_NET=y
 # CONFIG_NETDEV_10000 is not set
@@ -455,7 +459,12 @@ CONFIG_GELIC_NET=y
 # Wireless LAN
 #
 # CONFIG_WLAN_PRE80211 is not set
-# CONFIG_WLAN_80211 is not set
+CONFIG_WLAN_80211=y
+# CONFIG_LIBERTAS is not set
+# CONFIG_USB_ZD1201 is not set
+# CONFIG_HOSTAP is not set
+CONFIG_ZD1211RW=m
+# CONFIG_ZD1211RW_DEBUG is not set
 
 #
 # USB Network Adapters
@@ -464,8 +473,8 @@ CONFIG_GELIC_NET=y
 # CONFIG_USB_KAWETH is not set
 CONFIG_USB_PEGASUS=m
 # CONFIG_USB_RTL8150 is not set
-CONFIG_USB_USBNET_MII=m
 CONFIG_USB_USBNET=m
+CONFIG_USB_NET_AX8817X=m
 # CONFIG_USB_NET_CDCETHER is not set
 # CONFIG_USB_NET_DM9601 is not set
 # CONFIG_USB_NET_GL620A is not set
@@ -499,9 +508,8 @@ CONFIG_INPUT_MOUSEDEV=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
-# CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
-# CONFIG_INPUT_EVDEV is not set
+CONFIG_INPUT_JOYDEV=m
+CONFIG_INPUT_EVDEV=m
 # CONFIG_INPUT_EVBUG is not set
 
 #
@@ -561,7 +569,6 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
@@ -579,6 +586,13 @@ CONFIG_GEN_RTC=y
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
@@ -595,12 +609,6 @@ CONFIG_GEN_RTC=y
 #
 # Graphics support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
-
-#
-# Display device support
-#
-# CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_VGASTATE is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
@@ -609,6 +617,7 @@ CONFIG_FB=y
 # CONFIG_FB_CFB_FILLRECT is not set
 # CONFIG_FB_CFB_COPYAREA is not set
 # CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
 CONFIG_FB_SYS_FILLRECT=y
 CONFIG_FB_SYS_COPYAREA=y
 CONFIG_FB_SYS_IMAGEBLIT=y
@@ -628,8 +637,14 @@ CONFIG_FB_DEFERRED_IO=y
 # CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_IBM_GXT4500 is not set
 CONFIG_FB_PS3=y
-CONFIG_FB_PS3_DEFAULT_SIZE_M=18
+CONFIG_FB_PS3_DEFAULT_SIZE_M=9
 # CONFIG_FB_VIRTUAL is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
 # Console display driver support
@@ -713,6 +728,7 @@ CONFIG_SND_PS3_DEFAULT_START_DELAY=2000
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
+# CONFIG_HIDRAW is not set
 
 #
 # USB Input Devices
@@ -776,12 +792,14 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_STORAGE_DEBUG is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
 # CONFIG_USB_STORAGE_DPCM is not set
 # CONFIG_USB_STORAGE_USBAT is not set
 # CONFIG_USB_STORAGE_SDDR09 is not set
 # CONFIG_USB_STORAGE_SDDR55 is not set
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
 # CONFIG_USB_STORAGE_KARMA is not set
 # CONFIG_USB_LIBUSUAL is not set
 
@@ -839,19 +857,6 @@ CONFIG_USB_MON=y
 # CONFIG_RTC_CLASS is not set
 
 #
-# DMA Engine support
-#
-# CONFIG_DMA_ENGINE is not set
-
-#
-# DMA Clients
-#
-
-#
-# DMA Devices
-#
-
-#
 # Userspace I/O
 #
 # CONFIG_UIO is not set
@@ -868,7 +873,6 @@ CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
@@ -881,6 +885,8 @@ CONFIG_FS_MBCACHE=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 CONFIG_QUOTA=y
+# CONFIG_QUOTA_NETLINK_INTERFACE is not set
+CONFIG_PRINT_QUOTA_WARNING=y
 # CONFIG_QFMT_V1 is not set
 CONFIG_QFMT_V2=y
 CONFIG_QUOTACTL=y
@@ -919,7 +925,6 @@ CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -938,10 +943,7 @@ CONFIG_RAMFS=y
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
@@ -973,10 +975,6 @@ CONFIG_CIFS=m
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 CONFIG_NLS_CODEPAGE_437=y
@@ -1017,10 +1015,6 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
 # CONFIG_NLS_UTF8 is not set
-
-#
-# Distributed Lock Manager
-#
 # CONFIG_DLM is not set
 # CONFIG_UCC_SLOW is not set
 
@@ -1038,17 +1032,16 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
-
-#
-# Instrumentation Support
-#
+CONFIG_INSTRUMENTATION=y
 # CONFIG_PROFILING is not set
 # CONFIG_KPROBES is not set
+# CONFIG_MARKERS is not set
 
 #
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
@@ -1060,7 +1053,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 CONFIG_DEBUG_SPINLOCK=y
@@ -1072,9 +1065,12 @@ CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_VM is not set
 CONFIG_DEBUG_LIST=y
+# CONFIG_DEBUG_SG is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_PAGEALLOC is not set
@@ -1088,6 +1084,7 @@ CONFIG_IRQSTACKS=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
@@ -1107,22 +1104,26 @@ CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_XTS is not set
 # CONFIG_CRYPTO_CRYPTD is not set
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
-# CONFIG_CRYPTO_AES is not set
+CONFIG_CRYPTO_AES=m
 # CONFIG_CRYPTO_CAST5 is not set
 # CONFIG_CRYPTO_CAST6 is not set
 # CONFIG_CRYPTO_TEA is not set
-# CONFIG_CRYPTO_ARC4 is not set
+CONFIG_CRYPTO_ARC4=m
 # CONFIG_CRYPTO_KHAZAD is not set
 # CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_SEED is not set
 # CONFIG_CRYPTO_DEFLATE is not set
-# CONFIG_CRYPTO_MICHAEL_MIC is not set
+CONFIG_CRYPTO_MICHAEL_MIC=m
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
+# CONFIG_CRYPTO_AUTHENC is not set
 CONFIG_CRYPTO_HW=y
+# CONFIG_PPC_CLOCK is not set
