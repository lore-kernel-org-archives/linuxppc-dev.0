Return-Path: <robin@india.tejasnetworks.com>
Received: from pop-mail.india.tejasnetworks.com (india.tejasnetworks.com
	[164.164.94.83]) by ozlabs.org (Postfix) with SMTP id 58B9467A2F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Feb 2005 20:47:32 +1100 (EST)
From: robin <robin@india.tejasnetworks.com>
To: Gerhard Jaeger <g.jaeger@sysgo.com>, linuxppc-embedded@ozlabs.org
Date: Thu, 10 Feb 2005 15:16:58 +0530
References: <20050204192117.4F29CC108D@atlas.denx.de>
	<200502101137.07711.robin@india.tejasnetworks.com>
	<200502100840.38232.g.jaeger@sysgo.com>
In-Reply-To: <200502100840.38232.g.jaeger@sysgo.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
	boundary="------------Boundary-00=_AIWO0HXH2OXK3NDR4GWL"
Message-Id: <200502101516.58244.robin@india.tejasnetworks.com>
Subject: Re: Memory leak problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--------------Boundary-00=_AIWO0HXH2OXK3NDR4GWL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi thanks for your reply..

I am attaching the kernel config file. the kernel version is kernel 2.4.2=
0.
The processor we are using is MPC852T.

Am i correct in my conclusion that the software restart(killing and=20
restarting)  without kernel reboot does free all resources used by the=20
software including memory??

thanks in advance




On Thursday 10 Feb 2005 1:10 pm, you wrote:
> On Thursday 10 February 2005 07:07, robin wrote:
> > Hi
> > We have an application running on  denx linux kernel 2.4.20.
> >
> > Apparently there is a memory leak that we are not able to find.
> > The application is giving out of memory error. Even if we restart
> > the application without rebooting the kernel, (killing all applicatio=
n
> > processes and restarting), it gives the same out of memory error.
> > Rebooting the kernel solves the problem.
> >
> > It seems that the memory leak is not at the application level
> > 'cos restarting the application doesnt solve the problem..
> >
> > 1. Any ideas where I should look for the leak??
>
> Check /proc/slabinfo and see if there are some "supicious" buffer,
> that only increase and never decrease. From the kind of buffer
> showing this behaviour you might find out where to dig...
> Check it before running the application and afterwards.
>
> > 2. Is there any known memory leak problems with the kernel??
>
> There are enough places, where a kernel could leak, but in general
> such leaks in the main part are detected really fast. Undiscovered
> leaks are often found in the drivers itself.
>
> What's your kernel config?
> Which HW are you using?
> What does this application?
>
> Ciao,
> Gerhard

--=20
Nvidia driver loaded - bugs to nvidia. vmware loaded bugs to vmware,
both loaded, god help you, nobody else will

=09- Alan Cox explaining where to send bug reports for binary-only driver=
s

--------------Boundary-00=_AIWO0HXH2OXK3NDR4GWL
Content-Type: text/plain;
  charset="iso-8859-1";
  name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config"



#
# Automatically generated make config: don't edit
#
# CONFIG_UID16 is not set
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_HAVE_DEC_LOCK=y


#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_ADVANCED_OPTIONS=y
CONFIG_TRIM_DOWN=y


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
# CONFIG_440 is not set
# CONFIG_POWER3 is not set
CONFIG_8xx=y
# CONFIG_PPC_ISERIES is not set
# CONFIG_PPC_STD_MMU is not set
CONFIG_SERIAL_CONSOLE=y
CONFIG_NOT_COHERENT_CACHE=y
# CONFIG_RPXLITE is not set
# CONFIG_RPXCLASSIC is not set
# CONFIG_BSEIP is not set
# CONFIG_FADS is not set
# CONFIG_TQM823L is not set
# CONFIG_TQM850L is not set
# CONFIG_TQM855L is not set
# CONFIG_TQM860L is not set
# CONFIG_TQM823M is not set
# CONFIG_TQM850M is not set
# CONFIG_TQM855M is not set
# CONFIG_TQM860M is not set
# CONFIG_TQM862M is not set
# CONFIG_FPS850L is not set
# CONFIG_SPD823TS is not set
# CONFIG_IVMS8 is not set
# CONFIG_IVML24 is not set
# CONFIG_SM850 is not set
# CONFIG_HERMES_PRO is not set
# CONFIG_IP860 is not set
# CONFIG_LWMON is not set
# CONFIG_PCU_E is not set
# CONFIG_CCM is not set
# CONFIG_LANTEC is not set
# CONFIG_MBX is not set
CONFIG_TEJAS=y
# CONFIG_DAB4K is not set
# CONFIG_WINCEPT is not set
CONFIG_TN100=y
# CONFIG_TN200 is not set
CONFIG_IGN_MC_EXCEP=y
# CONFIG_TN100_ITC is not set
# CONFIG_TN100_LTC is not set
# CONFIG_TN100_MC4L is not set
CONFIG_TN100_TXC1=y
# CONFIG_TN100_LTC4 is not set
# CONFIG_TN100_LPSS2 is not set
# CONFIG_ALL_PPC is not set
# CONFIG_SMP is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_EMBEDDEDBOOT=y


#
# General setup
#
# CONFIG_HIGHMEM is not set
# CONFIG_KERNEL_START_BOOL is not set
# CONFIG_TASK_SIZE_BOOL is not set
# CONFIG_PIN_TLB is not set
# CONFIG_ISA is not set
# CONFIG_EISA is not set
# CONFIG_SBUS is not set
# CONFIG_MCA is not set
# CONFIG_PCI_QSPAN is not set
# CONFIG_PCI is not set
CONFIG_NET=y
CONFIG_SYSCTL=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_KERNEL_ELF=y
CONFIG_BINFMT_MISC=y
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set


#
# Parallel port support
#
# CONFIG_PARPORT is not set
# CONFIG_PPC_RTC is not set
# CONFIG_CMDLINE_BOOL is not set


#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_CONCAT is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set


#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set


#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
# CONFIG_MTD_CFI_B1 is not set
# CONFIG_MTD_CFI_B2 is not set
CONFIG_MTD_CFI_B4=y
# CONFIG_MTD_CFI_B8 is not set
# CONFIG_MTD_CFI_I1 is not set
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_OBSOLETE_CHIPS is not set
# CONFIG_MTD_AMDSTD is not set
# CONFIG_MTD_SHARP is not set
# CONFIG_MTD_JEDEC is not set


#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_TN100_MAP=y
# CONFIG_MTD_TN100_MAP_HARD_CODED is not set
CONFIG_MTD_PHYSMAP_BUSWIDTH=4
# CONFIG_MTD_DBOX2 is not set
# CONFIG_MTD_CFI_FLAGADM is not set
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_PCMCIA is not set


#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLKMTD is not set


#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set
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
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set


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
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
# CONFIG_IP_PIMSM_V2 is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y


#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_UNCLEAN=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=y
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_TARGET_LOG is not set
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set


#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set


#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
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
# Network testing
#
# CONFIG_NET_PKTGEN is not set


#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y


#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y


#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set


#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_MPC8xx_IDE=y
CONFIG_IDE_8xx_PCCARD=y
# CONFIG_IDE_8xx_DIRECT is not set
# CONFIG_IDE_EXT_DIRECT is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
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
# I2O device support
#
# CONFIG_I2O is not set
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
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set


#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=y
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=y
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=y
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPPOE is not set
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
# Wan interfaces
#
CONFIG_WAN=y
# CONFIG_COMX is not set
# CONFIG_DSCC4 is not set
# CONFIG_FARSYNC is not set
# CONFIG_LANMEDIA is not set
# CONFIG_ATI_XX20 is not set
# CONFIG_SEALEVEL_4021 is not set
CONFIG_SYNCLINK_SYNCPPP=y
# CONFIG_HDLC is not set
# CONFIG_DLCI is not set
# CONFIG_LAPBETHER is not set
# CONFIG_X25_ASY is not set


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
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set


#
# Macintosh device drivers
#


#
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_DIGI is not set
# CONFIG_ESPSERIAL is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_N_HDLC is not set
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=128


#
# I2C support
#
# CONFIG_I2C is not set


#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set


#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set


#
# Input core support is needed for gameports
#


#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set


#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_AMD7XX_TCO is not set
CONFIG_WDT_MPC8XX=y
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_RTC_11_MINUTE_MODE is not set
# CONFIG_PCF8563_RTC is not set
# CONFIG_RTC_8XX is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_FLASH is not set


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
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_NAND is not set
CONFIG_CRAMFS=y
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
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
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
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
# MPC8xx CPM Options
#
# CONFIG_CPM_TRACK_LOAD is not set
# CONFIG_SCC_ENET is not set
# CONFIG_SCC1_ENET is not set
# CONFIG_SCC2_ENET is not set
# CONFIG_SCC3_ENET is not set
CONFIG_FEC_ENET=y
CONFIG_USE_MDIO=y
# CONFIG_FEC_AM79C874 is not set
# CONFIG_FEC_LXT970 is not set
CONFIG_FEC_LXT971=y
# CONFIG_FEC_QS6612 is not set
# CONFIG_FEC_DP83843 is not set
# CONFIG_FEC_DP83846A is not set
# CONFIG_FEC_PACKETHOOK is not set
# CONFIG_ENET_BIG_BUFFERS is not set
CONFIG_SMC1_UART_RX_BDNUM=4
CONFIG_SMC1_UART_RX_BDSIZE=32
CONFIG_SMC1_UART_TX_BDNUM=4
CONFIG_SMC1_UART_TX_BDSIZE=32
# CONFIG_SMC2_UART is not set
# CONFIG_USE_SCC_IO is not set


#
# Generic MPC8xx Options
#
CONFIG_8xx_COPYBACK=y
# CONFIG_8xx_CPU6 is not set
# CONFIG_UCODE_PATCH is not set


#
# USB support
#
# CONFIG_USB is not set


#
# Bluetooth support
#
# CONFIG_BLUEZ is not set


#
# Library routines
#
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y


#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_WAITQ is not set
# CONFIG_KGDB is not set
# CONFIG_XMON is not set
# CONFIG_BDI_SWITCH is not set


--------------Boundary-00=_AIWO0HXH2OXK3NDR4GWL--
