Return-Path: <som_kadam1@rediffmail.com>
Received: from rediffmail.com (unknown [203.199.83.146])
	by ozlabs.org (Postfix) with SMTP id 2438F68590
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Oct 2005 18:52:48 +1000 (EST)
Date: 17 Oct 2005 08:52:41 -0000
Message-ID: <20051017085241.13510.qmail@webmail24.rediffmail.com>
MIME-Version: 1.0
From: "somshekar chandrashekar kadam" <som_kadam1@rediffmail.com>
To: linuxppc-embedded@ozlabs.org
Content-type: multipart/alternative;
	boundary="Next_1129539161---0-203.199.83.146-13478"
Subject: Re: Linuxppc-embedded Digest, Vol 14, Issue 33
Reply-To: somshekar chandrashekar kadam <som_kadam1@rediffmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 This is a multipart mime message


--Next_1129539161---0-203.199.83.146-13478
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

                                                                        hi =
, =0A i think the message got deleted ,  i am sending it once agn , =0A=0Ai=
 use MPC862 with 64mb ram on my custom board , i use eldk 3.1.1 , with linu=
x-2.4.25 and ramdisk_image.gz provided by  denx eldk , =0A=0Awhen i boot ke=
rnel with ramdisk image , kernel at 0x500000 and ramdisk at 0x600000 , i ge=
t the following message given below , =0Aon uboot i use smc2 , on linux i u=
se scc4 , as i got som eproblem getting smc2 up on linux kernel , i get alw=
ays kernel panic with VFS unable to mount root fs on 01:00 , =0Ai used even=
 multi image clubbing vmlinux.gz and ramdisk_image.gz even this gives me th=
e same result , =0A=0Ais there something else i should configure or i am mi=
ssing something else imp ,=0A=0Athanks in advance =0Aregards=0Aneelu=0A=0A=
=0A     =0AServer Ethernet Address : 00:0d:60:10:6c:15                     =
               =0ATFTP server Address     : 10.140.18.207                  =
                      =0AOur IP Address          : 10.140.18.204           =
                             =0AFilename                : uImage           =
                                    =0ALoad address            : 0x500000  =
                                           =0A                             =
                                                 =0ALoading: ##############=
###################################################     =0A        ########=
########################                                      =0Adone      =
                                                                     =0AByt=
es transferred =3D 495795 (790b3 hex)                                      =
   =0A=3D> tftpboot 0x600000 simple-initrd                                 =
            =0ASCC ETHERNET configured                                     =
                   =0AARP broadcast 1                                      =
                          =0AGot ARP REPLY, set server/gtwy eth addr       =
                                 =0A                                       =
                                       =0AServer Ethernet Address : 00:0d:6=
0:10:6c:15                                    =0ATFTP server Address     : =
10.140.18.207                                        =0AOur IP Address     =
     : 10.140.18.204                                        =0AFilename    =
            : simple-initrd                                        =0ALoad =
address            : 0x600000                                             =
=0A                                                                        =
      =0ALoading: #########################################################=
########     =0A        ###################################################=
##############     =0A        #############################################=
####################     =0A        #######################################=
###############err: c01        =0A###########                              =
                                      =0A        #######err: c01           =
                                            =0A############################=
######################                             =0Adone                 =
                                                          =0ABytes transfer=
red =3D 1618048 (18b080 hex)                                       =0A=3D> =
bootm 0x500000 0x600000                                                    =
 =0A## Booting image at 00500000 ...                                       =
        =0A  Image Name:   Linux-2.4.25                                    =
              =0A  Image Type:   PowerPC Linux Kernel Image (gzip compresse=
d)                  =0A  Data Size:    495731 Bytes =3D 484.1 kB           =
                            =0A  Load Address: 00000000                    =
                                  =0A  Entry Point:  00000000              =
                                        =0A  Verifying Checksum ... OK     =
                                              =0A  Uncompressing Kernel Ima=
ge ... versio04                                     =0A0 at300 n pty: 256 U=
nix98 ptys configured  =0A=0A=0ATransferring control to Linux (at address 0=
0000000) ...                     =0Azone 163ageszone 0 p.crsio3.3 X EL.1.1.=
3-910 Sct 1:59:DT 2                     =0A                    n(2):agesKer=
nommaine:t=3D/dam rDecrter uenc36000/60Warn ream=0AMe: 8kil (86ernede,  dat=
4k i 0k mem)Dentacheh taentr 819rder 655ytesIncachsh t =0ACPRT dr ven 0.040=
 at300 n SCsing1     =0A----------------------------? smc2 =0A=0A----------=
--------------? scc4 onwards=0A                                   =0A__iore=
map(): phys addr 03e13000 is RAM lr c000c1c8                             =
=0ARAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize   =
       =0ANET4: Linux TCP/IP 1.0 for NET4.0                                =
              =0AIP Protocols: ICMP, UDP, TCP                              =
                     =0AIP: routing cache hash table of 512 buckets, 4Kbyte=
s                           =0ATCP: Hash tables configured (established 409=
6 bind 8192)                       =0ANET4: Unix domain sockets 1.0/SMP for=
 Linux NET4.0.                            =0AKernel panic: VFS: Unable to m=
ount root fs on 01:00                            =0A<0>Rebooting in 180 sec=
onds..                                                 =0A                 =
                 =0A-------------- next part --------------=0A#=0A# Automat=
ically generated by make menuconfig: don't edit=0A#=0A# CONFIG_UID16 is not=
 set=0A# CONFIG_RWSEM_GENERIC_SPINLOCK is not set=0ACONFIG_RWSEM_XCHGADD_AL=
GORITHM=3Dy=0ACONFIG_HAVE_DEC_LOCK=3Dy=0A=0A#=0A# Code maturity level optio=
ns=0A#=0ACONFIG_EXPERIMENTAL=3Dy=0A# CONFIG_ADVANCED_OPTIONS is not set=0A=
=0A#=0A# Loadable module support=0A#=0ACONFIG_MODULES=3Dy=0A# CONFIG_MODVER=
SIONS is not set=0ACONFIG_KMOD=3Dy=0A=0A#=0A# Platform support=0A#=0ACONFIG=
_PPC=3Dy=0ACONFIG_PPC32=3Dy=0A# CONFIG_6xx is not set=0A# CONFIG_40x is not=
 set=0A# CONFIG_44x is not set=0A# CONFIG_POWER3 is not set=0A# CONFIG_POWE=
R4 is not set=0ACONFIG_8xx=3Dy=0A# CONFIG_PPC_STD_MMU is not set=0ACONFIG_S=
ERIAL_CONSOLE=3Dy=0ACONFIG_NOT_COHERENT_CACHE=3Dy=0A# CONFIG_ADDER_II is no=
t set=0A# CONFIG_AMX860 is not set=0A# CONFIG_BSEIP is not set=0A# CONFIG_C=
CM is not set=0A# CONFIG_DBOX2 is not set=0A# CONFIG_DAB4K is not set=0A# C=
ONFIG_FADS is not set=0A# CONFIG_FPS850L is not set=0A# CONFIG_FPS860L is n=
ot set=0A# CONFIG_HERMES_PRO is not set=0A# CONFIG_IP860 is not set=0A# CON=
FIG_IVML24 is not set=0A# CONFIG_IVMS8 is not set=0A# CONFIG_LANTEC is not =
set=0A# CONFIG_LWMON is not set=0ACONFIG_MBX=3Dy=0A# CONFIG_NSCU is not set=
=0A# CONFIG_NC650 is not set=0A# CONFIG_PCU_E is not set=0A# CONFIG_QUANTUM=
 is not set=0A# CONFIG_RBC823 is not set=0A# CONFIG_RMU is not set=0A# CONF=
IG_RPXCLASSIC is not set=0A# CONFIG_RPXLITE is not set=0A# CONFIG_SM850 is =
not set=0A# CONFIG_SPD823TS is not set=0A# CONFIG_TQM823L is not set=0A# CO=
NFIG_TQM823M is not set=0A# CONFIG_TQM850L is not set=0A# CONFIG_TQM850M is=
 not set=0A# CONFIG_TQM855L is not set=0A# CONFIG_TQM855M is not set=0A# CO=
NFIG_TQM860M is not set=0A# CONFIG_TQM862M is not set=0A# CONFIG_TQM860L is=
 not set=0A# CONFIG_UC100 is not set=0A# CONFIG_VIPER860 is not set=0A# CON=
FIG_WINCEPT is not set=0A# CONFIG_ALL_PPC is not set=0A# CONFIG_SMP is not =
set=0ACONFIG_MATH_EMULATION=3Dy=0ACONFIG_EMBEDDEDBOOT=3Dy=0A=0A#=0A# Genera=
l setup=0A#=0A# CONFIG_HIGHMEM is not set=0ACONFIG_HIGHMEM_START=3D0xfe0000=
00=0ACONFIG_LOWMEM_SIZE=3D0x30000000=0ACONFIG_KERNEL_START=3D0xc0000000=0AC=
ONFIG_TASK_SIZE=3D0x80000000=0A# CONFIG_ISA is not set=0A# CONFIG_EISA is n=
ot set=0A# CONFIG_SBUS is not set=0A# CONFIG_MCA is not set=0A# CONFIG_PCI_=
QSPAN is not set=0A# CONFIG_PCI is not set=0ACONFIG_NET=3Dy=0ACONFIG_SYSCTL=
=3Dy=0ACONFIG_SYSVIPC=3Dy=0A# CONFIG_BSD_PROCESS_ACCT is not set=0ACONFIG_K=
CORE_ELF=3Dy=0ACONFIG_BINFMT_ELF=3Dy=0ACONFIG_KERNEL_ELF=3Dy=0ACONFIG_BINFM=
T_MISC=3Dy=0A# CONFIG_OOM_KILLER is not set=0A# CONFIG_HOTPLUG is not set=
=0A# CONFIG_PCMCIA is not set=0A=0A#=0A# Parallel port support=0A#=0A# CONF=
IG_PARPORT is not set=0A# CONFIG_GEN_RTC is not set=0A# CONFIG_PPC_RTC is n=
ot set=0ACONFIG_CMDLINE_BOOL=3Dy=0ACONFIG_CMDLINE=3D"devfs=3Dmount rw root=
=3Dramfs"=0A=0A#=0A# Embedded options=0A#=0A# CONFIG_EMBEDDED is not set=0A=
=0A#=0A# Memory Technology Devices (MTD)=0A#=0A# CONFIG_MTD is not set=0A=
=0A#=0A# Plug and Play configuration=0A#=0A# CONFIG_PNP is not set=0A# CONF=
IG_ISAPNP is not set=0A=0A#=0A# Block devices=0A#=0A# CONFIG_BLK_DEV_FD is =
not set=0A# CONFIG_BLK_DEV_XD is not set=0A# CONFIG_PARIDE is not set=0A# C=
ONFIG_BLK_CPQ_DA is not set=0A# CONFIG_BLK_CPQ_CISS_DA is not set=0A# CONFI=
G_CISS_SCSI_TAPE is not set=0A# CONFIG_CISS_MONITOR_THREAD is not set=0A# C=
ONFIG_BLK_DEV_DAC960 is not set=0A# CONFIG_BLK_DEV_UMEM is not set=0A# CONF=
IG_BLK_DEV_LOOP is not set=0A# CONFIG_BLK_DEV_NBD is not set=0ACONFIG_BLK_D=
EV_RAM=3Dy=0ACONFIG_BLK_DEV_RAM_SIZE=3D4096=0ACONFIG_BLK_DEV_INITRD=3Dy=0A#=
 CONFIG_BLK_STATS is not set=0A=0A#=0A# Multi-device support (RAID and LVM)=
=0A#=0A# CONFIG_MD is not set=0A# CONFIG_BLK_DEV_MD is not set=0A# CONFIG_M=
D_LINEAR is not set=0A# CONFIG_MD_RAID0 is not set=0A# CONFIG_MD_RAID1 is n=
ot set=0A# CONFIG_MD_RAID5 is not set=0A# CONFIG_MD_MULTIPATH is not set=0A=
# CONFIG_BLK_DEV_LVM is not set=0A=0A#=0A# Networking options=0A#=0ACONFIG_=
PACKET=3Dy=0A# CONFIG_PACKET_MMAP is not set=0ACONFIG_NETLINK_DEV=3Dy=0A# C=
ONFIG_NETFILTER is not set=0A# CONFIG_FILTER is not set=0ACONFIG_UNIX=3Dy=
=0ACONFIG_INET=3Dy=0A# CONFIG_IP_MULTICAST is not set=0A# CONFIG_IP_ADVANCE=
D_ROUTER is not set=0ACONFIG_IP_PNP=3Dy=0A# CONFIG_IP_PNP_DHCP is not set=
=0A# CONFIG_IP_PNP_BOOTP is not set=0A# CONFIG_IP_PNP_RARP is not set=0A# C=
ONFIG_NET_IPIP is not set=0A# CONFIG_NET_IPGRE is not set=0A# CONFIG_ARPD i=
s not set=0A# CONFIG_INET_ECN is not set=0A# CONFIG_SYN_COOKIES is not set=
=0A# CONFIG_IPV6 is not set=0A# CONFIG_KHTTPD is not set=0A=0A#=0A#    SCTP=
 Configuration (EXPERIMENTAL)=0A#=0ACONFIG_IPV6_SCTP__=3Dy=0A# CONFIG_IP_SC=
TP is not set=0A# CONFIG_ATM is not set=0A# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_IPX is not set=0A# CONFIG_ATALK is not set=0A=0A#=0A# Appletalk de=
vices=0A#=0A# CONFIG_DEV_APPLETALK is not set=0A# CONFIG_DECNET is not set=
=0A# CONFIG_BRIDGE is not set=0A# CONFIG_X25 is not set=0A# CONFIG_LAPB is =
not set=0A# CONFIG_LLC is not set=0A# CONFIG_NET_DIVERT is not set=0A# CONF=
IG_ECONET is not set=0A# CONFIG_WAN_ROUTER is not set=0A# CONFIG_NET_FASTRO=
UTE is not set=0A# CONFIG_NET_HW_FLOWCONTROL is not set=0A=0A#=0A# QoS and/=
or fair queueing=0A#=0A# CONFIG_NET_SCHED is not set=0A=0A#=0A# Network tes=
ting=0A#=0A# CONFIG_NET_PKTGEN is not set=0A=0A#=0A# ATA/IDE/MFM/RLL suppor=
t=0A#=0A# CONFIG_IDE is not set=0A# CONFIG_BLK_DEV_HD is not set=0A=0A#=0A#=
 SCSI support=0A#=0A# CONFIG_SCSI is not set=0A=0A#=0A# Fusion MPT device s=
upport=0A#=0A# CONFIG_FUSION is not set=0A# CONFIG_FUSION_BOOT is not set=
=0A# CONFIG_FUSION_ISENSE is not set=0A# CONFIG_FUSION_CTL is not set=0A# C=
ONFIG_FUSION_LAN is not set=0A=0A#=0A# I2O device support=0A#=0A# CONFIG_I2=
O is not set=0A# CONFIG_I2O_BLOCK is not set=0A# CONFIG_I2O_LAN is not set=
=0A# CONFIG_I2O_SCSI is not set=0A# CONFIG_I2O_PROC is not set=0A=0A#=0A# N=
etwork device support=0A#=0ACONFIG_NETDEVICES=3Dy=0A=0A#=0A# ARCnet devices=
=0A#=0A# CONFIG_ARCNET is not set=0A# CONFIG_DUMMY is not set=0A# CONFIG_BO=
NDING is not set=0A# CONFIG_EQUALIZER is not set=0A# CONFIG_TUN is not set=
=0A# CONFIG_ETHERTAP is not set=0A=0A#=0A# Ethernet (10 or 100Mbit)=0A#=0AC=
ONFIG_NET_ETHERNET=3Dy=0A# CONFIG_MACE is not set=0A# CONFIG_BMAC is not se=
t=0A# CONFIG_GMAC is not set=0A# CONFIG_SUNLANCE is not set=0A# CONFIG_SUNB=
MAC is not set=0A# CONFIG_SUNQE is not set=0A# CONFIG_SUNGEM is not set=0A#=
 CONFIG_NET_VENDOR_3COM is not set=0A# CONFIG_LANCE is not set=0A# CONFIG_N=
ET_VENDOR_SMC is not set=0A# CONFIG_NET_VENDOR_RACAL is not set=0A# CONFIG_=
NET_ISA is not set=0A# CONFIG_NET_PCI is not set=0A# CONFIG_NET_POCKET is n=
ot set=0A=0A#=0A# Ethernet (1000 Mbit)=0A#=0A# CONFIG_ACENIC is not set=0A#=
 CONFIG_DL2K is not set=0A# CONFIG_E1000 is not set=0A# CONFIG_MYRI_SBUS is=
 not set=0A# CONFIG_NS83820 is not set=0A# CONFIG_HAMACHI is not set=0A# CO=
NFIG_YELLOWFIN is not set=0A# CONFIG_R8169 is not set=0A# CONFIG_SK98LIN is=
 not set=0A# CONFIG_TIGON3 is not set=0A# CONFIG_FDDI is not set=0A# CONFIG=
_NETCONSOLE is not set=0A# CONFIG_HIPPI is not set=0A# CONFIG_PLIP is not s=
et=0A# CONFIG_PPP is not set=0A# CONFIG_SLIP is not set=0A=0A#=0A# Wireless=
 LAN (non-hamradio)=0A#=0A# CONFIG_NET_RADIO is not set=0A=0A#=0A# Token Ri=
ng devices=0A#=0A# CONFIG_TR is not set=0A# CONFIG_NET_FC is not set=0A# CO=
NFIG_RCPCI is not set=0A# CONFIG_SHAPER is not set=0A=0A#=0A# Wan interface=
s=0A#=0A# CONFIG_WAN is not set=0A=0A#=0A# Amateur Radio support=0A#=0A# CO=
NFIG_HAMRADIO is not set=0A=0A#=0A# IrDA (infrared) support=0A#=0A# CONFIG_=
IRDA is not set=0A=0A#=0A# ISDN subsystem=0A#=0A# CONFIG_ISDN is not set=0A=
=0A#=0A# Old CD-ROM drivers (not SCSI, not IDE)=0A#=0A# CONFIG_CD_NO_IDESCS=
I is not set=0A=0A#=0A# Console drivers=0A#=0A=0A#=0A# Frame-buffer support=
=0A#=0A# CONFIG_FB is not set=0A=0A#=0A# Input core support=0A#=0A# CONFIG_=
INPUT is not set=0A# CONFIG_INPUT_KEYBDEV is not set=0A# CONFIG_INPUT_MOUSE=
DEV is not set=0A# CONFIG_INPUT_JOYDEV is not set=0A# CONFIG_INPUT_EVDEV is=
 not set=0A# CONFIG_INPUT_UINPUT is not set=0A=0A#=0A# Macintosh device dri=
vers=0A#=0A=0A#=0A# Character devices=0A#=0A# CONFIG_VT is not set=0A# CONF=
IG_SERIAL is not set=0A# CONFIG_SERIAL_EXTENDED is not set=0A# CONFIG_SERIA=
L_NONSTANDARD is not set=0ACONFIG_UNIX98_PTYS=3Dy=0ACONFIG_UNIX98_PTY_COUNT=
=3D32=0A=0A#=0A# I2C support=0A#=0A# CONFIG_I2C is not set=0A=0A#=0A# Mice=
=0A#=0A# CONFIG_BUSMOUSE is not set=0A# CONFIG_MOUSE is not set=0A=0A#=0A# =
Joysticks=0A#=0A# CONFIG_INPUT_GAMEPORT is not set=0A# CONFIG_QIC02_TAPE is=
 not set=0A# CONFIG_IPMI_HANDLER is not set=0A# CONFIG_IPMI_PANIC_EVENT is =
not set=0A# CONFIG_IPMI_DEVICE_INTERFACE is not set=0A# CONFIG_IPMI_KCS is =
not set=0A# CONFIG_IPMI_WATCHDOG is not set=0A=0A#=0A# Watchdog Cards=0A#=
=0A# CONFIG_WATCHDOG is not set=0A# CONFIG_SCx200 is not set=0A# CONFIG_SCx=
200_GPIO is not set=0A# CONFIG_AMD_PM768 is not set=0A# CONFIG_NVRAM is not=
 set=0A# CONFIG_RTC is not set=0A# CONFIG_RTC_11_MINUTE_MODE is not set=0A#=
 CONFIG_RTC_8XX is not set=0A# CONFIG_DTLK is not set=0A# CONFIG_R3964 is n=
ot set=0A# CONFIG_APPLICOM is not set=0A# CONFIG_FLASH is not set=0A=0A#=0A=
# Ftape, the floppy tape device driver=0A#=0A# CONFIG_FTAPE is not set=0A# =
CONFIG_AGP is not set=0A=0A#=0A# Direct Rendering Manager (XFree86 DRI supp=
ort)=0A#=0A# CONFIG_DRM is not set=0A=0A#=0A# Multimedia devices=0A#=0A# CO=
NFIG_VIDEO_DEV is not set=0A=0A#=0A# File systems=0A#=0A# CONFIG_QUOTA is n=
ot set=0A# CONFIG_QFMT_V2 is not set=0ACONFIG_AUTOFS_FS=3Dy=0A# CONFIG_AUTO=
FS4_FS is not set=0A# CONFIG_REISERFS_FS is not set=0A# CONFIG_REISERFS_CHE=
CK is not set=0A# CONFIG_REISERFS_PROC_INFO is not set=0A# CONFIG_ADFS_FS i=
s not set=0A# CONFIG_ADFS_FS_RW is not set=0A# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A# CONFIG_HFSPLUS_FS is not set=0A# CONFIG_BEFS=
_FS is not set=0A# CONFIG_BEFS_DEBUG is not set=0A# CONFIG_BFS_FS is not se=
t=0A# CONFIG_EXT3_FS is not set=0A# CONFIG_JBD is not set=0A# CONFIG_JBD_DE=
BUG is not set=0A# CONFIG_FAT_FS is not set=0A# CONFIG_MSDOS_FS is not set=
=0A# CONFIG_UMSDOS_FS is not set=0A# CONFIG_VFAT_FS is not set=0A# CONFIG_E=
FS_FS is not set=0A# CONFIG_JFFS_FS is not set=0A# CONFIG_JFFS2_FS is not s=
et=0A# CONFIG_CRAMFS is not set=0A# CONFIG_TMPFS is not set=0ACONFIG_RAMFS=
=3Dy=0A# CONFIG_ISO9660_FS is not set=0A# CONFIG_JOLIET is not set=0A# CONF=
IG_ZISOFS is not set=0A# CONFIG_JFS_FS is not set=0A# CONFIG_JFS_DEBUG is n=
ot set=0A# CONFIG_JFS_STATISTICS is not set=0A# CONFIG_MINIX_FS is not set=
=0A# CONFIG_VXFS_FS is not set=0A# CONFIG_NTFS_FS is not set=0A# CONFIG_NTF=
S_RW is not set=0A# CONFIG_HPFS_FS is not set=0ACONFIG_PROC_FS=3Dy=0A# CONF=
IG_DEVFS_FS is not set=0A# CONFIG_DEVFS_MOUNT is not set=0A# CONFIG_DEVFS_D=
EBUG is not set=0A# CONFIG_DEVPTS_FS is not set=0A# CONFIG_QNX4FS_FS is not=
 set=0A# CONFIG_QNX4FS_RW is not set=0A# CONFIG_ROMFS_FS is not set=0ACONFI=
G_EXT2_FS=3Dy=0A# CONFIG_SYSV_FS is not set=0A# CONFIG_UDF_FS is not set=0A=
# CONFIG_UDF_RW is not set=0A# CONFIG_UFS_FS is not set=0A# CONFIG_UFS_FS_W=
RITE is not set=0A# CONFIG_XFS_FS is not set=0A# CONFIG_XFS_QUOTA is not se=
t=0A# CONFIG_XFS_RT is not set=0A# CONFIG_XFS_TRACE is not set=0A# CONFIG_X=
FS_DEBUG is not set=0A=0A#=0A# Network File Systems=0A#=0A# CONFIG_CODA_FS =
is not set=0A# CONFIG_INTERMEZZO_FS is not set=0A# CONFIG_NFS_FS is not set=
=0A# CONFIG_NFS_V3 is not set=0A# CONFIG_NFS_DIRECTIO is not set=0A# CONFIG=
_ROOT_NFS is not set=0A# CONFIG_NFSD is not set=0A# CONFIG_NFSD_V3 is not s=
et=0A# CONFIG_NFSD_TCP is not set=0A# CONFIG_SUNRPC is not set=0A# CONFIG_L=
OCKD is not set=0A# CONFIG_SMB_FS is not set=0A# CONFIG_NCP_FS is not set=
=0A# CONFIG_NCPFS_PACKET_SIGNING is not set=0A# CONFIG_NCPFS_IOCTL_LOCKING =
is not set=0A# CONFIG_NCPFS_STRONG is not set=0A# CONFIG_NCPFS_NFS_NS is no=
t set=0A# CONFIG_NCPFS_OS2_NS is not set=0A# CONFIG_NCPFS_SMALLDOS is not s=
et=0A# CONFIG_NCPFS_NLS is not set=0A# CONFIG_NCPFS_EXTRAS is not set=0A# C=
ONFIG_ZISOFS_FS is not set=0A=0A#=0A# Partition Types=0A#=0A# CONFIG_PARTIT=
ION_ADVANCED is not set=0ACONFIG_MSDOS_PARTITION=3Dy=0A# CONFIG_SMB_NLS is =
not set=0A# CONFIG_NLS is not set=0A=0A#=0A# Sound=0A#=0A# CONFIG_SOUND is =
not set=0A=0A#=0A# MPC8xx Options=0A#=0A# CONFIG_8xx_COPYBACK is not set=0A=
# CONFIG_8xx_CPU6 is not set=0A# CONFIG_8xx_CPU15 is not set=0A# CONFIG_UCO=
DE_PATCH is not set=0A# CONFIG_CPM_TRACK_LOAD is not set=0A# CONFIG_SCC_ENE=
T is not set=0A# CONFIG_SCC1_ENET is not set=0A# CONFIG_SCC2_ENET is not se=
t=0A# CONFIG_SCC3_ENET is not set=0A# CONFIG_FEC_ENET is not set=0A# CONFIG=
_ENET_BIG_BUFFERS is not set=0A# CONFIG_HDLC_ENET is not set=0A# CONFIG_8xx=
_SMC1 is not set=0A# CONFIG_8xx_SMC2 is not set=0ACONFIG_8xx_SCC_UART=3Dy=
=0A# CONFIG_8xx_SCC1_UART is not set=0A# CONFIG_8xx_SCC2_UART is not set=0A=
# CONFIG_8xx_SCC3_UART is not set=0ACONFIG_8xx_SCC4_UART=3Dy=0ACONFIG_PORT_=
CTS4_NONE=3Dy=0A# CONFIG_UART_CTS_CONTROL_SCC4 is not set=0ACONFIG_PORT_RTS=
4_NONE=3Dy=0A# CONFIG_PORT_RTS4_B is not set=0A# CONFIG_PORT_RTS4_C is not =
set=0A# CONFIG_PORT_RTS4_D is not set=0ACONFIG_PORT_CD4_NONE=3Dy=0A# CONFIG=
_UART_CD_CONTROL_SCC4 is not set=0ACONFIG_PORT_DTR4_NONE=3Dy=0A# CONFIG_POR=
T_DTR4_A is not set=0A# CONFIG_PORT_DTR4_B is not set=0A# CONFIG_PORT_DTR4_=
C is not set=0A# CONFIG_PORT_DTR4_D is not set=0ACONFIG_8xx_SCC4_UART_MAXID=
L=3D1=0ACONFIG_8xx_SCC4_UART_RX_BDNUM=3D4=0ACONFIG_8xx_SCC4_UART_RX_BDSIZE=
=3D32=0ACONFIG_8xx_SCC4_UART_TX_BDNUM=3D4=0ACONFIG_8xx_SCC4_UART_TX_BDSIZE=
=3D32=0A=0A#=0A# USB support=0A#=0A# CONFIG_USB is not set=0A=0A#=0A# Suppo=
rt for USB gadgets=0A#=0A# CONFIG_USB_GADGET is not set=0A=0A#=0A# Bluetoot=
h support=0A#=0A# CONFIG_BLUEZ is not set=0A=0A#=0A# Cryptographic options=
=0A#=0A# CONFIG_CRYPTO is not set=0A=0A#=0A# Library routines=0A#=0A# CONFI=
G_CRC32 is not set=0A# CONFIG_ZLIB_INFLATE is not set=0A# CONFIG_ZLIB_DEFLA=
TE is not set=0A=0A#=0A# Kernel hacking=0A#=0A# CONFIG_DEBUG_KERNEL is not =
set=0ACONFIG_LOG_BUF_SHIFT=3D0=0A=0A
--Next_1129539161---0-203.199.83.146-13478
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; hi , <BR>=0A i think the message got delet=
ed ,&nbsp; i am sending it once agn , <BR>=0A<BR>=0Ai use MPC862 with 64mb =
ram on my custom board , i use eldk 3.1.1 , with linux-2.4.25 and ramdisk_i=
mage.gz provided by&nbsp; denx eldk , <BR>=0A<BR>=0Awhen i boot kernel with=
 ramdisk image , kernel at 0x500000 and ramdisk at 0x600000 , i get the fol=
lowing message given below , <BR>=0Aon uboot i use smc2 , on linux i use sc=
c4 , as i got som eproblem getting smc2 up on linux kernel , i get always k=
ernel panic with VFS unable to mount root fs on 01:00 , <BR>=0Ai used even =
multi image clubbing vmlinux.gz and ramdisk_image.gz even this gives me the=
 same result , <BR>=0A<BR>=0Ais there something else i should configure or =
i am missing something else imp ,<BR>=0A<BR>=0Athanks in advance <BR>=0Areg=
ards<BR>=0Aneelu<BR>=0A<BR>=0A<BR>=0A&nbsp; &nbsp;  <BR>=0AServer Ethernet =
Address : 00:0d:60:10:6c:15&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; <BR>=0ATFTP server Address&nbsp; &nbsp;  : 10.140.18.207&nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0AOur IP Address&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; : 10.140.18.204&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0AFilename&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; : uImage&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0ALoad address&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : 0x500000&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A&nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0ALoading: ###########################=
######################################&nbsp; &nbsp;  <BR>=0A&nbsp; &nbsp; &=
nbsp; &nbsp; ################################&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; <BR>=0Adone&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <=
BR>=0ABytes transferred =3D 495795 (790b3 hex)&nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A=3D&gt; tftpboot 0x600000 simpl=
e-initrd&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp;  <BR>=0ASCC ETHERNET configured&nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; <BR>=0AARP broadcast 1&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0AGot ARP REPLY, set server/gtwy et=
h addr&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=
=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0AServer Ethernet A=
ddress : 00:0d:60:10:6c:15&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; <BR>=0ATFTP server Address&nbsp; &nbsp;  : 10.140.18.207&nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0AOur IP Address&nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; : 10.140.18.204&nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0AFilename&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; : simple-initrd&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0ALoad address&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; : 0x600000&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; <BR>=0ALoading: ###########################################=
######################&nbsp; &nbsp;  <BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; ###=
##############################################################&nbsp; &nbsp;=
  <BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; ######################################=
###########################&nbsp; &nbsp;  <BR>=0A&nbsp; &nbsp; &nbsp; &nbsp=
; ######################################################err: c01&nbsp; &nbs=
p; &nbsp; &nbsp; <BR>=0A###########&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0A&nbsp; &nbsp; &nbsp;=
 &nbsp; #######err: c01&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A#####=
#############################################&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=
=0Adone&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0ABytes transferred =3D 1618=
048 (18b080 hex)&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  =
<BR>=0A=3D&gt; bootm 0x500000 0x600000&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=
=0A## Booting image at 00500000 ...&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A&nbsp; Image Name:&nb=
sp;  Linux-2.4.25&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0A&nbsp; Image Type:&nbsp;  =
PowerPC Linux Kernel Image (gzip compressed)&nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0A&nbsp; Data Size:&nbsp; &nbsp; 49573=
1 Bytes =3D 484.1 kB&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;  <BR>=0A&nbsp; Load Address: 00000000&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; <BR>=0A&nbsp; Entry Point:&nbsp; 00000000&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; <BR>=0A&nbsp; Verifying Checksum ... OK&nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <=
BR>=0A&nbsp; Uncompressing Kernel Image ... versio04&nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A0 at300 n pty: 256 Unix98 ptys configur=
ed&nbsp; <BR>=0A<BR>=0A<BR>=0ATransferring control to Linux (at address 000=
00000) ...&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp;  <BR>=0Azone 163ageszone 0 p.crsio3.3 X EL.1.1.3-910 Sct 1:59:DT 2&nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A&=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; n(2):a=
gesKernommaine:t=3D/dam rDecrter uenc36000/60Warn ream<BR>=0AMe: 8kil (86er=
nede,&nbsp; dat4k i 0k mem)Dentacheh taentr 819rder 655ytesIncachsh t <BR>=
=0ACPRT dr ven 0.040 at300 n SCsing1&nbsp; &nbsp;  <BR>=0A-----------------=
-----------? smc2 <BR>=0A<BR>=0A------------------------? scc4 onwards<BR>=
=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A__ioremap(): phys ad=
dr 03e13000 is RAM lr c000c1c8&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0ARAMDISK driver=
 initialized: 16 RAM disks of 4096K size 1024 blocksize&nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; <BR>=0ANET4: Linux TCP/IP 1.0 for NET4.0&nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0AIP=
 Protocols: ICMP, UDP, TCP&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0AIP: routing cach=
e hash table of 512 buckets, 4Kbytes&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0ATCP: Hash table=
s configured (established 4096 bind 8192)&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0ANET4: Unix domain socket=
s 1.0/SMP for Linux NET4.0.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0AKernel panic: VFS:=
 Unable to mount root fs on 01:00&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <BR>=0A&lt;0&gt;Reb=
ooting in 180 seconds..&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; <BR>=0A-------------- next part --------------<BR>=0A#<BR=
>=0A# Automatically generated by make menuconfig: don't edit<BR>=0A#<BR>=0A=
# CONFIG_UID16 is not set<BR>=0A# CONFIG_RWSEM_GENERIC_SPINLOCK is not set<=
BR>=0ACONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy<BR>=0ACONFIG_HAVE_DEC_LOCK=3Dy<BR>=
=0A<BR>=0A#<BR>=0A# Code maturity level options<BR>=0A#<BR>=0ACONFIG_EXPERI=
MENTAL=3Dy<BR>=0A# CONFIG_ADVANCED_OPTIONS is not set<BR>=0A<BR>=0A#<BR>=0A=
# Loadable module support<BR>=0A#<BR>=0ACONFIG_MODULES=3Dy<BR>=0A# CONFIG_M=
ODVERSIONS is not set<BR>=0ACONFIG_KMOD=3Dy<BR>=0A<BR>=0A#<BR>=0A# Platform=
 support<BR>=0A#<BR>=0ACONFIG_PPC=3Dy<BR>=0ACONFIG_PPC32=3Dy<BR>=0A# CONFIG=
_6xx is not set<BR>=0A# CONFIG_40x is not set<BR>=0A# CONFIG_44x is not set=
<BR>=0A# CONFIG_POWER3 is not set<BR>=0A# CONFIG_POWER4 is not set<BR>=0ACO=
NFIG_8xx=3Dy<BR>=0A# CONFIG_PPC_STD_MMU is not set<BR>=0ACONFIG_SERIAL_CONS=
OLE=3Dy<BR>=0ACONFIG_NOT_COHERENT_CACHE=3Dy<BR>=0A# CONFIG_ADDER_II is not =
set<BR>=0A# CONFIG_AMX860 is not set<BR>=0A# CONFIG_BSEIP is not set<BR>=0A=
# CONFIG_CCM is not set<BR>=0A# CONFIG_DBOX2 is not set<BR>=0A# CONFIG_DAB4=
K is not set<BR>=0A# CONFIG_FADS is not set<BR>=0A# CONFIG_FPS850L is not s=
et<BR>=0A# CONFIG_FPS860L is not set<BR>=0A# CONFIG_HERMES_PRO is not set<B=
R>=0A# CONFIG_IP860 is not set<BR>=0A# CONFIG_IVML24 is not set<BR>=0A# CON=
FIG_IVMS8 is not set<BR>=0A# CONFIG_LANTEC is not set<BR>=0A# CONFIG_LWMON =
is not set<BR>=0ACONFIG_MBX=3Dy<BR>=0A# CONFIG_NSCU is not set<BR>=0A# CONF=
IG_NC650 is not set<BR>=0A# CONFIG_PCU_E is not set<BR>=0A# CONFIG_QUANTUM =
is not set<BR>=0A# CONFIG_RBC823 is not set<BR>=0A# CONFIG_RMU is not set<B=
R>=0A# CONFIG_RPXCLASSIC is not set<BR>=0A# CONFIG_RPXLITE is not set<BR>=
=0A# CONFIG_SM850 is not set<BR>=0A# CONFIG_SPD823TS is not set<BR>=0A# CON=
FIG_TQM823L is not set<BR>=0A# CONFIG_TQM823M is not set<BR>=0A# CONFIG_TQM=
850L is not set<BR>=0A# CONFIG_TQM850M is not set<BR>=0A# CONFIG_TQM855L is=
 not set<BR>=0A# CONFIG_TQM855M is not set<BR>=0A# CONFIG_TQM860M is not se=
t<BR>=0A# CONFIG_TQM862M is not set<BR>=0A# CONFIG_TQM860L is not set<BR>=
=0A# CONFIG_UC100 is not set<BR>=0A# CONFIG_VIPER860 is not set<BR>=0A# CON=
FIG_WINCEPT is not set<BR>=0A# CONFIG_ALL_PPC is not set<BR>=0A# CONFIG_SMP=
 is not set<BR>=0ACONFIG_MATH_EMULATION=3Dy<BR>=0ACONFIG_EMBEDDEDBOOT=3Dy<B=
R>=0A<BR>=0A#<BR>=0A# General setup<BR>=0A#<BR>=0A# CONFIG_HIGHMEM is not s=
et<BR>=0ACONFIG_HIGHMEM_START=3D0xfe000000<BR>=0ACONFIG_LOWMEM_SIZE=3D0x300=
00000<BR>=0ACONFIG_KERNEL_START=3D0xc0000000<BR>=0ACONFIG_TASK_SIZE=3D0x800=
00000<BR>=0A# CONFIG_ISA is not set<BR>=0A# CONFIG_EISA is not set<BR>=0A# =
CONFIG_SBUS is not set<BR>=0A# CONFIG_MCA is not set<BR>=0A# CONFIG_PCI_QSP=
AN is not set<BR>=0A# CONFIG_PCI is not set<BR>=0ACONFIG_NET=3Dy<BR>=0ACONF=
IG_SYSCTL=3Dy<BR>=0ACONFIG_SYSVIPC=3Dy<BR>=0A# CONFIG_BSD_PROCESS_ACCT is n=
ot set<BR>=0ACONFIG_KCORE_ELF=3Dy<BR>=0ACONFIG_BINFMT_ELF=3Dy<BR>=0ACONFIG_=
KERNEL_ELF=3Dy<BR>=0ACONFIG_BINFMT_MISC=3Dy<BR>=0A# CONFIG_OOM_KILLER is no=
t set<BR>=0A# CONFIG_HOTPLUG is not set<BR>=0A# CONFIG_PCMCIA is not set<BR=
>=0A<BR>=0A#<BR>=0A# Parallel port support<BR>=0A#<BR>=0A# CONFIG_PARPORT i=
s not set<BR>=0A# CONFIG_GEN_RTC is not set<BR>=0A# CONFIG_PPC_RTC is not s=
et<BR>=0ACONFIG_CMDLINE_BOOL=3Dy<BR>=0ACONFIG_CMDLINE=3D&quot;devfs=3Dmount=
 rw root=3Dramfs&quot;<BR>=0A<BR>=0A#<BR>=0A# Embedded options<BR>=0A#<BR>=
=0A# CONFIG_EMBEDDED is not set<BR>=0A<BR>=0A#<BR>=0A# Memory Technology De=
vices (MTD)<BR>=0A#<BR>=0A# CONFIG_MTD is not set<BR>=0A<BR>=0A#<BR>=0A# Pl=
ug and Play configuration<BR>=0A#<BR>=0A# CONFIG_PNP is not set<BR>=0A# CON=
FIG_ISAPNP is not set<BR>=0A<BR>=0A#<BR>=0A# Block devices<BR>=0A#<BR>=0A# =
CONFIG_BLK_DEV_FD is not set<BR>=0A# CONFIG_BLK_DEV_XD is not set<BR>=0A# C=
ONFIG_PARIDE is not set<BR>=0A# CONFIG_BLK_CPQ_DA is not set<BR>=0A# CONFIG=
_BLK_CPQ_CISS_DA is not set<BR>=0A# CONFIG_CISS_SCSI_TAPE is not set<BR>=0A=
# CONFIG_CISS_MONITOR_THREAD is not set<BR>=0A# CONFIG_BLK_DEV_DAC960 is no=
t set<BR>=0A# CONFIG_BLK_DEV_UMEM is not set<BR>=0A# CONFIG_BLK_DEV_LOOP is=
 not set<BR>=0A# CONFIG_BLK_DEV_NBD is not set<BR>=0ACONFIG_BLK_DEV_RAM=3Dy=
<BR>=0ACONFIG_BLK_DEV_RAM_SIZE=3D4096<BR>=0ACONFIG_BLK_DEV_INITRD=3Dy<BR>=
=0A# CONFIG_BLK_STATS is not set<BR>=0A<BR>=0A#<BR>=0A# Multi-device suppor=
t (RAID and LVM)<BR>=0A#<BR>=0A# CONFIG_MD is not set<BR>=0A# CONFIG_BLK_DE=
V_MD is not set<BR>=0A# CONFIG_MD_LINEAR is not set<BR>=0A# CONFIG_MD_RAID0=
 is not set<BR>=0A# CONFIG_MD_RAID1 is not set<BR>=0A# CONFIG_MD_RAID5 is n=
ot set<BR>=0A# CONFIG_MD_MULTIPATH is not set<BR>=0A# CONFIG_BLK_DEV_LVM is=
 not set<BR>=0A<BR>=0A#<BR>=0A# Networking options<BR>=0A#<BR>=0ACONFIG_PAC=
KET=3Dy<BR>=0A# CONFIG_PACKET_MMAP is not set<BR>=0ACONFIG_NETLINK_DEV=3Dy<=
BR>=0A# CONFIG_NETFILTER is not set<BR>=0A# CONFIG_FILTER is not set<BR>=0A=
CONFIG_UNIX=3Dy<BR>=0ACONFIG_INET=3Dy<BR>=0A# CONFIG_IP_MULTICAST is not se=
t<BR>=0A# CONFIG_IP_ADVANCED_ROUTER is not set<BR>=0ACONFIG_IP_PNP=3Dy<BR>=
=0A# CONFIG_IP_PNP_DHCP is not set<BR>=0A# CONFIG_IP_PNP_BOOTP is not set<B=
R>=0A# CONFIG_IP_PNP_RARP is not set<BR>=0A# CONFIG_NET_IPIP is not set<BR>=
=0A# CONFIG_NET_IPGRE is not set<BR>=0A# CONFIG_ARPD is not set<BR>=0A# CON=
FIG_INET_ECN is not set<BR>=0A# CONFIG_SYN_COOKIES is not set<BR>=0A# CONFI=
G_IPV6 is not set<BR>=0A# CONFIG_KHTTPD is not set<BR>=0A<BR>=0A#<BR>=0A#&n=
bsp; &nbsp; SCTP Configuration (EXPERIMENTAL)<BR>=0A#<BR>=0ACONFIG_IPV6_SCT=
P__=3Dy<BR>=0A# CONFIG_IP_SCTP is not set<BR>=0A# CONFIG_ATM is not set<BR>=
=0A# CONFIG_VLAN_8021Q is not set<BR>=0A# CONFIG_IPX is not set<BR>=0A# CON=
FIG_ATALK is not set<BR>=0A<BR>=0A#<BR>=0A# Appletalk devices<BR>=0A#<BR>=
=0A# CONFIG_DEV_APPLETALK is not set<BR>=0A# CONFIG_DECNET is not set<BR>=
=0A# CONFIG_BRIDGE is not set<BR>=0A# CONFIG_X25 is not set<BR>=0A# CONFIG_=
LAPB is not set<BR>=0A# CONFIG_LLC is not set<BR>=0A# CONFIG_NET_DIVERT is =
not set<BR>=0A# CONFIG_ECONET is not set<BR>=0A# CONFIG_WAN_ROUTER is not s=
et<BR>=0A# CONFIG_NET_FASTROUTE is not set<BR>=0A# CONFIG_NET_HW_FLOWCONTRO=
L is not set<BR>=0A<BR>=0A#<BR>=0A# QoS and/or fair queueing<BR>=0A#<BR>=0A=
# CONFIG_NET_SCHED is not set<BR>=0A<BR>=0A#<BR>=0A# Network testing<BR>=0A=
#<BR>=0A# CONFIG_NET_PKTGEN is not set<BR>=0A<BR>=0A#<BR>=0A# ATA/IDE/MFM/R=
LL support<BR>=0A#<BR>=0A# CONFIG_IDE is not set<BR>=0A# CONFIG_BLK_DEV_HD =
is not set<BR>=0A<BR>=0A#<BR>=0A# SCSI support<BR>=0A#<BR>=0A# CONFIG_SCSI =
is not set<BR>=0A<BR>=0A#<BR>=0A# Fusion MPT device support<BR>=0A#<BR>=0A#=
 CONFIG_FUSION is not set<BR>=0A# CONFIG_FUSION_BOOT is not set<BR>=0A# CON=
FIG_FUSION_ISENSE is not set<BR>=0A# CONFIG_FUSION_CTL is not set<BR>=0A# C=
ONFIG_FUSION_LAN is not set<BR>=0A<BR>=0A#<BR>=0A# I2O device support<BR>=
=0A#<BR>=0A# CONFIG_I2O is not set<BR>=0A# CONFIG_I2O_BLOCK is not set<BR>=
=0A# CONFIG_I2O_LAN is not set<BR>=0A# CONFIG_I2O_SCSI is not set<BR>=0A# C=
ONFIG_I2O_PROC is not set<BR>=0A<BR>=0A#<BR>=0A# Network device support<BR>=
=0A#<BR>=0ACONFIG_NETDEVICES=3Dy<BR>=0A<BR>=0A#<BR>=0A# ARCnet devices<BR>=
=0A#<BR>=0A# CONFIG_ARCNET is not set<BR>=0A# CONFIG_DUMMY is not set<BR>=
=0A# CONFIG_BONDING is not set<BR>=0A# CONFIG_EQUALIZER is not set<BR>=0A# =
CONFIG_TUN is not set<BR>=0A# CONFIG_ETHERTAP is not set<BR>=0A<BR>=0A#<BR>=
=0A# Ethernet (10 or 100Mbit)<BR>=0A#<BR>=0ACONFIG_NET_ETHERNET=3Dy<BR>=0A#=
 CONFIG_MACE is not set<BR>=0A# CONFIG_BMAC is not set<BR>=0A# CONFIG_GMAC =
is not set<BR>=0A# CONFIG_SUNLANCE is not set<BR>=0A# CONFIG_SUNBMAC is not=
 set<BR>=0A# CONFIG_SUNQE is not set<BR>=0A# CONFIG_SUNGEM is not set<BR>=
=0A# CONFIG_NET_VENDOR_3COM is not set<BR>=0A# CONFIG_LANCE is not set<BR>=
=0A# CONFIG_NET_VENDOR_SMC is not set<BR>=0A# CONFIG_NET_VENDOR_RACAL is no=
t set<BR>=0A# CONFIG_NET_ISA is not set<BR>=0A# CONFIG_NET_PCI is not set<B=
R>=0A# CONFIG_NET_POCKET is not set<BR>=0A<BR>=0A#<BR>=0A# Ethernet (1000 M=
bit)<BR>=0A#<BR>=0A# CONFIG_ACENIC is not set<BR>=0A# CONFIG_DL2K is not se=
t<BR>=0A# CONFIG_E1000 is not set<BR>=0A# CONFIG_MYRI_SBUS is not set<BR>=
=0A# CONFIG_NS83820 is not set<BR>=0A# CONFIG_HAMACHI is not set<BR>=0A# CO=
NFIG_YELLOWFIN is not set<BR>=0A# CONFIG_R8169 is not set<BR>=0A# CONFIG_SK=
98LIN is not set<BR>=0A# CONFIG_TIGON3 is not set<BR>=0A# CONFIG_FDDI is no=
t set<BR>=0A# CONFIG_NETCONSOLE is not set<BR>=0A# CONFIG_HIPPI is not set<=
BR>=0A# CONFIG_PLIP is not set<BR>=0A# CONFIG_PPP is not set<BR>=0A# CONFIG=
_SLIP is not set<BR>=0A<BR>=0A#<BR>=0A# Wireless LAN (non-hamradio)<BR>=0A#=
<BR>=0A# CONFIG_NET_RADIO is not set<BR>=0A<BR>=0A#<BR>=0A# Token Ring devi=
ces<BR>=0A#<BR>=0A# CONFIG_TR is not set<BR>=0A# CONFIG_NET_FC is not set<B=
R>=0A# CONFIG_RCPCI is not set<BR>=0A# CONFIG_SHAPER is not set<BR>=0A<BR>=
=0A#<BR>=0A# Wan interfaces<BR>=0A#<BR>=0A# CONFIG_WAN is not set<BR>=0A<BR=
>=0A#<BR>=0A# Amateur Radio support<BR>=0A#<BR>=0A# CONFIG_HAMRADIO is not =
set<BR>=0A<BR>=0A#<BR>=0A# IrDA (infrared) support<BR>=0A#<BR>=0A# CONFIG_I=
RDA is not set<BR>=0A<BR>=0A#<BR>=0A# ISDN subsystem<BR>=0A#<BR>=0A# CONFIG=
_ISDN is not set<BR>=0A<BR>=0A#<BR>=0A# Old CD-ROM drivers (not SCSI, not I=
DE)<BR>=0A#<BR>=0A# CONFIG_CD_NO_IDESCSI is not set<BR>=0A<BR>=0A#<BR>=0A# =
Console drivers<BR>=0A#<BR>=0A<BR>=0A#<BR>=0A# Frame-buffer support<BR>=0A#=
<BR>=0A# CONFIG_FB is not set<BR>=0A<BR>=0A#<BR>=0A# Input core support<BR>=
=0A#<BR>=0A# CONFIG_INPUT is not set<BR>=0A# CONFIG_INPUT_KEYBDEV is not se=
t<BR>=0A# CONFIG_INPUT_MOUSEDEV is not set<BR>=0A# CONFIG_INPUT_JOYDEV is n=
ot set<BR>=0A# CONFIG_INPUT_EVDEV is not set<BR>=0A# CONFIG_INPUT_UINPUT is=
 not set<BR>=0A<BR>=0A#<BR>=0A# Macintosh device drivers<BR>=0A#<BR>=0A<BR>=
=0A#<BR>=0A# Character devices<BR>=0A#<BR>=0A# CONFIG_VT is not set<BR>=0A#=
 CONFIG_SERIAL is not set<BR>=0A# CONFIG_SERIAL_EXTENDED is not set<BR>=0A#=
 CONFIG_SERIAL_NONSTANDARD is not set<BR>=0ACONFIG_UNIX98_PTYS=3Dy<BR>=0ACO=
NFIG_UNIX98_PTY_COUNT=3D32<BR>=0A<BR>=0A#<BR>=0A# I2C support<BR>=0A#<BR>=
=0A# CONFIG_I2C is not set<BR>=0A<BR>=0A#<BR>=0A# Mice<BR>=0A#<BR>=0A# CONF=
IG_BUSMOUSE is not set<BR>=0A# CONFIG_MOUSE is not set<BR>=0A<BR>=0A#<BR>=
=0A# Joysticks<BR>=0A#<BR>=0A# CONFIG_INPUT_GAMEPORT is not set<BR>=0A# CON=
FIG_QIC02_TAPE is not set<BR>=0A# CONFIG_IPMI_HANDLER is not set<BR>=0A# CO=
NFIG_IPMI_PANIC_EVENT is not set<BR>=0A# CONFIG_IPMI_DEVICE_INTERFACE is no=
t set<BR>=0A# CONFIG_IPMI_KCS is not set<BR>=0A# CONFIG_IPMI_WATCHDOG is no=
t set<BR>=0A<BR>=0A#<BR>=0A# Watchdog Cards<BR>=0A#<BR>=0A# CONFIG_WATCHDOG=
 is not set<BR>=0A# CONFIG_SCx200 is not set<BR>=0A# CONFIG_SCx200_GPIO is =
not set<BR>=0A# CONFIG_AMD_PM768 is not set<BR>=0A# CONFIG_NVRAM is not set=
<BR>=0A# CONFIG_RTC is not set<BR>=0A# CONFIG_RTC_11_MINUTE_MODE is not set=
<BR>=0A# CONFIG_RTC_8XX is not set<BR>=0A# CONFIG_DTLK is not set<BR>=0A# C=
ONFIG_R3964 is not set<BR>=0A# CONFIG_APPLICOM is not set<BR>=0A# CONFIG_FL=
ASH is not set<BR>=0A<BR>=0A#<BR>=0A# Ftape, the floppy tape device driver<=
BR>=0A#<BR>=0A# CONFIG_FTAPE is not set<BR>=0A# CONFIG_AGP is not set<BR>=
=0A<BR>=0A#<BR>=0A# Direct Rendering Manager (XFree86 DRI support)<BR>=0A#<=
BR>=0A# CONFIG_DRM is not set<BR>=0A<BR>=0A#<BR>=0A# Multimedia devices<BR>=
=0A#<BR>=0A# CONFIG_VIDEO_DEV is not set<BR>=0A<BR>=0A#<BR>=0A# File system=
s<BR>=0A#<BR>=0A# CONFIG_QUOTA is not set<BR>=0A# CONFIG_QFMT_V2 is not set=
<BR>=0ACONFIG_AUTOFS_FS=3Dy<BR>=0A# CONFIG_AUTOFS4_FS is not set<BR>=0A# CO=
NFIG_REISERFS_FS is not set<BR>=0A# CONFIG_REISERFS_CHECK is not set<BR>=0A=
# CONFIG_REISERFS_PROC_INFO is not set<BR>=0A# CONFIG_ADFS_FS is not set<BR=
>=0A# CONFIG_ADFS_FS_RW is not set<BR>=0A# CONFIG_AFFS_FS is not set<BR>=0A=
# CONFIG_HFS_FS is not set<BR>=0A# CONFIG_HFSPLUS_FS is not set<BR>=0A# CON=
FIG_BEFS_FS is not set<BR>=0A# CONFIG_BEFS_DEBUG is not set<BR>=0A# CONFIG_=
BFS_FS is not set<BR>=0A# CONFIG_EXT3_FS is not set<BR>=0A# CONFIG_JBD is n=
ot set<BR>=0A# CONFIG_JBD_DEBUG is not set<BR>=0A# CONFIG_FAT_FS is not set=
<BR>=0A# CONFIG_MSDOS_FS is not set<BR>=0A# CONFIG_UMSDOS_FS is not set<BR>=
=0A# CONFIG_VFAT_FS is not set<BR>=0A# CONFIG_EFS_FS is not set<BR>=0A# CON=
FIG_JFFS_FS is not set<BR>=0A# CONFIG_JFFS2_FS is not set<BR>=0A# CONFIG_CR=
AMFS is not set<BR>=0A# CONFIG_TMPFS is not set<BR>=0ACONFIG_RAMFS=3Dy<BR>=
=0A# CONFIG_ISO9660_FS is not set<BR>=0A# CONFIG_JOLIET is not set<BR>=0A# =
CONFIG_ZISOFS is not set<BR>=0A# CONFIG_JFS_FS is not set<BR>=0A# CONFIG_JF=
S_DEBUG is not set<BR>=0A# CONFIG_JFS_STATISTICS is not set<BR>=0A# CONFIG_=
MINIX_FS is not set<BR>=0A# CONFIG_VXFS_FS is not set<BR>=0A# CONFIG_NTFS_F=
S is not set<BR>=0A# CONFIG_NTFS_RW is not set<BR>=0A# CONFIG_HPFS_FS is no=
t set<BR>=0ACONFIG_PROC_FS=3Dy<BR>=0A# CONFIG_DEVFS_FS is not set<BR>=0A# C=
ONFIG_DEVFS_MOUNT is not set<BR>=0A# CONFIG_DEVFS_DEBUG is not set<BR>=0A# =
CONFIG_DEVPTS_FS is not set<BR>=0A# CONFIG_QNX4FS_FS is not set<BR>=0A# CON=
FIG_QNX4FS_RW is not set<BR>=0A# CONFIG_ROMFS_FS is not set<BR>=0ACONFIG_EX=
T2_FS=3Dy<BR>=0A# CONFIG_SYSV_FS is not set<BR>=0A# CONFIG_UDF_FS is not se=
t<BR>=0A# CONFIG_UDF_RW is not set<BR>=0A# CONFIG_UFS_FS is not set<BR>=0A#=
 CONFIG_UFS_FS_WRITE is not set<BR>=0A# CONFIG_XFS_FS is not set<BR>=0A# CO=
NFIG_XFS_QUOTA is not set<BR>=0A# CONFIG_XFS_RT is not set<BR>=0A# CONFIG_X=
FS_TRACE is not set<BR>=0A# CONFIG_XFS_DEBUG is not set<BR>=0A<BR>=0A#<BR>=
=0A# Network File Systems<BR>=0A#<BR>=0A# CONFIG_CODA_FS is not set<BR>=0A#=
 CONFIG_INTERMEZZO_FS is not set<BR>=0A# CONFIG_NFS_FS is not set<BR>=0A# C=
ONFIG_NFS_V3 is not set<BR>=0A# CONFIG_NFS_DIRECTIO is not set<BR>=0A# CONF=
IG_ROOT_NFS is not set<BR>=0A# CONFIG_NFSD is not set<BR>=0A# CONFIG_NFSD_V=
3 is not set<BR>=0A# CONFIG_NFSD_TCP is not set<BR>=0A# CONFIG_SUNRPC is no=
t set<BR>=0A# CONFIG_LOCKD is not set<BR>=0A# CONFIG_SMB_FS is not set<BR>=
=0A# CONFIG_NCP_FS is not set<BR>=0A# CONFIG_NCPFS_PACKET_SIGNING is not se=
t<BR>=0A# CONFIG_NCPFS_IOCTL_LOCKING is not set<BR>=0A# CONFIG_NCPFS_STRONG=
 is not set<BR>=0A# CONFIG_NCPFS_NFS_NS is not set<BR>=0A# CONFIG_NCPFS_OS2=
_NS is not set<BR>=0A# CONFIG_NCPFS_SMALLDOS is not set<BR>=0A# CONFIG_NCPF=
S_NLS is not set<BR>=0A# CONFIG_NCPFS_EXTRAS is not set<BR>=0A# CONFIG_ZISO=
FS_FS is not set<BR>=0A<BR>=0A#<BR>=0A# Partition Types<BR>=0A#<BR>=0A# CON=
FIG_PARTITION_ADVANCED is not set<BR>=0ACONFIG_MSDOS_PARTITION=3Dy<BR>=0A# =
CONFIG_SMB_NLS is not set<BR>=0A# CONFIG_NLS is not set<BR>=0A<BR>=0A#<BR>=
=0A# Sound<BR>=0A#<BR>=0A# CONFIG_SOUND is not set<BR>=0A<BR>=0A#<BR>=0A# M=
PC8xx Options<BR>=0A#<BR>=0A# CONFIG_8xx_COPYBACK is not set<BR>=0A# CONFIG=
_8xx_CPU6 is not set<BR>=0A# CONFIG_8xx_CPU15 is not set<BR>=0A# CONFIG_UCO=
DE_PATCH is not set<BR>=0A# CONFIG_CPM_TRACK_LOAD is not set<BR>=0A# CONFIG=
_SCC_ENET is not set<BR>=0A# CONFIG_SCC1_ENET is not set<BR>=0A# CONFIG_SCC=
2_ENET is not set<BR>=0A# CONFIG_SCC3_ENET is not set<BR>=0A# CONFIG_FEC_EN=
ET is not set<BR>=0A# CONFIG_ENET_BIG_BUFFERS is not set<BR>=0A# CONFIG_HDL=
C_ENET is not set<BR>=0A# CONFIG_8xx_SMC1 is not set<BR>=0A# CONFIG_8xx_SMC=
2 is not set<BR>=0ACONFIG_8xx_SCC_UART=3Dy<BR>=0A# CONFIG_8xx_SCC1_UART is =
not set<BR>=0A# CONFIG_8xx_SCC2_UART is not set<BR>=0A# CONFIG_8xx_SCC3_UAR=
T is not set<BR>=0ACONFIG_8xx_SCC4_UART=3Dy<BR>=0ACONFIG_PORT_CTS4_NONE=3Dy=
<BR>=0A# CONFIG_UART_CTS_CONTROL_SCC4 is not set<BR>=0ACONFIG_PORT_RTS4_NON=
E=3Dy<BR>=0A# CONFIG_PORT_RTS4_B is not set<BR>=0A# CONFIG_PORT_RTS4_C is n=
ot set<BR>=0A# CONFIG_PORT_RTS4_D is not set<BR>=0ACONFIG_PORT_CD4_NONE=3Dy=
<BR>=0A# CONFIG_UART_CD_CONTROL_SCC4 is not set<BR>=0ACONFIG_PORT_DTR4_NONE=
=3Dy<BR>=0A# CONFIG_PORT_DTR4_A is not set<BR>=0A# CONFIG_PORT_DTR4_B is no=
t set<BR>=0A# CONFIG_PORT_DTR4_C is not set<BR>=0A# CONFIG_PORT_DTR4_D is n=
ot set<BR>=0ACONFIG_8xx_SCC4_UART_MAXIDL=3D1<BR>=0ACONFIG_8xx_SCC4_UART_RX_=
BDNUM=3D4<BR>=0ACONFIG_8xx_SCC4_UART_RX_BDSIZE=3D32<BR>=0ACONFIG_8xx_SCC4_U=
ART_TX_BDNUM=3D4<BR>=0ACONFIG_8xx_SCC4_UART_TX_BDSIZE=3D32<BR>=0A<BR>=0A#<B=
R>=0A# USB support<BR>=0A#<BR>=0A# CONFIG_USB is not set<BR>=0A<BR>=0A#<BR>=
=0A# Support for USB gadgets<BR>=0A#<BR>=0A# CONFIG_USB_GADGET is not set<B=
R>=0A<BR>=0A#<BR>=0A# Bluetooth support<BR>=0A#<BR>=0A# CONFIG_BLUEZ is not=
 set<BR>=0A<BR>=0A#<BR>=0A# Cryptographic options<BR>=0A#<BR>=0A# CONFIG_CR=
YPTO is not set<BR>=0A<BR>=0A#<BR>=0A# Library routines<BR>=0A#<BR>=0A# CON=
FIG_CRC32 is not set<BR>=0A# CONFIG_ZLIB_INFLATE is not set<BR>=0A# CONFIG_=
ZLIB_DEFLATE is not set<BR>=0A<BR>=0A#<BR>=0A# Kernel hacking<BR>=0A#<BR>=
=0A# CONFIG_DEBUG_KERNEL is not set<BR>=0ACONFIG_LOG_BUF_SHIFT=3D0<BR>=0A<B=
R>=0A=0A</P>=0A<br><br>=0A<a href=3D"http://adworks.rediff.com/cgi-bin/AdWo=
rks/sigclick.cgi/www.rediff.com/signature-home.htm/1507191490@Middle5?PARTN=
ER=3D3"><IMG SRC=3D"http://adworks.rediff.com/cgi-bin/AdWorks/sigimpress.cg=
i/www.rediff.com/signature-home.htm/1963059423@Middle5?OAS_query=3Dnull&PAR=
TNER=3D3" BORDER=3D0 VSPACE=3D0 HSPACE=3D0></a>=0A
--Next_1129539161---0-203.199.83.146-13478--
