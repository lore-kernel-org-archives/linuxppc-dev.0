Return-Path: <cpvjagadeesh@yahoo.com>
Received: from web50405.mail.yahoo.com (web50405.mail.yahoo.com
	[206.190.38.70]) by ozlabs.org (Postfix) with SMTP id 6814F68956
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Dec 2005 19:50:38 +1100 (EST)
Message-ID: <20051229085036.53773.qmail@web50405.mail.yahoo.com>
Date: Thu, 29 Dec 2005 00:50:36 -0800 (PST)
From: venkatajagadeesh p <cpvjagadeesh@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-854699733-1135846236=:52787"
Subject: Portin Linux2.6.13 on Custom build MPC860T board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-854699733-1135846236=:52787
Content-Type: multipart/alternative; boundary="0-956493263-1135846236=:52787"

--0-956493263-1135846236=:52787
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

    We are trying to port Linux-2.6.13 on Custom build board, We gone through some of the threads and done those modifications for initializing the console. But it was not working.  We are sending the output data and config file.
     
  
U-Boot 1.0.2 (Oct 13 2005 - 10:06:32)
  CPU:   XPC86xxxZPnnD3 at 60 MHz: 4 kB I-Cache 4 kB D-Cache FEC present
Board: FADS with db MPC860T rev ENG
DRAM:  (64 MB SDRAM) unknown dramdelay (0x1) - defaulting to 70 ns64 MB
ok1
ok2
functions are over
Top of RAM usable for U-Boot at: 04000000
Reserving 141k for U-Boot at: 03fdc000
Reserving 640k for malloc() at: 03f3c000
Reserving 60 Bytes for Board Info at: 03f3bfc4
Reserving 48 Bytes for Global Data at: 03f3bf94
Stack Pointer at: 03f3bf78
New Stack Pointer is: 03f3bf78
  memcopy over
Now running in RAM - U-Boot at: 03fdc000
FLASH:
in flash_get_size       micron is identified ffff
device id in flash.c 18
device id correct
  in flash_get_size       micron is identified 1
device id in flash.c 18
device id correct
32 MB
In:    serial
Out:   serial
Err:   serial
KGDB:  [on SMC2] kgdb ready
ready
Net:   FEC ETHERNET
ent into mainloop
Hit any key to stop autoboot:  0
=>loadb 0x100000 57600
## Ready for binary (kermit) download to 0x00100000 at 57600 bps...
## Total Size      = 0x000e9e5d = 958045 Bytes
## Start Addr      = 0x00100000
=>loadb 0x400000 57600
## Ready for binary (kermit) download to 0x00400000 at 57600 bps...
## Total Size      = 0x0039c124 = 3784996 Bytes
## Start Addr      = 0x00400000
=>bootm 0x100000 0x400000
## Booting image at 00100000 ...
   Image Name:   Linux-2.6.13
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    957981 Bytes = 935.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... gunzip function called
OK
do_bootm_linux called ...do_bootm_linux  after ...part2 do_boot_linux before RAM
 Disk image loading ...
## Loading RAMDisk Image at 00400000 ...
   Image Name:   Ramdisk image
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3784932 Bytes =  3.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
data is non zero
   Loading Ramdisk to 03b9f000, end 03f3b0e4 ... OK
## Transferring control to Linux (at address 00000000) ...



		
---------------------------------
Yahoo! Shopping
 Find Great Deals on Holiday Gifts at Yahoo! Shopping 
--0-956493263-1135846236=:52787
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV id=RTEContent>  <DIV id=RTEContent>&nbsp; We are trying to port Linux-2.6.13 on Custom build board, We gone through some of the threads and done those modifications for initializing the console. But it was not working.&nbsp; We are sending the output data and config file.</DIV>  <DIV id=RTEContent>&nbsp;&nbsp; </DIV>  <DIV id=RTEContent><BR>U-Boot 1.0.2 (Oct 13 2005 - 10:06:32)</DIV>  <DIV id=RTEContent>CPU:&nbsp;&nbsp; XPC86xxxZPnnD3 at 60 MHz: 4 kB I-Cache 4 kB D-Cache FEC present<BR>Board: FADS with db MPC860T rev ENG<BR>DRAM:&nbsp; (64 MB SDRAM) unknown dramdelay (0x1) - defaulting to 70 ns64 MB<BR>ok1<BR>ok2<BR>functions are over<BR>Top of RAM usable for U-Boot at: 04000000<BR>Reserving 141k for U-Boot at: 03fdc000<BR>Reserving 640k for malloc() at: 03f3c000<BR>Reserving 60 Bytes for Board Info at: 03f3bfc4<BR>Reserving 48 Bytes for Global Data at: 03f3bf94<BR>Stack Pointer at: 03f3bf78<BR>New Stack Pointer is: 03f3bf78</DIV>  <DIV id=RTEContent>memcopy over<BR>Now running
 in RAM - U-Boot at: 03fdc000<BR>FLASH:<BR>in flash_get_size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; micron is identified ffff<BR>device id in flash.c 18<BR>device id correct</DIV>  <DIV id=RTEContent>in flash_get_size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; micron is identified 1<BR>device id in flash.c 18<BR>device id correct<BR>32 MB<BR>In:&nbsp;&nbsp;&nbsp; serial<BR>Out:&nbsp;&nbsp; serial<BR>Err:&nbsp;&nbsp; serial<BR>KGDB:&nbsp; [on SMC2] kgdb ready<BR>ready<BR>Net:&nbsp;&nbsp; FEC ETHERNET<BR>ent into mainloop<BR>Hit any key to stop autoboot:&nbsp; 0<BR>=&gt;loadb 0x100000 57600<BR>## Ready for binary (kermit) download to 0x00100000 at 57600 bps...<BR>## Total Size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x000e9e5d = 958045 Bytes<BR>## Start Addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x00100000<BR>=&gt;loadb 0x400000 57600<BR>## Ready for binary (kermit) download to 0x00400000 at 57600 bps...<BR>## Total Size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x0039c124 = 3784996 Bytes<BR>## Start
 Addr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x00400000<BR>=&gt;bootm 0x100000 0x400000<BR>## Booting image at 00100000 ...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.13<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 957981 Bytes = 935.5 kB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp; Uncompressing Kernel Image ... gunzip function called<BR>OK<BR>do_bootm_linux called ...do_bootm_linux&nbsp; after ...part2 do_boot_linux before RAM<BR>&nbsp;Disk image loading ...<BR>## Loading RAMDisk Image at 00400000 ...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Ramdisk image<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 3784932 Bytes =&nbsp; 3.6 MB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp;
 00000000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>data is non zero<BR>&nbsp;&nbsp; Loading Ramdisk to 03b9f000, end 03f3b0e4 ... OK<BR>## Transferring control to Linux (at address 00000000) ...<BR></DIV></DIV><p>
		<hr size=1>Yahoo! Shopping<br> 
Find Great Deals on Holiday Gifts at <a href="http://us.rd.yahoo.com/mail_us/footer/shopping/*http://shopping.yahoo.com/;_ylc=X3oDMTE2bzVzaHJtBF9TAzk1OTQ5NjM2BHNlYwNtYWlsdGFnBHNsawNob2xpZGF5LTA1 
">Yahoo! Shopping</a> 
--0-956493263-1135846236=:52787--

--0-854699733-1135846236=:52787
Content-Type: text/plain; name=".config"
Content-Description: 172188218-.config
Content-Disposition: inline; filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.13
# Thu Dec 29 10:54:14 2005
#
CONFIG_MMU=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_GENERIC_NVRAM=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y

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
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
# CONFIG_HOTPLUG is not set
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
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
# CONFIG_MODULES is not set

#
# Processor
#
# CONFIG_6xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_POWER3 is not set
# CONFIG_POWER4 is not set
CONFIG_8xx=y
# CONFIG_E200 is not set
# CONFIG_E500 is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_KEXEC is not set
# CONFIG_CPU_FREQ is not set
CONFIG_WANT_EARLY_SERIAL=y
CONFIG_EMBEDDEDBOOT=y
CONFIG_NOT_COHERENT_CACHE=y

#
# Platform options
#
CONFIG_FADS=y
# CONFIG_RPXLITE is not set
# CONFIG_RPXCLASSIC is not set
# CONFIG_BSEIP is not set
CONFIG_MPC8XXFADS=y
# CONFIG_MPC86XADS is not set
# CONFIG_MPC885ADS is not set
# CONFIG_TQM823L is not set
# CONFIG_TQM850L is not set
# CONFIG_TQM855L is not set
# CONFIG_TQM860L is not set
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
# CONFIG_WINCEPT is not set
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
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="console=ttyCPM1,57600 root=/dev/ram"
# CONFIG_PM is not set
CONFIG_SECCOMP=y
CONFIG_ISA_DMA_API=y

#
# Bus options
#
# CONFIG_PCI is not set
# CONFIG_PCI_DOMAINS is not set
# CONFIG_PCI_QSPAN is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

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
CONFIG_CONSISTENT_START=0xff100000
CONFIG_CONSISTENT_SIZE=0x00200000
CONFIG_BOOT_LOAD=0x00400000

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_ARPD=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_IP_TCPDIAG=y
CONFIG_IP_TCPDIAG_IPV6=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
CONFIG_IPV6=y
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_NETFILTER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
CONFIG_BRIDGE=y
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
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set

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
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
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
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
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

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y

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
# CONFIG_SERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_N_HDLC is not set
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_CPM=y
CONFIG_SERIAL_CPM_CONSOLE=y
# CONFIG_SERIAL_CPM_SCC1 is not set
# CONFIG_SERIAL_CPM_SCC2 is not set
# CONFIG_SERIAL_CPM_SCC3 is not set
# CONFIG_SERIAL_CPM_SCC4 is not set
# CONFIG_SERIAL_CPM_SMC1 is not set
CONFIG_SERIAL_CPM_SMC2=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

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

#
# I2C support
#
# CONFIG_I2C is not set
# CONFIG_I2C_SENSOR is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set

#
# Misc devices
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
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT2_FS_XIP=y
CONFIG_FS_XIP=y
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=y
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

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
# CONFIG_DEVPTS_FS_XATTR is not set
# CONFIG_TMPFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

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
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

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
# MPC8xx CPM Options
#
# CONFIG_SCC_ENET is not set
CONFIG_FEC_ENET=y
CONFIG_USE_MDIO=y
CONFIG_FEC_AM79C874=y
# CONFIG_FEC_LXT970 is not set
# CONFIG_FEC_LXT971 is not set
# CONFIG_FEC_QS6612 is not set
CONFIG_ENET_BIG_BUFFERS=y

#
# Generic MPC8xx Options
#
# CONFIG_8xx_COPYBACK is not set
# CONFIG_8xx_CPU6 is not set
CONFIG_NO_UCODE_PATCH=y
# CONFIG_USB_SOF_UCODE_PATCH is not set
# CONFIG_I2C_SPI_UCODE_PATCH is not set
# CONFIG_I2C_SPI_SMC1_UCODE_PATCH is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC32 is not set
# CONFIG_LIBCRC32C is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=14

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

--0-854699733-1135846236=:52787--
