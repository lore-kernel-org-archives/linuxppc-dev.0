Return-Path: <jakob.viketoft@bitsim.se>
Received: from amsfep12-int.chello.nl (amsfep12-int.chello.nl [213.46.243.17])
	by ozlabs.org (Postfix) with ESMTP id DBE5B67A73
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Feb 2005 22:41:06 +1100 (EST)
Message-ID: <42035F13.5050803@bitsim.se>
Date: Fri, 04 Feb 2005 12:40:03 +0100
From: Jakob Viketoft <jakob.viketoft@bitsim.se>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
References: <4201F956.1050702@bitsim.com> <420232BF.9070302@ru.mvista.com>
In-Reply-To: <420232BF.9070302@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Linux on Virtex-II Pro P20 development board...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrei Konovalov wrote:
> Jakob,
> 
> Why are you using 2.6.8.1 which is rather old and doesn't have
> any Virtex-II Pro support?

Well, I had the notion of not being right on the bleeding edge, but then 
it would probably make more sense to use the 2.4.x kernel. I've updated 
now anyway... :)

Thanks for all the info! I'm just about to download the bitstream and 
the kernel to the board and I'll see where it goes from there...

Oh, and I seem to have failed to mention that it's a Memec Design 2VPxx 
FF1152 board, it almost looks like it's more supported in the 2.4.x 
kernel, am I right?

Cheers,

	/Jakob

> Virtex-II Pro support in 2.6 is very minimalistic at the moment:
> http://linux.bkbits.net:8080/linux-2.5/cset@1.1938.115.48
> 
> Nevertheless, it should be enough to bring up your board
> with 16x50 UART and ramdisk (I mean adding your platform using
> ML300 as a template).
> 
> This stuff works for me in the following configuration:
>   board:
>     Xilinx ML300
>   bitstream:
>     http://www.xilinx.com/ise/embedded/edk6_2docs/edk_62i_examples.htm
>     Example #7
>   kernel:
>     2.6.11-rc1
>   .config:
>     attached
> 
> You could also need the TLB bug fix mentioned at:
>   
> http://support.xilinx.com/xlnx/xil_ans_display.jsp?iLanguageID=1&iCountryID=1&getPagePath=14052 
> 
>   (look for "Solution 12")
>   and
>   http://ppc.bkbits.net:8080/linuxppc-2.4/cset@1.1282
> 
> 
> Best regards,
> Andrei
> 
> 
> Jakob Viketoft wrote:
> 
>> Hello everyone!
>>
>> I've just started trying to get the Linux (2.6.8.1) kernel to run on 
>> the above mentioned board (or, specifically, a PPC405 on the Xilinx 
>> Virtex-II Pro 2VP20). I just figured I'd ask around and see if any of 
>> you have got this board running and then what kernel modifications 
>> where necessary and IP blocks (from the development kit) you've used. 
>> At the moment I'm primarily interested in the PPC and a serial port, 
>> later on the TP port will be useful as well.
>>
>> I've previously ported the 2.4.x kernel to Cirrus Logic EP7312 (ARM) 
>> chip, but that was some years ago and with the new kernel, chip and 
>> structure of the PPC arch of the kernel I'm a bit disoriented. Any 
>> help would be greatly appreciated!
>>
>> Regards,
>>     /Jakob
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
> 
> 
> ------------------------------------------------------------------------
> 
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.11-rc1
> # Thu Feb  3 16:14:59 2005
> #
> CONFIG_MMU=y
> CONFIG_GENERIC_HARDIRQS=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_HAVE_DEC_LOCK=y
> CONFIG_PPC=y
> CONFIG_PPC32=y
> CONFIG_GENERIC_NVRAM=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_CLEAN_COMPILE=y
> CONFIG_BROKEN_ON_SMP=y
> 
> #
> # General setup
> #
> CONFIG_LOCALVERSION="ank"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> # CONFIG_POSIX_MQUEUE is not set
> CONFIG_BSD_PROCESS_ACCT=y
> # CONFIG_BSD_PROCESS_ACCT_V3 is not set
> CONFIG_SYSCTL=y
> # CONFIG_AUDIT is not set
> CONFIG_LOG_BUF_SHIFT=14
> CONFIG_HOTPLUG=y
> CONFIG_KOBJECT_UEVENT=y
> # CONFIG_IKCONFIG is not set
> CONFIG_EMBEDDED=y
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_ALL is not set
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SHMEM=y
> CONFIG_CC_ALIGN_FUNCTIONS=0
> CONFIG_CC_ALIGN_LABELS=0
> CONFIG_CC_ALIGN_LOOPS=0
> CONFIG_CC_ALIGN_JUMPS=0
> # CONFIG_TINY_SHMEM is not set
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_OBSOLETE_MODPARM=y
> CONFIG_MODVERSIONS=y
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_KMOD=y
> 
> #
> # Processor
> #
> # CONFIG_6xx is not set
> CONFIG_40x=y
> # CONFIG_44x is not set
> # CONFIG_POWER3 is not set
> # CONFIG_POWER4 is not set
> # CONFIG_8xx is not set
> # CONFIG_E500 is not set
> # CONFIG_MATH_EMULATION is not set
> # CONFIG_CPU_FREQ is not set
> CONFIG_4xx=y
> 
> #
> # IBM 4xx options
> #
> # CONFIG_ASH is not set
> # CONFIG_BUBINGA is not set
> # CONFIG_CPCI405 is not set
> # CONFIG_EP405 is not set
> # CONFIG_OAK is not set
> # CONFIG_REDWOOD_5 is not set
> # CONFIG_REDWOOD_6 is not set
> # CONFIG_SYCAMORE is not set
> # CONFIG_WALNUT is not set
> CONFIG_XILINX_ML300=y
> CONFIG_IBM405_ERR77=y
> CONFIG_IBM405_ERR51=y
> CONFIG_XILINX_OCP=y
> CONFIG_VIRTEX_II_PRO=y
> CONFIG_EMBEDDEDBOOT=y
> # CONFIG_PPC4xx_DMA is not set
> CONFIG_PPC_GEN550=y
> # CONFIG_PM is not set
> CONFIG_UART0_TTYS0=y
> # CONFIG_UART0_TTYS1 is not set
> CONFIG_NOT_COHERENT_CACHE=y
> 
> #
> # Platform options
> #
> # CONFIG_PC_KEYBOARD is not set
> # CONFIG_SMP is not set
> # CONFIG_PREEMPT is not set
> # CONFIG_HIGHMEM is not set
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_MISC is not set
> CONFIG_CMDLINE_BOOL=y
> CONFIG_CMDLINE="console=ttyS0,9600 ip=off root=/dev/ram"
> 
> #
> # Bus options
> #
> # CONFIG_PCI is not set
> # CONFIG_PCI_DOMAINS is not set
> 
> #
> # PCCARD (PCMCIA/CardBus) support
> #
> # CONFIG_PCCARD is not set
> 
> #
> # PC-card bridges
> #
> 
> #
> # Advanced setup
> #
> CONFIG_ADVANCED_OPTIONS=y
> CONFIG_HIGHMEM_START=0xfe000000
> # CONFIG_LOWMEM_SIZE_BOOL is not set
> CONFIG_LOWMEM_SIZE=0x30000000
> # CONFIG_KERNEL_START_BOOL is not set
> CONFIG_KERNEL_START=0xc0000000
> # CONFIG_TASK_SIZE_BOOL is not set
> CONFIG_TASK_SIZE=0x80000000
> # CONFIG_CONSISTENT_START_BOOL is not set
> CONFIG_CONSISTENT_START=0xff100000
> # CONFIG_CONSISTENT_SIZE_BOOL is not set
> CONFIG_CONSISTENT_SIZE=0x00200000
> # CONFIG_BOOT_LOAD_BOOL is not set
> CONFIG_BOOT_LOAD=0x00400000
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> # CONFIG_FW_LOADER is not set
> # CONFIG_DEBUG_DRIVER is not set
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
> 
> #
> # Plug and Play support
> #
> 
> #
> # Block devices
> #
> # CONFIG_BLK_DEV_FD is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=y
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=8192
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> # CONFIG_LBD is not set
> # CONFIG_CDROM_PKTCDVD is not set
> 
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> # CONFIG_ATA_OVER_ETH is not set
> 
> #
> # ATA/ATAPI/MFM/RLL support
> #
> # CONFIG_IDE is not set
> 
> #
> # SCSI device support
> #
> # CONFIG_SCSI is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> 
> #
> # Fusion MPT device support
> #
> 
> #
> # IEEE 1394 (FireWire) support
> #
> 
> #
> # I2O device support
> #
> 
> #
> # Macintosh device drivers
> #
> 
> #
> # Networking support
> #
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_NETLINK_DEV=y
> CONFIG_UNIX=y
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_VERBOSE=y
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_TUNNEL=y
> CONFIG_IP_TCPDIAG=y
> # CONFIG_IP_TCPDIAG_IPV6 is not set
> # CONFIG_IPV6 is not set
> # CONFIG_NETFILTER is not set
> CONFIG_XFRM=y
> # CONFIG_XFRM_USER is not set
> 
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_SCTP is not set
> # CONFIG_ATM is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> 
> #
> # QoS and/or fair queueing
> #
> CONFIG_NET_SCHED=y
> CONFIG_NET_SCH_CLK_JIFFIES=y
> # CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
> # CONFIG_NET_SCH_CLK_CPU is not set
> CONFIG_NET_SCH_CBQ=m
> CONFIG_NET_SCH_HTB=m
> # CONFIG_NET_SCH_HFSC is not set
> CONFIG_NET_SCH_PRIO=m
> CONFIG_NET_SCH_RED=m
> CONFIG_NET_SCH_SFQ=m
> CONFIG_NET_SCH_TEQL=m
> CONFIG_NET_SCH_TBF=m
> CONFIG_NET_SCH_GRED=m
> CONFIG_NET_SCH_DSMARK=m
> # CONFIG_NET_SCH_NETEM is not set
> CONFIG_NET_SCH_INGRESS=m
> CONFIG_NET_QOS=y
> CONFIG_NET_ESTIMATOR=y
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_TCINDEX=m
> CONFIG_NET_CLS_ROUTE4=m
> CONFIG_NET_CLS_ROUTE=y
> CONFIG_NET_CLS_FW=m
> CONFIG_NET_CLS_U32=m
> # CONFIG_CLS_U32_PERF is not set
> # CONFIG_NET_CLS_IND is not set
> CONFIG_NET_CLS_RSVP=m
> CONFIG_NET_CLS_RSVP6=m
> # CONFIG_NET_CLS_ACT is not set
> CONFIG_NET_CLS_POLICE=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> CONFIG_NETDEVICES=y
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_ETHERTAP is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> # CONFIG_NET_ETHERNET is not set
> # CONFIG_IBM_EMAC is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> 
> #
> # Ethernet (10000 Mbit)
> #
> 
> #
> # Token Ring devices
> #
> 
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> # CONFIG_SHAPER is not set
> # CONFIG_NETCONSOLE is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> 
> #
> # Input device support
> #
> # CONFIG_INPUT is not set
> 
> #
> # Userland interfaces
> #
> 
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=y
> # CONFIG_SERIO is not set
> # CONFIG_SERIO_I8042 is not set
> 
> #
> # Input Device Drivers
> #
> 
> #
> # Character devices
> #
> # CONFIG_VT is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> 
> #
> # IPMI
> #
> CONFIG_IPMI_HANDLER=m
> # CONFIG_IPMI_PANIC_EVENT is not set
> CONFIG_IPMI_DEVICE_INTERFACE=m
> # CONFIG_IPMI_SI is not set
> CONFIG_IPMI_WATCHDOG=m
> # CONFIG_IPMI_POWEROFF is not set
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_NVRAM is not set
> # CONFIG_GEN_RTC is not set
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_AGP is not set
> # CONFIG_DRM is not set
> # CONFIG_RAW_DRIVER is not set
> 
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> 
> #
> # Dallas's 1-wire bus
> #
> # CONFIG_W1 is not set
> 
> #
> # Misc devices
> #
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
> 
> #
> # Graphics support
> #
> # CONFIG_FB is not set
> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> 
> #
> # Sound
> #
> # CONFIG_SOUND is not set
> 
> #
> # USB support
> #
> # CONFIG_USB_ARCH_HAS_HCD is not set
> # CONFIG_USB_ARCH_HAS_OHCI is not set
> 
> #
> # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
> #
> 
> #
> # USB Gadget Support
> #
> # CONFIG_USB_GADGET is not set
> 
> #
> # MMC/SD Card support
> #
> # CONFIG_MMC is not set
> 
> #
> # InfiniBand support
> #
> # CONFIG_INFINIBAND is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> # CONFIG_EXT2_FS_XATTR is not set
> # CONFIG_EXT3_FS is not set
> # CONFIG_JBD is not set
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_QUOTA is not set
> CONFIG_DNOTIFY=y
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> 
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> # CONFIG_UDF_FS is not set
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_NTFS_FS is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_SYSFS=y
> # CONFIG_DEVFS_FS is not set
> # CONFIG_DEVPTS_FS_XATTR is not set
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_XATTR is not set
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_RAMFS=y
> 
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> 
> #
> # Network File Systems
> #
> # CONFIG_NFS_FS is not set
> # CONFIG_NFSD is not set
> # CONFIG_EXPORTFS is not set
> # CONFIG_SMB_FS is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> # CONFIG_NLS_CODEPAGE_437 is not set
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ASCII is not set
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_UTF8 is not set
> 
> #
> # IBM 40x options
> #
> 
> #
> # Library routines
> #
> CONFIG_CRC_CCITT=y
> CONFIG_CRC32=y
> # CONFIG_LIBCRC32C is not set
> 
> #
> # Profiling support
> #
> # CONFIG_PROFILING is not set
> 
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=y
> # CONFIG_MAGIC_SYSRQ is not set
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_DEBUG_KOBJECT is not set
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_DEBUG_FS is not set
> # CONFIG_KGDB is not set
> # CONFIG_XMON is not set
> CONFIG_BDI_SWITCH=y
> # CONFIG_SERIAL_TEXT_DEBUG is not set
> CONFIG_PPC_OCP=y
> 
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY is not set
> 
> #
> # Cryptographic options
> #
> # CONFIG_CRYPTO is not set
> 
> #
> # Hardware crypto devices
> #
