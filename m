Message-ID: <380738B0.7BEF3017@eng.uct.ac.za>
Date: Fri, 15 Oct 1999 16:22:40 +0200
From: Grant Carter <gcarter@eng.uct.ac.za>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel Compilation Problems
Content-Type: multipart/mixed;
 boundary="------------6B99DA4984773F1016642C78"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------6B99DA4984773F1016642C78
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all

I am trying to compile a 2.2.5 kernel for my BSE-IP board with no luck.
The kernel compiles with no errors and I can download the zImage to my
board successfully. The problem comes when I try to run the image: I
just get a line of garbage on my console. I do not even get to the
"Linux/PPC load " prompt.

I pretty much followed the configuration that I found for an MBX board
as I have no reference for a BSE one. If someone has a working .config
for the BSE board, I would really appreciate a copy of it. I have
attached the one that I am currently using.

I am using a egcs-1.1.2 set up as a cross compiler from my x86-FreeBSD
box. It seem to work as I can compile some simple test programs and run
them on my PowerPC just fine.

I believe that I am loading the kernel onto the BSE board correctly as I
have a precompiled kernel which I found on linuxppc.cs.nmt.edu which
works. Is there something that I need to do to the zImage before it can
be executed? It seems like the only 2 things that can be the problem are
a) the compiler is faulty or b) the config is wrong. Since the compiler
can create other executables fine, I don;t think that that is the case.
WRT (b), I am not sure how much the configuration plays in getting the
kernel to run until the Linux/PPC boot prompt. So I am stumped and am
therefore looking for any advice.... 

One other question: Are both the 823's SMC serial ports supported? The
kernel which I have (2.1.127) only finds one.

Many thanks in advance
Grant
-- 
Grant Carter                              gcarter@eng.uct.ac.za
Department of Electrical Engineering      University of Cape Town
Tel: +27 (0)21 650-3467                   Fax: +27 (0)21 650-3465
                     "Coffee not found - operator halted!"
--------------6B99DA4984773F1016642C78
Content-Type: text/plain; charset=us-ascii;
 name=".config"
Content-Disposition: inline;
 filename=".config"
Content-Transfer-Encoding: 7bit

#
# Automatically generated make config: don't edit
#

#
# Platform support
#
CONFIG_PPC=y
# CONFIG_6xx is not set
CONFIG_8xx=y
# CONFIG_MPC821 is not set
CONFIG_MPC823=y
# CONFIG_MPC850 is not set
# CONFIG_MPC860 is not set
# CONFIG_MPC860T is not set
CONFIG_SERIAL_CONSOLE=y
# CONFIG_PMAC is not set
# CONFIG_PREP is not set
# CONFIG_CHRP is not set
# CONFIG_ALL_PPC is not set
# CONFIG_APUS is not set
# CONFIG_MBX is not set
# CONFIG_RPXLITE is not set
# CONFIG_RPXCLASSIC is not set
CONFIG_BSEIP=y
# CONFIG_SMP is not set
CONFIG_MACH_SPECIFIC=y

#
# General setup
#
CONFIG_EXPERIMENTAL=y
# CONFIG_MODULES is not set
# CONFIG_PCI is not set
# CONFIG_PCI_QUIRKS is not set
CONFIG_NET=y
CONFIG_SYSCTL=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_BINFMT_ELF=y
CONFIG_KERNEL_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_BINFMT_JAVA is not set
# CONFIG_PARPORT is not set
# CONFIG_VGA_CONSOLE is not set
# CONFIG_FB is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_IDE is not set

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_ONLY is not set

#
# Additional Block Devices
#
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_XD is not set
CONFIG_PARIDE_PARPORT=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_HD is not set

#
# Networking options
#
# CONFIG_PACKET is not set
# CONFIG_NETLINK is not set
# CONFIG_FIREWALL is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_IP_ALIAS is not set
# CONFIG_SYN_COOKIES is not set

#
# (it is safe to leave these untouched)
#
CONFIG_INET_RARP=y
# CONFIG_SKB_LARGE is not set
# CONFIG_IPV6 is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_BRIDGE is not set
# CONFIG_LLC is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set
# CONFIG_CPU_IS_SLOW is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_ETHERNET=y
# CONFIG_MACE is not set
# CONFIG_BMAC is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_RTL8139 is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_ACENIC is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_EISA is not set
# CONFIG_NET_POCKET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_DLCI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_RADIO is not set
# CONFIG_TR is not set
# CONFIG_SHAPER is not set
# CONFIG_RCPCI is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

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
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_UNIX98_PTYS is not set
# CONFIG_MOUSE is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set

#
# Joystick support
#
# CONFIG_JOYSTICK is not set
# CONFIG_DTLK is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set

#
# Filesystems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_EXT2_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y
# CONFIG_NFSD is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_SMD_DISKLABEL is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_NLS is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_KGDB is not set
# CONFIG_XMON is not set

--------------6B99DA4984773F1016642C78--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
