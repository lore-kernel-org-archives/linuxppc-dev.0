Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C9D3DDE41
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 17:41:54 +1000 (EST)
Date: Wed, 09 May 2007 16:41:16 +0900 (JST)
Message-Id: <200705090741.l497ffUf015135@toshiba.co.jp>
Subject: [PATCH 4/4] celleb: update celleb_defconfig
To: paulus@samba.org
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

Updates for celleb_defconfig.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/configs/celleb_defconfig
diff -u linux-powerpc-git/arch/powerpc/configs/celleb_defconfig:1.1.1.1 linux-powerpc-git/arch/powerpc/configs/celleb_defconfig:1.8.2.1
--- linux-powerpc-git/arch/powerpc/configs/celleb_defconfig:1.1.1.1	Thu Feb  8 11:38:20 2007
+++ linux-powerpc-git/arch/powerpc/configs/celleb_defconfig	Wed May  9 13:54:40 2007
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc4
-# Thu Jan 11 20:55:33 2007
+# Linux kernel version: 2.6.21
+# Tue May  8 12:32:16 2007
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -60,6 +60,7 @@
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
@@ -70,6 +71,7 @@
 # CONFIG_CPUSETS is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
@@ -132,15 +134,26 @@
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_ISERIES is not set
 # CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_MPC5200 is not set
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 # CONFIG_PPC_PASEMI is not set
+CONFIG_PPC_CELLEB=y
+# CONFIG_PPC_PS3 is not set
 CONFIG_PPC_CELL=y
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_IBM_CELL_BLADE is not set
-# CONFIG_PPC_PS3 is not set
-CONFIG_PPC_CELLEB=y
+
+#
+# Cell Broadband Engine options
+#
+CONFIG_SPU_FS=y
+CONFIG_SPU_BASE=y
+# CONFIG_PQ2ADS is not set
 CONFIG_PPC_UDBG_BEAT=y
+# CONFIG_MPIC is not set
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
 # CONFIG_U3_DART is not set
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
@@ -149,15 +162,7 @@
 # CONFIG_PPC_INDIRECT_IO is not set
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
-# CONFIG_WANT_EARLY_SERIAL is not set
-# CONFIG_MPIC is not set
-
-#
-# Cell Broadband Engine options
-#
-CONFIG_SPU_FS=y
-CONFIG_SPU_BASE=y
-# CONFIG_CBE_RAS is not set
+# CONFIG_CPM2 is not set
 
 #
 # Kernel options
@@ -183,7 +188,6 @@
 CONFIG_NODES_SHIFT=4
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
-CONFIG_ARCH_SPARSEMEM_DEFAULT=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 # CONFIG_FLATMEM_MANUAL is not set
@@ -199,6 +203,7 @@
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_MIGRATION=y
 CONFIG_RESOURCES_64BIT=y
+CONFIG_ZONE_DMA_FLAG=1
 CONFIG_ARCH_MEMORY_PROBE=y
 CONFIG_NODES_SPAN_OTHER_NODES=y
 # CONFIG_PPC_64K_PAGES is not set
@@ -207,14 +212,14 @@
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 CONFIG_SECCOMP=y
+# CONFIG_WANT_DEVICE_TREE is not set
 CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
+CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
-# CONFIG_MPIC_WEIRD is not set
-# CONFIG_PPC_I8259 is not set
 # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
@@ -240,13 +245,13 @@
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -262,7 +267,7 @@
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
-# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_TUNNEL=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
@@ -280,6 +285,7 @@
 CONFIG_IPV6=y
 # CONFIG_IPV6_PRIVACY is not set
 # CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_IPV6_OPTIMISTIC_DAD is not set
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
@@ -302,17 +308,21 @@
 #
 # CONFIG_NETFILTER_NETLINK is not set
 # CONFIG_NF_CONNTRACK_ENABLED is not set
+# CONFIG_NF_CONNTRACK is not set
 # CONFIG_NETFILTER_XTABLES is not set
 
 #
 # IP: Netfilter Configuration
 #
 CONFIG_IP_NF_QUEUE=m
+# CONFIG_IP_NF_IPTABLES is not set
+# CONFIG_IP_NF_ARPTABLES is not set
 
 #
 # IPv6: Netfilter Configuration (EXPERIMENTAL)
 #
 # CONFIG_IP6_NF_QUEUE is not set
+# CONFIG_IP6_NF_IPTABLES is not set
 
 #
 # DCCP Configuration (EXPERIMENTAL)
@@ -352,6 +362,13 @@
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
 # CONFIG_IEEE80211 is not set
 
 #
@@ -365,16 +382,13 @@
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
 # Connector - unified userspace <-> kernelspace linker
 #
 # CONFIG_CONNECTOR is not set
-
-#
-# Memory Technology Devices (MTD)
-#
 # CONFIG_MTD is not set
 
 #
@@ -385,6 +399,7 @@
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -404,7 +419,6 @@
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=131072
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -443,7 +457,6 @@
 # CONFIG_BLK_DEV_OPTI621 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
-CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
@@ -458,6 +471,7 @@
 # CONFIG_BLK_DEV_JMICRON is not set
 # CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_IT8213 is not set
 # CONFIG_BLK_DEV_IT821X is not set
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_PDC202XX_OLD is not set
@@ -468,11 +482,11 @@
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
-CONFIG_BLK_DEV_IDE_CELLEB=y
+# CONFIG_BLK_DEV_TC86C001 is not set
+CONFIG_BLK_DEV_CELLEB=y
 # CONFIG_IDE_ARM is not set
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
-CONFIG_IDEDMA_AUTO=y
 # CONFIG_BLK_DEV_HD is not set
 
 #
@@ -546,6 +560,7 @@
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_ESP_CORE is not set
 # CONFIG_SCSI_SRP is not set
 
 #
@@ -591,12 +606,7 @@
 # I2O device support
 #
 # CONFIG_I2O is not set
-
-#
-# Macintosh device drivers
-#
-# CONFIG_MAC_EMUMOUSEBTN is not set
-# CONFIG_WINDFARM is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
 
 #
 # Network device support
@@ -652,15 +662,18 @@
 # CONFIG_BNX2 is not set
 CONFIG_SPIDER_NET=y
 # CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
 
 #
 # Ethernet (10000 Mbit)
 #
 # CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
 # CONFIG_NETXEN_NIC is not set
+# CONFIG_PASEMI_MAC is not set
 
 #
 # Token Ring devices
@@ -668,9 +681,10 @@
 # CONFIG_TR is not set
 
 #
-# Wireless LAN (non-hamradio)
+# Wireless LAN
 #
-# CONFIG_NET_RADIO is not set
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
 
 #
 # Wan interfaces
@@ -770,6 +784,7 @@
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_SERIAL_TXX9=y
 CONFIG_HAS_TXX9_SERIAL=y
+CONFIG_SERIAL_TXX9_NR_UARTS=3
 CONFIG_SERIAL_TXX9_CONSOLE=y
 # CONFIG_SERIAL_TXX9_STDSERIAL is not set
 # CONFIG_SERIAL_JSM is not set
@@ -891,6 +906,11 @@
 # CONFIG_HWMON_VID is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -904,7 +924,7 @@
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
 
@@ -913,7 +933,6 @@
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -924,6 +943,15 @@
 # HID Devices
 #
 CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+CONFIG_USB_HIDDEV=y
 
 #
 # USB support
@@ -938,9 +966,8 @@
 # Miscellaneous USB options
 #
 CONFIG_USB_DEVICEFS=y
-# CONFIG_USB_BANDWIDTH is not set
+# CONFIG_USB_DEVICE_CLASS is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_MULTITHREAD_PROBE is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -953,6 +980,7 @@
 CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
 # CONFIG_USB_ISP116X_HCD is not set
 CONFIG_USB_OHCI_HCD=m
+# CONFIG_USB_OHCI_HCD_PPC_OF is not set
 # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
 CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
@@ -989,10 +1017,6 @@
 #
 # USB Input Devices
 #
-CONFIG_USB_HID=y
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
-# CONFIG_HID_FF is not set
-CONFIG_USB_HIDDEV=y
 # CONFIG_USB_AIPTEK is not set
 # CONFIG_USB_WACOM is not set
 # CONFIG_USB_ACECAD is not set
@@ -1005,6 +1029,7 @@
 # CONFIG_USB_ATI_REMOTE2 is not set
 # CONFIG_USB_KEYSPAN_REMOTE is not set
 # CONFIG_USB_APPLETOUCH is not set
+# CONFIG_USB_GTCO is not set
 
 #
 # USB Imaging devices
@@ -1042,6 +1067,7 @@
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
@@ -1052,6 +1078,7 @@
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1109,6 +1136,10 @@
 #
 
 #
+# Auxiliary Display support
+#
+
+#
 # Virtualization
 #
 
@@ -1293,6 +1324,8 @@
 # Distributed Lock Manager
 #
 # CONFIG_DLM is not set
+# CONFIG_UCC_SLOW is not set
+# CONFIG_UCC_FAST is not set
 
 #
 # Library routines
@@ -1305,7 +1338,8 @@
 CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
 
 #
 # Instrumentation Support
@@ -1323,15 +1357,16 @@
 CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
 CONFIG_LOG_BUF_SHIFT=15
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_RWSEMS is not set
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1341,8 +1376,10 @@
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_FORCED_INLINING is not set
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
 CONFIG_DEBUGGER=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
@@ -1356,6 +1393,7 @@
 # CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE is not set
 # CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
 # CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
+# CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE is not set
 CONFIG_PPC_EARLY_DEBUG_BEAT=y
 
 #
@@ -1385,8 +1423,10 @@
 # CONFIG_CRYPTO_GF128MUL is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=m
+CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=m
+# CONFIG_CRYPTO_FCRYPT is not set
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_TWOFISH_COMMON=m
@@ -1401,6 +1441,7 @@
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
+# CONFIG_CRYPTO_CAMELLIA is not set
 CONFIG_CRYPTO_TEST=m
 
 #
