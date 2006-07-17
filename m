Return-Path: <vancasperz@yahoo.com.cn>
Received: from web15607.mail.cnb.yahoo.com (web15607.mail.cnb.yahoo.com
	[202.165.102.61]) by ozlabs.org (Postfix) with SMTP id 8ABC667B32
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Jul 2006 18:11:00 +1000 (EST)
Message-ID: <20060717081058.55832.qmail@web15607.mail.cnb.yahoo.com>
Date: Mon, 17 Jul 2006 16:10:58 +0800 (CST)
From: Zhou Rui <vancasperz@yahoo.com.cn>
Subject: What is "request_module: runaway loop modprobe binfmt-4c46"?
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1686208644-1153123858=:53053"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1686208644-1153123858=:53053
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi,
I tried to compile kernel for PowerPC405EP Octobus board with ELDK4.0. I used the kernel source 2.6.15 contained in ELDK4.0. I cross-compiled the kernel with "ARCH=ppc CROSS_COMPILE=ppc_4xx-". The filesystem was based on NFS. I tried to boot the image from ram in u-boot, but the boot procedure stopped at
"VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 100k init
request_module: runaway loop modprobe binfmt-4c46
request_module: runaway loop modprobe binfmt-4c46
request_module: runaway loop modprobe binfmt-4c46
request_module: runaway loop modprobe binfmt-4c46
request_module: runaway loop modprobe binfmt-4c46"

So would you like to tell me what the matter is with this? Thanks a lot.

My .config file for 2.6.15 kernel is like this:

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15
# Wed Aug 23 14:58:08 2006
#
CONFIG_MMU=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_GENERIC_NVRAM=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
# CONFIG_HOTPLUG is not set
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
# CONFIG_LBD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"

#
# Processor
#
# CONFIG_6xx is not set
CONFIG_40x=y
# CONFIG_44x is not set
# CONFIG_POWER3 is not set
# CONFIG_POWER4 is not set
# CONFIG_8xx is not set
# CONFIG_E200 is not set
# CONFIG_E500 is not set
CONFIG_MATH_EMULATION=y
# CONFIG_KEXEC is not set
# CONFIG_CPU_FREQ is not set
CONFIG_4xx=y
# CONFIG_WANT_EARLY_SERIAL is not set

#
# IBM 4xx options
#
# CONFIG_BUBINGA is not set
# CONFIG_CPCI405 is not set
# CONFIG_EP405 is not set
CONFIG_PPChameleonEVB=y
# CONFIG_REDWOOD_5 is not set
# CONFIG_REDWOOD_6 is not set
# CONFIG_SYCAMORE is not set
# CONFIG_WALNUT is not set
# CONFIG_XILINX_ML300 is not set
CONFIG_IBM_OCP=y
CONFIG_405EP=y
CONFIG_PPC4xx_DMA=y
CONFIG_PPC4xx_EDMA=y
CONFIG_PPC_GEN550=y
CONFIG_UART0_TTYS0=y
# CONFIG_UART0_TTYS1 is not set
CONFIG_NOT_COHERENT_CACHE=y

#
# Platform options
#
# CONFIG_PC_KEYBOARD is not set
# CONFIG_HIGHMEM is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_BINFMT_ELF is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="console=ttyS0,115200 console=tty0 root=/dev/nfs"
# CONFIG_PM is not set
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_SECCOMP is not set
CONFIG_ISA_DMA_API=y

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
CONFIG_ADVANCED_OPTIONS=y
CONFIG_HIGHMEM_START=0xfe000000
# CONFIG_LOWMEM_SIZE_BOOL is not set
CONFIG_LOWMEM_SIZE=0x30000000
# CONFIG_KERNEL_START_BOOL is not set
CONFIG_KERNEL_START=0xc0000000
# CONFIG_TASK_SIZE_BOOL is not set
CONFIG_TASK_SIZE=0x80000000
# CONFIG_CONSISTENT_START_BOOL is not set
CONFIG_CONSISTENT_START=0xff100000
# CONFIG_CONSISTENT_SIZE_BOOL is not set
CONFIG_CONSISTENT_SIZE=0x00200000
# CONFIG_BOOT_LOAD_BOOL is not set
CONFIG_BOOT_LOAD=0x00400000

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
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
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

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
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
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
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
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
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
CONFIG_IBM_EMAC=y
CONFIG_IBM_EMAC_RXB=128
CONFIG_IBM_EMAC_TXB=64
CONFIG_IBM_EMAC_POLL_WEIGHT=32
CONFIG_IBM_EMAC_RX_COPY_THRESHOLD=256
CONFIG_IBM_EMAC_RX_SKB_HEADROOM=0
# CONFIG_IBM_EMAC_PHY_RX_CLK_FIX is not set
# CONFIG_IBM_EMAC_DEBUG is not set

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
CONFIG_NETCONSOLE=y
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y

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
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
# CONFIG_SERIO_I8042 is not set
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_LIBPS2 is not set
CONFIG_SERIO_RAW=y
# CONFIG_GAMEPORT is not set

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
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
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
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

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
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB_ARCH_HAS_HCD is not set
# CONFIG_USB_ARCH_HAS_OHCI is not set

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
# InfiniBand support
#

#
# SN Devices
#

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT2_FS_XIP=y
CONFIG_FS_XIP=y
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_INOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set

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
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
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
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# IBM 40x options
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_DETECT_SOFTLOCKUP is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_KGDB is not set
# CONFIG_XMON is not set
CONFIG_BDI_SWITCH=y
CONFIG_SERIAL_TEXT_DEBUG=y
CONFIG_PPC_OCP=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=y
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
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#


Zhou Rui
Distributed & Embedded System Lab
School of Information Science & Engineering
Lanzhou University, P. R. China
http://dslab.lzu.edu.cn/~zr/
 		
---------------------------------
ÇÀ×¢ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ£¡ 
--0-1686208644-1153123858=:53053
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi,<br>I tried to compile kernel for PowerPC405EP Octobus board with ELDK4.0. I used the kernel source 2.6.15 contained in ELDK4.0. I cross-compiled the kernel with "ARCH=ppc CROSS_COMPILE=ppc_4xx-". The filesystem was based on NFS. I tried to boot the image from ram in u-boot, but the boot procedure stopped at<br>"VFS: Mounted root (nfs filesystem).<br>Freeing unused kernel memory: 100k init<br>request_module: runaway loop modprobe binfmt-4c46<br>request_module: runaway loop modprobe binfmt-4c46<br>request_module: runaway loop modprobe binfmt-4c46<br>request_module: runaway loop modprobe binfmt-4c46<br>request_module: runaway loop modprobe binfmt-4c46"<br><br>So would you like to tell me what the matter is with this? Thanks a lot.<br><br>My .config file for 2.6.15 kernel is like this:<br><br>#<br># Automatically generated make config: don't edit<br># Linux kernel version: 2.6.15<br># Wed Aug 23 14:58:08
 2006<br>#<br>CONFIG_MMU=y<br>CONFIG_GENERIC_HARDIRQS=y<br>CONFIG_RWSEM_XCHGADD_ALGORITHM=y<br>CONFIG_GENERIC_CALIBRATE_DELAY=y<br>CONFIG_PPC=y<br>CONFIG_PPC32=y<br>CONFIG_GENERIC_NVRAM=y<br>CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y<br>CONFIG_ARCH_MAY_HAVE_PC_FDC=y<br><br>#<br># Code maturity level options<br>#<br>CONFIG_EXPERIMENTAL=y<br>CONFIG_CLEAN_COMPILE=y<br>CONFIG_BROKEN_ON_SMP=y<br>CONFIG_INIT_ENV_ARG_LIMIT=32<br><br>#<br># General setup<br>#<br>CONFIG_LOCALVERSION=""<br># CONFIG_LOCALVERSION_AUTO is not set<br># CONFIG_SWAP is not set<br>CONFIG_SYSVIPC=y<br># CONFIG_POSIX_MQUEUE is not set<br># CONFIG_BSD_PROCESS_ACCT is not set<br>CONFIG_SYSCTL=y<br># CONFIG_AUDIT is not set<br># CONFIG_HOTPLUG is not set<br>CONFIG_KOBJECT_UEVENT=y<br># CONFIG_IKCONFIG is not set<br>CONFIG_INITRAMFS_SOURCE=""<br># CONFIG_CC_OPTIMIZE_FOR_SIZE is not set<br>CONFIG_EMBEDDED=y<br>CONFIG_KALLSYMS=y<br># CONFIG_KALLSYMS_ALL is not set<br># CONFIG_KALLSYMS_EXTRA_PASS is not
 set<br>CONFIG_PRINTK=y<br>CONFIG_BUG=y<br>CONFIG_BASE_FULL=y<br>CONFIG_FUTEX=y<br>CONFIG_EPOLL=y<br>CONFIG_SHMEM=y<br>CONFIG_CC_ALIGN_FUNCTIONS=0<br>CONFIG_CC_ALIGN_LABELS=0<br>CONFIG_CC_ALIGN_LOOPS=0<br>CONFIG_CC_ALIGN_JUMPS=0<br># CONFIG_TINY_SHMEM is not set<br>CONFIG_BASE_SMALL=0<br><br>#<br># Loadable module support<br>#<br>CONFIG_MODULES=y<br>CONFIG_MODULE_UNLOAD=y<br>CONFIG_MODULE_FORCE_UNLOAD=y<br>CONFIG_OBSOLETE_MODPARM=y<br># CONFIG_MODVERSIONS is not set<br># CONFIG_MODULE_SRCVERSION_ALL is not set<br>CONFIG_KMOD=y<br><br>#<br># Block layer<br>#<br># CONFIG_LBD is not set<br><br>#<br># IO Schedulers<br>#<br>CONFIG_IOSCHED_NOOP=y<br># CONFIG_IOSCHED_AS is not set<br># CONFIG_IOSCHED_DEADLINE is not set<br># CONFIG_IOSCHED_CFQ is not set<br># CONFIG_DEFAULT_AS is not set<br># CONFIG_DEFAULT_DEADLINE is not set<br># CONFIG_DEFAULT_CFQ is not set<br>CONFIG_DEFAULT_NOOP=y<br>CONFIG_DEFAULT_IOSCHED="noop"<br><br>#<br># Processor<br>#<br># CONFIG_6xx is not
 set<br>CONFIG_40x=y<br># CONFIG_44x is not set<br># CONFIG_POWER3 is not set<br># CONFIG_POWER4 is not set<br># CONFIG_8xx is not set<br># CONFIG_E200 is not set<br># CONFIG_E500 is not set<br>CONFIG_MATH_EMULATION=y<br># CONFIG_KEXEC is not set<br># CONFIG_CPU_FREQ is not set<br>CONFIG_4xx=y<br># CONFIG_WANT_EARLY_SERIAL is not set<br><br>#<br># IBM 4xx options<br>#<br># CONFIG_BUBINGA is not set<br># CONFIG_CPCI405 is not set<br># CONFIG_EP405 is not set<br>CONFIG_PPChameleonEVB=y<br># CONFIG_REDWOOD_5 is not set<br># CONFIG_REDWOOD_6 is not set<br># CONFIG_SYCAMORE is not set<br># CONFIG_WALNUT is not set<br># CONFIG_XILINX_ML300 is not set<br>CONFIG_IBM_OCP=y<br>CONFIG_405EP=y<br>CONFIG_PPC4xx_DMA=y<br>CONFIG_PPC4xx_EDMA=y<br>CONFIG_PPC_GEN550=y<br>CONFIG_UART0_TTYS0=y<br># CONFIG_UART0_TTYS1 is not set<br>CONFIG_NOT_COHERENT_CACHE=y<br><br>#<br># Platform options<br>#<br># CONFIG_PC_KEYBOARD is not set<br># CONFIG_HIGHMEM is not set<br>CONFIG_HZ_100=y<br>#
 CONFIG_HZ_250 is not set<br># CONFIG_HZ_1000 is not set<br>CONFIG_HZ=100<br>CONFIG_PREEMPT_NONE=y<br># CONFIG_PREEMPT_VOLUNTARY is not set<br># CONFIG_PREEMPT is not set<br>CONFIG_SELECT_MEMORY_MODEL=y<br>CONFIG_FLATMEM_MANUAL=y<br># CONFIG_DISCONTIGMEM_MANUAL is not set<br># CONFIG_SPARSEMEM_MANUAL is not set<br>CONFIG_FLATMEM=y<br>CONFIG_FLAT_NODE_MEM_MAP=y<br># CONFIG_SPARSEMEM_STATIC is not set<br>CONFIG_SPLIT_PTLOCK_CPUS=4<br># CONFIG_BINFMT_ELF is not set<br># CONFIG_BINFMT_MISC is not set<br>CONFIG_CMDLINE_BOOL=y<br>CONFIG_CMDLINE="console=ttyS0,115200 console=tty0 root=/dev/nfs"<br># CONFIG_PM is not set<br># CONFIG_SOFTWARE_SUSPEND is not set<br># CONFIG_SECCOMP is not set<br>CONFIG_ISA_DMA_API=y<br><br>#<br># Bus options<br>#<br># CONFIG_PPC_I8259 is not set<br># CONFIG_PCI is not set<br># CONFIG_PCI_DOMAINS is not set<br><br>#<br># PCCARD (PCMCIA/CardBus) support<br>#<br># CONFIG_PCCARD is not set<br><br>#<br># Advanced
 setup<br>#<br>CONFIG_ADVANCED_OPTIONS=y<br>CONFIG_HIGHMEM_START=0xfe000000<br># CONFIG_LOWMEM_SIZE_BOOL is not set<br>CONFIG_LOWMEM_SIZE=0x30000000<br># CONFIG_KERNEL_START_BOOL is not set<br>CONFIG_KERNEL_START=0xc0000000<br># CONFIG_TASK_SIZE_BOOL is not set<br>CONFIG_TASK_SIZE=0x80000000<br># CONFIG_CONSISTENT_START_BOOL is not set<br>CONFIG_CONSISTENT_START=0xff100000<br># CONFIG_CONSISTENT_SIZE_BOOL is not set<br>CONFIG_CONSISTENT_SIZE=0x00200000<br># CONFIG_BOOT_LOAD_BOOL is not set<br>CONFIG_BOOT_LOAD=0x00400000<br><br>#<br># Networking<br>#<br>CONFIG_NET=y<br><br>#<br># Networking options<br>#<br>CONFIG_PACKET=y<br># CONFIG_PACKET_MMAP is not set<br>CONFIG_UNIX=y<br># CONFIG_NET_KEY is not set<br>CONFIG_INET=y<br>CONFIG_IP_MULTICAST=y<br># CONFIG_IP_ADVANCED_ROUTER is not set<br>CONFIG_IP_FIB_HASH=y<br>CONFIG_IP_PNP=y<br>CONFIG_IP_PNP_DHCP=y<br>CONFIG_IP_PNP_BOOTP=y<br>CONFIG_IP_PNP_RARP=y<br># CONFIG_NET_IPIP is not set<br># CONFIG_NET_IPGRE is not set<br>#
 CONFIG_IP_MROUTE is not set<br># CONFIG_ARPD is not set<br>CONFIG_SYN_COOKIES=y<br># CONFIG_INET_AH is not set<br># CONFIG_INET_ESP is not set<br># CONFIG_INET_IPCOMP is not set<br># CONFIG_INET_TUNNEL is not set<br>CONFIG_INET_DIAG=y<br>CONFIG_INET_TCP_DIAG=y<br># CONFIG_TCP_CONG_ADVANCED is not set<br>CONFIG_TCP_CONG_BIC=y<br># CONFIG_IPV6 is not set<br># CONFIG_NETFILTER is not set<br><br>#<br># DCCP Configuration (EXPERIMENTAL)<br>#<br># CONFIG_IP_DCCP is not set<br><br>#<br># SCTP Configuration (EXPERIMENTAL)<br>#<br># CONFIG_IP_SCTP is not set<br># CONFIG_ATM is not set<br># CONFIG_BRIDGE is not set<br># CONFIG_VLAN_8021Q is not set<br># CONFIG_DECNET is not set<br># CONFIG_LLC2 is not set<br># CONFIG_IPX is not set<br># CONFIG_ATALK is not set<br># CONFIG_X25 is not set<br># CONFIG_LAPB is not set<br># CONFIG_NET_DIVERT is not set<br># CONFIG_ECONET is not set<br># CONFIG_WAN_ROUTER is not set<br><br>#<br># QoS and/or fair queueing<br>#<br># CONFIG_NET_SCHED is not
 set<br><br>#<br># Network testing<br>#<br># CONFIG_NET_PKTGEN is not set<br># CONFIG_HAMRADIO is not set<br># CONFIG_IRDA is not set<br># CONFIG_BT is not set<br># CONFIG_IEEE80211 is not set<br><br>#<br># Device Drivers<br>#<br><br>#<br># Generic Driver Options<br>#<br># CONFIG_STANDALONE is not set<br># CONFIG_PREVENT_FIRMWARE_BUILD is not set<br># CONFIG_FW_LOADER is not set<br># CONFIG_DEBUG_DRIVER is not set<br><br>#<br># Connector - unified userspace &lt;-&gt; kernelspace linker<br>#<br># CONFIG_CONNECTOR is not set<br><br>#<br># Memory Technology Devices (MTD)<br>#<br># CONFIG_MTD is not set<br><br>#<br># Parallel port support<br>#<br># CONFIG_PARPORT is not set<br><br>#<br># Plug and Play support<br>#<br><br>#<br># Block devices<br>#<br># CONFIG_BLK_DEV_FD is not set<br># CONFIG_BLK_DEV_COW_COMMON is not set<br>CONFIG_BLK_DEV_LOOP=y<br># CONFIG_BLK_DEV_CRYPTOLOOP is not
 set<br>CONFIG_BLK_DEV_NBD=y<br>CONFIG_BLK_DEV_RAM=y<br>CONFIG_BLK_DEV_RAM_COUNT=16<br>CONFIG_BLK_DEV_RAM_SIZE=4096<br>CONFIG_BLK_DEV_INITRD=y<br># CONFIG_CDROM_PKTCDVD is not set<br># CONFIG_ATA_OVER_ETH is not set<br><br>#<br># ATA/ATAPI/MFM/RLL support<br>#<br># CONFIG_IDE is not set<br><br>#<br># SCSI device support<br>#<br># CONFIG_RAID_ATTRS is not set<br># CONFIG_SCSI is not set<br><br>#<br># Multi-device support (RAID and LVM)<br>#<br># CONFIG_MD is not set<br><br>#<br># Fusion MPT device support<br>#<br># CONFIG_FUSION is not set<br><br>#<br># IEEE 1394 (FireWire) support<br>#<br><br>#<br># I2O device support<br>#<br><br>#<br># Macintosh device drivers<br>#<br># CONFIG_WINDFARM is not set<br><br>#<br># Network device support<br>#<br>CONFIG_NETDEVICES=y<br>CONFIG_DUMMY=y<br># CONFIG_BONDING is not set<br># CONFIG_EQUALIZER is not set<br># CONFIG_TUN is not set<br><br>#<br># PHY device support<br>#<br># CONFIG_PHYLIB is not set<br><br>#<br># Ethernet (10 or
 100Mbit)<br>#<br>CONFIG_NET_ETHERNET=y<br># CONFIG_MII is not set<br>CONFIG_IBM_EMAC=y<br>CONFIG_IBM_EMAC_RXB=128<br>CONFIG_IBM_EMAC_TXB=64<br>CONFIG_IBM_EMAC_POLL_WEIGHT=32<br>CONFIG_IBM_EMAC_RX_COPY_THRESHOLD=256<br>CONFIG_IBM_EMAC_RX_SKB_HEADROOM=0<br># CONFIG_IBM_EMAC_PHY_RX_CLK_FIX is not set<br># CONFIG_IBM_EMAC_DEBUG is not set<br><br>#<br># Ethernet (1000 Mbit)<br>#<br><br>#<br># Ethernet (10000 Mbit)<br>#<br><br>#<br># Token Ring devices<br>#<br><br>#<br># Wireless LAN (non-hamradio)<br>#<br># CONFIG_NET_RADIO is not set<br><br>#<br># Wan interfaces<br>#<br># CONFIG_WAN is not set<br># CONFIG_PPP is not set<br># CONFIG_SLIP is not set<br># CONFIG_SHAPER is not set<br>CONFIG_NETCONSOLE=y<br>CONFIG_NETPOLL=y<br># CONFIG_NETPOLL_RX is not set<br># CONFIG_NETPOLL_TRAP is not set<br>CONFIG_NET_POLL_CONTROLLER=y<br><br>#<br># ISDN subsystem<br>#<br># CONFIG_ISDN is not set<br><br>#<br># Telephony Support<br>#<br># CONFIG_PHONE is not set<br><br>#<br># Input device
 support<br>#<br>CONFIG_INPUT=y<br><br>#<br># Userland interfaces<br>#<br>CONFIG_INPUT_MOUSEDEV=y<br># CONFIG_INPUT_MOUSEDEV_PSAUX is not set<br>CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024<br>CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768<br># CONFIG_INPUT_JOYDEV is not set<br># CONFIG_INPUT_TSDEV is not set<br># CONFIG_INPUT_EVDEV is not set<br># CONFIG_INPUT_EVBUG is not set<br><br>#<br># Input Device Drivers<br>#<br># CONFIG_INPUT_KEYBOARD is not set<br># CONFIG_INPUT_MOUSE is not set<br># CONFIG_INPUT_JOYSTICK is not set<br># CONFIG_INPUT_TOUCHSCREEN is not set<br># CONFIG_INPUT_MISC is not set<br><br>#<br># Hardware I/O ports<br>#<br>CONFIG_SERIO=y<br># CONFIG_SERIO_I8042 is not set<br>CONFIG_SERIO_SERPORT=y<br># CONFIG_SERIO_LIBPS2 is not set<br>CONFIG_SERIO_RAW=y<br># CONFIG_GAMEPORT is not set<br><br>#<br># Character devices<br>#<br>CONFIG_VT=y<br>CONFIG_VT_CONSOLE=y<br>CONFIG_HW_CONSOLE=y<br># CONFIG_SERIAL_NONSTANDARD is not set<br><br>#<br># Serial
 drivers<br>#<br>CONFIG_SERIAL_8250=y<br>CONFIG_SERIAL_8250_CONSOLE=y<br>CONFIG_SERIAL_8250_NR_UARTS=4<br>CONFIG_SERIAL_8250_EXTENDED=y<br># CONFIG_SERIAL_8250_MANY_PORTS is not set<br># CONFIG_SERIAL_8250_SHARE_IRQ is not set<br># CONFIG_SERIAL_8250_DETECT_IRQ is not set<br># CONFIG_SERIAL_8250_RSA is not set<br><br>#<br># Non-8250 serial port support<br>#<br>CONFIG_SERIAL_CORE=y<br>CONFIG_SERIAL_CORE_CONSOLE=y<br>CONFIG_UNIX98_PTYS=y<br>CONFIG_LEGACY_PTYS=y<br>CONFIG_LEGACY_PTY_COUNT=256<br><br>#<br># IPMI<br>#<br># CONFIG_IPMI_HANDLER is not set<br><br>#<br># Watchdog Cards<br>#<br># CONFIG_WATCHDOG is not set<br># CONFIG_NVRAM is not set<br># CONFIG_GEN_RTC is not set<br># CONFIG_DTLK is not set<br># CONFIG_R3964 is not set<br><br>#<br># Ftape, the floppy tape device driver<br>#<br># CONFIG_AGP is not set<br># CONFIG_RAW_DRIVER is not set<br><br>#<br># TPM devices<br>#<br># CONFIG_TCG_TPM is not set<br># CONFIG_TELCLOCK is not set<br><br>#<br># I2C support<br>#<br>#
 CONFIG_I2C is not set<br><br>#<br># Dallas's 1-wire bus<br>#<br># CONFIG_W1 is not set<br><br>#<br># Hardware Monitoring support<br>#<br># CONFIG_HWMON is not set<br># CONFIG_HWMON_VID is not set<br><br>#<br># Misc devices<br>#<br><br>#<br># Multimedia Capabilities Port drivers<br>#<br><br>#<br># Multimedia devices<br>#<br># CONFIG_VIDEO_DEV is not set<br><br>#<br># Digital Video Broadcasting Devices<br>#<br># CONFIG_DVB is not set<br><br>#<br># Graphics support<br>#<br># CONFIG_FB is not set<br><br>#<br># Console display driver support<br>#<br>CONFIG_DUMMY_CONSOLE=y<br><br>#<br># Sound<br>#<br># CONFIG_SOUND is not set<br><br>#<br># USB support<br>#<br># CONFIG_USB_ARCH_HAS_HCD is not set<br># CONFIG_USB_ARCH_HAS_OHCI is not set<br><br>#<br># NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'<br>#<br><br>#<br># USB Gadget Support<br>#<br># CONFIG_USB_GADGET is not set<br><br>#<br># MMC/SD Card support<br>#<br># CONFIG_MMC is not set<br><br>#<br># InfiniBand
 support<br>#<br><br>#<br># SN Devices<br>#<br><br>#<br># File systems<br>#<br>CONFIG_EXT2_FS=y<br>CONFIG_EXT2_FS_XATTR=y<br>CONFIG_EXT2_FS_POSIX_ACL=y<br># CONFIG_EXT2_FS_SECURITY is not set<br>CONFIG_EXT2_FS_XIP=y<br>CONFIG_FS_XIP=y<br># CONFIG_EXT3_FS is not set<br># CONFIG_JBD is not set<br>CONFIG_FS_MBCACHE=y<br># CONFIG_REISERFS_FS is not set<br># CONFIG_JFS_FS is not set<br>CONFIG_FS_POSIX_ACL=y<br># CONFIG_XFS_FS is not set<br># CONFIG_MINIX_FS is not set<br># CONFIG_ROMFS_FS is not set<br># CONFIG_INOTIFY is not set<br># CONFIG_QUOTA is not set<br>CONFIG_DNOTIFY=y<br>CONFIG_AUTOFS_FS=y<br>CONFIG_AUTOFS4_FS=y<br># CONFIG_FUSE_FS is not set<br><br>#<br># CD-ROM/DVD Filesystems<br>#<br># CONFIG_ISO9660_FS is not set<br># CONFIG_UDF_FS is not set<br><br>#<br># DOS/FAT/NT Filesystems<br>#<br># CONFIG_MSDOS_FS is not set<br># CONFIG_VFAT_FS is not set<br># CONFIG_NTFS_FS is not set<br><br>#<br># Pseudo filesystems<br>#<br>CONFIG_PROC_FS=y<br># CONFIG_PROC_KCORE is not
 set<br>CONFIG_SYSFS=y<br>CONFIG_TMPFS=y<br># CONFIG_HUGETLB_PAGE is not set<br>CONFIG_RAMFS=y<br># CONFIG_RELAYFS_FS is not set<br><br>#<br># Miscellaneous filesystems<br>#<br># CONFIG_ADFS_FS is not set<br># CONFIG_AFFS_FS is not set<br># CONFIG_HFS_FS is not set<br># CONFIG_HFSPLUS_FS is not set<br># CONFIG_BEFS_FS is not set<br># CONFIG_BFS_FS is not set<br># CONFIG_EFS_FS is not set<br># CONFIG_CRAMFS is not set<br># CONFIG_VXFS_FS is not set<br># CONFIG_HPFS_FS is not set<br># CONFIG_QNX4FS_FS is not set<br># CONFIG_SYSV_FS is not set<br># CONFIG_UFS_FS is not set<br><br>#<br># Network File Systems<br>#<br>CONFIG_NFS_FS=y<br>CONFIG_NFS_V3=y<br>CONFIG_NFS_V3_ACL=y<br>CONFIG_NFS_V4=y<br>CONFIG_NFS_DIRECTIO=y<br># CONFIG_NFSD is not set<br>CONFIG_ROOT_NFS=y<br>CONFIG_LOCKD=y<br>CONFIG_LOCKD_V4=y<br>CONFIG_NFS_ACL_SUPPORT=y<br>CONFIG_NFS_COMMON=y<br>CONFIG_SUNRPC=y<br>CONFIG_SUNRPC_GSS=y<br>CONFIG_RPCSEC_GSS_KRB5=y<br># CONFIG_RPCSEC_GSS_SPKM3 is not set<br>#
 CONFIG_SMB_FS is not set<br># CONFIG_CIFS is not set<br># CONFIG_NCP_FS is not set<br># CONFIG_CODA_FS is not set<br># CONFIG_AFS_FS is not set<br># CONFIG_9P_FS is not set<br><br>#<br># Partition Types<br>#<br># CONFIG_PARTITION_ADVANCED is not set<br>CONFIG_MSDOS_PARTITION=y<br><br>#<br># Native Language Support<br>#<br># CONFIG_NLS is not set<br><br>#<br># IBM 40x options<br>#<br><br>#<br># Library routines<br>#<br># CONFIG_CRC_CCITT is not set<br># CONFIG_CRC16 is not set<br>CONFIG_CRC32=y<br># CONFIG_LIBCRC32C is not set<br># CONFIG_PROFILING is not set<br><br>#<br># Kernel hacking<br>#<br># CONFIG_PRINTK_TIME is not set<br>CONFIG_DEBUG_KERNEL=y<br># CONFIG_MAGIC_SYSRQ is not set<br>CONFIG_LOG_BUF_SHIFT=14<br># CONFIG_DETECT_SOFTLOCKUP is not set<br># CONFIG_SCHEDSTATS is not set<br># CONFIG_DEBUG_SLAB is not set<br># CONFIG_DEBUG_SPINLOCK is not set<br># CONFIG_DEBUG_SPINLOCK_SLEEP is not set<br># CONFIG_DEBUG_KOBJECT is not set<br># CONFIG_DEBUG_INFO is not set<br>#
 CONFIG_DEBUG_FS is not set<br># CONFIG_DEBUG_VM is not set<br># CONFIG_RCU_TORTURE_TEST is not set<br># CONFIG_KGDB is not set<br># CONFIG_XMON is not set<br>CONFIG_BDI_SWITCH=y<br>CONFIG_SERIAL_TEXT_DEBUG=y<br>CONFIG_PPC_OCP=y<br><br>#<br># Security options<br>#<br># CONFIG_KEYS is not set<br># CONFIG_SECURITY is not set<br><br>#<br># Cryptographic options<br>#<br>CONFIG_CRYPTO=y<br># CONFIG_CRYPTO_HMAC is not set<br># CONFIG_CRYPTO_NULL is not set<br># CONFIG_CRYPTO_MD4 is not set<br>CONFIG_CRYPTO_MD5=y<br># CONFIG_CRYPTO_SHA1 is not set<br># CONFIG_CRYPTO_SHA256 is not set<br># CONFIG_CRYPTO_SHA512 is not set<br># CONFIG_CRYPTO_WP512 is not set<br># CONFIG_CRYPTO_TGR192 is not set<br>CONFIG_CRYPTO_DES=y<br># CONFIG_CRYPTO_BLOWFISH is not set<br># CONFIG_CRYPTO_TWOFISH is not set<br># CONFIG_CRYPTO_SERPENT is not set<br># CONFIG_CRYPTO_AES is not set<br># CONFIG_CRYPTO_CAST5 is not set<br># CONFIG_CRYPTO_CAST6 is not set<br># CONFIG_CRYPTO_TEA is not set<br>#
 CONFIG_CRYPTO_ARC4 is not set<br># CONFIG_CRYPTO_KHAZAD is not set<br># CONFIG_CRYPTO_ANUBIS is not set<br># CONFIG_CRYPTO_DEFLATE is not set<br># CONFIG_CRYPTO_MICHAEL_MIC is not set<br># CONFIG_CRYPTO_CRC32C is not set<br># CONFIG_CRYPTO_TEST is not set<br><br>#<br># Hardware crypto devices<br>#<br><BR><BR>Zhou Rui<br>Distributed &amp; Embedded System Lab<br>School of Information Science &amp; Engineering<br>Lanzhou University, P. R. China<br>http://dslab.lzu.edu.cn/~zr/<p>&#32;
		<hr size=1><a href="http://cn.mail.yahoo.com" target=blank>ÇÀ×¢ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ£¡</a> 
--0-1686208644-1153123858=:53053--
