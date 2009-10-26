Return-Path: <swdebug@gmail.com>
Received: from mail-px0-f199.google.com (mail-px0-f199.google.com
	[209.85.216.199]) by ozlabs.org (Postfix) with ESMTP id 6749EB7BD8
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Oct 2009 17:49:17 +1100 (EST)
Received: by pxi37 with SMTP id 37so2423680pxi.15
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Oct 2009 23:49:16 -0700 (PDT)
Date: Mon, 26 Oct 2009 14:49:09 +0800
From: swdebug <swdebug@gmail.com>
To: "wilbur.chan" <wilbur512@gmail.com>
Subject: Re: How to mount rootfs though harddisk when booting?
In-Reply-To: <e997b7420910242043q63ad7024g74dc75f97b16a8a0@mail.gmail.com>
References: <e997b7420910242027y6c7d3ed9qde7a7ca552b4be9b@mail.gmail.com>
	<e997b7420910242043q63ad7024g74dc75f97b16a8a0@mail.gmail.com>
Message-Id: <20091026144901.5AEA.DF7FEE79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


VFS: Cannot open root device "sda3" or unknown-block(0,0)

# CONFIG_EXT3_FS is not set

Please add the ext2 & ext3 filesystem support.


On Sun, 25 Oct 2009 11:43:20 +0800
"wilbur.chan" <wilbur512@gmail.com> wrote:

> Sorry, the config I just post is somewhat confusing, here I post my
> config again.Thx
> 
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.21.7-EMBSYS-CGEL-3.06.10.P2.F0.B4
> # Sun Oct 25 11:24:25 2009
> #
> # CONFIG_PPC64 is not set
> CONFIG_PPC32=y
> CONFIG_PPC_MERGE=y
> CONFIG_MMU=y
> CONFIG_GENERIC_TIME=y
> CONFIG_GENERIC_HARDIRQS=y
> CONFIG_IRQ_PER_CPU=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_ARCH_HAS_ILOG2_U32=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_GENERIC_FIND_NEXT_BIT=y
> CONFIG_PPC=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_GENERIC_NVRAM=y
> CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_PPC_OF=y
> CONFIG_PPC_UDBG_16550=y
> CONFIG_GENERIC_TBSYNC=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_GENERIC_BUG=y
> CONFIG_DEFAULT_UIMAGE=y
> 
> #
> # Processor support
> #
> # CONFIG_CLASSIC32 is not set
> # CONFIG_PPC_512x is not set
> # CONFIG_PPC_82xx is not set
> # CONFIG_PPC_83xx is not set
> CONFIG_PPC_85xx=y
> # CONFIG_PPC_86xx is not set
> # CONFIG_PPC_8xx is not set
> # CONFIG_40x is not set
> # CONFIG_44x is not set
> # CONFIG_E200 is not set
> CONFIG_85xx=y
> CONFIG_E500=y
> # CONFIG_PPC_DCR_NATIVE is not set
> # CONFIG_PPC_DCR_MMIO is not set
> CONFIG_BOOKE=y
> CONFIG_FSL_BOOKE=y
> # CONFIG_PHYS_64BIT is not set
> CONFIG_SPE=y
> CONFIG_SMP=y
> CONFIG_NR_CPUS=2
> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_LOCK_KERNEL=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> 
> #
> # General setup
> #
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> # CONFIG_IPC_NS is not set
> CONFIG_SYSVIPC_SYSCTL=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_BSD_PROCESS_ACCT=y
> # CONFIG_BSD_PROCESS_ACCT_V3 is not set
> # CONFIG_TASKSTATS is not set
> # CONFIG_UTS_NS is not set
> CONFIG_AUDIT=y
> # CONFIG_AUDITSYSCALL is not set
> # CONFIG_WRS_FCHECK is not set
> # CONFIG_EVLOG is not set
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> # CONFIG_CONTAINER_DEBUG is not set
> # CONFIG_CPUSETS is not set
> # CONFIG_RSS_CONTAINER is not set
> CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_FAIR_USER_SCHED=y
> # CONFIG_FAIR_CGROUP_SCHED is not set
> CONFIG_SYSFS_DEPRECATED=y
> # CONFIG_CONTAINER_CPUACCT is not set
> # CONFIG_RELAY is not set
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_HWTIMER_HOOKS=y
> # CONFIG_HWTIMER_TEST is not set
> # CONFIG_HIGH_PRIO_OOMKILL is not set
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=y
> CONFIG_EMBEDDED=y
> CONFIG_SYSCTL_SYSCALL=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_EXTRA_PASS=y
> CONFIG_HOTPLUG=y
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_SHMEM=y
> CONFIG_SLAB=y
> CONFIG_VM_EVENT_COUNTERS=y
> # CONFIG_ALWAYS_RESTART is not set
> CONFIG_SIGEXIT=y
> CONFIG_MEMMON=y
> # CONFIG_MEMMON_SWAP_SUPPORT is not set
> CONFIG_NOTIFY_SETTIME=y
> CONFIG_RT_MUTEXES=y
> # CONFIG_TINY_SHMEM is not set
> CONFIG_BASE_SMALL=0
> # CONFIG_SLOB is not set
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_KMOD=y
> CONFIG_STOP_MACHINE=y
> 
> #
> # Block layer
> #
> CONFIG_BLOCK=y
> CONFIG_LBD=y
> # CONFIG_BLK_DEV_IO_TRACE is not set
> # CONFIG_LSF is not set
> 
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> # CONFIG_DEFAULT_AS is not set
> # CONFIG_DEFAULT_DEADLINE is not set
> CONFIG_DEFAULT_CFQ=y
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED="cfq"
> # CONFIG_WANT_EARLY_SERIAL is not set
> 
> #
> # Platform support
> #
> # CONFIG_MPC8540_ADS is not set
> # CONFIG_MPC8560_ADS is not set
> # CONFIG_MPC85xx_CDS is not set
> # CONFIG_MPC85xx_MDS is not set
> # CONFIG_MPC8572_PC is not set
> CONFIG_MPC85xx_DS=y
> CONFIG_P2020=y
> CONFIG_MPC85xx=y
> CONFIG_PPC_INDIRECT_PCI_BE=y
> CONFIG_MPIC=y
> 
> #
> # Kernel options
> #
> CONFIG_HIGHMEM=y
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> # CONFIG_GENERIC_CLOCKEVENTS is not set
> # CONFIG_TICK_ONESHOT is not set
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> # CONFIG_REAL_PREEMPT is not set
> # CONFIG_PREEMPT_SOFTIRQS is not set
> # CONFIG_PREEMPT_HARDIRQS is not set
> CONFIG_PREEMPT_BKL=y
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_MISC is not set
> CONFIG_MATH_EMULATION=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> # CONFIG_KEXEC is not set
> # CONFIG_IRQ_ALL_CPUS is not set
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_POPULATES_NODE_MAP=y
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_DISCONTIGMEM_MANUAL is not set
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> # CONFIG_SPARSEMEM_STATIC is not set
> CONFIG_SPLIT_PTLOCK_CPUS=4
> # CONFIG_RESOURCES_64BIT is not set
> CONFIG_ZONE_DMA_FLAG=1
> CONFIG_PROC_DEVICETREE=y
> # CONFIG_CMDLINE_BOOL is not set
> # CONFIG_PM is not set
> # CONFIG_SECCOMP is not set
> CONFIG_WANT_DEVICE_TREE=y
> CONFIG_DEVICE_TREE=""
> CONFIG_ISA_DMA_API=y
> 
> #
> # Bus options
> #
> CONFIG_ZONE_DMA=y
> # CONFIG_MPIC_WEIRD is not set
> CONFIG_PPC_I8259=y
> CONFIG_PPC_INDIRECT_PCI=y
> CONFIG_FSL_SOC=y
> CONFIG_FSL_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_PCIEPORTBUS=y
> 
> #
> # PCCARD (PCMCIA/CardBus) support
> #
> # CONFIG_PCCARD is not set
> 
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # Advanced setup
> #
> # CONFIG_ADVANCED_OPTIONS is not set
> 
> #
> # Default settings for advanced configuration options are used
> #
> CONFIG_HIGHMEM_START=0xfe000000
> CONFIG_LOWMEM_SIZE=0x30000000
> CONFIG_KERNEL_START=0xc0000000
> CONFIG_TASK_SIZE=0x80000000
> CONFIG_BOOT_LOAD=0x00800000
> 
> #
> # Networking
> #
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> # CONFIG_NETDEBUG is not set
> CONFIG_PACKET=y
> # CONFIG_PACKET_MMAP is not set
> CONFIG_UNIX=y
> # CONFIG_NET_KEY is not set
> # CONFIG_INTERPEAK is not set
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_FIB_HASH=y
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> CONFIG_IP_PNP_BOOTP=y
> CONFIG_IP_PNP_RARP=y
> CONFIG_NET_IPIP=y
> CONFIG_NET_IPGRE=y
> CONFIG_ARPD=y
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> # CONFIG_INET_XFRM_TUNNEL is not set
> CONFIG_INET_TUNNEL=y
> # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> # CONFIG_INET_XFRM_MODE_TUNNEL is not set
> # CONFIG_INET_XFRM_MODE_BEET is not set
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> # CONFIG_IPV6 is not set
> # CONFIG_INET6_XFRM_TUNNEL is not set
> # CONFIG_INET6_TUNNEL is not set
> # CONFIG_NETWORK_SECMARK is not set
> # CONFIG_NETFILTER is not set
> 
> #
> # DCCP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_DCCP is not set
> 
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_SCTP is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> 
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> # CONFIG_IEEE80211 is not set
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
> CONFIG_FW_LOADER=y
> # CONFIG_SYS_HYPERVISOR is not set
> 
> #
> # Connector - unified userspace <-> kernelspace linker
> #
> # CONFIG_CONNECTOR is not set
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Trueffs Device Driver (TFFS)
> #
> # CONFIG_TFFS is not set
> 
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
> 
> #
> # Plug and Play support
> #
> # CONFIG_PNPACPI is not set
> 
> #
> # Block devices
> #
> # CONFIG_BLK_DEV_FD is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> # CONFIG_BLK_DEV_LOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
> 
> #
> # Misc devices
> #
> # CONFIG_SGI_IOC4 is not set
> # CONFIG_TIFM_CORE is not set
> 
> #
> # ATA/ATAPI/MFM/RLL support
> #
> # CONFIG_IDE is not set
> 
> #
> # SCSI device support
> #
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI=y
> # CONFIG_SCSI_TGT is not set
> # CONFIG_SCSI_NETLINK is not set
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> # CONFIG_BLK_DEV_SR is not set
> # CONFIG_CHR_DEV_SG is not set
> # CONFIG_CHR_DEV_SCH is not set
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> # CONFIG_SCSI_MULTI_LUN is not set
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> # CONFIG_SCSI_SCAN_ASYNC is not set
> 
> #
> # SCSI Transports
> #
> # CONFIG_SCSI_SPI_ATTRS is not set
> # CONFIG_SCSI_FC_ATTRS is not set
> # CONFIG_SCSI_ISCSI_ATTRS is not set
> # CONFIG_SCSI_SAS_ATTRS is not set
> # CONFIG_SCSI_SAS_LIBSAS is not set
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_STEX is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_FC is not set
> # CONFIG_SCSI_QLA_ISCSI is not set
> # CONFIG_SCSI_LPFC is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_SRP is not set
> 
> #
> # Serial ATA (prod) and Parallel ATA (experimental) drivers
> #
> CONFIG_ATA=y
> # CONFIG_ATA_NONSTANDARD is not set
> CONFIG_SATA_AHCI=y
> CONFIG_SATA_SVW=y
> CONFIG_ATA_PIIX=y
> CONFIG_SATA_MV=y
> CONFIG_SATA_NV=y
> CONFIG_PDC_ADMA=y
> CONFIG_SATA_QSTOR=y
> CONFIG_SATA_PROMISE=y
> CONFIG_SATA_SX4=y
> CONFIG_SATA_SIL=y
> CONFIG_SATA_SIL24=y
> CONFIG_SATA_SIS=y
> CONFIG_SATA_ULI=y
> CONFIG_SATA_VIA=y
> CONFIG_SATA_VITESSE=y
> CONFIG_SATA_INIC162X=y
> CONFIG_PATA_ALI=y
> CONFIG_PATA_AMD=y
> CONFIG_PATA_ARTOP=y
> CONFIG_PATA_ATIIXP=y
> CONFIG_PATA_CMD64X=y
> CONFIG_PATA_CS5520=y
> CONFIG_PATA_CS5530=y
> CONFIG_PATA_CYPRESS=y
> CONFIG_PATA_EFAR=y
> CONFIG_ATA_GENERIC=y
> CONFIG_PATA_HPT366=y
> CONFIG_PATA_HPT37X=y
> CONFIG_PATA_HPT3X2N=y
> CONFIG_PATA_HPT3X3=y
> CONFIG_PATA_IT821X=y
> CONFIG_PATA_IT8213=y
> CONFIG_PATA_JMICRON=y
> CONFIG_PATA_TRIFLEX=y
> CONFIG_PATA_MARVELL=y
> CONFIG_PATA_MPIIX=y
> CONFIG_PATA_OLDPIIX=y
> CONFIG_PATA_NETCELL=y
> CONFIG_PATA_NS87410=y
> CONFIG_PATA_OPTI=y
> CONFIG_PATA_OPTIDMA=y
> CONFIG_PATA_PDC_OLD=y
> CONFIG_PATA_RADISYS=y
> CONFIG_PATA_RZ1000=y
> CONFIG_PATA_SC1200=y
> CONFIG_PATA_SERVERWORKS=y
> CONFIG_PATA_PDC2027X=y
> CONFIG_PATA_SIL680=y
> CONFIG_PATA_SIS=y
> CONFIG_PATA_VIA=y
> CONFIG_PATA_WINBOND=y
> CONFIG_PATA_PLATFORM=y
> 
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> 
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> # CONFIG_FUSION_SPI is not set
> # CONFIG_FUSION_FC is not set
> # CONFIG_FUSION_SAS is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_IEEE1394 is not set
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> 
> #
> # Macintosh device drivers
> #
> # CONFIG_MAC_EMUMOUSEBTN is not set
> # CONFIG_WINDFARM is not set
> 
> #
> # Network device support
> #
> CONFIG_NETDEVICES=y
> CONFIG_DUMMY=y
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> 
> #
> # PHY device support
> #
> CONFIG_PHYLIB=y
> 
> #
> # MII PHY device drivers
> #
> # CONFIG_MARVELL_PHY is not set
> # CONFIG_DAVICOM_PHY is not set
> # CONFIG_QSEMI_PHY is not set
> # CONFIG_LXT_PHY is not set
> # CONFIG_CICADA_PHY is not set
> CONFIG_VITESSE_PHY=y
> # CONFIG_VITESSE_7385 is not set
> # CONFIG_SMSC_PHY is not set
> # CONFIG_BROADCOM_PHY is not set
> # CONFIG_FIXED_PHY is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> CONFIG_MII=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NET_VENDOR_3COM is not set
> 
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> # CONFIG_HP100 is not set
> CONFIG_NET_PCI=y
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_B44 is not set
> # CONFIG_FORCEDETH is not set
> # CONFIG_DGRS is not set
> # CONFIG_EEPRO100 is not set
> # CONFIG_E100 is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
> # CONFIG_SC92031 is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_CAVIUM_ETHERNET is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_E1000E is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SIS190 is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_VIA_VELOCITY is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2 is not set
> CONFIG_GIANFAR=y
> CONFIG_GFAR_NAPI=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_ATL1 is not set
> 
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_IXGB is not set
> # CONFIG_S2IO is not set
> # CONFIG_MYRI10GE is not set
> # CONFIG_NETXEN_NIC is not set
> 
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
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
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> # CONFIG_NET_FC is not set
> # CONFIG_SHAPER is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
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
> CONFIG_INPUT=y
> # CONFIG_INPUT_FF_MEMLESS is not set
> 
> #
> # Userland interfaces
> #
> # CONFIG_INPUT_MOUSEDEV is not set
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> # CONFIG_INPUT_KEYBOARD is not set
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> # CONFIG_SERIO_I8042 is not set
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> # CONFIG_GAMEPORT is not set
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
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_NR_UARTS=2
> CONFIG_SERIAL_8250_RUNTIME_UARTS=2
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> CONFIG_SERIAL_8250_DETECT_IRQ=y
> CONFIG_SERIAL_8250_RSA=y
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> # CONFIG_SERIAL_OF_PLATFORM is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> # CONFIG_IPMI_HANDLER is not set
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_HW_RANDOM is not set
> CONFIG_NVRAM=y
> CONFIG_GEN_RTC=y
> CONFIG_GEN_RTC_X=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_AGP is not set
> # CONFIG_DRM is not set
> # CONFIG_RAW_DRIVER is not set
> 
> #
> # TPM devices
> #
> # CONFIG_TCG_TPM is not set
> 
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> 
> #
> # SPI support
> #
> # CONFIG_SPI is not set
> # CONFIG_SPI_MASTER is not set
> 
> #
> # Dallas's 1-wire bus
> #
> # CONFIG_W1 is not set
> 
> #
> # Hardware Monitoring support
> #
> # CONFIG_HWMON is not set
> # CONFIG_HWMON_VID is not set
> 
> #
> # Multifunction device drivers
> #
> # CONFIG_MFD_SM501 is not set
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
> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> # CONFIG_FB is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> 
> #
> # Sound
> #
> # CONFIG_SOUND is not set
> 
> #
> # HID Devices
> #
> # CONFIG_HID is not set
> 
> #
> # USB support
> #
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB_ARCH_HAS_OHCI=y
> CONFIG_USB_ARCH_HAS_EHCI=y
> # CONFIG_USB is not set
> 
> #
> # Enable Host or Gadget support to see Inventra options
> #
> 
> #
> # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
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
> # LED devices
> #
> # CONFIG_NEW_LEDS is not set
> 
> #
> # LED drivers
> #
> 
> #
> # LED Triggers
> #
> 
> #
> # InfiniBand support
> #
> # CONFIG_INFINIBAND is not set
> 
> #
> # EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
> #
> 
> #
> # Real Time Clock
> #
> CONFIG_RTC_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> # CONFIG_RTC_DEBUG is not set
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> 
> #
> # RTC drivers
> #
> # CONFIG_RTC_DRV_CMOS is not set
> # CONFIG_RTC_DRV_DS1553 is not set
> # CONFIG_RTC_DRV_DS1742 is not set
> # CONFIG_RTC_DRV_M48T86 is not set
> # CONFIG_RTC_DRV_TEST is not set
> # CONFIG_RTC_DRV_V3020 is not set
> # CONFIG_RTC_DRV_MPC5200 is not set
> # CONFIG_RTC_DRV_MPC512x is not set
> 
> #
> # Controller Area Network
> #
> # CONFIG_CAN_DEV is not set
> 
> #
> # DMA Engine support
> #
> # CONFIG_DMA_ENGINE is not set
> 
> #
> # DMA Clients
> #
> 
> #
> # DMA Devices
> #
> 
> #
> # Auxiliary Display support
> #
> 
> #
> # Virtualization
> #
> 
> #
> # Userspace I/O
> #
> # CONFIG_UIO is not set
> 
> #
> # Command Line Interface (KCLI)
> #
> # CONFIG_KCLI is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> # CONFIG_EXT2_FS_SECURITY is not set
> # CONFIG_EXT2_FS_XIP is not set
> # CONFIG_EXT3_FS is not set
> # CONFIG_EXT4DEV_FS is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> CONFIG_FS_POSIX_ACL=y
> # CONFIG_XFS_FS is not set
> # CONFIG_GFS2_FS is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_INOTIFY is not set
> # CONFIG_QUOTA is not set
> # CONFIG_DNOTIFY is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_FUSE_FS is not set
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
> # CONFIG_MSDOS_FS is not set
> # CONFIG_VFAT_FS is not set
> # CONFIG_NTFS_FS is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_SYSCTL=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> # CONFIG_TMPFS_ROOT is not set
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_RAMFS=y
> # CONFIG_CONFIGFS_FS is not set
> 
> #
> # Layered filesystems
> #
> # CONFIG_UNION_FS is not set
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
> CONFIG_NFS_FS=y
> CONFIG_NFS_DEF_FILE_IO_SIZE=4096
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=y
> # CONFIG_NFS_DIRECTIO is not set
> CONFIG_NFSD=y
> # CONFIG_NFSD_V3 is not set
> CONFIG_NFSD_TCP=y
> CONFIG_ROOT_NFS=y
> CONFIG_ROOT_NFS_PATH=""
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_EXPORTFS=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=y
> CONFIG_RPCSEC_GSS_KRB5=y
> # CONFIG_RPCSEC_GSS_SPKM3 is not set
> # CONFIG_SMB_FS is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
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
> # CONFIG_NLS is not set
> 
> #
> # Distributed Lock Manager
> #
> # CONFIG_DLM is not set
> 
> #
> # Watchpoint Support
> #
> # CONFIG_HARDWARE_WATCHPOINTS is not set
> 
> #
> # Library routines
> #
> CONFIG_BITREVERSE=y
> # CONFIG_CRC_CCITT is not set
> # CONFIG_CRC16 is not set
> CONFIG_CRC32=y
> CONFIG_LIBCRC32C=m
> CONFIG_PLIST=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT=y
> 
> #
> # Semaphore support priority inherit
> #
> # CONFIG_SEMAPHORE_PI is not set
> 
> #
> # Kernel Exception Processing
> #
> CONFIG_KERN_EXC=y
> CONFIG_KERNEXC_TRYCATCH=y
> CONFIG_KERN_EXC_RECORD_TIMES=6
> 
> #
> # Kernel Exception Information Dump Mode
> #
> CONFIG_KERN_EXC_DUMP_FILE=y
> CONFIG_KERN_EXC_DUMP_CONSOLE=y
> CONFIG_KERN_EXC_DUMP_BBX=y
> CONFIG_SYS_BBX_SIZE=6
> # CONFIG_KERN_EXC_COREDUMP is not set
> 
> #
> # Based On Lsp Packet Compile
> #
> CONFIG_LSP_PROJECT_COMPILE=y
> 
> #
> # Realtime Workqueue
> #
> # CONFIG_RT_WQ is not set
> 
> #
> # mux config
> #
> # CONFIG_V2LIN_MUX_SUPPORT is not set
> 
> #
> # Allocate Pages at brk/mmap
> #
> # CONFIG_MAPPING_ALLOC is not set
> 
> #
> # standard kernel tools configuration
> #
> # CONFIG_STANDARDKERTOOLS is not set
> 
> #
> # Page cache limit configuraion
> #
> # CONFIG_PAGECACHE_LIMIT is not set
> 
> #
> # Show mem information in detail
> #
> # CONFIG_MM_INFO is not set
> 
> #
> # Show the time task out off cpu
> #
> # CONFIG_TASKOUTCPU_STATISTICS is not set
> 
> #
> # Instrumentation Support
> #
> # CONFIG_PROFILING is not set
> # CONFIG_MARKERS is not set
> 
> #
> # Kernel hacking
> #
> # CONFIG_WRNOTE is not set
> # CONFIG_PRINTK_TIME is not set
> # CONFIG_BDI_SWITCH is not set
> # CONFIG_WR_OCD_DEBUG is not set
> CONFIG_ENABLE_MUST_CHECK=y
> # CONFIG_MAGIC_SYSRQ is not set
> # CONFIG_UNUSED_SYMBOLS is not set
> # CONFIG_DEBUG_FS is not set
> # CONFIG_HEADERS_CHECK is not set
> # CONFIG_DEBUG_KERNEL is not set
> CONFIG_LOG_BUF_SHIFT=15
> # CONFIG_DEBUG_BUGVERBOSE is not set
> # CONFIG_WANT_EXTRA_DEBUG_INFORMATION is not set
> # CONFIG_UNWIND_INFO is not set
> # CONFIG_KGDB_SSTEP_IRQS_LOCKED is not set
> # CONFIG_KGDB_ATTACH_WAIT is not set
> # CONFIG_BOOTX_TEXT is not set
> # CONFIG_PPC_EARLY_DEBUG is not set
> 
> #
> # Security options
> #
> 
> #
> # Grsecurity
> #
> # CONFIG_GRKERNSEC is not set
> 
> #
> # PaX
> #
> 
> #
> # Miscellaneous hardening features
> #
> # CONFIG_PAX_MEMORY_SANITIZE is not set
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY is not set
> 
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=y
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_BLKCIPHER=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_XCBC is not set
> # CONFIG_CRYPTO_NULL is not set
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=y
> # CONFIG_CRYPTO_SHA1 is not set
> # CONFIG_CRYPTO_SHA256 is not set
> # CONFIG_CRYPTO_SHA512 is not set
> # CONFIG_CRYPTO_WP512 is not set
> # CONFIG_CRYPTO_TGR192 is not set
> # CONFIG_CRYPTO_GF128MUL is not set
> # CONFIG_CRYPTO_ECB is not set
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_PCBC=m
> # CONFIG_CRYPTO_LRW is not set
> CONFIG_CRYPTO_DES=y
> # CONFIG_CRYPTO_FCRYPT is not set
> # CONFIG_CRYPTO_BLOWFISH is not set
> # CONFIG_CRYPTO_TWOFISH is not set
> # CONFIG_CRYPTO_SERPENT is not set
> # CONFIG_CRYPTO_AES is not set
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST6 is not set
> # CONFIG_CRYPTO_TEA is not set
> # CONFIG_CRYPTO_ARC4 is not set
> # CONFIG_CRYPTO_KHAZAD is not set
> # CONFIG_CRYPTO_ANUBIS is not set
> # CONFIG_CRYPTO_DEFLATE is not set
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> # CONFIG_CRYPTO_CRC32C is not set
> # CONFIG_CRYPTO_CAMELLIA is not set
> # CONFIG_CRYPTO_TEST is not set
> 
> #
> # Hardware crypto devices
> #
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
swdebug <swdebug@gmail.com>
