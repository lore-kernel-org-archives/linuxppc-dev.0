Date: Sun, 08 Sep 2002 08:11:45 +0800
From: leeyang <leeyang@ycig.com>
Subject: Re: open initial console failed
To: mschmid@ascona.de, linuxppc-embedded@lists.linuxppc.org
Message-id: <003b01c256cc$6442c610$0f4fb73d@leeyang>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <OF6C1C083B.6DB7A73B-ONC1256C2C.0045D928@ascona.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


pls check the /eldk/ppc_8xx/dev
if there are only 3 files,try the MKDEV(sth like this name)
scripts in the eldk

It is stated in the README,I miss it at first.

leeyang
----- Original Message -----
From: <mschmid@ascona.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, September 06, 2002 9:10 PM
Subject: open initial console failed


>
> Hi,
>
> i got linux kernel 2.4.4 (from denx ftp-server) running on our custom
> MPC8240 board.
> The board has no serial device. No connection for a display. Ethernet is
> available.
> There is the following warning within the kernel log.
> "Warning: unable to open an initial console."
> This is ok because there is no device /dev/console available.
> Can i ignore this warning or will this cause problems on the further init
> process ?
> This are my configuration settings. Did i forget something to provide the
> initial console ?
>
> Regards
> Mathias
>
> #
> # Automatically generated make config: don't edit
> #
> # CONFIG_UID16 is not set
> # CONFIG_RWSEM_GENERIC_SPINLOCK is not set
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
>
> #
> # Code maturity level options
> #
> # CONFIG_EXPERIMENTAL is not set
>
> #
> # Loadable module support
> #
> # CONFIG_MODULES is not set
>
> #
> # Platform support
> #
> CONFIG_PPC=y
> CONFIG_6xx=y
> # CONFIG_4xx is not set
> # CONFIG_POWER3 is not set
> # CONFIG_POWER4 is not set
> # CONFIG_8xx is not set
> # CONFIG_8260 is not set
> CONFIG_ALL_PPC=y
> # CONFIG_GEMINI is not set
> # CONFIG_APUS is not set
> # CONFIG_PPC601_SYNC_FIX is not set
> # CONFIG_SMP is not set
> # CONFIG_ALTIVEC is not set
> # CONFIG_SASH is not set
> CONFIG_MACH_SPECIFIC=y
> CONFIG_TE980=y
>
> #
> # General setup
> #
> # CONFIG_HIGHMEM is not set
> # CONFIG_ISA is not set
> # CONFIG_EISA is not set
> # CONFIG_SBUS is not set
> # CONFIG_MCA is not set
> CONFIG_PCI=y
> CONFIG_NET=y
> CONFIG_SYSCTL=y
> CONFIG_SYSVIPC=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_KCORE_ELF=y
> CONFIG_BINFMT_ELF=y
> CONFIG_KERNEL_ELF=y
> CONFIG_BINFMT_MISC=y
> CONFIG_PCI_NAMES=y
> # CONFIG_HOTPLUG is not set
> # CONFIG_PCMCIA is not set
>
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
> # CONFIG_PPC_RTC is not set
> # CONFIG_PROC_DEVICETREE is not set
> # CONFIG_PPC_RTAS is not set
> # CONFIG_BOOTX_TEXT is not set
> # CONFIG_PREP_RESIDUAL is not set
> # CONFIG_CMDLINE_BOOL is not set
>
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
>
> #
> # Plug and Play configuration
> #
> # CONFIG_PNP is not set
> # CONFIG_ISAPNP is not set
>
> #
> # Block devices
> #
> # CONFIG_BLK_DEV_FD is not set
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> CONFIG_BLK_DEV_LOOP=y
> # CONFIG_BLK_DEV_NBD is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_SIZE=8192
> CONFIG_BLK_DEV_INITRD=y
>
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> # CONFIG_BLK_DEV_MD is not set
> # CONFIG_MD_LINEAR is not set
> # CONFIG_MD_RAID0 is not set
> # CONFIG_MD_RAID1 is not set
> # CONFIG_MD_RAID5 is not set
> # CONFIG_BLK_DEV_LVM is not set
>
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_MMAP is not set
> CONFIG_NETLINK=y
> # CONFIG_RTNETLINK is not set
> # CONFIG_NETLINK_DEV is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_FILTER is not set
> CONFIG_UNIX=y
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_INET_ECN is not set
> # CONFIG_SYN_COOKIES is not set
>
> #
> #
> #
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
>
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
>
> #
> # ATA/IDE/MFM/RLL support
> #
> # CONFIG_IDE is not set
> # CONFIG_BLK_DEV_IDE_MODES is not set
> # CONFIG_BLK_DEV_HD is not set
>
> #
> # SCSI support
> #
> # CONFIG_SCSI is not set
>
> #
> # Network device support
> #
> CONFIG_NETDEVICES=y
>
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_NET_SB1000 is not set
>
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> # CONFIG_MACE is not set
> # CONFIG_BMAC is not set
> # CONFIG_GMAC is not set
> # CONFIG_NCR885E is not set
> # CONFIG_OAKNET is not set
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
> # CONFIG_DEPCA is not set
> # CONFIG_HP100 is not set
> # CONFIG_NET_ISA is not set
> CONFIG_NET_PCI=y
> # CONFIG_PCNET32 is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_APRICOT is not set
> # CONFIG_CS89x0 is not set
> # CONFIG_TULIP is not set
> # CONFIG_DE4X5 is not set
> # CONFIG_DGRS is not set
> # CONFIG_DM9102 is not set
> CONFIG_EEPRO100=y
> # CONFIG_EEPRO100_PM is not set
> # CONFIG_LNE390 is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_NE3210 is not set
> # CONFIG_ES3210 is not set
> # CONFIG_8139TOO is not set
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> # CONFIG_8139TOO_8129 is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
> # CONFIG_WINBOND_840 is not set
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_NET_POCKET is not set
>
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_FDDI is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
>
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
>
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> # CONFIG_NET_FC is not set
>
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
>
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
>
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
>
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
>
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
>
> #
> # Console drivers
> #
> # CONFIG_VGA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
>
> #
> # Frame-buffer support
> #
> # CONFIG_FB is not set
>
> #
> # Input core support
> #
> # CONFIG_INPUT is not set
>
> #
> # Macintosh device drivers
> #
> # CONFIG_ADB_CUDA is not set
> # CONFIG_ADB_PMU is not set
> # CONFIG_MAC_FLOPPY is not set
> # CONFIG_MAC_SERIAL is not set
> # CONFIG_ADB is not set
>
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> # CONFIG_SERIAL is not set
> # CONFIG_SERIAL_EXTENDED is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_UNIX98_PTYS is not set
>
> #
> # I2C support
> #
> # CONFIG_I2C is not set
>
> #
> # Mice
> #
> # CONFIG_BUSMOUSE is not set
> # CONFIG_MOUSE is not set
>
> #
> # Joysticks
> #
> # CONFIG_JOYSTICK is not set
>
> #
> # Input core support is needed for joysticks
> #
> # CONFIG_QIC02_TAPE is not set
>
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_INTEL_RNG is not set
> # CONFIG_NVRAM is not set
> # CONFIG_RTC is not set
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_FLASH is not set
>
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> # CONFIG_AGP is not set
> # CONFIG_DRM is not set
>
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
>
> #
> # File systems
> #
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_REISERFS_FS is not set
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_ADFS_FS_RW is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_FAT_FS is not set
> # CONFIG_MSDOS_FS is not set
> # CONFIG_UMSDOS_FS is not set
> # CONFIG_VFAT_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_JFFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_TMPFS is not set
> CONFIG_RAMFS=y
> # CONFIG_ISO9660_FS is not set
> # CONFIG_JOLIET is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_NTFS_RW is not set
> # CONFIG_HPFS_FS is not set
> CONFIG_PROC_FS=y
> CONFIG_DEVFS_FS=y
> CONFIG_DEVFS_MOUNT=y
> # CONFIG_DEVFS_DEBUG is not set
> # CONFIG_DEVPTS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX4FS_RW is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_EXT2_FS=y
> # CONFIG_SYSV_FS is not set
> # CONFIG_SYSV_FS_WRITE is not set
> # CONFIG_UDF_FS is not set
> # CONFIG_UDF_RW is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_UFS_FS_WRITE is not set
>
> #
> # Network File Systems
> #
> # CONFIG_CODA_FS is not set
> # CONFIG_NFS_FS is not set
> # CONFIG_NFS_V3 is not set
> # CONFIG_ROOT_NFS is not set
> # CONFIG_NFSD is not set
> # CONFIG_NFSD_V3 is not set
> # CONFIG_SUNRPC is not set
> # CONFIG_LOCKD is not set
> # CONFIG_SMB_FS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_NCPFS_PACKET_SIGNING is not set
> # CONFIG_NCPFS_IOCTL_LOCKING is not set
> # CONFIG_NCPFS_STRONG is not set
> # CONFIG_NCPFS_NFS_NS is not set
> # CONFIG_NCPFS_OS2_NS is not set
> # CONFIG_NCPFS_SMALLDOS is not set
> # CONFIG_NCPFS_NLS is not set
> # CONFIG_NCPFS_EXTRAS is not set
>
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> # CONFIG_SMB_NLS is not set
> # CONFIG_NLS is not set
>
> #
> # Sound
> #
> # CONFIG_SOUND is not set
>
> #
> # USB support
> #
> # CONFIG_USB is not set
>
> #
> # Kernel hacking
> #
> # CONFIG_MAGIC_SYSRQ is not set
> # CONFIG_KGDB is not set
> # CONFIG_XMON is not set
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
