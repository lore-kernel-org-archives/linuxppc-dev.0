Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 7995FDE0D1
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 08:59:44 +1000 (EST)
Message-Id: <20070618224923.632464298@arndb.de>
References: <20070618224247.972139855@arndb.de>
Date: Tue, 19 Jun 2007 00:42:52 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 5/5] Update cell_defconfig
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linux-2.6/arch/powerpc/configs/cell_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/cell_defconfig
+++ linux-2.6/arch/powerpc/configs/cell_defconfig
@@ -1,9 +1,23 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21-rc6
-# Mon Apr 23 20:46:48 2007
+# Linux kernel version: 2.6.22-rc4
+# Sat Jun 16 20:45:34 2007
 #
 CONFIG_PPC64=y
+
+#
+# Processor support
+#
+# CONFIG_POWER4_ONLY is not set
+CONFIG_POWER3=y
+CONFIG_POWER4=y
+CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_MM_SLICES=y
+CONFIG_VIRT_CPU_ACCOUNTING=y
+CONFIG_SMP=y
+CONFIG_NR_CPUS=4
 CONFIG_64BIT=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -27,23 +41,10 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 # CONFIG_DEFAULT_UIMAGE is not set
-
-#
-# Processor support
-#
-# CONFIG_POWER4_ONLY is not set
-CONFIG_POWER3=y
-CONFIG_POWER4=y
-CONFIG_PPC_FPU=y
 # CONFIG_PPC_DCR_NATIVE is not set
 CONFIG_PPC_DCR_MMIO=y
 CONFIG_PPC_DCR=y
 CONFIG_PPC_OF_PLATFORM_PCI=y
-CONFIG_ALTIVEC=y
-CONFIG_PPC_STD_MMU=y
-CONFIG_VIRT_CPU_ACCOUNTING=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=4
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -69,6 +70,7 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=15
 CONFIG_CPUSETS=y
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
@@ -87,14 +89,19 @@ CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
-CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
 
 #
 # Loadable module support
@@ -131,7 +138,6 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_EMBEDDED6xx is not set
-# CONFIG_APUS is not set
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_ISERIES is not set
 # CONFIG_PPC_MPC52xx is not set
@@ -151,7 +157,11 @@ CONFIG_PS3_HTAB_SIZE=20
 CONFIG_PS3_USE_LPAR_ADDR=y
 CONFIG_PS3_VUART=y
 CONFIG_PS3_PS3AV=y
-CONFIG_PS3_SYS_MANAGER=y
+CONFIG_PS3_SYS_MANAGER=m
+CONFIG_PS3_STORAGE=y
+CONFIG_PS3_DISK=y
+CONFIG_PS3_ROM=m
+CONFIG_PS3_FLASH=m
 CONFIG_PPC_CELL=y
 CONFIG_PPC_CELL_NATIVE=y
 CONFIG_PPC_IBM_CELL_BLADE=y
@@ -163,9 +173,17 @@ CONFIG_SPU_FS=m
 CONFIG_SPU_BASE=y
 CONFIG_CBE_RAS=y
 CONFIG_CBE_THERM=m
+CONFIG_CBE_CPUFREQ=m
+# CONFIG_PQ2ADS is not set
 CONFIG_PPC_NATIVE=y
 CONFIG_UDBG_RTAS_CONSOLE=y
 CONFIG_PPC_UDBG_BEAT=y
+CONFIG_PPC_SYSTEMSIM=y
+# CONFIG_SYSTEMSIM_IDLE is not set
+# CONFIG_SYSTEMSIM_BOOT is not set
+CONFIG_MPIC=y
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
 # CONFIG_U3_DART is not set
 CONFIG_PPC_RTAS=y
 # CONFIG_RTAS_ERROR_LOGGING is not set
@@ -177,9 +195,24 @@ CONFIG_MMIO_NVRAM=y
 # CONFIG_PPC_970_NAP is not set
 CONFIG_PPC_INDIRECT_IO=y
 CONFIG_GENERIC_IOMAP=y
-# CONFIG_CPU_FREQ_PMAC64 is not set
-# CONFIG_WANT_EARLY_SERIAL is not set
-CONFIG_MPIC=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_TABLE=m
+CONFIG_CPU_FREQ_DEBUG=y
+CONFIG_CPU_FREQ_STAT=m
+CONFIG_CPU_FREQ_STAT_DETAILS=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
+# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
+CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=m
+CONFIG_CPU_FREQ_GOV_USERSPACE=m
+CONFIG_CPU_FREQ_GOV_ONDEMAND=m
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
+
+#
+# CPU Frequency drivers
+#
+# CONFIG_CPM2 is not set
+CONFIG_AXON_RAM=m
 
 #
 # Kernel options
@@ -224,12 +257,14 @@ CONFIG_RESOURCES_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_ARCH_MEMORY_PROBE=y
 CONFIG_NODES_SPAN_OTHER_NODES=y
+CONFIG_PPC_HAS_HASH_64K=y
 CONFIG_PPC_64K_PAGES=y
 CONFIG_SCHED_SMT=y
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 CONFIG_SECCOMP=y
+# CONFIG_WANT_DEVICE_TREE is not set
 CONFIG_ISA_DMA_API=y
 
 #
@@ -237,22 +272,18 @@ CONFIG_ISA_DMA_API=y
 #
 CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
-# CONFIG_MPIC_WEIRD is not set
-# CONFIG_PPC_I8259 is not set
 # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 CONFIG_PCIEPORTBUS=y
+CONFIG_ARCH_SUPPORTS_MSI=y
+CONFIG_PCI_MSI=y
 # CONFIG_PCI_DEBUG is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
 #
 # CONFIG_PCCARD is not set
-
-#
-# PCI Hotplug Support
-#
 # CONFIG_HOTPLUG_PCI is not set
 CONFIG_KERNEL_START=0xc000000000000000
 
@@ -264,7 +295,6 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -300,14 +330,11 @@ CONFIG_INET_TCP_DIAG=y
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
-
-#
-# IP: Virtual Server Configuration
-#
 # CONFIG_IP_VS is not set
 CONFIG_IPV6=y
 # CONFIG_IPV6_PRIVACY is not set
 # CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_IPV6_OPTIMISTIC_DAD is not set
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
@@ -332,6 +359,7 @@ CONFIG_NETFILTER_NETLINK=m
 CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NETFILTER_NETLINK_LOG=m
 # CONFIG_NF_CONNTRACK_ENABLED is not set
+# CONFIG_NF_CONNTRACK is not set
 CONFIG_NETFILTER_XTABLES=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_DSCP=m
@@ -389,20 +417,8 @@ CONFIG_IP_NF_ARP_MANGLE=m
 #
 # CONFIG_IP6_NF_QUEUE is not set
 # CONFIG_IP6_NF_IPTABLES is not set
-
-#
-# DCCP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_DCCP is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_SCTP is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -420,6 +436,7 @@ CONFIG_IP_NF_ARP_MANGLE=m
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+CONFIG_NET_SCH_FIFO=y
 CONFIG_NET_CLS_ROUTE=y
 
 #
@@ -429,7 +446,18 @@ CONFIG_NET_CLS_ROUTE=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+CONFIG_CFG80211=m
+CONFIG_WIRELESS_EXT=y
+CONFIG_MAC80211=m
+# CONFIG_MAC80211_DEBUGFS is not set
+# CONFIG_MAC80211_DEBUG is not set
 # CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
 
 #
 # Device Drivers
@@ -449,10 +477,6 @@ CONFIG_FW_LOADER=y
 # Connector - unified userspace <-> kernelspace linker
 #
 # CONFIG_CONNECTOR is not set
-
-#
-# Memory Technology Devices (MTD)
-#
 # CONFIG_MTD is not set
 
 #
@@ -483,18 +507,18 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=131072
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+CONFIG_BLK_DEV_SYSTEMSIM=m
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
 #
 # Misc devices
 #
+# CONFIG_PHANTOM is not set
 # CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
+# CONFIG_BLINK is not set
+# CONFIG_EEPROM_93CX6 is not set
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDE=y
 
@@ -509,6 +533,7 @@ CONFIG_IDEDISK_MULTI_MODE=y
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_BLK_DEV_IDESCSI is not set
 # CONFIG_IDE_TASK_IOCTL is not set
+# CONFIG_IDE_PROC_FS is not set
 
 #
 # IDE chipset support/bugfixes
@@ -516,6 +541,7 @@ CONFIG_IDEDISK_MULTI_MODE=y
 CONFIG_IDE_GENERIC=y
 CONFIG_BLK_DEV_IDEPCI=y
 CONFIG_IDEPCI_SHARE_IRQ=y
+CONFIG_IDEPCI_PCIBUS_ORDER=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
@@ -580,6 +606,7 @@ CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
 
 #
 # SCSI Transports
@@ -626,10 +653,6 @@ CONFIG_SCSI_SAS_ATTRS=y
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_DEBUG is not set
 # CONFIG_SCSI_SRP is not set
-
-#
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
 # CONFIG_SATA_AHCI is not set
@@ -652,6 +675,7 @@ CONFIG_SATA_PROMISE=y
 # CONFIG_PATA_AMD is not set
 # CONFIG_PATA_ARTOP is not set
 # CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD640_PCI is not set
 # CONFIG_PATA_CMD64X is not set
 # CONFIG_PATA_CS5520 is not set
 # CONFIG_PATA_CS5530 is not set
@@ -705,6 +729,7 @@ CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
 CONFIG_DM_MULTIPATH=m
 # CONFIG_DM_MULTIPATH_EMC is not set
+# CONFIG_DM_DELAY is not set
 
 #
 # Fusion MPT device support
@@ -719,58 +744,32 @@ CONFIG_FUSION_MAX_SGE=128
 #
 # IEEE 1394 (FireWire) support
 #
+# CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
 
 #
 # I2O device support
 #
 # CONFIG_I2O is not set
-
-#
-# Macintosh device drivers
-#
-# CONFIG_MAC_EMUMOUSEBTN is not set
-# CONFIG_WINDFARM is not set
-
-#
-# Network device support
-#
+# CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 CONFIG_BONDING=m
 # CONFIG_EQUALIZER is not set
 CONFIG_TUN=y
-
-#
-# ARCnet devices
-#
 # CONFIG_ARCNET is not set
-
-#
-# PHY device support
-#
 # CONFIG_PHYLIB is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
 # CONFIG_NET_VENDOR_3COM is not set
-
-#
-# Tulip family network device support
-#
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+CONFIG_SYSTEMSIM_NET=m
 # CONFIG_NET_PCI is not set
-
-#
-# Ethernet (1000 Mbit)
-#
+CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
 CONFIG_E1000=m
@@ -784,36 +783,43 @@ CONFIG_E1000_NAPI=y
 CONFIG_SKGE=m
 CONFIG_SKY2=m
 # CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
 CONFIG_TIGON3=y
 # CONFIG_BNX2 is not set
 CONFIG_SPIDER_NET=y
+CONFIG_GELIC_NET=m
+CONFIG_GELIC_WIRELESS=y
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
-
-#
-# Ethernet (10000 Mbit)
-#
-# CONFIG_CHELSIO_T1 is not set
-# CONFIG_CHELSIO_T3 is not set
-# CONFIG_IXGB is not set
-# CONFIG_S2IO is not set
-# CONFIG_MYRI10GE is not set
-# CONFIG_NETXEN_NIC is not set
-# CONFIG_PASEMI_MAC is not set
-
-#
-# Token Ring devices
-#
+# CONFIG_NETDEV_10000 is not set
+CONFIG_MLX4_CORE=m
 # CONFIG_TR is not set
 
 #
-# Wireless LAN (non-hamradio)
+# Wireless LAN
 #
-# CONFIG_NET_RADIO is not set
+# CONFIG_WLAN_PRE80211 is not set
+CONFIG_WLAN_80211=y
+# CONFIG_IPW2100 is not set
+# CONFIG_IPW2200 is not set
+# CONFIG_LIBERTAS is not set
+# CONFIG_AIRO is not set
+# CONFIG_HERMES is not set
+# CONFIG_ATMEL is not set
+# CONFIG_PRISM54 is not set
+# CONFIG_USB_ZD1201 is not set
+# CONFIG_RTL8187 is not set
+# CONFIG_HOSTAP is not set
 
 #
-# Wan interfaces
+# USB Network Adapters
 #
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
+# CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
@@ -840,6 +846,7 @@ CONFIG_SPIDER_NET=y
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -859,6 +866,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
@@ -921,6 +929,8 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_HVC_DRIVER=y
+# CONFIG_HVC_FSS is not set
+# CONFIG_PPC_EARLY_DEBUG_FSS is not set
 CONFIG_HVC_RTAS=y
 CONFIG_HVC_BEAT=y
 
@@ -933,10 +943,6 @@ CONFIG_IPMI_DEVICE_INTERFACE=m
 CONFIG_IPMI_SI=m
 CONFIG_IPMI_WATCHDOG=m
 CONFIG_IPMI_POWEROFF=m
-
-#
-# Watchdog Cards
-#
 CONFIG_WATCHDOG=y
 # CONFIG_WATCHDOG_NOWAYOUT is not set
 
@@ -959,7 +965,6 @@ CONFIG_WATCHDOG=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_AGP is not set
@@ -971,11 +976,9 @@ CONFIG_GEN_RTC=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
+CONFIG_DEVPORT=y
 CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
 # CONFIG_I2C_CHARDEV is not set
 
 #
@@ -999,17 +1002,17 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
-# CONFIG_I2C_PASEMI is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_I2C_SIMTEC is not set
 # CONFIG_I2C_SIS5595 is not set
 # CONFIG_I2C_SIS630 is not set
 # CONFIG_I2C_SIS96X is not set
 # CONFIG_I2C_STUB is not set
+# CONFIG_I2C_TINY_USB is not set
 # CONFIG_I2C_VIA is not set
 # CONFIG_I2C_VIAPRO is not set
 # CONFIG_I2C_VOODOO3 is not set
-# CONFIG_I2C_PCA_ISA is not set
 
 #
 # Miscellaneous I2C Chip support
@@ -1036,12 +1039,7 @@ CONFIG_I2C_ALGOBIT=y
 # Dallas's 1-wire bus
 #
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
 # CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
 
 #
 # Multifunction device drivers
@@ -1052,17 +1050,19 @@ CONFIG_I2C_ALGOBIT=y
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_DAB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Graphics support
 #
-# CONFIG_DVB is not set
-# CONFIG_USB_DABUSB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Graphics support
+# Display device support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
 
@@ -1084,6 +1084,17 @@ CONFIG_HID=m
 # CONFIG_HID_DEBUG is not set
 
 #
+# USB Input Devices
+#
+# CONFIG_USB_HID is not set
+
+#
+# USB HID Boot Protocol drivers
+#
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -1096,6 +1107,7 @@ CONFIG_USB=m
 # Miscellaneous USB options
 #
 CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_DEVICE_CLASS is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
 # CONFIG_USB_OTG is not set
 
@@ -1147,44 +1159,10 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_LIBUSUAL is not set
 
 #
-# USB Input Devices
-#
-# CONFIG_USB_HID is not set
-
-#
-# USB HID Boot Protocol drivers
-#
-# CONFIG_USB_KBD is not set
-# CONFIG_USB_MOUSE is not set
-# CONFIG_USB_AIPTEK is not set
-# CONFIG_USB_WACOM is not set
-# CONFIG_USB_ACECAD is not set
-# CONFIG_USB_KBTAB is not set
-# CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_TOUCHSCREEN is not set
-# CONFIG_USB_YEALINK is not set
-# CONFIG_USB_XPAD is not set
-# CONFIG_USB_ATI_REMOTE is not set
-# CONFIG_USB_ATI_REMOTE2 is not set
-# CONFIG_USB_KEYSPAN_REMOTE is not set
-# CONFIG_USB_APPLETOUCH is not set
-# CONFIG_USB_GTCO is not set
-
-#
 # USB Imaging devices
 #
 # CONFIG_USB_MDC800 is not set
 # CONFIG_USB_MICROTEK is not set
-
-#
-# USB Network Adapters
-#
-# CONFIG_USB_CATC is not set
-# CONFIG_USB_KAWETH is not set
-# CONFIG_USB_PEGASUS is not set
-# CONFIG_USB_RTL8150 is not set
-# CONFIG_USB_USBNET_MII is not set
-# CONFIG_USB_USBNET is not set
 CONFIG_USB_MON=y
 
 #
@@ -1228,10 +1206,6 @@ CONFIG_USB_MON=y
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
-
-#
-# MMC/SD Card support
-#
 # CONFIG_MMC is not set
 
 #
@@ -1253,10 +1227,13 @@ CONFIG_USB_MON=y
 CONFIG_INFINIBAND=m
 CONFIG_INFINIBAND_USER_MAD=m
 CONFIG_INFINIBAND_USER_ACCESS=m
+CONFIG_INFINIBAND_USER_MEM=y
 CONFIG_INFINIBAND_ADDR_TRANS=y
 CONFIG_INFINIBAND_MTHCA=m
 CONFIG_INFINIBAND_MTHCA_DEBUG=y
+# CONFIG_INFINIBAND_IPATH is not set
 # CONFIG_INFINIBAND_AMSO1100 is not set
+CONFIG_MLX4_INFINIBAND=m
 CONFIG_INFINIBAND_IPOIB=m
 # CONFIG_INFINIBAND_IPOIB_CM is not set
 CONFIG_INFINIBAND_IPOIB_DEBUG=y
@@ -1287,14 +1264,6 @@ CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=y
 #
 
 #
-# Auxiliary Display support
-#
-
-#
-# Virtualization
-#
-
-#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -1389,6 +1358,7 @@ CONFIG_LOCKD_V4=y
 CONFIG_NFS_ACL_SUPPORT=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -1418,6 +1388,7 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_SUN_PARTITION is not set
 # CONFIG_KARMA_PARTITION is not set
 CONFIG_EFI_PARTITION=y
+# CONFIG_SYSV68_PARTITION is not set
 
 #
 # Native Language Support
@@ -1468,7 +1439,6 @@ CONFIG_NLS_ISO8859_15=m
 #
 # CONFIG_DLM is not set
 # CONFIG_UCC_SLOW is not set
-# CONFIG_UCC_FAST is not set
 
 #
 # Library routines
@@ -1476,6 +1446,7 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=m
@@ -1487,6 +1458,7 @@ CONFIG_TEXTSEARCH_FSM=m
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
 
 #
 # Instrumentation Support
@@ -1507,7 +1479,6 @@ CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
-CONFIG_LOG_BUF_SHIFT=15
 # CONFIG_DETECT_SOFTLOCKUP is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
@@ -1548,6 +1519,7 @@ CONFIG_IRQSTACKS=y
 #
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ABLKCIPHER=m
 CONFIG_CRYPTO_BLKCIPHER=m
 CONFIG_CRYPTO_HASH=y
 CONFIG_CRYPTO_MANAGER=y
@@ -1566,16 +1538,17 @@ CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
+CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_DES=m
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
 CONFIG_CRYPTO_DEFLATE=m

--
