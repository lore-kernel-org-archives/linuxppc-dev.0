Date: Tue, 25 May 2004 02:28:10 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH 3/7] update apus_defconfig
Message-ID: <Pine.LNX.4.58.0405250228020.19024@scrub.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Make the apus_defconfig a bit more uptodate.

Index: 2.6/arch/ppc/configs/apus_defconfig
diff -u 2.6/arch/ppc/configs/apus_defconfig:1.1.1.1 2.6/arch/ppc/configs/apus_defconfig:1.6
--- 2.6/arch/ppc/configs/apus_defconfig:1.1.1.1	Sat Jan 31 15:23:59 2004
+++ 2.6/arch/ppc/configs/apus_defconfig	Mon May 24 14:36:42 2004
@@ -4,54 +4,70 @@
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y

 #
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_STANDALONE=y
+CONFIG_BROKEN_ON_SMP=y

 #
 # General setup
 #
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_POSIX_MQUEUE=y
+CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
+# CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
+CONFIG_KALLSYMS=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

 #
 # Loadable module support
 #
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
 CONFIG_KMOD=y

 #
-# Platform support
+# Processor
 #
-CONFIG_PPC=y
-CONFIG_PPC32=y
 CONFIG_6xx=y
 # CONFIG_40x is not set
+# CONFIG_44x is not set
 # CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
 # CONFIG_8xx is not set
+# CONFIG_ALTIVEC is not set
+# CONFIG_TAU is not set
+# CONFIG_CPU_FREQ is not set
+CONFIG_PPC_STD_MMU=y

 #
-# IBM 4xx options
+# Platform options
 #
-# CONFIG_8260 is not set
-CONFIG_GENERIC_ISA_DMA=y
-CONFIG_PPC_STD_MMU=y
-CONFIG_SERIAL_CONSOLE=y
 # CONFIG_PPC_MULTIPLATFORM is not set
 CONFIG_APUS=y
-# CONFIG_WILLOW_2 is not set
+# CONFIG_WILLOW is not set
 # CONFIG_PCORE is not set
 # CONFIG_POWERPMC250 is not set
 # CONFIG_EV64260 is not set
@@ -67,37 +83,17 @@
 # CONFIG_K2 is not set
 # CONFIG_PAL4 is not set
 # CONFIG_GEMINI is not set
+# CONFIG_EST8260 is not set
+# CONFIG_SBS8260 is not set
+# CONFIG_RPX6 is not set
+# CONFIG_TQM8260 is not set
+CONFIG_SERIAL_CONSOLE=y
 # CONFIG_SMP is not set
 # CONFIG_PREEMPT is not set
-# CONFIG_ALTIVEC is not set
-# CONFIG_TAU is not set
-# CONFIG_CPU_FREQ is not set
-
-#
-# General setup
-#
 # CONFIG_HIGHMEM is not set
-CONFIG_PCI=y
-CONFIG_PCI_DOMAINS=y
-CONFIG_PCI_PERMEDIA=y
-CONFIG_KCORE_ELF=y
-CONFIG_BINFMT_ELF=y
 CONFIG_KERNEL_ELF=y
+CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=m
-CONFIG_PCI_LEGACY_PROC=y
-CONFIG_PCI_NAMES=y
-# CONFIG_HOTPLUG is not set
-
-#
-# Parallel port support
-#
-CONFIG_PARPORT=m
-# CONFIG_PARPORT_PC is not set
-CONFIG_PARPORT_AMIGA=m
-# CONFIG_PARPORT_MFC3 is not set
-# CONFIG_PARPORT_OTHER is not set
-# CONFIG_PARPORT_1284 is not set
-CONFIG_PPC601_SYNC_FIX=y
 # CONFIG_CMDLINE_BOOL is not set
 CONFIG_AMIGA=y
 CONFIG_ZORRO=y
@@ -105,18 +101,28 @@
 CONFIG_APUS_FAST_EXCEPT=y
 CONFIG_AMIGA_PCMCIA=y
 CONFIG_AMIGA_BUILTIN_SERIAL=y
-CONFIG_GVPIOEXT=y
+CONFIG_GVPIOEXT=m
 CONFIG_GVPIOEXT_LP=m
 CONFIG_GVPIOEXT_PLIP=m
-CONFIG_MULTIFACE_III_TTY=y
-CONFIG_A2232=y
-CONFIG_WHIPPET_SERIAL=y
+CONFIG_MULTIFACE_III_TTY=m
+CONFIG_A2232=m
+CONFIG_WHIPPET_SERIAL=m
 CONFIG_APNE=y
 CONFIG_HEARTBEAT=y
 CONFIG_PROC_HARDWARE=y
 CONFIG_ZORRO_NAMES=y

 #
+# Bus options
+#
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_PERMEDIA=y
+CONFIG_PCI_LEGACY_PROC=y
+CONFIG_PCI_NAMES=y
+
+#
 # Advanced setup
 #
 # CONFIG_ADVANCED_OPTIONS is not set
@@ -131,14 +137,32 @@
 CONFIG_BOOT_LOAD=0x00800000

 #
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+# CONFIG_DEBUG_DRIVER is not set
+
+#
 # Memory Technology Devices (MTD)
 #
 # CONFIG_MTD is not set

 #
+# Parallel port support
+#
+CONFIG_PARPORT=m
+# CONFIG_PARPORT_PC is not set
+CONFIG_PARPORT_AMIGA=m
+# CONFIG_PARPORT_MFC3 is not set
+# CONFIG_PARPORT_OTHER is not set
+# CONFIG_PARPORT_1284 is not set
+
+#
 # Plug and Play support
 #
-# CONFIG_PNP is not set

 #
 # Block devices
@@ -152,57 +176,49 @@
 # CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_UMEM is not set
 CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=m
-CONFIG_BLK_DEV_RAM=y
+# CONFIG_BLK_DEV_CARMEL is not set
+CONFIG_BLK_DEV_RAM=m
 CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_BLK_DEV_INITRD=y
-
-#
-# Multi-device support (RAID and LVM)
-#
-CONFIG_MD=y
-CONFIG_BLK_DEV_MD=m
-CONFIG_MD_LINEAR=m
-CONFIG_MD_RAID0=m
-CONFIG_MD_RAID1=m
-CONFIG_MD_RAID5=m
-# CONFIG_MD_MULTIPATH is not set
-CONFIG_BLK_DEV_DM=m
+# CONFIG_LBD is not set

 #
-# ATA/IDE/MFM/RLL support
+# ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
-
-#
-# IDE, ATA and ATAPI Block devices
-#
 CONFIG_BLK_DEV_IDE=y

 #
 # Please see Documentation/ide.txt for help/info on IDE drives
 #
-# CONFIG_BLK_DEV_HD is not set
 CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_IDEDISK_MULTI_MODE is not set
 # CONFIG_IDEDISK_STROKE is not set
 CONFIG_BLK_DEV_IDECD=y
+# CONFIG_BLK_DEV_IDETAPE is not set
 CONFIG_BLK_DEV_IDEFLOPPY=y
 CONFIG_BLK_DEV_IDESCSI=m
 # CONFIG_IDE_TASK_IOCTL is not set
+# CONFIG_IDE_TASKFILE_IO is not set

 #
 # IDE chipset support/bugfixes
 #
+CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEPCI is not set
 CONFIG_BLK_DEV_GAYLE=y
 CONFIG_BLK_DEV_IDEDOUBLER=y
 CONFIG_BLK_DEV_BUDDHA=y
+# CONFIG_BLK_DEV_IDEDMA is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set

 #
-# SCSI support
+# SCSI device support
 #
 CONFIG_SCSI=y
+CONFIG_SCSI_PROC_FS=y

 #
 # SCSI support type (disk, tape, CD-ROM)
@@ -223,6 +239,12 @@
 CONFIG_SCSI_LOGGING=y

 #
+# SCSI Transport Attributes
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+
+#
 # SCSI low-level drivers
 #
 # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
@@ -231,11 +253,9 @@
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
-# CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
-# CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
+# CONFIG_SCSI_SATA is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
 # CONFIG_SCSI_DMX3191D is not set
@@ -243,28 +263,26 @@
 # CONFIG_SCSI_EATA_PIO is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_GDTH is not set
-# CONFIG_SCSI_GENERIC_NCR5380 is not set
-# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
-# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_IPS is not set
 # CONFIG_SCSI_INIA100 is not set
 # CONFIG_SCSI_PPA is not set
 # CONFIG_SCSI_IMM is not set
-# CONFIG_SCSI_NCR53C7xx is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
-# CONFIG_SCSI_NCR53C8XX is not set
-# CONFIG_SCSI_SYM53C8XX is not set
-# CONFIG_SCSI_PCI2000 is not set
-# CONFIG_SCSI_PCI2220I is not set
 # CONFIG_SCSI_QLOGIC_ISP is not set
 # CONFIG_SCSI_QLOGIC_FC is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
+CONFIG_SCSI_QLA2XXX=y
+# CONFIG_SCSI_QLA21XX is not set
+# CONFIG_SCSI_QLA22XX is not set
+# CONFIG_SCSI_QLA2300 is not set
+# CONFIG_SCSI_QLA2322 is not set
+# CONFIG_SCSI_QLA6312 is not set
+# CONFIG_SCSI_QLA6322 is not set
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
-# CONFIG_SCSI_U14_34F is not set
 # CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_A3000_SCSI=y
-CONFIG_A4000T_SCSI=y
 CONFIG_A2091_SCSI=y
 CONFIG_GVP11_SCSI=y
 CONFIG_CYBERSTORM_SCSI=y
@@ -272,18 +290,29 @@
 CONFIG_BLZ2060_SCSI=y
 CONFIG_BLZ1230_SCSI=y
 CONFIG_FASTLANE_SCSI=y
-CONFIG_A4091_SCSI=y
-CONFIG_WARPENGINE_SCSI=y
-CONFIG_BLZ603EPLUS_SCSI=y
 CONFIG_OKTAGON_SCSI=y

 #
+# Multi-device support (RAID and LVM)
+#
+CONFIG_MD=y
+CONFIG_BLK_DEV_MD=m
+CONFIG_MD_LINEAR=m
+CONFIG_MD_RAID0=m
+CONFIG_MD_RAID1=m
+CONFIG_MD_RAID5=m
+# CONFIG_MD_RAID6 is not set
+# CONFIG_MD_MULTIPATH is not set
+CONFIG_BLK_DEV_DM=m
+# CONFIG_DM_CRYPT is not set
+
+#
 # Fusion MPT device support
 #
 # CONFIG_FUSION is not set

 #
-# IEEE 1394 (FireWire) support (EXPERIMENTAL)
+# IEEE 1394 (FireWire) support
 #
 # CONFIG_IEEE1394 is not set

@@ -293,6 +322,10 @@
 # CONFIG_I2O is not set

 #
+# Macintosh device drivers
+#
+
+#
 # Networking support
 #
 CONFIG_NET=y
@@ -300,11 +333,9 @@
 #
 # Networking options
 #
-CONFIG_PACKET=m
+CONFIG_PACKET=y
 CONFIG_PACKET_MMAP=y
 CONFIG_NETLINK_DEV=m
-CONFIG_NETFILTER=y
-# CONFIG_NETFILTER_DEBUG is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -314,13 +345,20 @@
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set

 #
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+# CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
 # IP: Netfilter Configuration
 #
 CONFIG_IP_NF_CONNTRACK=m
@@ -331,11 +369,13 @@
 CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_LIMIT=m
+# CONFIG_IP_NF_MATCH_IPRANGE is not set
 CONFIG_IP_NF_MATCH_MAC=m
 # CONFIG_IP_NF_MATCH_PKTTYPE is not set
 CONFIG_IP_NF_MATCH_MARK=m
 CONFIG_IP_NF_MATCH_MULTIPORT=m
 CONFIG_IP_NF_MATCH_TOS=m
+# CONFIG_IP_NF_MATCH_RECENT is not set
 # CONFIG_IP_NF_MATCH_ECN is not set
 # CONFIG_IP_NF_MATCH_DSCP is not set
 # CONFIG_IP_NF_MATCH_AH_ESP is not set
@@ -345,15 +385,15 @@
 CONFIG_IP_NF_MATCH_HELPER=m
 CONFIG_IP_NF_MATCH_STATE=m
 CONFIG_IP_NF_MATCH_CONNTRACK=m
-CONFIG_IP_NF_MATCH_UNCLEAN=m
 CONFIG_IP_NF_MATCH_OWNER=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_MIRROR=m
 CONFIG_IP_NF_NAT=m
 CONFIG_IP_NF_NAT_NEEDED=y
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
+# CONFIG_IP_NF_TARGET_NETMAP is not set
+# CONFIG_IP_NF_TARGET_SAME is not set
 # CONFIG_IP_NF_NAT_LOCAL is not set
 CONFIG_IP_NF_NAT_SNMP_BASIC=m
 CONFIG_IP_NF_NAT_IRC=m
@@ -365,26 +405,28 @@
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_DSCP=m
 CONFIG_IP_NF_TARGET_MARK=m
+# CONFIG_IP_NF_TARGET_CLASSIFY is not set
 CONFIG_IP_NF_TARGET_LOG=m
 CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_IP_NF_TARGET_TCPMSS=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
+# CONFIG_IP_NF_ARP_MANGLE is not set
 CONFIG_IP_NF_COMPAT_IPCHAINS=m
 # CONFIG_IP_NF_COMPAT_IPFWADM is not set
-# CONFIG_IPV6 is not set
-# CONFIG_XFRM_USER is not set
+# CONFIG_IP_NF_RAW is not set

 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
-# CONFIG_LLC is not set
 # CONFIG_DECNET is not set
-# CONFIG_BRIDGE is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
 # CONFIG_NET_DIVERT is not set
@@ -402,12 +444,12 @@
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
 CONFIG_NETDEVICES=y
-
-#
-# ARCnet devices
-#
-# CONFIG_ARCNET is not set
 CONFIG_DUMMY=m
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
@@ -415,15 +457,20 @@
 # CONFIG_ETHERTAP is not set

 #
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
 # CONFIG_MII is not set
 # CONFIG_OAKNET is not set
 CONFIG_ARIADNE=y
-# CONFIG_ZORRO8390 is not set
 CONFIG_A2065=y
 CONFIG_HYDRA=y
+CONFIG_ZORRO8390=y
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_NET_VENDOR_3COM is not set
@@ -452,6 +499,22 @@
 # Ethernet (10000 Mbit)
 #
 # CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 CONFIG_PLIP=m
@@ -467,96 +530,30 @@
 CONFIG_SLIP_COMPRESSED=y
 CONFIG_SLIP_SMART=y
 CONFIG_SLIP_MODE_SLIP6=y
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# Token Ring devices (depends on LLC=y)
-#
 # CONFIG_NET_FC is not set
 # CONFIG_RCPCI is not set
 # CONFIG_SHAPER is not set
-
-#
-# Wan interfaces
-#
-# CONFIG_WAN is not set
-
-#
-# Amateur Radio support
-#
-# CONFIG_HAMRADIO is not set
-
-#
-# IrDA (infrared) support
-#
-# CONFIG_IRDA is not set
+# CONFIG_NETCONSOLE is not set

 #
 # ISDN subsystem
 #
-# CONFIG_ISDN_BOOL is not set
+# CONFIG_ISDN is not set

 #
-# Graphics support
+# Telephony Support
 #
-CONFIG_FB=y
-# CONFIG_FB_CIRRUS is not set
-CONFIG_FB_PM2=y
-# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
-# CONFIG_FB_PM2_PCI is not set
-CONFIG_FB_PM2_CVPPC=y
-CONFIG_FB_CYBER2000=y
-CONFIG_FB_AMIGA=y
-CONFIG_FB_AMIGA_OCS=y
-CONFIG_FB_AMIGA_ECS=y
-CONFIG_FB_AMIGA_AGA=y
-CONFIG_FB_CYBER=y
-CONFIG_FB_VIRGE=y
-CONFIG_FB_RETINAZ3=y
-CONFIG_FB_FM2=y
-# CONFIG_FB_CT65550 is not set
-# CONFIG_FB_IMSTT is not set
-# CONFIG_FB_S3TRIO is not set
-# CONFIG_FB_VGA16 is not set
-# CONFIG_FB_RIVA is not set
-# CONFIG_FB_MATROX is not set
-# CONFIG_FB_RADEON is not set
-# CONFIG_FB_ATY128 is not set
-# CONFIG_FB_ATY is not set
-# CONFIG_FB_SIS is not set
-# CONFIG_FB_NEOMAGIC is not set
-# CONFIG_FB_3DFX is not set
-# CONFIG_FB_VOODOO1 is not set
-# CONFIG_FB_TRIDENT is not set
-# CONFIG_FB_PM3 is not set
-# CONFIG_FB_VIRTUAL is not set
-
-#
-# Logo configuration
-#
-CONFIG_LOGO=y
-CONFIG_LOGO_LINUX_MONO=y
-CONFIG_LOGO_LINUX_VGA16=y
-CONFIG_LOGO_LINUX_CLUT224=y
-
-#
-# Old CD-ROM drivers (not SCSI, not IDE)
-#
-# CONFIG_CD_NO_IDESCSI is not set
+# CONFIG_PHONE is not set

 #
 # Input device support
 #
-CONFIG_INPUT=m
+CONFIG_INPUT=y

 #
 # Userland interfaces
 #
-CONFIG_INPUT_MOUSEDEV=m
+CONFIG_INPUT_MOUSEDEV=y
 CONFIG_INPUT_MOUSEDEV_PSAUX=y
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
@@ -570,25 +567,24 @@
 #
 # CONFIG_GAMEPORT is not set
 CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
+# CONFIG_SERIO is not set
 # CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_CT82C710 is not set
-# CONFIG_SERIO_PARKBD is not set

 #
 # Input Device Drivers
 #
 CONFIG_INPUT_KEYBOARD=y
-CONFIG_KEYBOARD_ATKBD=m
+# CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
-CONFIG_KEYBOARD_AMIGA=m
+CONFIG_KEYBOARD_AMIGA=y
 CONFIG_INPUT_MOUSE=y
-CONFIG_MOUSE_PS2=m
-CONFIG_MOUSE_SERIAL=m
+# CONFIG_MOUSE_PS2 is not set
+# CONFIG_MOUSE_SERIAL is not set
 CONFIG_MOUSE_AMIGA=m
+# CONFIG_MOUSE_VSXXXAA is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 CONFIG_INPUT_MISC=y
@@ -596,12 +592,11 @@
 CONFIG_INPUT_UINPUT=m

 #
-# Macintosh device drivers
-#
-
-#
 # Character devices
 #
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
 # CONFIG_SERIAL_NONSTANDARD is not set

 #
@@ -613,30 +608,12 @@
 # Non-8250 serial port support
 #
 CONFIG_UNIX98_PTYS=y
-CONFIG_UNIX98_PTY_COUNT=256
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
 CONFIG_PRINTER=m
 # CONFIG_LP_CONSOLE is not set
 # CONFIG_PPDEV is not set
 # CONFIG_TIPAR is not set
-
-#
-# I2C support
-#
-# CONFIG_I2C is not set
-
-#
-# I2C Hardware Sensors Mainboard support
-#
-
-#
-# I2C Hardware Sensors Chip support
-#
-# CONFIG_I2C_SENSOR is not set
-
-#
-# Mice
-#
-CONFIG_BUSMOUSE=y
 # CONFIG_QIC02_TAPE is not set

 #
@@ -662,7 +639,15 @@
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
-# CONFIG_HANGCHECK_TIMER is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Misc devices
+#

 #
 # Multimedia devices
@@ -675,6 +660,127 @@
 # CONFIG_DVB is not set

 #
+# Graphics support
+#
+CONFIG_FB=y
+# CONFIG_FB_PM2 is not set
+CONFIG_FB_CYBER2000=y
+CONFIG_FB_AMIGA=y
+CONFIG_FB_AMIGA_OCS=y
+CONFIG_FB_AMIGA_ECS=y
+CONFIG_FB_AMIGA_AGA=y
+CONFIG_FB_FM2=y
+# CONFIG_FB_CT65550 is not set
+# CONFIG_FB_IMSTT is not set
+# CONFIG_FB_S3TRIO is not set
+# CONFIG_FB_VGA16 is not set
+# CONFIG_FB_RIVA is not set
+# CONFIG_FB_MATROX is not set
+# CONFIG_FB_RADEON_OLD is not set
+# CONFIG_FB_RADEON is not set
+# CONFIG_FB_ATY128 is not set
+# CONFIG_FB_ATY is not set
+# CONFIG_FB_SIS is not set
+# CONFIG_FB_NEOMAGIC is not set
+# CONFIG_FB_KYRO is not set
+# CONFIG_FB_3DFX is not set
+# CONFIG_FB_VOODOO1 is not set
+# CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_VIRTUAL is not set
+
+#
+# Console display driver support
+#
+CONFIG_VGA_CONSOLE=y
+# CONFIG_MDA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE is not set
+
+#
+# Logo configuration
+#
+CONFIG_LOGO=y
+CONFIG_LOGO_LINUX_MONO=y
+CONFIG_LOGO_LINUX_VGA16=y
+CONFIG_LOGO_LINUX_CLUT224=y
+
+#
+# Sound
+#
+CONFIG_SOUND=y
+CONFIG_DMASOUND_PAULA=m
+CONFIG_DMASOUND=m
+
+#
+# Advanced Linux Sound Architecture
+#
+# CONFIG_SND is not set
+
+#
+# Open Sound System
+#
+CONFIG_SOUND_PRIME=m
+# CONFIG_SOUND_BT878 is not set
+# CONFIG_SOUND_CMPCI is not set
+# CONFIG_SOUND_EMU10K1 is not set
+# CONFIG_SOUND_FUSION is not set
+# CONFIG_SOUND_CS4281 is not set
+# CONFIG_SOUND_ES1370 is not set
+# CONFIG_SOUND_ES1371 is not set
+# CONFIG_SOUND_ESSSOLO1 is not set
+# CONFIG_SOUND_MAESTRO is not set
+# CONFIG_SOUND_MAESTRO3 is not set
+# CONFIG_SOUND_ICH is not set
+# CONFIG_SOUND_SONICVIBES is not set
+# CONFIG_SOUND_TRIDENT is not set
+# CONFIG_SOUND_MSNDCLAS is not set
+# CONFIG_SOUND_MSNDPIN is not set
+# CONFIG_SOUND_VIA82CXXX is not set
+CONFIG_SOUND_OSS=m
+CONFIG_SOUND_TRACEINIT=y
+# CONFIG_SOUND_DMAP is not set
+# CONFIG_SOUND_AD1816 is not set
+# CONFIG_SOUND_AD1889 is not set
+# CONFIG_SOUND_SGALAXY is not set
+# CONFIG_SOUND_ADLIB is not set
+# CONFIG_SOUND_ACI_MIXER is not set
+# CONFIG_SOUND_CS4232 is not set
+# CONFIG_SOUND_SSCAPE is not set
+# CONFIG_SOUND_GUS is not set
+CONFIG_SOUND_VMIDI=m
+# CONFIG_SOUND_TRIX is not set
+# CONFIG_SOUND_MSS is not set
+# CONFIG_SOUND_MPU401 is not set
+# CONFIG_SOUND_NM256 is not set
+# CONFIG_SOUND_MAD16 is not set
+# CONFIG_SOUND_PAS is not set
+# CONFIG_SOUND_PSS is not set
+# CONFIG_SOUND_SB is not set
+# CONFIG_SOUND_AWE32_SYNTH is not set
+# CONFIG_SOUND_WAVEFRONT is not set
+# CONFIG_SOUND_MAUI is not set
+# CONFIG_SOUND_YM3812 is not set
+# CONFIG_SOUND_OPL3SA1 is not set
+# CONFIG_SOUND_OPL3SA2 is not set
+# CONFIG_SOUND_YMFPCI is not set
+# CONFIG_SOUND_UART6850 is not set
+# CONFIG_SOUND_AEDSP16 is not set
+# CONFIG_SOUND_ALI5455 is not set
+# CONFIG_SOUND_FORTE is not set
+# CONFIG_SOUND_RME96XX is not set
+# CONFIG_SOUND_AD1980 is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -690,7 +796,7 @@
 # CONFIG_JFS_FS is not set
 # CONFIG_XFS_FS is not set
 CONFIG_MINIX_FS=y
-CONFIG_ROMFS_FS=y
+CONFIG_ROMFS_FS=m
 # CONFIG_QUOTA is not set
 CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
@@ -715,10 +821,12 @@
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
 # CONFIG_DEVFS_FS is not set
-CONFIG_DEVPTS_FS=y
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y

 #
@@ -727,10 +835,11 @@
 # CONFIG_ADFS_FS is not set
 CONFIG_AFFS_FS=y
 CONFIG_HFS_FS=y
+# CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-CONFIG_CRAMFS=y
+CONFIG_CRAMFS=m
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
@@ -743,6 +852,7 @@
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 # CONFIG_NFSD_V4 is not set
@@ -751,12 +861,13 @@
 CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=m
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_GSS is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
 CONFIG_SMB_FS=m
 # CONFIG_SMB_NLS_DEFAULT is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 CONFIG_CODA_FS=m
+# CONFIG_CODA_FS_OLD_API is not set
 # CONFIG_INTERMEZZO_FS is not set
 # CONFIG_AFS_FS is not set

@@ -780,12 +891,11 @@
 # CONFIG_ULTRIX_PARTITION is not set
 # CONFIG_SUN_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
-CONFIG_SMB_NLS=y
-CONFIG_NLS=y

 #
 # Native Language Support
 #
+CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_737=m
@@ -808,7 +918,7 @@
 CONFIG_NLS_CODEPAGE_949=m
 CONFIG_NLS_CODEPAGE_874=m
 CONFIG_NLS_ISO8859_8=m
-# CONFIG_NLS_CODEPAGE_1250 is not set
+CONFIG_NLS_CODEPAGE_1250=m
 CONFIG_NLS_CODEPAGE_1251=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_ISO8859_2=m
@@ -826,90 +936,25 @@
 CONFIG_NLS_UTF8=m

 #
-# Sound
-#
-CONFIG_SOUND=y
-CONFIG_DMASOUND_PAULA=m
-CONFIG_DMASOUND=m
-
-#
-# Advanced Linux Sound Architecture
-#
-# CONFIG_SND is not set
-
-#
-# Open Sound System
-#
-CONFIG_SOUND_PRIME=m
-# CONFIG_SOUND_BT878 is not set
-# CONFIG_SOUND_CMPCI is not set
-# CONFIG_SOUND_EMU10K1 is not set
-# CONFIG_SOUND_FUSION is not set
-# CONFIG_SOUND_CS4281 is not set
-# CONFIG_SOUND_ES1370 is not set
-# CONFIG_SOUND_ES1371 is not set
-# CONFIG_SOUND_ESSSOLO1 is not set
-# CONFIG_SOUND_MAESTRO is not set
-# CONFIG_SOUND_MAESTRO3 is not set
-# CONFIG_SOUND_ICH is not set
-# CONFIG_SOUND_RME96XX is not set
-# CONFIG_SOUND_SONICVIBES is not set
-# CONFIG_SOUND_TRIDENT is not set
-# CONFIG_SOUND_MSNDCLAS is not set
-# CONFIG_SOUND_MSNDPIN is not set
-# CONFIG_SOUND_VIA82CXXX is not set
-CONFIG_SOUND_OSS=m
-CONFIG_SOUND_TRACEINIT=y
-CONFIG_SOUND_DMAP=y
-# CONFIG_SOUND_AD1816 is not set
-# CONFIG_SOUND_SGALAXY is not set
-# CONFIG_SOUND_ADLIB is not set
-# CONFIG_SOUND_ACI_MIXER is not set
-# CONFIG_SOUND_CS4232 is not set
-# CONFIG_SOUND_SSCAPE is not set
-# CONFIG_SOUND_GUS is not set
-CONFIG_SOUND_VMIDI=m
-# CONFIG_SOUND_TRIX is not set
-# CONFIG_SOUND_MSS is not set
-# CONFIG_SOUND_MPU401 is not set
-# CONFIG_SOUND_NM256 is not set
-# CONFIG_SOUND_MAD16 is not set
-# CONFIG_SOUND_PAS is not set
-# CONFIG_SOUND_PSS is not set
-# CONFIG_SOUND_SB is not set
-# CONFIG_SOUND_AWE32_SYNTH is not set
-# CONFIG_SOUND_WAVEFRONT is not set
-# CONFIG_SOUND_MAUI is not set
-# CONFIG_SOUND_YM3812 is not set
-# CONFIG_SOUND_OPL3SA1 is not set
-# CONFIG_SOUND_OPL3SA2 is not set
-# CONFIG_SOUND_YMFPCI is not set
-# CONFIG_SOUND_UART6850 is not set
-# CONFIG_SOUND_AEDSP16 is not set
-
-#
-# USB support
-#
-# CONFIG_USB is not set
-# CONFIG_USB_GADGET is not set
-
-#
-# Bluetooth support
-#
-# CONFIG_BT is not set
-
-#
 # Library routines
 #
-# CONFIG_CRC32 is not set
+CONFIG_CRC32=y
+CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y

 #
 # Kernel hacking
 #
-# CONFIG_DEBUG_KERNEL is not set
-# CONFIG_KALLSYMS is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SLAB is not set
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_KGDB is not set
+# CONFIG_XMON is not set
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_DEBUG_INFO is not set

 #
 # Security options

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
