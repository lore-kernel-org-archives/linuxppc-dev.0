Return-Path: <andros@citi.umich.edu>
Received: from citi.umich.edu (citi.umich.edu [141.211.133.111])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "citi.umich.edu",
	Issuer "Comodo Class 3 Security Services CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2EEE367A46
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Feb 2005 08:04:37 +1100 (EST)
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1107463045_145270"
Date: Thu, 03 Feb 2005 15:38:04 -0500
From: "William A.(Andy) Adamson" <andros@citi.umich.edu>
Message-Id: <20050203203804.CEF201BAA9@citi.umich.edu>
Cc: andros@citi.umich.edu
Subject: 2.6.11-rc2 on powerbook g4 - lost interrupt
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart MIME message.

--==_Exmh_1107463045_145270
Content-Type: text/plain; charset=us-ascii

hello

i'm trying to get 2.6.11-rc2 to run on my powerbook g4, cpuinfo below. i found 
the discussion and patch for the adb-probe hang which i experienced. now i'm 
finding the ide subsystem is loosing interrupt's talking to the harddisk, hda. 
i attached my kernel config. i looked in the email archive and didn't find 
anything relevant. any suggestions would be appreciated. i delevelop NFSv4 on 
linux, and need the latest kernels....

thanks

-->Andy Adamson

cat /proc/cpuinfo:

cpu             : 7457, altivec supported
clock           : 1249MHz
revision        : 1.1 (pvr 8002 0101)
bogomips        : 763.49
machine         : PowerBook5,2
motherboard     : PowerBook5,2 MacRISC3 Power Macintosh
board revision  : 00000002
detected as     : 287 (Unknown Intrepid-based)
pmac flags      : 00000008
L2 cache        : 512K unified
memory          : 512MB
pmac-generation : NewWorld


--==_Exmh_1107463045_145270
Content-Type: text/plain ; name="powerbook-g4-2.6.11-rc2-config";
	charset=us-ascii
Content-Description: powerbook-g4-2.6.11-rc2-config
Content-Disposition: attachment; filename="powerbook-g4-2.6.11-rc2-config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.11-rc2-CITI_NFS4_ALL-1
# Thu Feb  3 20:08:07 2005
#
CONFIG_MMU=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_GENERIC_NVRAM=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Processor
#
CONFIG_6xx=y
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_POWER3 is not set
# CONFIG_POWER4 is not set
# CONFIG_8xx is not set
# CONFIG_E500 is not set
CONFIG_ALTIVEC=y
CONFIG_TAU=y
# CONFIG_TAU_INT is not set
CONFIG_TAU_AVERAGE=y
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_PMAC=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_PPC601_SYNC_FIX is not set
CONFIG_PM=y
CONFIG_PPC_STD_MMU=y

#
# Platform options
#
CONFIG_PPC_MULTIPLATFORM=y
# CONFIG_APUS is not set
# CONFIG_KATANA is not set
# CONFIG_WILLOW is not set
# CONFIG_CPCI690 is not set
# CONFIG_PCORE is not set
# CONFIG_POWERPMC250 is not set
# CONFIG_CHESTNUT is not set
# CONFIG_SPRUCE is not set
# CONFIG_EV64260 is not set
# CONFIG_LOPEC is not set
# CONFIG_MCPN765 is not set
# CONFIG_MVME5100 is not set
# CONFIG_PPLUS is not set
# CONFIG_PRPMC750 is not set
# CONFIG_PRPMC800 is not set
# CONFIG_SANDPOINT is not set
# CONFIG_ADIR is not set
# CONFIG_K2 is not set
# CONFIG_PAL4 is not set
# CONFIG_GEMINI is not set
# CONFIG_EST8260 is not set
# CONFIG_SBC82xx is not set
# CONFIG_SBS8260 is not set
# CONFIG_RPX8260 is not set
# CONFIG_TQM8260 is not set
# CONFIG_ADS8272 is not set
# CONFIG_PQ2FADS is not set
# CONFIG_LITE5200 is not set
CONFIG_PPC_CHRP=y
CONFIG_PPC_PMAC=y
CONFIG_PPC_PREP=y
CONFIG_PPC_OF=y
CONFIG_PPCBUG_NVRAM=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_HIGHMEM=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PROC_DEVICETREE=y
# CONFIG_PREP_RESIDUAL is not set
# CONFIG_CMDLINE_BOOL is not set

#
# Bus options
#
# CONFIG_ISA is not set
CONFIG_GENERIC_ISA_DMA=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PC-card bridges
#

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_TASK_SIZE=0x80000000
CONFIG_BOOT_LOAD=0x00800000

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_MAC_FLOPPY is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_SL82C105=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_AEC62XX=y
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_IDE_PMAC=y
CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST=y
CONFIG_BLK_DEV_IDEDMA_PMAC=y
# CONFIG_BLK_DEV_IDE_PMAC_BLINK is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
CONFIG_SCSI_MESH=y
CONFIG_SCSI_MESH_SYNC_RATE=5
CONFIG_SCSI_MESH_RESET_DELAY_MS=4000
CONFIG_SCSI_MAC53C94=y

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
CONFIG_IEEE1394_CONFIG_ROM_IP1394=y

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_CMP is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Macintosh device drivers
#
CONFIG_ADB=y
CONFIG_ADB_CUDA=y
CONFIG_ADB_PMU=y
CONFIG_PMAC_PBOOK=y
CONFIG_PMAC_APM_EMU=y
CONFIG_PMAC_BACKLIGHT=y
CONFIG_ADB_MACIO=y
CONFIG_INPUT_ADBHID=y
CONFIG_MAC_EMUMOUSEBTN=y
# CONFIG_THERM_WINDTUNNEL is not set
CONFIG_THERM_ADT746X=y
# CONFIG_ANSLCD is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_IP_TCPDIAG=y
# CONFIG_IP_TCPDIAG_IPV6 is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
# CONFIG_IP_NF_MATCH_IPRANGE is not set
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
# CONFIG_IP_NF_MATCH_RECENT is not set
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_SAME is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
# CONFIG_IP_NF_TARGET_CLASSIFY is not set
# CONFIG_IP_NF_RAW is not set
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
# CONFIG_IP_NF_ARP_MANGLE is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
CONFIG_ATALK=m
# CONFIG_DEV_APPLETALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
CONFIG_BT=m
CONFIG_BT_L2CAP=m
# CONFIG_BT_SCO is not set
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
# CONFIG_BT_BNEP is not set
# CONFIG_BT_HIDP is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIVHCI is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_MACE=y
# CONFIG_MACE_AAUI_PORT is not set
CONFIG_BMAC=y
# CONFIG_HAPPYMEAL is not set
CONFIG_SUNGEM=y
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_HERMES=m
CONFIG_APPLE_AIRPORT=m
# CONFIG_PLX_HERMES is not set
# CONFIG_TMD_HERMES is not set
CONFIG_PCI_HERMES=m
# CONFIG_ATMEL is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
CONFIG_NET_WIRELESS=y

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PPP=y
CONFIG_PPP_MULTILINK=y
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
CONFIG_ISDN=m

#
# Old ISDN4Linux
#
# CONFIG_ISDN_I4L is not set

#
# CAPI subsystem
#
# CONFIG_ISDN_CAPI is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ATKBD is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_PMACZILOG is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_NVRAM=y
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_UNINORTH=y
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_HYDRA is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_ISA is not set
CONFIG_I2C_KEYWEST=y
# CONFIG_I2C_MPC is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_OVCAMCHIP is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_OF=y
CONFIG_FB_CONTROL=y
CONFIG_FB_PLATINUM=y
CONFIG_FB_VALKYRIE=y
CONFIG_FB_CT65550=y
# CONFIG_FB_ASILIANT is not set
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=y
CONFIG_DMASOUND_PMAC=y
CONFIG_DMASOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set

#
# ALSA PowerMac devices
#
CONFIG_SND_POWERMAC=y

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
# CONFIG_USB is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
# CONFIG_MSDOS_PARTITION is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Library routines
#
CONFIG_CRC_CCITT=y
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_DEBUG_PREEMPT=y
CONFIG_BOOTX_TEXT=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

--==_Exmh_1107463045_145270--
