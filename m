Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 055F967A8D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 09:29:40 +1100 (EST)
Date: Wed, 26 Jan 2005 15:29:30 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20050126152930.A676@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] STx GP3 port
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Adds support for the STx GP3 board with an MPC8560. Thanks to Dan
Malek for the original 2.4 port. Please apply.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff -Nru a/arch/ppc/configs/stx_gp3_defconfig b/arch/ppc/configs/stx_gp3_defconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/configs/stx_gp3_defconfig	2005-01-26 15:22:39 -07:00
@@ -0,0 +1,972 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.11-rc2
+# Wed Jan 26 14:32:58 2005
+#
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
+# CONFIG_IKCONFIG is not set
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+# CONFIG_MODULE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+CONFIG_MODVERSIONS=y
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Processor
+#
+# CONFIG_6xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+# CONFIG_8xx is not set
+CONFIG_E500=y
+CONFIG_BOOKE=y
+CONFIG_FSL_BOOKE=y
+# CONFIG_SPE is not set
+CONFIG_MATH_EMULATION=y
+# CONFIG_CPU_FREQ is not set
+CONFIG_85xx=y
+CONFIG_PPC_INDIRECT_PCI_BE=y
+
+#
+# Freescale 85xx options
+#
+# CONFIG_MPC8540_ADS is not set
+# CONFIG_MPC8555_CDS is not set
+# CONFIG_MPC8560_ADS is not set
+# CONFIG_SBC8560 is not set
+CONFIG_STX_GP3=y
+CONFIG_MPC8560=y
+
+#
+# Platform options
+#
+CONFIG_CPM2=y
+# CONFIG_PC_KEYBOARD is not set
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT is not set
+CONFIG_HIGHMEM=y
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=m
+# CONFIG_CMDLINE_BOOL is not set
+
+#
+# Bus options
+#
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_PCI_LEGACY_PROC is not set
+# CONFIG_PCI_NAMES is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PC-card bridges
+#
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_BOOT_LOAD=0x00800000
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+CONFIG_PARPORT=m
+CONFIG_PARPORT_PC=m
+# CONFIG_PARPORT_PC_FIFO is not set
+# CONFIG_PARPORT_PC_SUPERIO is not set
+# CONFIG_PARPORT_OTHER is not set
+# CONFIG_PARPORT_1284 is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_PARIDE is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=m
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+CONFIG_BLK_DEV_NBD=m
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=m
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_LBD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+# CONFIG_IDEDISK_MULTI_MODE is not set
+CONFIG_BLK_DEV_IDECD=m
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_BLK_DEV_IDESCSI is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+# CONFIG_BLK_DEV_IDEPCI is not set
+# CONFIG_IDE_ARM is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI=m
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=m
+CONFIG_CHR_DEV_ST=m
+# CONFIG_CHR_DEV_OSST is not set
+CONFIG_BLK_DEV_SR=m
+# CONFIG_BLK_DEV_SR_VENDOR is not set
+CONFIG_CHR_DEV_SG=m
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+CONFIG_SCSI_MULTI_LUN=y
+CONFIG_SCSI_CONSTANTS=y
+# CONFIG_SCSI_LOGGING is not set
+
+#
+# SCSI Transport Attributes
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_EATA_PIO is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_PPA is not set
+# CONFIG_SCSI_IMM is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_QLOGIC_ISP is not set
+# CONFIG_SCSI_QLOGIC_FC is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+CONFIG_SCSI_QLA2XXX=m
+# CONFIG_SCSI_QLA21XX is not set
+# CONFIG_SCSI_QLA22XX is not set
+# CONFIG_SCSI_QLA2300 is not set
+# CONFIG_SCSI_QLA2322 is not set
+# CONFIG_SCSI_QLA6312 is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Macintosh device drivers
+#
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+# CONFIG_NETLINK_DEV is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
+
+#
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+# CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# IP: Netfilter Configuration
+#
+CONFIG_IP_NF_CONNTRACK=m
+# CONFIG_IP_NF_CT_ACCT is not set
+# CONFIG_IP_NF_CONNTRACK_MARK is not set
+# CONFIG_IP_NF_CT_PROTO_SCTP is not set
+CONFIG_IP_NF_FTP=m
+CONFIG_IP_NF_IRC=m
+# CONFIG_IP_NF_TFTP is not set
+# CONFIG_IP_NF_AMANDA is not set
+# CONFIG_IP_NF_QUEUE is not set
+CONFIG_IP_NF_IPTABLES=m
+# CONFIG_IP_NF_MATCH_LIMIT is not set
+# CONFIG_IP_NF_MATCH_IPRANGE is not set
+# CONFIG_IP_NF_MATCH_MAC is not set
+# CONFIG_IP_NF_MATCH_PKTTYPE is not set
+# CONFIG_IP_NF_MATCH_MARK is not set
+# CONFIG_IP_NF_MATCH_MULTIPORT is not set
+# CONFIG_IP_NF_MATCH_TOS is not set
+# CONFIG_IP_NF_MATCH_RECENT is not set
+# CONFIG_IP_NF_MATCH_ECN is not set
+# CONFIG_IP_NF_MATCH_DSCP is not set
+# CONFIG_IP_NF_MATCH_AH_ESP is not set
+# CONFIG_IP_NF_MATCH_LENGTH is not set
+# CONFIG_IP_NF_MATCH_TTL is not set
+# CONFIG_IP_NF_MATCH_TCPMSS is not set
+# CONFIG_IP_NF_MATCH_HELPER is not set
+# CONFIG_IP_NF_MATCH_STATE is not set
+# CONFIG_IP_NF_MATCH_CONNTRACK is not set
+# CONFIG_IP_NF_MATCH_OWNER is not set
+# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
+# CONFIG_IP_NF_MATCH_REALM is not set
+# CONFIG_IP_NF_MATCH_SCTP is not set
+# CONFIG_IP_NF_MATCH_COMMENT is not set
+# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
+CONFIG_IP_NF_FILTER=m
+# CONFIG_IP_NF_TARGET_REJECT is not set
+# CONFIG_IP_NF_TARGET_LOG is not set
+# CONFIG_IP_NF_TARGET_ULOG is not set
+# CONFIG_IP_NF_TARGET_TCPMSS is not set
+CONFIG_IP_NF_NAT=m
+CONFIG_IP_NF_NAT_NEEDED=y
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_TARGET_REDIRECT=m
+# CONFIG_IP_NF_TARGET_NETMAP is not set
+# CONFIG_IP_NF_TARGET_SAME is not set
+CONFIG_IP_NF_NAT_SNMP_BASIC=m
+CONFIG_IP_NF_NAT_IRC=m
+CONFIG_IP_NF_NAT_FTP=m
+# CONFIG_IP_NF_MANGLE is not set
+# CONFIG_IP_NF_RAW is not set
+# CONFIG_IP_NF_ARPTABLES is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+# CONFIG_MII is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_PCI is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+CONFIG_GIANFAR=y
+CONFIG_GFAR_NAPI=y
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_IXGB is not set
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
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PLIP is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
+CONFIG_INPUT_JOYDEV=m
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=m
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PARKBD is not set
+# CONFIG_SERIO_PCIPS2 is not set
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_CPM=y
+CONFIG_SERIAL_CPM_CONSOLE=y
+# CONFIG_SERIAL_CPM_SCC1 is not set
+CONFIG_SERIAL_CPM_SCC2=y
+# CONFIG_SERIAL_CPM_SCC3 is not set
+# CONFIG_SERIAL_CPM_SCC4 is not set
+# CONFIG_SERIAL_CPM_SMC1 is not set
+# CONFIG_SERIAL_CPM_SMC2 is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+CONFIG_PRINTER=m
+# CONFIG_LP_CONSOLE is not set
+# CONFIG_PPDEV is not set
+# CONFIG_TIPAR is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+CONFIG_AGP=m
+CONFIG_DRM=m
+# CONFIG_DRM_TDFX is not set
+# CONFIG_DRM_R128 is not set
+# CONFIG_DRM_RADEON is not set
+# CONFIG_DRM_MGA is not set
+# CONFIG_DRM_SIS is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# I2C support
+#
+CONFIG_I2C=m
+CONFIG_I2C_CHARDEV=m
+
+#
+# I2C Algorithms
+#
+CONFIG_I2C_ALGOBIT=m
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_ISA is not set
+# CONFIG_I2C_MPC is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_PARPORT is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_SCx200_ACB is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_ISA is not set
+
+#
+# Hardware Sensors Chip support
+#
+# CONFIG_I2C_SENSOR is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83627HF is not set
+
+#
+# Other I2C Chip support
+#
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Sound
+#
+CONFIG_SOUND=m
+
+#
+# Advanced Linux Sound Architecture
+#
+# CONFIG_SND is not set
+
+#
+# Open Sound System
+#
+# CONFIG_SOUND_PRIME is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+CONFIG_JBD_DEBUG=y
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+CONFIG_AUTOFS_FS=m
+CONFIG_AUTOFS4_FS=y
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=m
+# CONFIG_JOLIET is not set
+# CONFIG_ZISOFS is not set
+CONFIG_UDF_FS=m
+CONFIG_UDF_NLS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+# CONFIG_PROC_KCORE is not set
+CONFIG_SYSFS=y
+CONFIG_DEVFS_FS=y
+# CONFIG_DEVFS_MOUNT is not set
+# CONFIG_DEVFS_DEBUG is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_CRAMFS=m
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+# CONFIG_EXPORTFS is not set
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+CONFIG_SMB_FS=m
+# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+# CONFIG_SCC_ENET is not set
+# CONFIG_FEC_ENET is not set
+
+#
+# CPM2 Options
+#
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=y
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=m
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_HIGHMEM is not set
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_KGDB_CONSOLE is not set
+# CONFIG_XMON is not set
+CONFIG_BDI_SWITCH=y
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
diff -Nru a/arch/ppc/platforms/85xx/Kconfig b/arch/ppc/platforms/85xx/Kconfig
--- a/arch/ppc/platforms/85xx/Kconfig	2005-01-26 15:22:39 -07:00
+++ b/arch/ppc/platforms/85xx/Kconfig	2005-01-26 15:22:39 -07:00
@@ -37,6 +37,12 @@
 	  This option enables support for the WindRiver PowerQUICC III 
 	  SBC8560 board.
 
+config STX_GP3
+	bool "Silicon Turnkey Express GP3"
+	help
+	  This option enables support for the Silicon Turnkey Express GP3 
+	  board.
+
 endchoice
 
 # It's often necessary to know the specific 85xx processor type.
@@ -54,7 +60,7 @@
 
 config MPC8560
 	bool
-	depends on SBC8560 || MPC8560_ADS
+	depends on SBC8560 || MPC8560_ADS || STX_GP3
 	default y
 
 config 85xx_PCI2
diff -Nru a/arch/ppc/platforms/85xx/Makefile b/arch/ppc/platforms/85xx/Makefile
--- a/arch/ppc/platforms/85xx/Makefile	2005-01-26 15:22:39 -07:00
+++ b/arch/ppc/platforms/85xx/Makefile	2005-01-26 15:22:39 -07:00
@@ -7,3 +7,4 @@
 obj-$(CONFIG_MPC8555_CDS)	+= mpc85xx_cds_common.o
 obj-$(CONFIG_MPC8560_ADS)	+= mpc85xx_ads_common.o mpc8560_ads.o
 obj-$(CONFIG_SBC8560)		+= sbc85xx.o sbc8560.o
+obj-$(CONFIG_STX_GP3)		+= stx_gp3.o
diff -Nru a/arch/ppc/platforms/85xx/stx_gp3.c b/arch/ppc/platforms/85xx/stx_gp3.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/85xx/stx_gp3.c	2005-01-26 15:22:39 -07:00
@@ -0,0 +1,381 @@
+/*
+ * arch/ppc/platforms/85xx/stx_gp3.c
+ * 
+ * STx GP3 board specific routines
+ * 
+ * Dan Malek <dan@embeddededge.com>
+ * Copyright 2004 Embedded Edge, LLC
+ *
+ * Copied from mpc8560_ads.c
+ * Copyright 2002, 2003 Motorola Inc.
+ * 
+ * Ported to 2.6, Matt Porter <mporter@kernel.crashing.org>
+ * Copyright 2004-2005 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/blkdev.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/root_dev.h>
+#include <linux/seq_file.h>
+#include <linux/serial.h>
+#include <linux/module.h>
+#include <linux/fsl_devices.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/atomic.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/open_pic.h>
+#include <asm/bootinfo.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpc85xx.h>
+#include <asm/irq.h>
+#include <asm/immap_85xx.h>
+#include <asm/immap_cpm2.h>
+#include <asm/mpc85xx.h>
+#include <asm/ppc_sys.h>
+
+#include <syslib/cpm2_pic.h>
+#include <syslib/ppc85xx_common.h>
+
+extern void cpm2_reset(void);
+
+unsigned char __res[sizeof(bd_t)];
+
+#ifndef CONFIG_PCI
+unsigned long isa_io_base = 0;
+unsigned long isa_mem_base = 0;
+unsigned long pci_dram_offset = 0;
+#endif
+                                                                                
+/* Internal interrupts are all Level Sensitive, and Positive Polarity */
+static u8 gp3_openpic_initsenses[] __initdata = {
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  0: L2 Cache */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  1: ECM */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  2: DDR DRAM */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  3: LBIU */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  4: DMA 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  5: DMA 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  6: DMA 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  7: DMA 3 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  8: PCI/PCI-X */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  9: RIO Inbound Port Write Error */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 10: RIO Doorbell Inbound */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 11: RIO Outbound Message */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 12: RIO Inbound Message */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 13: TSEC 0 Transmit */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 14: TSEC 0 Receive */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 15: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 16: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 17: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 18: TSEC 0 Receive/Transmit Error */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 19: TSEC 1 Transmit */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 20: TSEC 1 Receive */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 21: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 22: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 23: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 24: TSEC 1 Receive/Transmit Error */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 25: Fast Ethernet */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 26: DUART */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 27: I2C */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 28: Performance Monitor */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 29: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 30: CPM */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 31: Unused */
+	0x0,						/* External  0: */
+#if defined(CONFIG_PCI)
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 1: PCI slot 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 2: PCI slot 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 3: PCI slot 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 4: PCI slot 3 */
+#else
+	0x0,				/* External  1: */
+	0x0,				/* External  2: */
+	0x0,				/* External  3: */
+	0x0,				/* External  4: */
+#endif
+	0x0,				/* External  5: */
+	0x0,				/* External  6: */
+	0x0,				/* External  7: */
+	0x0,				/* External  8: */
+	0x0,				/* External  9: */
+	0x0,				/* External 10: */
+	0x0,				/* External 11: */
+};
+
+/*
+ * Setup the architecture
+ */
+static void __init
+gp3_setup_arch(void)
+{
+	bd_t *binfo = (bd_t *) __res;
+	unsigned int freq;
+	struct gianfar_platform_data *pdata;
+
+	cpm2_reset();
+
+	/* get the core frequency */
+	freq = binfo->bi_intfreq;
+
+	if (ppc_md.progress)
+		ppc_md.progress("gp3_setup_arch()", 0);
+
+	/* Set loops_per_jiffy to a half-way reasonable value,
+	   for use until calibrate_delay gets called. */
+	loops_per_jiffy = freq / HZ;
+
+#ifdef CONFIG_PCI
+	/* setup PCI host bridges */
+	mpc85xx_setup_hose();
+#endif
+
+	/* setup the board related information for the enet controllers */
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
+/*	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR; */
+	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+	pdata->phyid = 2;
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+
+	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
+/*	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR; */
+	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+	pdata->phyid = 4;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef	CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_HDA1;
+#endif
+
+	printk ("bi_immr_base = %8.8lx\n", binfo->bi_immr_base);
+}
+
+static irqreturn_t cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
+{
+	while ((irq = cpm2_get_irq(regs)) >= 0)
+		__do_IRQ(irq, regs);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction cpm2_irqaction = {
+	.handler	= cpm2_cascade,
+	.flags		= SA_INTERRUPT,
+	.mask		= CPU_MASK_NONE,
+	.name		= "cpm2_cascade",
+};
+
+static void __init
+gp3_init_IRQ(void)
+{
+	int i;
+	volatile cpm2_map_t *immap = cpm2_immr;
+	bd_t *binfo = (bd_t *) __res;
+
+	/*
+	 * Setup OpenPIC
+	 */
+
+	/* Determine the Physical Address of the OpenPIC regs */
+	phys_addr_t OpenPIC_PAddr =
+	    binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
+	OpenPIC_Addr = ioremap(OpenPIC_PAddr, MPC85xx_OPENPIC_SIZE);
+	OpenPIC_InitSenses = gp3_openpic_initsenses;
+	OpenPIC_NumInitSenses = sizeof (gp3_openpic_initsenses);
+
+	/* Skip reserved space and internal sources */
+	openpic_set_sources(0, 32, OpenPIC_Addr + 0x10200);
+
+	/* Map PIC IRQs 0-11 */
+	openpic_set_sources(32, 12, OpenPIC_Addr + 0x10000);
+
+	/*
+	 * Let openpic interrupts starting from an offset, to
+	 * leave space for cascading interrupts underneath.
+	 */
+	openpic_init(MPC85xx_OPENPIC_IRQ_OFFSET);
+
+	/*
+	 * Setup CPM2 PIC
+	 */
+
+	/* disable all CPM interupts */
+	immap->im_intctl.ic_simrh = 0x0;
+	immap->im_intctl.ic_simrl = 0x0;
+
+	for (i = CPM_IRQ_OFFSET; i < (NR_CPM_INTS + CPM_IRQ_OFFSET); i++)
+		irq_desc[i].handler = &cpm2_pic;
+
+	/*
+	 * Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	immap->im_intctl.ic_sicr = 0;
+	immap->im_intctl.ic_scprrh = 0x05309770;
+	immap->im_intctl.ic_scprrl = 0x05309770;
+
+	setup_irq(MPC85xx_IRQ_CPM, &cpm2_irqaction);
+
+	return;
+}
+
+static int
+gp3_show_cpuinfo(struct seq_file *m)
+{
+	uint pvid, svid, phid1;
+	bd_t *binfo = (bd_t *) __res;
+	uint	memsize;
+	unsigned int freq;
+	extern unsigned long total_memory;	/* in mm/init */
+
+	/* get the core frequency */
+	freq = binfo->bi_intfreq;
+
+	pvid = mfspr(PVR);
+	svid = mfspr(SVR);
+
+	memsize = total_memory;
+
+	seq_printf(m, "Vendor\t\t: RPC Electronics STx \n");
+
+	switch (svid & 0xffff0000) {
+	case SVR_8540:
+		seq_printf(m, "Machine\t\t: GP3 - MPC8540\n");
+		break;
+	case SVR_8560:
+		seq_printf(m, "Machine\t\t: GP3 - MPC8560\n");
+		break;
+	default:
+		seq_printf(m, "Machine\t\t: unknown\n");
+		break;
+	}
+	seq_printf(m, "bus freq\t: %u.%.6u MHz\n", freq / 1000000,
+		   freq % 1000000);
+	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+
+	/* Display cpu Pll setting */
+	phid1 = mfspr(HID1);
+	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
+
+	/* Display the amount of memory */
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+
+	return 0;
+}
+
+#ifdef CONFIG_PCI
+int mpc85xx_map_irq(struct pci_dev *dev, unsigned char idsel,
+		    unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	    /*
+	     *      PCI IDSEL/INTPIN->INTLINE
+	     *        A      B      C      D
+	     */
+	{
+		{PIRQA, PIRQB, PIRQC, PIRQD},
+		{PIRQD, PIRQA, PIRQB, PIRQC},
+		{PIRQC, PIRQD, PIRQA, PIRQB},
+		{PIRQB, PIRQC, PIRQD, PIRQA},
+	};
+
+	const long min_idsel = 12, max_idsel = 15, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+}
+
+int mpc85xx_exclude_device(u_char bus, u_char devfn)
+{
+	if (bus == 0 && PCI_SLOT(devfn) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+#endif /* CONFIG_PCI */
+
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	      unsigned long r6, unsigned long r7)
+{
+	/* parse_bootinfo must always be called first */
+	parse_bootinfo(find_bootinfo());
+
+	/*
+	 * If we were passed in a board information, copy it into the
+	 * residual data area.
+	 */
+	if (r3) {
+		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
+		       sizeof (bd_t));
+
+	}
+#if defined(CONFIG_BLK_DEV_INITRD)
+	/*
+	 * If the init RAM disk has been configured in, and there's a valid
+	 * starting address for it, set it up.
+	 */
+	if (r4) {
+		initrd_start = r4 + KERNELBASE;
+		initrd_end = r5 + KERNELBASE;
+	}
+#endif				/* CONFIG_BLK_DEV_INITRD */
+
+	/* Copy the kernel command line arguments to a safe place. */
+
+	if (r6) {
+		*(char *) (r7 + KERNELBASE) = 0;
+		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
+	}
+
+	identify_ppc_sys_by_id(mfspr(SVR));
+
+	/* setup the PowerPC module struct */
+	ppc_md.setup_arch = gp3_setup_arch;
+	ppc_md.show_cpuinfo = gp3_show_cpuinfo;
+
+	ppc_md.init_IRQ = gp3_init_IRQ;
+	ppc_md.get_irq = openpic_get_irq;
+
+	ppc_md.restart = mpc85xx_restart;
+	ppc_md.power_off = mpc85xx_power_off;
+	ppc_md.halt = mpc85xx_halt;
+
+	ppc_md.find_end_of_memory = mpc85xx_find_end_of_memory;
+
+	ppc_md.calibrate_decr = mpc85xx_calibrate_decr;
+
+	if (ppc_md.progress)
+		ppc_md.progress("platform_init(): exit", 0);
+
+	return;
+}
diff -Nru a/arch/ppc/platforms/85xx/stx_gp3.h b/arch/ppc/platforms/85xx/stx_gp3.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/85xx/stx_gp3.h	2005-01-26 15:22:39 -07:00
@@ -0,0 +1,74 @@
+/*
+ * arch/ppc/platforms/stx8560_gp3.h
+ *
+ * STx GP3 board definitions
+ *
+ * Dan Malek (dan@embeddededge.com)
+ * Copyright 2004 Embedded Edge, LLC
+ *
+ * Ported to 2.6, Matt Porter <mporter@kernel.crashing.org>
+ * Copyright 2004-2005 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef __MACH_STX_GP3_H
+#define __MACH_STX_GP3_H
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/seq_file.h>
+#include <asm/ppcboot.h>
+
+#define BOARD_CCSRBAR		((uint)0xe0000000)
+#define CCSRBAR_SIZE		((uint)1024*1024)
+
+#define CPM_MAP_ADDR		(CCSRBAR + MPC85xx_CPM_OFFSET)
+
+#define BCSR_ADDR		((uint)0xfc000000)
+#define BCSR_SIZE		((uint)(16 * 1024))
+
+#define BCSR_TSEC1_RESET	0x00000080
+#define BCSR_TSEC2_RESET	0x00000040
+#define BCSR_LED1		0x00000008
+#define BCSR_LED2		0x00000004
+#define BCSR_LED3		0x00000002
+#define BCSR_LED4		0x00000001
+
+extern void mpc85xx_setup_hose(void) __init;
+extern void mpc85xx_restart(char *cmd);
+extern void mpc85xx_power_off(void);
+extern void mpc85xx_halt(void);
+extern int mpc85xx_show_cpuinfo(struct seq_file *m);
+extern void mpc85xx_init_IRQ(void) __init; 
+extern unsigned long mpc85xx_find_end_of_memory(void) __init;
+extern void mpc85xx_calibrate_decr(void) __init;
+
+#define PCI_CFG_ADDR_OFFSET	(0x8000)
+#define PCI_CFG_DATA_OFFSET	(0x8004)
+
+/* PCI interrupt controller */
+#define PIRQA		MPC85xx_IRQ_EXT1
+#define PIRQB		MPC85xx_IRQ_EXT2
+#define PIRQC		MPC85xx_IRQ_EXT3
+#define PIRQD		MPC85xx_IRQ_EXT4
+#define PCI_MIN_IDSEL	16
+#define PCI_MAX_IDSEL	19
+#define PCI_IRQ_SLOT	4
+
+#define MPC85XX_PCI1_LOWER_IO	0x00000000
+#define MPC85XX_PCI1_UPPER_IO	0x00ffffff
+
+#define MPC85XX_PCI1_LOWER_MEM	0x80000000
+#define MPC85XX_PCI1_UPPER_MEM	0x9fffffff
+
+#define MPC85XX_PCI1_IO_BASE	0xe2000000
+#define MPC85XX_PCI1_MEM_OFFSET	0x00000000
+
+#define MPC85XX_PCI1_IO_SIZE	0x01000000
+
+#endif /* __MACH_STX_GP3_H */
diff -Nru a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
--- a/include/asm-ppc/mpc85xx.h	2005-01-26 15:22:39 -07:00
+++ b/include/asm-ppc/mpc85xx.h	2005-01-26 15:22:39 -07:00
@@ -34,6 +34,9 @@
 #ifdef CONFIG_SBC8560
 #include <platforms/85xx/sbc8560.h>
 #endif
+#ifdef CONFIG_STX_GP3
+#include <platforms/85xx/stx_gp3.h>
+#endif
 
 #define _IO_BASE        isa_io_base
 #define _ISA_MEM_BASE   isa_mem_base
