Return-Path: <majid.khanmohammedzai@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 1CF4667B71
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Jun 2006 01:38:25 +1000 (EST)
Received: from il06exr03.mot.com (il06exr03.mot.com [129.188.137.133])
	by motgate8.mot.com (8.12.11/Motgate7) with ESMTP id k5FFcNej011430
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Jun 2006 08:38:24 -0700 (MST)
Received: from ZMY16EXM67.ds.mot.com (zmy16exm67.ap.mot.com [10.179.4.27])
	by il06exr03.mot.com (8.13.1/8.13.0) with ESMTP id k5FFcL04005716
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Jun 2006 10:38:22 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linuxppc-embedded Digest, Vol 22, Issue 32
Date: Thu, 15 Jun 2006 23:38:19 +0800
Message-ID: <77B86CB862744A48B3C9703CEBCC559FC136C0@ZMY16EXM67.ds.mot.com>
From: "MZ Majid Khan-amm117" <majid.khanmohammedzai@motorola.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Phil.
could you please send me the below Patch file.

Thanks.
Majid
------------------------------------------------------------------------
--------------
Hi guys,

I've written a DMA controller driver for the Marvell Discovery series
(particularly the MV64360, MV64460).  It is still a work-in-progress and
comes with many caveats, but I'm happy to share it should anyone be
interested.  Some of the caveats include:
  - does not support scatter-gather operations yet
  - quite limited testing has been performed to date

The 50 kb, 5000 line patch is usually applied to a 2.6.16 kernel which
has already been patched for use with Artesyn boards, particularly the
PmPPC7448, and affects the following files:

        linux-2.6.16/arch/ppc/Kconfig
        linux-2.6.16/arch/ppc/configs/pmppc744x_defconfig
        linux-2.6.16/arch/ppc/platforms/pmppc7447.c
        linux-2.6.16/arch/ppc/syslib/Makefile
        linux-2.6.16/arch/ppc/syslib/mv64x60.c
        linux-2.6.16/arch/ppc/syslib/mv64x6x_dma.c
        linux-2.6.16/include/asm-ppc/mv64x60.h
        linux-2.6.16/include/asm-ppc/mv64x60_defs.h
        linux-2.6.16/include/asm-ppc/mv64x6x_dma.h
        linux-2.6.16/include/linux/mv643xx.h
       =20
Please let me know if there is anyone would like me to post this patch,
and in what form I should do this.

--=20
Phil




------------------------------------------------------------------------
--------


Previous message: Init dies with unhandled signal 4=20
Next message: help with inittab=20
Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]=20

------------------------------------------------------------------------
--------
More information about the Linuxppc-embedded mailing list=20

-----Original Message-----
From:
linuxppc-embedded-bounces+majid.khanmohammedzai=3Dmotorola.com@ozlabs.org=

[mailto:linuxppc-embedded-bounces+majid.khanmohammedzai=3Dmotorola.com@oz=
l
abs.org] On Behalf Of linuxppc-embedded-request@ozlabs.org
Sent: Thursday, June 15, 2006 5:38 PM
To: linuxppc-embedded@ozlabs.org
Subject: Linuxppc-embedded Digest, Vol 22, Issue 32

Send Linuxppc-embedded mailing list submissions to
	linuxppc-embedded@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
or, via email, send a message with subject or body 'help' to
	linuxppc-embedded-request@ozlabs.org

You can reach the person managing the list at
	linuxppc-embedded-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific than
"Re: Contents of Linuxppc-embedded digest..."


Today's Topics:

   1. xilinx ml403 with 2.6 Kernel (Karl Pr?fer)
   2. Binding FCC interfaces to device names in reverse order
      (Laurent Pinchart)
   3. Re: xilinx ml403 with 2.6 Kernel (Karl Pr?fer)


----------------------------------------------------------------------

Message: 1
Date: Thu, 15 Jun 2006 12:20:55 +0200
From: "Karl Pr?fer" <heiguga@gmx.net>
Subject: xilinx ml403 with 2.6 Kernel
To: linuxppc-embedded@ozlabs.org
Message-ID: <20060615102055.39970@gmx.net>
Content-Type: text/plain; charset=3D"iso-8859-1"

Hallo!

I am not perfect in english, so please forgice me my mistakes...

I am trying to get the 2.6 kernel running on my ml403 board...

1. I downloaded paulus tree:
cg-clone
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
myprojectdir


2. I copied my Xilinx BSP in the kernel dir cp -ra <BSPDIR>/*
<KERNELDIR>/


3. I configured the Makefile to use my crosscompiler and the ppc Arch.
I have built a crosstoolchain for a 2.4.26 kernel in past (with
crosstool 0.42).
I know that this toolchain works with a 2.4 kernel...

Can i use this toolchain to compile the 2.6 kernel??
Why do i need a kernel(some headers) to build the croostoolchain??


4. Then I configured the kernel:
#
# Automatically generated make config: don't edit # Linux kernel
version: 2.6.17-rc5 # Wed Jun 14 10:02:22 2006 # CONFIG_MMU=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy CONFIG_GENERIC_CALIBRATE_DELAY=3Dy =
CONFIG_PPC=3Dy
CONFIG_PPC32=3Dy CONFIG_GENERIC_NVRAM=3Dy =
CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32

#
# General setup
#
CONFIG_LOCALVERSION=3D""
# CONFIG_LOCALVERSION_AUTO is not set
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=3Dy
CONFIG_POSIX_MQUEUE=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=3D""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set # CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=3Dy # CONFIG_KALLSYMS_ALL is not set #
CONFIG_KALLSYMS_EXTRA_PASS is not set CONFIG_HOTPLUG=3Dy =
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy CONFIG_ELF_CORE=3Dy CONFIG_BASE_FULL=3Dy CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy CONFIG_SHMEM=3Dy CONFIG_SLAB=3Dy # CONFIG_TINY_SHMEM is =
not
set CONFIG_BASE_SMALL=3D0 # CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=3Dy
# CONFIG_MODULE_SRCVERSION_ALL is not set CONFIG_KMOD=3Dy

#
# Block layer
#
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
CONFIG_DEFAULT_AS=3Dy
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"anticipatory"

#
# Processor
#
# CONFIG_6xx is not set
CONFIG_40x=3Dy
# CONFIG_44x is not set
# CONFIG_8xx is not set
# CONFIG_E200 is not set
# CONFIG_E500 is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_KEXEC is not set
# CONFIG_CPU_FREQ is not set
CONFIG_4xx=3Dy
# CONFIG_WANT_EARLY_SERIAL is not set

#
# IBM 4xx options
#
# CONFIG_BUBINGA is not set
# CONFIG_CPCI405 is not set
# CONFIG_EP405 is not set
# CONFIG_REDWOOD_5 is not set
# CONFIG_REDWOOD_6 is not set
# CONFIG_SYCAMORE is not set
# CONFIG_WALNUT is not set
# CONFIG_XILINX_ML300 is not set
CONFIG_XILINX_ML403=3Dy
CONFIG_IBM405_ERR77=3Dy
CONFIG_IBM405_ERR51=3Dy
CONFIG_XILINX_VIRTEX_4_FX=3Dy
CONFIG_XILINX_VIRTEX=3Dy
CONFIG_EMBEDDEDBOOT=3Dy
# CONFIG_PPC4xx_DMA is not set
CONFIG_PPC_GEN550=3Dy
CONFIG_UART0_TTYS0=3Dy
# CONFIG_UART0_TTYS1 is not set
CONFIG_NOT_COHERENT_CACHE=3Dy

#
# Platform options
#
# CONFIG_PC_KEYBOARD is not set
# CONFIG_HIGHMEM is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=3Dy
# CONFIG_HZ_1000 is not set
CONFIG_HZ=3D250
CONFIG_PREEMPT_NONE=3Dy
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_MISC is not set
CONFIG_CMDLINE_BOOL=3Dy
CONFIG_CMDLINE=3D"console=3DttyS0,9600 ip=3Doff =
root=3D/dev/xsysace/disc0/part3
rw"
# CONFIG_PM is not set
# CONFIG_SOFTWARE_SUSPEND is not set
CONFIG_SECCOMP=3Dy
CONFIG_ISA_DMA_API=3Dy

#
# Bus options
#
# CONFIG_PPC_I8259 is not set
# CONFIG_PCI is not set
# CONFIG_PCI_DOMAINS is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used #
CONFIG_HIGHMEM_START=3D0xfe000000 CONFIG_LOWMEM_SIZE=3D0x30000000
CONFIG_KERNEL_START=3D0xc0000000 CONFIG_TASK_SIZE=3D0x80000000
CONFIG_CONSISTENT_START=3D0xff100000
CONFIG_CONSISTENT_SIZE=3D0x00200000
CONFIG_BOOT_LOAD=3D0x00400000

#
# Networking
#
CONFIG_NET=3Dy

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=3Dy
CONFIG_XFRM=3Dy
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
CONFIG_IP_PNP=3Dy
CONFIG_IP_PNP_DHCP=3Dy
CONFIG_IP_PNP_BOOTP=3Dy
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=3Dy
CONFIG_INET_AH=3Dy
CONFIG_INET_ESP=3Dy
CONFIG_INET_IPCOMP=3Dy
CONFIG_INET_XFRM_TUNNEL=3Dy
CONFIG_INET_TUNNEL=3Dy
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=3Dy
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker # #
CONFIG_CONNECTOR is not set

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
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D4096
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set

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

#
# I2O device support
#

#
# Macintosh device drivers
#
# CONFIG_WINDFARM is not set

#
# Network device support
#
CONFIG_NETDEVICES=3Dy
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_MII is not set
# CONFIG_IBM_EMAC is not set

#
# Ethernet (1000 Mbit)
#

#
# Ethernet (10000 Mbit)
#

#
# Token Ring devices
#

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dy
CONFIG_SERIO_LIBPS2=3Dy
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_AGP is not set
# CONFIG_RAW_DRIVER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
CONFIG_VIDEO_V4L2=3Dy

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=3Dy

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB_ARCH_HAS_HCD is not set
# CONFIG_USB_ARCH_HAS_OHCI is not set
# CONFIG_USB_ARCH_HAS_EHCI is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
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
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL) #

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dy
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
CONFIG_REISERFS_FS=3Dy
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=3Dy
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=3Dy
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dy
CONFIG_VFAT_FS=3Dy
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
# CONFIG_PROC_KCORE is not set
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
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
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=3Dy
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
# CONFIG_ROOT_NFS is not set
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dy
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dm
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
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
CONFIG_NLS_ISO8859_1=3Dm
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
# CONFIG_NLS_UTF8 is not set

#
# IBM 40x options
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC32 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_DETECT_SOFTLOCKUP=3Dy
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set # CONFIG_DEBUG_KOBJECT is not
set # CONFIG_DEBUG_INFO is not set # CONFIG_DEBUG_FS is not set #
CONFIG_DEBUG_VM is not set CONFIG_FORCED_INLINING=3Dy #
CONFIG_RCU_TORTURE_TEST is not set # CONFIG_KGDB is not set #
CONFIG_XMON is not set # CONFIG_BDI_SWITCH is not set #
CONFIG_SERIAL_TEXT_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_SHA1=3Dy
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=3Dy
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=3Dy
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#







5. I tried to compile the kernel:
make clean bzImage modules

and get this error:
# Temporary hack until we have migrated to asm-powerpc
  CLEAN   /home/freaked/WORK/ppc_kernel_2_6_paulus
  CLEAN   arch/ppc/kernel
  CLEAN   init
  CLEAN   usr
  CLEAN   .tmp_versions
  CLEAN   .tmp_gas_check
  CHK     include/linux/version.h
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kxgettext.o
  HOSTCC  scripts/kconfig/mconf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -s arch/ppc/Kconfig # # using defaults found in
.config #
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      arch/ppc/kernel/asm-offsets.s
  GEN     include/asm-ppc/asm-offsets.h
  HOSTCC  scripts/genksyms/genksyms.o
  HOSTCC  scripts/genksyms/lex.o
  HOSTCC  scripts/genksyms/parse.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  CC      init/main.o
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
  CC      init/do_mounts_rd.o
  LD      init/mounts.o
  CC      init/initramfs.o
  CC      init/calibrate.o
  LD      init/built-in.o
  HOSTCC  usr/gen_init_cpio
  GEN     usr/initramfs_data.cpio.gz
  AS      usr/initramfs_data.o
  LD      usr/built-in.o
  AS      arch/ppc/kernel/entry.o
  CC      arch/ppc/kernel/traps.o
  CC      arch/ppc/kernel/time.o
  AS      arch/ppc/kernel/misc.o
  CC      arch/ppc/kernel/setup.o
  CC      arch/ppc/kernel/ppc_htab.o
  CC      arch/ppc/kernel/ppc_ksyms.o
  CC      arch/ppc/kernel/dma-mapping.o
  LD      arch/ppc/kernel/built-in.o
  AS      arch/ppc/kernel/head_4xx.o
  LDS     arch/ppc/kernel/vmlinux.lds
  CC      arch/powerpc/kernel/semaphore.o
  CC      arch/powerpc/kernel/cputable.o
  CC      arch/powerpc/kernel/ptrace.o
  CC      arch/powerpc/kernel/syscalls.o
  CC      arch/powerpc/kernel/irq.o
  CC      arch/powerpc/kernel/align.o
  CC      arch/powerpc/kernel/signal_32.o
arch/powerpc/kernel/signal_32.c: In function `handle_rt_signal':
arch/powerpc/kernel/signal_32.c:763: error: request for member
`vdso_base' in something not a structure or union
arch/powerpc/kernel/signal_32.c:766: error: request for member
`vdso_base' in something not a structure or union
arch/powerpc/kernel/signal_32.c: In function `handle_signal':
arch/powerpc/kernel/signal_32.c:1037: error: request for member
`vdso_base' in something not a structure or union
arch/powerpc/kernel/signal_32.c:1040: error: request for member
`vdso_base' in something not a structure or union
make[1]: *** [arch/powerpc/kernel/signal_32.o] Fehler 1
make: *** [arch/powerpc/kernel] Fehler 2







Could someone please help me to interprete this error??
Could someone send me an working .config file for the kernel?

I would be more then happy when someone could help me!!
Thanks in advanced!!

greetings Robert Zach
heiguga@gmx.net


--=20


Echte DSL-Flatrate dauerhaft f?r 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl


------------------------------

Message: 2
Date: Thu, 15 Jun 2006 13:59:02 +0200
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Binding FCC interfaces to device names in reverse order
To: linuxppc-embedded@ozlabs.org
Message-ID: <200606151359.02966.laurent.pinchart@tbox.biz>
Content-Type: text/plain;  charset=3D"us-ascii"

Hello,

I'm trying to change the order in which the MPC8248 FCC devices are
bound to network interface names.

The current behaviour is to handle FCC1, FCC2 and FCC3 in that order.
FCC1 is thus mapped to eth0 and FCC2 to eth1 (FCC3 is unused in my
design).

For some reason I'd like to map FCC2 to eth0 and FCC1 to eth1. Interface
names are allocated as devices are registered, so I thought I could
change the detection order by modifying the ppc_sys_platform_devices
array:

        ppc_sys_platform_devices[MPC82xx_CPM_FCC1].id =3D 2;
        ppc_sys_platform_devices[MPC82xx_CPM_FCC2].id =3D 1;

FCC devices detection is indeed reversed, and FCC2 is mapped to eth0.
Plugging a cable into the FCC2 socket prints a message referencing eth0,
and ifconfig confirms that eth0 is running.

Unfortunately, that's where things stop working. I can't ping FCC1 or
FCC2, no data is received by the kernel.

Does anyone know why changing the device ids breaks the fs_enet driver ?

Laurent Pinchart


------------------------------

Message: 3
Date: Thu, 15 Jun 2006 14:07:36 +0200
From: "Karl Pr?fer" <heiguga@gmx.net>
Subject: Re: xilinx ml403 with 2.6 Kernel
To: linuxppc-embedded@ozlabs.org
Message-ID: <20060615120736.40000@gmx.net>
Content-Type: text/plain; charset=3D"iso-8859-1"

Hello again!

I had a little mistake in my first mail.
I have copied the whole BSP...
Now i have tried to copy only the xparameters_ml403.h in
arch/ppc/platforms/4xx/xparameters/ but get the same error!!

I would be more then happy when somebody could help me.

nice greetings Robert

-------- Original-Nachricht --------
Datum: Thu, 15 Jun 2006 12:20:55 +0200
Von: "Karl Pr?fer" <heiguga@gmx.net>
An: linuxppc-embedded@ozlabs.org
Betreff: xilinx ml403 with 2.6 Kernel

> Hallo!
>=20
> I am not perfect in english, so please forgice me my mistakes...
>=20
> I am trying to get the 2.6 kernel running on my ml403 board...
>=20
> 1. I downloaded paulus tree:
> cg-clone=20
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> myprojectdir
>=20
>=20
> 2. I copied my Xilinx BSP in the kernel dir cp -ra <BSPDIR>/*=20
> <KERNELDIR>/
>=20
>=20
> 3. I configured the Makefile to use my crosscompiler and the ppc Arch.
> I have built a crosstoolchain for a 2.4.26 kernel in past (with =20
> crosstool 0.42).
> I know that this toolchain works with a 2.4 kernel...
>=20
> Can i use this toolchain to compile the 2.6 kernel??
> Why do i need a kernel(some headers) to build the croostoolchain??
>=20
>=20
> 4. Then I configured the kernel:
> #
> # Automatically generated make config: don't edit # Linux kernel=20
> version: 2.6.17-rc5 # Wed Jun 14 10:02:22 2006 # CONFIG_MMU=3Dy=20
> CONFIG_GENERIC_HARDIRQS=3Dy CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=20
> CONFIG_GENERIC_HWEIGHT=3Dy CONFIG_GENERIC_CALIBRATE_DELAY=3Dy =
CONFIG_PPC=3Dy

> CONFIG_PPC32=3Dy CONFIG_GENERIC_NVRAM=3Dy =
CONFIG_GENERIC_FIND_NEXT_BIT=3Dy=20
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
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set # CONFIG_EMBEDDED is not set=20
> CONFIG_KALLSYMS=3Dy # CONFIG_KALLSYMS_ALL is not set #=20
> CONFIG_KALLSYMS_EXTRA_PASS is not set CONFIG_HOTPLUG=3Dy =
CONFIG_PRINTK=3Dy

> CONFIG_BUG=3Dy CONFIG_ELF_CORE=3Dy CONFIG_BASE_FULL=3Dy =
CONFIG_FUTEX=3Dy=20
> CONFIG_EPOLL=3Dy CONFIG_SHMEM=3Dy CONFIG_SLAB=3Dy # CONFIG_TINY_SHMEM =
is not

> set CONFIG_BASE_SMALL=3D0 # CONFIG_SLOB is not set
>=20
> #
> # Loadable module support
> #
> CONFIG_MODULES=3Dy
> CONFIG_MODULE_UNLOAD=3Dy
> # CONFIG_MODULE_FORCE_UNLOAD is not set CONFIG_MODVERSIONS=3Dy #=20
> CONFIG_MODULE_SRCVERSION_ALL is not set CONFIG_KMOD=3Dy
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
> # CONFIG_DISCONTIGMEM_MANUAL is not set # CONFIG_SPARSEMEM_MANUAL is=20
> not set CONFIG_FLATMEM=3Dy CONFIG_FLAT_NODE_MEM_MAP=3Dy #=20
> CONFIG_SPARSEMEM_STATIC is not set
> CONFIG_SPLIT_PTLOCK_CPUS=3D4
> CONFIG_BINFMT_ELF=3Dy
> # CONFIG_BINFMT_MISC is not set
> CONFIG_CMDLINE_BOOL=3Dy
> CONFIG_CMDLINE=3D"console=3DttyS0,9600 ip=3Doff=20
> root=3D/dev/xsysace/disc0/part3 rw"
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
> # Default settings for advanced configuration options are used #=20
> CONFIG_HIGHMEM_START=3D0xfe000000 CONFIG_LOWMEM_SIZE=3D0x30000000=20
> CONFIG_KERNEL_START=3D0xc0000000 CONFIG_TASK_SIZE=3D0x80000000=20
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
> # CONFIG_IP_ADVANCED_ROUTER is not set CONFIG_IP_FIB_HASH=3Dy=20
> CONFIG_IP_PNP=3Dy CONFIG_IP_PNP_DHCP=3Dy CONFIG_IP_PNP_BOOTP=3Dy #=20
> CONFIG_IP_PNP_RARP is not set # CONFIG_NET_IPIP is not set #=20
> CONFIG_NET_IPGRE is not set # CONFIG_IP_MROUTE is not set #=20
> CONFIG_ARPD is not set CONFIG_SYN_COOKIES=3Dy CONFIG_INET_AH=3Dy=20
> CONFIG_INET_ESP=3Dy CONFIG_INET_IPCOMP=3Dy CONFIG_INET_XFRM_TUNNEL=3Dy =

> CONFIG_INET_TUNNEL=3Dy CONFIG_INET_DIAG=3Dy CONFIG_INET_TCP_DIAG=3Dy # =

> CONFIG_TCP_CONG_ADVANCED is not set CONFIG_TCP_CONG_BIC=3Dy #=20
> CONFIG_IPV6 is not set # CONFIG_INET6_XFRM_TUNNEL is not set #=20
> CONFIG_INET6_TUNNEL is not set # CONFIG_NETFILTER is not set
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
> # Connector - unified userspace <-> kernelspace linker # #=20
> CONFIG_CONNECTOR is not set
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
> # CONFIG_BLK_DEV_COW_COMMON is not set # CONFIG_BLK_DEV_LOOP is not=20
> set # CONFIG_BLK_DEV_NBD is not set CONFIG_BLK_DEV_RAM=3Dy
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
> # Ftape, the floppy tape device driver # # CONFIG_AGP is not set #=20
> CONFIG_RAW_DRIVER is not set
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
> # EDAC - error detection and reporting (RAS) (EXPERIMENTAL) #
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
> # CONFIG_REISERFS_PROC_INFO is not set # CONFIG_REISERFS_FS_XATTR is=20
> not set # CONFIG_JFS_FS is not set # CONFIG_FS_POSIX_ACL is not set #=20
> CONFIG_XFS_FS is not set # CONFIG_OCFS2_FS is not set #=20
> CONFIG_MINIX_FS is not set # CONFIG_ROMFS_FS is not set=20
> CONFIG_INOTIFY=3Dy # CONFIG_QUOTA is not set CONFIG_DNOTIFY=3Dy #=20
> CONFIG_AUTOFS_FS is not set # CONFIG_AUTOFS4_FS is not set #=20
> CONFIG_FUSE_FS is not set
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
> # CONFIG_PARTITION_ADVANCED is not set CONFIG_MSDOS_PARTITION=3Dy
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
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set # CONFIG_DEBUG_KOBJECT is not

> set # CONFIG_DEBUG_INFO is not set # CONFIG_DEBUG_FS is not set #=20
> CONFIG_DEBUG_VM is not set CONFIG_FORCED_INLINING=3Dy #=20
> CONFIG_RCU_TORTURE_TEST is not set # CONFIG_KGDB is not set #=20
> CONFIG_XMON is not set # CONFIG_BDI_SWITCH is not set #=20
> CONFIG_SERIAL_TEXT_DEBUG is not set
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
> # CONFIG_CRYPTO_MICHAEL_MIC is not set # CONFIG_CRYPTO_CRC32C is not=20
> set # CONFIG_CRYPTO_TEST is not set
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
> scripts/kconfig/conf -s arch/ppc/Kconfig # # using defaults found in=20
> .config #
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
> arch/powerpc/kernel/signal_32.c:763: error: request for member
`vdso_base'
> in something not a structure or union
> arch/powerpc/kernel/signal_32.c:766: error: request for member
`vdso_base'
> in something not a structure or union
> arch/powerpc/kernel/signal_32.c: In function `handle_signal':
> arch/powerpc/kernel/signal_32.c:1037: error: request for member=20
> `vdso_base' in something not a structure or union
> arch/powerpc/kernel/signal_32.c:1040: error: request for member=20
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
> --
>=20
>=20
> Echte DSL-Flatrate dauerhaft f?r 0,- Euro*!
> "Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--=20


Echte DSL-Flatrate dauerhaft f?r 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl


------------------------------

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

End of Linuxppc-embedded Digest, Vol 22, Issue 32
*************************************************
