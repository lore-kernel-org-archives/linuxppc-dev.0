Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15608.mail.cnb.yahoo.com (web15608.mail.cnb.yahoo.com
	[202.165.102.62]) by ozlabs.org (Postfix) with SMTP id AFD4E2BDB5
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 11:39:03 +1000 (EST)
Message-ID: <20040921013859.86944.qmail@web15608.mail.cnb.yahoo.com>
Date: Tue, 21 Sep 2004 09:38:59 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
To: Tom Rini <trini@kernel.crashing.org>, Pantelis Antoniou <panto@intracom.gr>
In-Reply-To: <20040920174914.GM27914@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-dev@ozlabs.org, Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: Linux 2.6.x on 8xx status
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini <trini@kernel.crashing.org> wrote£∫
> Note that the old SCC enet driver, in linuxppc-2.5
> at least is 'OK'.
> Not that it couldn't do with a cleanup and netdev
> person audit, but it's
> functional enough for me and my rpxlite to mount a
> root fs.
> 
> -- 
> Tom Rini
> http://gate.crashing.org/~trini/

Uh, I tried it again on lastest bk pull but still in
vain. What's the problem could be?

--------------------------------------------------
u-boot>set bootfile uImage.rpx26scc2
u-boot>run net_nfs
Using SCC ETHERNET device
TFTP from server 172.16.115.6; our IP address is
172.16.115.7
Filename 'uImage.rpx26scc2'.
Load address: 0x200000
Loading:
####################################################
done
Bytes transferred = 735617 (b3981 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.9-rc2
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    735553 Bytes = 718.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Uncompressing Kernel Image ... OK
Linux version 2.6.9-rc2 (root@shu.edu.net) (gcc
version 3.2.2 20030217 (Yellow Dog Linux 3.0
3.2.2-2a_1)) #1 Tue Sep 21 09:11:09 CST 2004
Built 1 zonelists
Kernel command line: root=/dev/nfs rw
nfsroot=172.16.115.6:/workspace/myfilesystem/target/
ip=172.16.115.7:172.16.115.6:172.16.115.254:255.255.255.0::eth0:off
panic=1
PID hash table entries: 512 (order: 9, 8192 bytes)
Decrementer Frequency = 180000000/60
Dentry cache hash table entries: 16384 (order: 4,
65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768
bytes)
Memory: 63104k available (1292k kernel code, 292k
data, 72k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
NET: Registered protocol family 16
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xfa200a80 (irq = 20) is a CPM UART
ttyCPM1 at MMIO 0xfa200a00 (irq = 46) is a CPM UART
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
loop: loaded (max 8 devices)
eth0: CPM ENET Version 0.2 on SCC2, 00:10:ec:00:37:5b
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind
8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Complete:
      device=eth0, addr=172.16.115.7,
mask=255.255.255.0, gw=172.16.115.254,
     host=172.16.115.7, domain=, nis-domain=(none),
     bootserver=172.16.115.6, rootserver=172.16.115.6,
rootpath=
Looking up port of RPC 100003/2 on 172.16.115.6
Looking up port of RPC 100005/1 on 172.16.115.6
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 72k init
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C0008D98 LR: C000DDAC SP: C0299E00 REGS: c0299d50
TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0FFC9BD4, DSISR: C2000000
TASK = c028fba0[1] 'init' THREAD: c0298000Last
syscall: 6
GPR00: C018ACA0 C0299E00 C028FBA0 0FFC9000 00000100
00003C55 0FFC9000 C0396F24
GPR08: C0190000 C018ACA0 00000000 00078AA0 01160040
1001EE38 03FB1900 00000000
GPR16: 007FFF91 00000000 7FFFF640 007FFF00 00000073
00000001 0FFC9000 C018ACA0
GPR24: 00000000 00000000 C01890FC 00000000 0FFC9BD4
03C55889 C022BAA0 C022BAA0
Call trace: [c003d0e4]  [c003d460]  [c000d35c] 
[c0006608]
Kernel panic - not syncing: Attempted to kill init!
 <0>Rebooting in 1 seconds..

U-Boot 1.1.2 (Aug 31 2004 - 09:47:03)

CPU:   PPC823EZTnnB2 at 48 MHz: 16 kB I-Cache 8 kB
D-Cache
Board: RPXlite_DW
DRAM:  64 MB
FLASH: 16 MB
Hit any key to stop autoboot:  0
u-boot>

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.9-rc2
# Tue Sep 21 09:04:50 2004
#
CONFIG_MMU=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_GENERIC_NVRAM=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_HOTPLUG is not set
CONFIG_IKCONFIG=y
# CONFIG_IKCONFIG_PROC is not set
CONFIG_EMBEDDED=y
# CONFIG_KALLSYMS is not set
CONFIG_FUTEX=y
# CONFIG_EPOLL is not set
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_IOSCHED_CFQ is not set
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
# CONFIG_TINY_SHMEM is not set

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
# CONFIG_E500 is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_CPU_FREQ is not set
CONFIG_EMBEDDEDBOOT=y
CONFIG_NOT_COHERENT_CACHE=y

#
# Platform options
#
CONFIG_RPXLITE=y
# CONFIG_RPXCLASSIC is not set
# CONFIG_BSEIP is not set
# CONFIG_FADS is not set
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
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_HIGHMEM is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_CMDLINE_BOOL is not set

#
# Bus options
#
# CONFIG_PCI is not set
# CONFIG_PCI_DOMAINS is not set
# CONFIG_PCI_QSPAN is not set

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options
are used
#
CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_TASK_SIZE=0x80000000
CONFIG_CONSISTENT_START=0xff100000
CONFIG_CONSISTENT_SIZE=0x00200000
CONFIG_BOOT_LOAD=0x00400000

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

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
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

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
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_NETFILTER is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

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
# CONFIG_BT is not set
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
# CONFIG_FEC_8XX is not set

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
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
# CONFIG_SERIO_I8042 is not set
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL_NONSTANDARD is not set

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
CONFIG_SERIAL_CPM_SCC1=y
# CONFIG_SERIAL_CPM_SCC2 is not set
# CONFIG_SERIAL_CPM_SCC3 is not set
# CONFIG_SERIAL_CPM_SCC4 is not set
CONFIG_SERIAL_CPM_SMC1=y
# CONFIG_SERIAL_CPM_SMC2 is not set
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
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set

#
# I2C support
#
# CONFIG_I2C is not set

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
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=y
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
CONFIG_PROC_KCORE=y
# CONFIG_SYSFS is not set
CONFIG_DEVPTS_FS_XATTR=y
# CONFIG_DEVPTS_FS_SECURITY is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_HFSPLUS_FS is not set
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
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
# CONFIG_EXPORTFS is not set
CONFIG_SUNRPC=y
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# MPC8xx CPM Options
#
CONFIG_SCC_ENET=y
# CONFIG_SCC1_ENET is not set
CONFIG_SCC2_ENET=y
# CONFIG_SCC3_ENET is not set
# CONFIG_FEC_ENET is not set
# CONFIG_ENET_BIG_BUFFERS is not set
# CONFIG_8xx_UART is not set

#
# Generic MPC8xx Options
#
CONFIG_8xx_COPYBACK=y
# CONFIG_8xx_CPU6 is not set
# CONFIG_UCODE_PATCH is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC32 is not set
# CONFIG_LIBCRC32C is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set
---------------------------------------------------

Best regards, 

Sam

_________________________________________________________
Do You Yahoo!?
150ÕÚ«˙MP3∑ËøÒÀ—£¨¥¯ƒ˙¥≥»Î“Ù¿÷µÓÃ√
http://music.yisou.com/
√¿≈Æ√˜–«”¶”–æ°”–£¨À—±È√¿Õº°¢—ﬁÕº∫Õø·Õº
http://image.yisou.com
1GæÕ «1000’◊£¨—≈ª¢µÁ” ◊‘÷˙¿©»›£°
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
