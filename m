Message-ID: <000901c2876d$87589630$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Configuration File
Date: Sat, 9 Nov 2002 02:56:41 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

Below is my configuration file. As of now I am trying to bring up very basic
kernel in my custom board. Any changes has to be done in the configuration?.

Thanking you in advance.
Regards
Aman

#
# Automatically generated make config: don't edit
#
# CONFIG_UID16 is not set
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_GENERIC_ISA_DMA=y
#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_ADVANCED_OPTIONS=y
#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y
#
# Platform support
#
CONFIG_PPC=y
CONFIG_PPC32=y
# CONFIG_6xx is not set
# CONFIG_40x is not set
CONFIG_440=y
# CONFIG_8xx is not set
# CONFIG_POWER3 is not set
CONFIG_4xx=y
# CONFIG_PPC_STD_MMU is not set
CONFIG_BOOKE=y
CONFIG_NOT_COHERENT_CACHE=y
CONFIG_IBM_OCP=y
CONFIG_GEN550_KGDB=y
CONFIG_PIN_TLB=y
CONFIG_IBM_OCP_MAL_CNT=1
CONFIG_EBONY=y
# CONFIG_EMBEDDED_OOM_KILLER is not set
# CONFIG_RTSCHED is not set
# CONFIG_ALL_PPC is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_PPC4xx_DMA is not set
CONFIG_PPC4xx_EDMA=y
CONFIG_OCP_PROC=y
#
# General setup
#
CONFIG_HIGHMEM=y
# CONFIG_HIGHMEM_START_BOOL is not set
CONFIG_LOWMEM_SIZE_BOOL=y
CONFIG_LOWMEM_SIZE=20000000
# CONFIG_KERNEL_START_BOOL is not set
# CONFIG_TASK_SIZE_BOOL is not set
# CONFIG_ILATENCY is not set
# CONFIG_ISA is not set
# CONFIG_EISA is not set
# CONFIG_SBUS is not set
# CONFIG_MCA is not set
CONFIG_PCI=y
# CONFIG_PC_KEYBOARD is not set
CONFIG_NET=y
CONFIG_SYSCTL=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SEMMNI=128
CONFIG_SYSVIPC_SEMMSL=250
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
# CONFIG_MULTITHREADED_CORES is not set
CONFIG_KERNEL_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PCI_NAMES is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
#
# Parallel port support
#
# CONFIG_PARPORT is not set
CONFIG_PPC_RTC=m
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="root=/dev/ram0 ramdisk_size=6144"
#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=m
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_PARTITIONS=m
# CONFIG_MTD_CONCAT is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=m
# CONFIG_MTD_RAM is not set
CONFIG_MTD_ROM=m
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_OBSOLETE_CHIPS is not set
# CONFIG_MTD_AMDSTD is not set
# CONFIG_MTD_SHARP is not set
# CONFIG_MTD_JEDEC is not set
#
# Mapping drivers for chip access
#
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_CSTM_MIPS_IXX is not set
# CONFIG_MTD_TQM8XXL is not set
# CONFIG_MTD_RPXLITE is not set
# CONFIG_MTD_MBX860 is not set
CONFIG_MTD_EBONY=m
# CONFIG_MTD_REDWOOD is not set
# CONFIG_MTD_DBOX2 is not set
# CONFIG_MTD_CFI_FLAGADM is not set
# CONFIG_MTD_POWERPLUS is not set
# CONFIG_MTD_POWERPMC250 is not set
# CONFIG_MTD_PCI is not set
#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLKMTD is not set
#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC1000 is not set
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOCPROBE is not set
#
# NAND Flash Device Drivers
#
# CONFIG_MTD_NAND is not set
#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set
#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# Below value is changed by AK
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=6144
CONFIG_BLK_DEV_INITRD=y
#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set
#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
# CONFIG_IP_PNP_DHCP is not set
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_QUEUE is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set
#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=m
#
# IDE, ATA and ATAPI Block devices
#
# CONFIG_BLK_DEV_IDE is not set
#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_ONLY is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_IDE_MODES is not set
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
#
# SCSI support
#
# CONFIG_SCSI is not set
#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set
#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set
#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set
#
# Network device support
#
CONFIG_NETDEVICES=y
#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MACE is not set
# CONFIG_BMAC is not set
# CONFIG_GMAC is not set
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNLANCE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TC35815 is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=m
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set
# CONFIG_HHNET is not set
# CONFIG_NPNET is not set
#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=m
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_BSDCOMP is not set
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set
#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set
#
# On-chip net devices
#
CONFIG_IBM_OCP_ENET=y
# CONFIG_IBM_OCP_ENET_ERROR_MSG is not set
CONFIG_IBM_OCP_ENET_RX_BUFF=64
CONFIG_IBM_OCP_ENET_TX_BUFF=8
CONFIG_IBM_OCP_ENET_GAP=8
CONFIG_IBM_OCP_ENET_SKB_RES=0
CONFIG_OCP_NET=y
CONFIG_IBM_OCP_MAL_CNT=1
CONFIG_IBM_OCP_ZMII=y
#
# Wan interfaces
#
# CONFIG_WAN is not set
#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set
#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set
#
# ISDN subsystem
#
# CONFIG_ISDN is not set
#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set
#
# Console drivers
#
#
# Frame-buffer support
#
# CONFIG_FB is not set
#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
#
# Macintosh device drivers
#
#
# Character devices
#
CONFIG_VT=y
# CONFIG_VT_CONSOLE is not set
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
#
# I2C support
#
CONFIG_I2C=m
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_IBM_OCP=m
# CONFIG_I2C_MAINBOARD is not set
CONFIG_I2C_CHARDEV=m
# CONFIG_I2C_PROC is not set
#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set
# CONFIG_RWMOUSE is not set
#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
#
# Joysticks
#
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set
#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
CONFIG_IBM_OCP_GPIO=m
#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=m
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS_FS=m
CONFIG_JFFS_FS_VERBOSE=0
# CONFIG_JFFS_PROC_FS is not set
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
#CONFIG_RAMFS was m now changed by AK
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_EXT2_FS WAS m now changed by AK
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set
CONFIG_ZLIB_FS_INFLATE=m
#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
# CONFIG_NLS is not set
#
# Sound
#
# CONFIG_SOUND is not set
#
# MPC4xx Driver Options
#
#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set
#
# USB Controllers
#
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
CONFIG_USB_OHCI=m
# CONFIG_USB_NON_PCI_OHCI is not set
# CONFIG_USB_OCP_OHCI is not set
#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_WACOM is not set
#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
#
# USB Multimedia devices
#
#
# Video4Linux support is needed for USB Multimedia device support
#
#
# USB Network adaptors
#
CONFIG_USB_PEGASUS=m
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
#
# USB Miscellaneous drivers
#
# CONFIG_USB_RIO500 is not set
#
# Bluetooth support
#
# CONFIG_BLUEZ is not set
#
# Kernel tracing
#
# CONFIG_TRACE is not set
#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_KGDB is not set
# CONFIG_XMON is not set
# CONFIG_BDI_SWITCH is not set
# CONFIG_SERIAL_TEXT_DEBUG is not set Set by AK for v8g2
CONFIG_SERIAL_TEXT_DEBUG=y
CONFIG_ZLIB=m


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
