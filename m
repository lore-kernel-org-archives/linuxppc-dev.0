Return-Path: <john.bonesio@xilinx.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C522267A66
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 05:15:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: xilinx ml403 with 2.6 Kernel
Date: Tue, 20 Jun 2006 11:42:00 -0700
Message-ID: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC01C80E25@XSJ-EXCHVS1.xlnx.xilinx.com>
From: "John Bonesio" <john.bonesio@xilinx.com>
To: =?iso-8859-1?Q?=22Karl_Pr=FCfer=22?= <heiguga@gmx.net>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Support for linux 2.6 from the EDK tools does not yet work. Xilinx has =
contracted MontaVista to create an LSP for the ML40x development boards =
for MVL Pro 4.0 (which uses the 2.6.10 kernel). The LSP is anticipated =
to be available sometime before the end of this month.

The use of xparameters_ml403.h does not provide the complete solution =
for building linux 2.6 on the ml403 board.

- John

-----Original Message-----
From: linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org] On =
Behalf Of "Karl Pr=FCfer"
Sent: Thursday, June 15, 2006 6:08 AM
To: linuxppc-embedded@ozlabs.org
Subject: Re: xilinx ml403 with 2.6 Kernel

Hello again!

I had a little mistake in my first mail.
I have copied the whole BSP...
Now i have tried to copy only the xparameters_ml403.h in =
arch/ppc/platforms/4xx/xparameters/ but get the same error!!

I would be more then happy when somebody could help me.

nice greetings Robert

-------- Original-Nachricht --------
Datum: Thu, 15 Jun 2006 12:20:55 +0200
Von: "Karl Pr=FCfer" <heiguga@gmx.net>
An: linuxppc-embedded@ozlabs.org
Betreff: xilinx ml403 with 2.6 Kernel

> Hallo!
>=20
> I am not perfect in english, so please forgice me my mistakes...
>=20
> I am trying to get the 2.6 kernel running on my ml403 board...
>=20
> 1. I downloaded paulus tree:
> cg-clone =
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> myprojectdir
>=20
>=20
> 2. I copied my Xilinx BSP in the kernel dir
> cp -ra <BSPDIR>/* <KERNELDIR>/
>=20
>=20
> 3. I configured the Makefile to use my crosscompiler and the ppc Arch.
> I have built a crosstoolchain for a 2.4.26 kernel in past (with  =
crosstool
> 0.42).
> I know that this toolchain works with a 2.4 kernel...
>=20
> Can i use this toolchain to compile the 2.6 kernel??
> Why do i need a kernel(some headers) to build the croostoolchain??
>=20
>=20
> 4. Then I configured the kernel:
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.17-rc5
> # Wed Jun 14 10:02:22 2006
> #
> CONFIG_MMU=3Dy
> CONFIG_GENERIC_HARDIRQS=3Dy
> CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> CONFIG_GENERIC_HWEIGHT=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> CONFIG_PPC=3Dy
> CONFIG_PPC32=3Dy
> CONFIG_GENERIC_NVRAM=3Dy
> CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
> CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=3Dy
> CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
>=20
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=3Dy
> CONFIG_BROKEN_ON_SMP=3Dy
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
>=20
> #
> # General setup
> #
> CONFIG_LOCALVERSION=3D""
> # CONFIG_LOCALVERSION_AUTO is not set
> # CONFIG_SWAP is not set
> CONFIG_SYSVIPC=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=3Dy
> # CONFIG_AUDIT is not set
> # CONFIG_IKCONFIG is not set
> # CONFIG_RELAY is not set
> CONFIG_INITRAMFS_SOURCE=3D""
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=3Dy
> # CONFIG_KALLSYMS_ALL is not set
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_HOTPLUG=3Dy
> CONFIG_PRINTK=3Dy
> CONFIG_BUG=3Dy
> CONFIG_ELF_CORE=3Dy
> CONFIG_BASE_FULL=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_SLAB=3Dy
> # CONFIG_TINY_SHMEM is not set
> CONFIG_BASE_SMALL=3D0
> # CONFIG_SLOB is not set
>=20
> #
> # Loadable module support
> #
> CONFIG_MODULES=3Dy
> CONFIG_MODULE_UNLOAD=3Dy
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_MODVERSIONS=3Dy
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_KMOD=3Dy
>=20
> #
> # Block layer
> #
> # CONFIG_LBD is not set
> # CONFIG_BLK_DEV_IO_TRACE is not set
> # CONFIG_LSF is not set
>=20
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=3Dy
> CONFIG_IOSCHED_AS=3Dy
> CONFIG_IOSCHED_DEADLINE=3Dy
> CONFIG_IOSCHED_CFQ=3Dy
> CONFIG_DEFAULT_AS=3Dy
> # CONFIG_DEFAULT_DEADLINE is not set
> # CONFIG_DEFAULT_CFQ is not set
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED=3D"anticipatory"
>=20
> #
> # Processor
> #
> # CONFIG_6xx is not set
> CONFIG_40x=3Dy
> # CONFIG_44x is not set
> # CONFIG_8xx is not set
> # CONFIG_E200 is not set
> # CONFIG_E500 is not set
> # CONFIG_MATH_EMULATION is not set
> # CONFIG_KEXEC is not set
> # CONFIG_CPU_FREQ is not set
> CONFIG_4xx=3Dy
> # CONFIG_WANT_EARLY_SERIAL is not set
>=20
> #
> # IBM 4xx options
> #
> # CONFIG_BUBINGA is not set
> # CONFIG_CPCI405 is not set
> # CONFIG_EP405 is not set
> # CONFIG_REDWOOD_5 is not set
> # CONFIG_REDWOOD_6 is not set
> # CONFIG_SYCAMORE is not set
> # CONFIG_WALNUT is not set
> # CONFIG_XILINX_ML300 is not set
> CONFIG_XILINX_ML403=3Dy
> CONFIG_IBM405_ERR77=3Dy
> CONFIG_IBM405_ERR51=3Dy
> CONFIG_XILINX_VIRTEX_4_FX=3Dy
> CONFIG_XILINX_VIRTEX=3Dy
> CONFIG_EMBEDDEDBOOT=3Dy
> # CONFIG_PPC4xx_DMA is not set
> CONFIG_PPC_GEN550=3Dy
> CONFIG_UART0_TTYS0=3Dy
> # CONFIG_UART0_TTYS1 is not set
> CONFIG_NOT_COHERENT_CACHE=3Dy
>=20
> #
> # Platform options
> #
> # CONFIG_PC_KEYBOARD is not set
> # CONFIG_HIGHMEM is not set
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=3Dy
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=3D250
> CONFIG_PREEMPT_NONE=3Dy
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> CONFIG_SELECT_MEMORY_MODEL=3Dy
> CONFIG_FLATMEM_MANUAL=3Dy
> # CONFIG_DISCONTIGMEM_MANUAL is not set
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=3Dy
> CONFIG_FLAT_NODE_MEM_MAP=3Dy
> # CONFIG_SPARSEMEM_STATIC is not set
> CONFIG_SPLIT_PTLOCK_CPUS=3D4
> CONFIG_BINFMT_ELF=3Dy
> # CONFIG_BINFMT_MISC is not set
> CONFIG_CMDLINE_BOOL=3Dy
> CONFIG_CMDLINE=3D"console=3DttyS0,9600 ip=3Doff =
root=3D/dev/xsysace/disc0/part3
> rw"
> # CONFIG_PM is not set
> # CONFIG_SOFTWARE_SUSPEND is not set
> CONFIG_SECCOMP=3Dy
> CONFIG_ISA_DMA_API=3Dy
>=20
> #
> # Bus options
> #
> # CONFIG_PPC_I8259 is not set
> # CONFIG_PCI is not set
> # CONFIG_PCI_DOMAINS is not set
>=20
> #
> # PCCARD (PCMCIA/CardBus) support
> #
> # CONFIG_PCCARD is not set
>=20
> #
> # Advanced setup
> #
> # CONFIG_ADVANCED_OPTIONS is not set
>=20
> #
> # Default settings for advanced configuration options are used
> #
> CONFIG_HIGHMEM_START=3D0xfe000000
> CONFIG_LOWMEM_SIZE=3D0x30000000
> CONFIG_KERNEL_START=3D0xc0000000
> CONFIG_TASK_SIZE=3D0x80000000
> CONFIG_CONSISTENT_START=3D0xff100000
> CONFIG_CONSISTENT_SIZE=3D0x00200000
> CONFIG_BOOT_LOAD=3D0x00400000
>=20
> #
> # Networking
> #
> CONFIG_NET=3Dy
>=20
> #
> # Networking options
> #
> # CONFIG_NETDEBUG is not set
> CONFIG_PACKET=3Dy
> # CONFIG_PACKET_MMAP is not set
> CONFIG_UNIX=3Dy
> CONFIG_XFRM=3Dy
> # CONFIG_XFRM_USER is not set
> # CONFIG_NET_KEY is not set
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_FIB_HASH=3Dy
> CONFIG_IP_PNP=3Dy
> CONFIG_IP_PNP_DHCP=3Dy
> CONFIG_IP_PNP_BOOTP=3Dy
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> CONFIG_SYN_COOKIES=3Dy
> CONFIG_INET_AH=3Dy
> CONFIG_INET_ESP=3Dy
> CONFIG_INET_IPCOMP=3Dy
> CONFIG_INET_XFRM_TUNNEL=3Dy
> CONFIG_INET_TUNNEL=3Dy
> CONFIG_INET_DIAG=3Dy
> CONFIG_INET_TCP_DIAG=3Dy
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_BIC=3Dy
> # CONFIG_IPV6 is not set
> # CONFIG_INET6_XFRM_TUNNEL is not set
> # CONFIG_INET6_TUNNEL is not set
> # CONFIG_NETFILTER is not set
>=20
> #
> # DCCP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_DCCP is not set
>=20
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_SCTP is not set
>=20
> #
> # TIPC Configuration (EXPERIMENTAL)
> #
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
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
>=20
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
>=20
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> # CONFIG_IEEE80211 is not set
>=20
> #
> # Device Drivers
> #
>=20
> #
> # Generic Driver Options
> #
> CONFIG_STANDALONE=3Dy
> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
> # CONFIG_FW_LOADER is not set
> # CONFIG_DEBUG_DRIVER is not set
>=20
> #
> # Connector - unified userspace <-> kernelspace linker
> #
> # CONFIG_CONNECTOR is not set
>=20
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
>=20
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
>=20
> #
> # Plug and Play support
> #
>=20
> #
> # Block devices
> #
> # CONFIG_BLK_DEV_FD is not set
> # CONFIG_BLK_DEV_COW_COMMON is not set
> # CONFIG_BLK_DEV_LOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> CONFIG_BLK_DEV_RAM=3Dy
> CONFIG_BLK_DEV_RAM_COUNT=3D16
> CONFIG_BLK_DEV_RAM_SIZE=3D4096
> # CONFIG_BLK_DEV_INITRD is not set
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
>=20
> #
> # ATA/ATAPI/MFM/RLL support
> #
> # CONFIG_IDE is not set
>=20
> #
> # SCSI device support
> #
> # CONFIG_RAID_ATTRS is not set
> # CONFIG_SCSI is not set
>=20
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
>=20
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
>=20
> #
> # IEEE 1394 (FireWire) support
> #
>=20
> #
> # I2O device support
> #
>=20
> #
> # Macintosh device drivers
> #
> # CONFIG_WINDFARM is not set
>=20
> #
> # Network device support
> #
> CONFIG_NETDEVICES=3Dy
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
>=20
> #
> # PHY device support
> #
> # CONFIG_PHYLIB is not set
>=20
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=3Dy
> # CONFIG_MII is not set
> # CONFIG_IBM_EMAC is not set
>=20
> #
> # Ethernet (1000 Mbit)
> #
>=20
> #
> # Ethernet (10000 Mbit)
> #
>=20
> #
> # Token Ring devices
> #
>=20
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
>=20
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> # CONFIG_SHAPER is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
>=20
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
>=20
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
>=20
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
>=20
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=3Dy
> CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
>=20
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=3Dy
> CONFIG_KEYBOARD_ATKBD=3Dy
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=3Dy
> # CONFIG_INPUT_UINPUT is not set
>=20
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> CONFIG_SERIO_SERPORT=3Dy
> CONFIG_SERIO_LIBPS2=3Dy
> # CONFIG_SERIO_RAW is not set
> # CONFIG_GAMEPORT is not set
>=20
> #
> # Character devices
> #
> CONFIG_VT=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_HW_CONSOLE=3Dy
> # CONFIG_SERIAL_NONSTANDARD is not set
>=20
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=3Dy
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_NR_UARTS=3D4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> # CONFIG_SERIAL_8250_EXTENDED is not set
>=20
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> CONFIG_UNIX98_PTYS=3Dy
> CONFIG_LEGACY_PTYS=3Dy
> CONFIG_LEGACY_PTY_COUNT=3D256
>=20
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
>=20
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_NVRAM is not set
> # CONFIG_GEN_RTC is not set
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
>=20
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_AGP is not set
> # CONFIG_RAW_DRIVER is not set
>=20
> #
> # TPM devices
> #
> # CONFIG_TCG_TPM is not set
> # CONFIG_TELCLOCK is not set
>=20
> #
> # I2C support
> #
> # CONFIG_I2C is not set
>=20
> #
> # SPI support
> #
> # CONFIG_SPI is not set
> # CONFIG_SPI_MASTER is not set
>=20
> #
> # Dallas's 1-wire bus
> #
> # CONFIG_W1 is not set
>=20
> #
> # Hardware Monitoring support
> #
> # CONFIG_HWMON is not set
> # CONFIG_HWMON_VID is not set
>=20
> #
> # Misc devices
> #
>=20
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> CONFIG_VIDEO_V4L2=3Dy
>=20
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
>=20
> #
> # Graphics support
> #
> # CONFIG_FB is not set
>=20
> #
> # Console display driver support
> #
> CONFIG_DUMMY_CONSOLE=3Dy
>=20
> #
> # Sound
> #
> # CONFIG_SOUND is not set
>=20
> #
> # USB support
> #
> # CONFIG_USB_ARCH_HAS_HCD is not set
> # CONFIG_USB_ARCH_HAS_OHCI is not set
> # CONFIG_USB_ARCH_HAS_EHCI is not set
>=20
> #
> # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
> #
>=20
> #
> # USB Gadget Support
> #
> # CONFIG_USB_GADGET is not set
>=20
> #
> # MMC/SD Card support
> #
> # CONFIG_MMC is not set
>=20
> #
> # LED devices
> #
> # CONFIG_NEW_LEDS is not set
>=20
> #
> # LED drivers
> #
>=20
> #
> # LED Triggers
> #
>=20
> #
> # InfiniBand support
> #
>=20
> #
> # EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
> #
>=20
> #
> # Real Time Clock
> #
> # CONFIG_RTC_CLASS is not set
>=20
> #
> # File systems
> #
> CONFIG_EXT2_FS=3Dy
> # CONFIG_EXT2_FS_XATTR is not set
> # CONFIG_EXT2_FS_XIP is not set
> CONFIG_EXT3_FS=3Dy
> CONFIG_EXT3_FS_XATTR=3Dy
> # CONFIG_EXT3_FS_POSIX_ACL is not set
> # CONFIG_EXT3_FS_SECURITY is not set
> CONFIG_JBD=3Dy
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=3Dy
> CONFIG_REISERFS_FS=3Dy
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> # CONFIG_REISERFS_FS_XATTR is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_FS_POSIX_ACL is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_INOTIFY=3Dy
> # CONFIG_QUOTA is not set
> CONFIG_DNOTIFY=3Dy
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_FUSE_FS is not set
>=20
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> # CONFIG_UDF_FS is not set
>=20
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=3Dy
> CONFIG_MSDOS_FS=3Dy
> CONFIG_VFAT_FS=3Dy
> CONFIG_FAT_DEFAULT_CODEPAGE=3D437
> CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
> # CONFIG_NTFS_FS is not set
>=20
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> # CONFIG_PROC_KCORE is not set
> CONFIG_SYSFS=3Dy
> CONFIG_TMPFS=3Dy
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_RAMFS=3Dy
> # CONFIG_CONFIGFS_FS is not set
>=20
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
>=20
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=3Dy
> CONFIG_NFS_V3=3Dy
> # CONFIG_NFS_V3_ACL is not set
> # CONFIG_NFS_V4 is not set
> # CONFIG_NFS_DIRECTIO is not set
> CONFIG_NFSD=3Dy
> # CONFIG_NFSD_V3 is not set
> # CONFIG_NFSD_TCP is not set
> # CONFIG_ROOT_NFS is not set
> CONFIG_LOCKD=3Dy
> CONFIG_LOCKD_V4=3Dy
> CONFIG_EXPORTFS=3Dy
> CONFIG_NFS_COMMON=3Dy
> CONFIG_SUNRPC=3Dy
> # CONFIG_RPCSEC_GSS_KRB5 is not set
> # CONFIG_RPCSEC_GSS_SPKM3 is not set
> # CONFIG_SMB_FS is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
>=20
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=3Dy
>=20
> #
> # Native Language Support
> #
> CONFIG_NLS=3Dy
> CONFIG_NLS_DEFAULT=3D"iso8859-1"
> CONFIG_NLS_CODEPAGE_437=3Dm
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
> CONFIG_NLS_ISO8859_1=3Dm
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
>=20
> #
> # IBM 40x options
> #
>=20
> #
> # Library routines
> #
> # CONFIG_CRC_CCITT is not set
> # CONFIG_CRC16 is not set
> # CONFIG_CRC32 is not set
> # CONFIG_LIBCRC32C is not set
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_ZLIB_DEFLATE=3Dy
> # CONFIG_PROFILING is not set
>=20
> #
> # Kernel hacking
> #
> # CONFIG_PRINTK_TIME is not set
> CONFIG_MAGIC_SYSRQ=3Dy
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_LOG_BUF_SHIFT=3D14
> CONFIG_DETECT_SOFTLOCKUP=3Dy
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_DEBUG_KOBJECT is not set
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_DEBUG_FS is not set
> # CONFIG_DEBUG_VM is not set
> CONFIG_FORCED_INLINING=3Dy
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_KGDB is not set
> # CONFIG_XMON is not set
> # CONFIG_BDI_SWITCH is not set
> # CONFIG_SERIAL_TEXT_DEBUG is not set
>=20
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY is not set
>=20
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=3Dy
> CONFIG_CRYPTO_HMAC=3Dy
> # CONFIG_CRYPTO_NULL is not set
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=3Dy
> CONFIG_CRYPTO_SHA1=3Dy
> # CONFIG_CRYPTO_SHA256 is not set
> # CONFIG_CRYPTO_SHA512 is not set
> # CONFIG_CRYPTO_WP512 is not set
> # CONFIG_CRYPTO_TGR192 is not set
> CONFIG_CRYPTO_DES=3Dy
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
> CONFIG_CRYPTO_DEFLATE=3Dy
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> # CONFIG_CRYPTO_CRC32C is not set
> # CONFIG_CRYPTO_TEST is not set
>=20
> #
> # Hardware crypto devices
> #
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> 5. I tried to compile the kernel:
> make clean bzImage modules
>=20
> and get this error:
> # Temporary hack until we have migrated to asm-powerpc
>   CLEAN   /home/freaked/WORK/ppc_kernel_2_6_paulus
>   CLEAN   arch/ppc/kernel
>   CLEAN   init
>   CLEAN   usr
>   CLEAN   .tmp_versions
>   CLEAN   .tmp_gas_check
>   CHK     include/linux/version.h
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/split-include
>   HOSTCC  scripts/basic/docproc
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/kxgettext.o
>   HOSTCC  scripts/kconfig/mconf.o
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf -s arch/ppc/Kconfig
> #
> # using defaults found in .config
> #
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   CC      arch/ppc/kernel/asm-offsets.s
>   GEN     include/asm-ppc/asm-offsets.h
>   HOSTCC  scripts/genksyms/genksyms.o
>   HOSTCC  scripts/genksyms/lex.o
>   HOSTCC  scripts/genksyms/parse.o
>   HOSTLD  scripts/genksyms/genksyms
>   CC      scripts/mod/empty.o
>   HOSTCC  scripts/mod/mk_elfconfig
>   MKELF   scripts/mod/elfconfig.h
>   HOSTCC  scripts/mod/file2alias.o
>   HOSTCC  scripts/mod/modpost.o
>   HOSTCC  scripts/mod/sumversion.o
>   HOSTLD  scripts/mod/modpost
>   HOSTCC  scripts/kallsyms
>   HOSTCC  scripts/conmakehash
>   CC      init/main.o
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   CC      init/do_mounts.o
>   CC      init/do_mounts_rd.o
>   LD      init/mounts.o
>   CC      init/initramfs.o
>   CC      init/calibrate.o
>   LD      init/built-in.o
>   HOSTCC  usr/gen_init_cpio
>   GEN     usr/initramfs_data.cpio.gz
>   AS      usr/initramfs_data.o
>   LD      usr/built-in.o
>   AS      arch/ppc/kernel/entry.o
>   CC      arch/ppc/kernel/traps.o
>   CC      arch/ppc/kernel/time.o
>   AS      arch/ppc/kernel/misc.o
>   CC      arch/ppc/kernel/setup.o
>   CC      arch/ppc/kernel/ppc_htab.o
>   CC      arch/ppc/kernel/ppc_ksyms.o
>   CC      arch/ppc/kernel/dma-mapping.o
>   LD      arch/ppc/kernel/built-in.o
>   AS      arch/ppc/kernel/head_4xx.o
>   LDS     arch/ppc/kernel/vmlinux.lds
>   CC      arch/powerpc/kernel/semaphore.o
>   CC      arch/powerpc/kernel/cputable.o
>   CC      arch/powerpc/kernel/ptrace.o
>   CC      arch/powerpc/kernel/syscalls.o
>   CC      arch/powerpc/kernel/irq.o
>   CC      arch/powerpc/kernel/align.o
>   CC      arch/powerpc/kernel/signal_32.o
> arch/powerpc/kernel/signal_32.c: In function `handle_rt_signal':
> arch/powerpc/kernel/signal_32.c:763: error: request for member =
`vdso_base'
> in something not a structure or union
> arch/powerpc/kernel/signal_32.c:766: error: request for member =
`vdso_base'
> in something not a structure or union
> arch/powerpc/kernel/signal_32.c: In function `handle_signal':
> arch/powerpc/kernel/signal_32.c:1037: error: request for member
> `vdso_base' in something not a structure or union
> arch/powerpc/kernel/signal_32.c:1040: error: request for member
> `vdso_base' in something not a structure or union
> make[1]: *** [arch/powerpc/kernel/signal_32.o] Fehler 1
> make: *** [arch/powerpc/kernel] Fehler 2
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> Could someone please help me to interprete this error??
> Could someone send me an working .config file for the kernel?
>=20
> I would be more then happy when someone could help me!!
> Thanks in advanced!!
>=20
> greetings Robert Zach
> heiguga@gmx.net
>=20
>=20
> --=20
>=20
>=20
> Echte DSL-Flatrate dauerhaft f=FCr 0,- Euro*!
> "Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--=20


Echte DSL-Flatrate dauerhaft f=FCr 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
