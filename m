Message-ID: <00e801bfeb51$d19bf300$1a6a1504@strayer.edu>
From: "Robert Thompson" <rothomp3@vt.edu>
To: "Franz Sirl" <Franz.Sirl-kernel@lauterbach.com>
Cc: "Hollis Blanchard" <hollis@amulet.co.jp>, <pogtal@erols.com>,
        <linuxppc-dev@lists.linuxppc.org>
References: <003b01bfeaa6$744c6e60$1a6a1504@strayer.edu><396ACDF9.826580D3@amulet.co.jp> <4.3.2.7.2.20000711172513.03963320@mail.munich.netsurf.de>
Subject: Re: trackpad
Date: Tue, 11 Jul 2000 12:05:11 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00E5_01BFEB30.43B29D80"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_00E5_01BFEB30.43B29D80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

> Can you please post the dmesg part where all the ADB/USB devices get
> registered to inputs? And please also the line which contains "adb
devices"
> in the dmesg and your kernel .config.

Sure, find them attached.

Later,
Robbie Thompson

------=_NextPart_000_00E5_01BFEB30.43B29D80
Content-Type: text/plain;
	name="dmesg.txt"
Content-Disposition: attachment;
	filename="dmesg.txt"
Content-Transfer-Encoding: quoted-printable

adb devices: [2]: 2 c3 [3]: 3 1 [7]: 7 1f=0A=
=0A=
...=0A=
=0A=
mouse0: PS/2 mouse device for input0=0A=
event0: Event device for input0=0A=
input0: Macintosh mouse button emulation=0A=
ADB keyboard at 2, handler 1=0A=
keybdev.c: Adding keyboard: input1=0A=
event1: Event device for input1=0A=
input1: Keyboard on ADB ID2=0A=
event2: Event device for input2=0A=
input2: Button device on ADB ID7=0A=
ADB mouse at 3, handler set to 4 (trackpad)=0A=
mouse1: PS/2 mouse device for input3=0A=
event3: Event device for input3=0A=
input3: Mouse on ADB ID3=0A=
=0A=
...=0A=
=0A=

------=_NextPart_000_00E5_01BFEB30.43B29D80
Content-Type: application/octet-stream;
	name=".config"
Content-Disposition: attachment;
	filename=".config"
Content-Transfer-Encoding: quoted-printable

#=0A=
# Automatically generated make config: don't edit=0A=
#=0A=
=0A=
#=0A=
# Platform support=0A=
#=0A=
CONFIG_PPC=3Dy=0A=
CONFIG_6xx=3Dy=0A=
# CONFIG_8xx is not set=0A=
CONFIG_PMAC=3Dy=0A=
# CONFIG_PREP is not set=0A=
# CONFIG_CHRP is not set=0A=
# CONFIG_ALL_PPC is not set=0A=
# CONFIG_APUS is not set=0A=
# CONFIG_GEMINI is not set=0A=
# CONFIG_MBX is not set=0A=
# CONFIG_SMP is not set=0A=
# CONFIG_ALTIVEC is not set=0A=
CONFIG_MACH_SPECIFIC=3Dy=0A=
CONFIG_6xx=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
CONFIG_MODULES=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
CONFIG_KMOD=3Dy=0A=
CONFIG_PCI=3Dy=0A=
# CONFIG_PCI_QUIRKS is not set=0A=
CONFIG_PCI_OLD_PROC=3Dy=0A=
CONFIG_NET=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_KERNEL_ELF=3Dy=0A=
CONFIG_BINFMT_MISC=3Dy=0A=
# CONFIG_BINFMT_JAVA is not set=0A=
# CONFIG_PARPORT is not set=0A=
# CONFIG_VGA_CONSOLE is not set=0A=
CONFIG_FB=3Dy=0A=
CONFIG_PMAC_PBOOK=3Dy=0A=
CONFIG_MAC_KEYBOARD=3Dy=0A=
CONFIG_MAC_FLOPPY=3Dy=0A=
CONFIG_MAC_SERIAL=3Dy=0A=
CONFIG_PPC_RTC=3Dy=0A=
CONFIG_ADBMOUSE=3Dy=0A=
CONFIG_PROC_DEVICETREE=3Dy=0A=
# CONFIG_TOTALMP is not set=0A=
CONFIG_BOOTX_TEXT=3Dy=0A=
# CONFIG_MOTOROLA_HOTSWAP is not set=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
# CONFIG_PNP is not set=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
# CONFIG_BLK_DEV_FD is not set=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
CONFIG_BLK_DEV_IDECD=3Dy=0A=
# CONFIG_BLK_DEV_IDETAPE is not set=0A=
CONFIG_BLK_DEV_IDEFLOPPY=3Dy=0A=
CONFIG_BLK_DEV_IDESCSI=3Dy=0A=
# CONFIG_BLK_DEV_CMD640 is not set=0A=
# CONFIG_BLK_DEV_RZ1000 is not set=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_VIA82C586 is not set=0A=
# CONFIG_BLK_DEV_CMD646 is not set=0A=
# CONFIG_BLK_DEV_CS5530 is not set=0A=
# CONFIG_BLK_DEV_SL82C105 is not set=0A=
CONFIG_BLK_DEV_IDE_PMAC=3Dy=0A=
CONFIG_BLK_DEV_IDEDMA_PMAC=3Dy=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
CONFIG_PMAC_IDEDMA_AUTO=3Dy=0A=
# CONFIG_IDE_CHIPSETS is not set=0A=
=0A=
#=0A=
# Additional Block Devices=0A=
#=0A=
CONFIG_BLK_DEV_LOOP=3Dy=0A=
CONFIG_BLK_DEV_NBD=3Dm=0A=
# CONFIG_BLK_DEV_MD is not set=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D4096=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
CONFIG_PARIDE_PARPORT=3Dy=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
CONFIG_NETLINK=3Dy=0A=
# CONFIG_RTNETLINK is not set=0A=
# CONFIG_NETLINK_DEV is not set=0A=
CONFIG_FIREWALL=3Dy=0A=
# CONFIG_FILTER is not set=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
# CONFIG_IP_PNP is not set=0A=
CONFIG_IP_FIREWALL=3Dy=0A=
# CONFIG_IP_FIREWALL_NETLINK is not set=0A=
# CONFIG_IP_TRANSPARENT_PROXY is not set=0A=
CONFIG_IP_MASQUERADE=3Dy=0A=
=0A=
#=0A=
# Protocol-specific masquerading support will be built as modules.=0A=
#=0A=
CONFIG_IP_MASQUERADE_ICMP=3Dy=0A=
=0A=
#=0A=
# Protocol-specific masquerading support will be built as modules.=0A=
#=0A=
CONFIG_IP_MASQUERADE_MOD=3Dy=0A=
# CONFIG_IP_MASQUERADE_IPAUTOFW is not set=0A=
# CONFIG_IP_MASQUERADE_IPPORTFW is not set=0A=
# CONFIG_IP_MASQUERADE_MFW is not set=0A=
# CONFIG_IP_ROUTER is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
CONFIG_IP_ALIAS=3Dy=0A=
CONFIG_SYN_COOKIES=3Dy=0A=
=0A=
#=0A=
# (it is safe to leave these untouched)=0A=
#=0A=
CONFIG_INET_RARP=3Dy=0A=
CONFIG_SKB_LARGE=3Dy=0A=
# CONFIG_IPV6 is not set=0A=
=0A=
#=0A=
#  =0A=
#=0A=
# CONFIG_IPX is not set=0A=
CONFIG_ATALK=3Dy=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_LLC is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_FASTROUTE is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
# CONFIG_CPU_IS_SLOW is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# SCSI support=0A=
#=0A=
CONFIG_SCSI=3Dy=0A=
=0A=
#=0A=
# SCSI support type (disk, tape, CD-ROM)=0A=
#=0A=
CONFIG_BLK_DEV_SD=3Dy=0A=
# CONFIG_CHR_DEV_ST is not set=0A=
CONFIG_BLK_DEV_SR=3Dy=0A=
# CONFIG_BLK_DEV_SR_VENDOR is not set=0A=
CONFIG_CHR_DEV_SG=3Dy=0A=
=0A=
#=0A=
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs=0A=
#=0A=
# CONFIG_SCSI_MULTI_LUN is not set=0A=
CONFIG_SCSI_CONSTANTS=3Dy=0A=
# CONFIG_SCSI_LOGGING is not set=0A=
=0A=
#=0A=
# SCSI low-level drivers=0A=
#=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
# CONFIG_SCSI_7000FASST is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AHA152X is not set=0A=
# CONFIG_SCSI_AHA1542 is not set=0A=
# CONFIG_SCSI_AHA1740 is not set=0A=
# CONFIG_SCSI_AIC7XXX is not set=0A=
# CONFIG_SCSI_IPS is not set=0A=
# CONFIG_SCSI_ADVANSYS is not set=0A=
# CONFIG_SCSI_IN2000 is not set=0A=
# CONFIG_SCSI_AM53C974 is not set=0A=
# CONFIG_SCSI_MEGARAID is not set=0A=
# CONFIG_SCSI_BUSLOGIC is not set=0A=
# CONFIG_SCSI_DTC3280 is not set=0A=
# CONFIG_SCSI_EATA is not set=0A=
# CONFIG_SCSI_EATA_DMA is not set=0A=
# CONFIG_SCSI_EATA_PIO is not set=0A=
# CONFIG_SCSI_FUTURE_DOMAIN is not set=0A=
# CONFIG_SCSI_GDTH is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380 is not set=0A=
# CONFIG_SCSI_INITIO is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_NCR53C406A is not set=0A=
# CONFIG_SCSI_SYM53C416 is not set=0A=
# CONFIG_SCSI_SIM710 is not set=0A=
# CONFIG_SCSI_NCR53C7xx is not set=0A=
# CONFIG_SCSI_NCR53C8XX is not set=0A=
# CONFIG_SCSI_SYM53C8XX is not set=0A=
# CONFIG_SCSI_PAS16 is not set=0A=
# CONFIG_SCSI_PCI2000 is not set=0A=
# CONFIG_SCSI_PCI2220I is not set=0A=
# CONFIG_SCSI_PSI240I is not set=0A=
# CONFIG_SCSI_QLOGIC_FAS is not set=0A=
# CONFIG_SCSI_QLOGIC_ISP is not set=0A=
# CONFIG_SCSI_QLOGIC_FC is not set=0A=
# CONFIG_SCSI_SEAGATE is not set=0A=
# CONFIG_SCSI_DC390T is not set=0A=
# CONFIG_SCSI_T128 is not set=0A=
# CONFIG_SCSI_U14_34F is not set=0A=
# CONFIG_SCSI_ULTRASTOR is not set=0A=
# CONFIG_SCSI_DEBUG is not set=0A=
# CONFIG_SCSI_MESH is not set=0A=
# CONFIG_SCSI_MAC53C94 is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
CONFIG_DUMMY=3Dy=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_ETHERTAP is not set=0A=
# CONFIG_NET_SB1000 is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
# CONFIG_MACE is not set=0A=
# CONFIG_BMAC is not set=0A=
CONFIG_GMAC=3Dy=0A=
# CONFIG_NCR885E is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
# CONFIG_RTL8139 is not set=0A=
# CONFIG_NET_ISA is not set=0A=
# CONFIG_NET_EISA is not set=0A=
# CONFIG_NET_POCKET is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
=0A=
#=0A=
# Appletalk devices=0A=
#=0A=
# CONFIG_LTPC is not set=0A=
# CONFIG_COPS is not set=0A=
# CONFIG_IPDDP is not set=0A=
CONFIG_PPP=3Dy=0A=
=0A=
#=0A=
# CCP compressors for PPP are only built as modules.=0A=
#=0A=
# CONFIG_SLIP is not set=0A=
CONFIG_NET_RADIO=3Dy=0A=
# CONFIG_STRIP is not set=0A=
# CONFIG_WAVELAN is not set=0A=
# CONFIG_ARLAN is not set=0A=
=0A=
#=0A=
# Token ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_HOSTESS_SV11 is not set=0A=
# CONFIG_COSA is not set=0A=
# CONFIG_SEALEVEL_4021 is not set=0A=
# CONFIG_SYNCLINK_SYNCPPP is not set=0A=
# CONFIG_LANMEDIA is not set=0A=
# CONFIG_COMX is not set=0A=
# CONFIG_HDLC is not set=0A=
# CONFIG_DLCI is not set=0A=
# CONFIG_SBNI is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Console drivers=0A=
#=0A=
CONFIG_DUMMY_CONSOLE=3Dy=0A=
# CONFIG_FB_PM2 is not set=0A=
CONFIG_FB_ATY=3Dy=0A=
CONFIG_FB_OF=3Dy=0A=
# CONFIG_FB_CONTROL is not set=0A=
# CONFIG_FB_PLATINUM is not set=0A=
# CONFIG_FB_VALKYRIE is not set=0A=
# CONFIG_FB_IMSTT is not set=0A=
# CONFIG_FB_CT65550 is not set=0A=
# CONFIG_FB_S3TRIO is not set=0A=
CONFIG_FB_COMPAT_XPMAC=3Dy=0A=
# CONFIG_FB_MATROX is not set=0A=
CONFIG_FB_ATY128=3Dy=0A=
# CONFIG_FB_VIRTUAL is not set=0A=
# CONFIG_FBCON_ADVANCED is not set=0A=
CONFIG_FBCON_CFB8=3Dy=0A=
CONFIG_FBCON_CFB16=3Dy=0A=
CONFIG_FBCON_CFB24=3Dy=0A=
CONFIG_FBCON_CFB32=3Dy=0A=
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set=0A=
CONFIG_FBCON_FONTS=3Dy=0A=
# CONFIG_FONT_8x8 is not set=0A=
CONFIG_FONT_8x16=3Dy=0A=
CONFIG_FONT_SUN8x16=3Dy=0A=
CONFIG_FONT_SUN12x22=3Dy=0A=
# CONFIG_FONT_6x11 is not set=0A=
# CONFIG_FONT_PEARL_8x8 is not set=0A=
# CONFIG_FONT_ACORN_8x8 is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
# CONFIG_SERIAL is not set=0A=
# CONFIG_SERIAL_EXTENDED is not set=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D256=0A=
# CONFIG_MOUSE is not set=0A=
=0A=
#=0A=
# Joysticks=0A=
#=0A=
# CONFIG_JOYSTICK is not set=0A=
# CONFIG_QIC02_TAPE is not set=0A=
# CONFIG_WATCHDOG is not set=0A=
CONFIG_NVRAM=3Dy=0A=
# CONFIG_RTC is not set=0A=
=0A=
#=0A=
# Video For Linux=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
# CONFIG_DTLK is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
# CONFIG_TOSHIBA is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB=3Dy=0A=
CONFIG_USB_DEBUG=3Dy=0A=
=0A=
#=0A=
# Miscellaneous USB options=0A=
#=0A=
CONFIG_USB_DEVICEFS=3Dy=0A=
# CONFIG_USB_BANDWIDTH is not set=0A=
=0A=
#=0A=
# USB Controllers=0A=
#=0A=
# CONFIG_USB_UHCI is not set=0A=
# CONFIG_USB_UHCI_ALT is not set=0A=
CONFIG_USB_OHCI=3Dy=0A=
=0A=
#=0A=
# USB Devices=0A=
#=0A=
CONFIG_USB_PRINTER=3Dm=0A=
CONFIG_USB_SCANNER=3Dm=0A=
CONFIG_USB_AUDIO=3Dm=0A=
CONFIG_USB_ACM=3Dm=0A=
CONFIG_USB_SERIAL=3Dm=0A=
CONFIG_USB_SERIAL_GENERIC=3Dy=0A=
# CONFIG_USB_SERIAL_VISOR is not set=0A=
# CONFIG_USB_SERIAL_WHITEHEAT is not set=0A=
CONFIG_USB_SERIAL_FTDI_SIO=3Dy=0A=
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dy=0A=
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dy=0A=
CONFIG_USB_SERIAL_OMNINET=3Dy=0A=
CONFIG_USB_SERIAL_DEBUG=3Dy=0A=
# CONFIG_USB_DC2XX is not set=0A=
# CONFIG_USB_MDC800 is not set=0A=
CONFIG_USB_STORAGE=3Dm=0A=
CONFIG_USB_STORAGE_DEBUG=3Dy=0A=
# CONFIG_USB_DABUSB is not set=0A=
# CONFIG_USB_PLUSB is not set=0A=
# CONFIG_USB_PEGASUS is not set=0A=
# CONFIG_USB_RIO500 is not set=0A=
# CONFIG_USB_MICROTEK is not set=0A=
=0A=
#=0A=
# USB HID=0A=
#=0A=
CONFIG_USB_HID=3Dy=0A=
# CONFIG_USB_WACOM is not set=0A=
# CONFIG_USB_WMFORCE is not set=0A=
CONFIG_INPUT_KEYBDEV=3Dy=0A=
CONFIG_INPUT_MOUSEDEV=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D800=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D600=0A=
CONFIG_INPUT_JOYDEV=3Dm=0A=
CONFIG_INPUT_EVDEV=3Dy=0A=
=0A=
#=0A=
# Filesystems=0A=
#=0A=
# CONFIG_QUOTA is not set=0A=
CONFIG_AUTOFS_FS=3Dy=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
CONFIG_HFS_FS=3Dy=0A=
CONFIG_FAT_FS=3Dm=0A=
CONFIG_MSDOS_FS=3Dm=0A=
# CONFIG_UMSDOS_FS is not set=0A=
CONFIG_VFAT_FS=3Dm=0A=
CONFIG_ISO9660_FS=3Dy=0A=
CONFIG_JOLIET=3Dy=0A=
CONFIG_MINIX_FS=3Dm=0A=
# CONFIG_NTFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_EXT2_FS=3Dy=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
# CONFIG_CODA_FS is not set=0A=
CONFIG_NFS_FS=3Dy=0A=
CONFIG_NFSD=3Dy=0A=
# CONFIG_NFSD_SUN is not set=0A=
CONFIG_SUNRPC=3Dy=0A=
CONFIG_LOCKD=3Dy=0A=
CONFIG_SMB_FS=3Dy=0A=
# CONFIG_NCP_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_BSD_DISKLABEL is not set=0A=
CONFIG_MAC_PARTITION=3Dy=0A=
# CONFIG_SMD_DISKLABEL is not set=0A=
# CONFIG_SOLARIS_X86_PARTITION is not set=0A=
# CONFIG_UNIXWARE_DISKLABEL is not set=0A=
CONFIG_NLS=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS_DEFAULT=3D"cp437"=0A=
CONFIG_NLS_CODEPAGE_437=3Dy=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
# CONFIG_NLS_CODEPAGE_850 is not set=0A=
# CONFIG_NLS_CODEPAGE_852 is not set=0A=
# CONFIG_NLS_CODEPAGE_855 is not set=0A=
# CONFIG_NLS_CODEPAGE_857 is not set=0A=
# CONFIG_NLS_CODEPAGE_860 is not set=0A=
# CONFIG_NLS_CODEPAGE_861 is not set=0A=
# CONFIG_NLS_CODEPAGE_862 is not set=0A=
# CONFIG_NLS_CODEPAGE_863 is not set=0A=
# CONFIG_NLS_CODEPAGE_864 is not set=0A=
# CONFIG_NLS_CODEPAGE_865 is not set=0A=
# CONFIG_NLS_CODEPAGE_866 is not set=0A=
# CONFIG_NLS_CODEPAGE_869 is not set=0A=
# CONFIG_NLS_CODEPAGE_874 is not set=0A=
# CONFIG_NLS_CODEPAGE_932 is not set=0A=
# CONFIG_NLS_CODEPAGE_936 is not set=0A=
# CONFIG_NLS_CODEPAGE_949 is not set=0A=
# CONFIG_NLS_CODEPAGE_950 is not set=0A=
# CONFIG_NLS_ISO8859_1 is not set=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A=
# CONFIG_NLS_ISO8859_3 is not set=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
# CONFIG_NLS_ISO8859_8 is not set=0A=
# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
CONFIG_NLS_ISO8859_15=3Dy=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
CONFIG_SOUND=3Dy=0A=
CONFIG_DMASOUND_AWACS=3Dy=0A=
CONFIG_DMASOUND=3Dy=0A=
# CONFIG_SOUND_CMPCI is not set=0A=
# CONFIG_SOUND_FUSION is not set=0A=
# CONFIG_SOUND_ES1370 is not set=0A=
# CONFIG_SOUND_ES1371 is not set=0A=
# CONFIG_SOUND_MAESTRO is not set=0A=
# CONFIG_SOUND_ESSSOLO1 is not set=0A=
# CONFIG_SOUND_ICH is not set=0A=
# CONFIG_SOUND_SONICVIBES is not set=0A=
# CONFIG_SOUND_TRIDENT is not set=0A=
# CONFIG_SOUND_MSNDCLAS is not set=0A=
# CONFIG_SOUND_MSNDPIN is not set=0A=
# CONFIG_SOUND_OSS is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_MAGIC_SYSRQ is not set=0A=
# CONFIG_KGDB is not set=0A=
# CONFIG_XMON is not set=0A=

------=_NextPart_000_00E5_01BFEB30.43B29D80--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
