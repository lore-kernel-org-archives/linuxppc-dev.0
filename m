Message-ID: <19991001162617.11804.rocketmail@web601.yahoomail.com>
Date: Fri, 1 Oct 1999 18:26:17 +0200 (CEST)
From: sébastien tadéoni <sebastien_tadeoni@yahoo.fr>
Subject: Cross compile MPC860, Initrd.
To: linux ppc embedded <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hi all;

Success! I have finally built a zImage for a MPC860
MBX board.
I thank you for your help.

I made the following configuration:

#define CONFIG_PPC 1
#undef  CONFIG_6xx
#define CONFIG_8xx 1
#undef  CONFIG_MPC821
#undef  CONFIG_MPC823
#undef  CONFIG_MPC850
#define CONFIG_MPC860 1
#undef  CONFIG_MPC860T
#define CONFIG_SERIAL_CONSOLE 1
#undef  CONFIG_PMAC
#undef  CONFIG_PREP
#undef  CONFIG_CHRP
#undef  CONFIG_ALL_PPC
#undef  CONFIG_APUS
#define CONFIG_MBX 1
#undef  CONFIG_RPXLITE
#undef  CONFIG_RPXCLASSIC
#undef  CONFIG_BSEIP
#undef  CONFIG_SMP
#define CONFIG_MACH_SPECIFIC 1
/*
 * General setup
 */
#undef  CONFIG_EXPERIMENTAL
#undef  CONFIG_MODULES
#undef  CONFIG_PCI
#undef  CONFIG_PCI_QUIRKS
#define CONFIG_NET 1
#undef  CONFIG_SYSCTL
#undef  CONFIG_SYSVIPC
#undef  CONFIG_BSD_PROCESS_ACCT
#define CONFIG_BINFMT_ELF 1
#define CONFIG_KERNEL_ELF 1
#undef  CONFIG_BINFMT_MISC
#undef  CONFIG_BINFMT_JAVA
#undef  CONFIG_PARPORT
#undef  CONFIG_VGA_CONSOLE
#undef  CONFIG_FB
/*
 * Plug and Play support
 */
#undef  CONFIG_PNP
/*
 * Block devices
 */
#undef  CONFIG_BLK_DEV_FD
#undef  CONFIG_BLK_DEV_IDE
#undef  CONFIG_BLK_DEV_HD_ONLY
#undef  CONFIG_BLK_DEV_LOOP
#undef  CONFIG_BLK_DEV_NBD
#undef  CONFIG_BLK_DEV_MD
#undef  CONFIG_BLK_DEV_RAM
#undef  CONFIG_BLK_DEV_XD
#define CONFIG_PARIDE_PARPORT 1
#undef  CONFIG_PARIDE
#undef  CONFIG_BLK_DEV_HD
/*
 * Networking options
 */
#define CONFIG_PACKET 1
#define CONFIG_NETLINK 1
#undef  CONFIG_RTNETLINK
#undef  CONFIG_NETLINK_DEV
#undef  CONFIG_FIREWALL
#undef  CONFIG_FILTER
#define CONFIG_UNIX 1
#define CONFIG_INET 1
#undef  CONFIG_IP_MULTICAST
#undef  CONFIG_IP_ADVANCED_ROUTER
#define CONFIG_IP_PNP 1
#define CONFIG_IP_PNP_BOOTP 1
#undef  CONFIG_IP_PNP_RARP
#undef  CONFIG_IP_ROUTER
#undef  CONFIG_NET_IPIP
#undef  CONFIG_NET_IPGRE
#undef  CONFIG_IP_ALIAS
#undef  CONFIG_SYN_COOKIES
#undef  CONFIG_INET_RARP
#undef  CONFIG_SKB_LARGE
#undef  CONFIG_IPX
#undef  CONFIG_ATALK
/*
 * SCSI support
 */
#undef  CONFIG_SCSI
/*
 * Network device support
 */
#define CONFIG_NETDEVICES 1
#undef  CONFIG_ARCNET
#undef  CONFIG_DUMMY
#undef  CONFIG_EQUALIZER
#define CONFIG_NET_ETHERNET 1
#undef  CONFIG_MACE
#undef  CONFIG_BMAC
#undef  CONFIG_NET_VENDOR_3COM
#undef  CONFIG_LANCE
#undef  CONFIG_NET_VENDOR_SMC
#undef  CONFIG_NET_VENDOR_RACAL
#undef  CONFIG_NET_ISA
#define CONFIG_NET_EISA 1
#undef  CONFIG_PCNET32
#undef  CONFIG_APRICOT
#undef  CONFIG_CS89x0
#undef  CONFIG_DE4X5
#undef  CONFIG_DEC_ELCP
#undef  CONFIG_DGRS
#undef  CONFIG_EEXPRESS_PRO100
#undef  CONFIG_NE2K_PCI
#undef  CONFIG_TLAN
#undef  CONFIG_VIA_RHINE
#undef  CONFIG_NET_POCKET
#undef  CONFIG_FDDI
#undef  CONFIG_DLCI
#define CONFIG_PPP 1
#define CONFIG_SLIP 1
#undef  CONFIG_SLIP_COMPRESSED
#undef  CONFIG_SLIP_SMART
#undef  CONFIG_SLIP_MODE_SLIP6
#undef  CONFIG_NET_RADIO
#undef  CONFIG_TR
#undef  CONFIG_HOSTESS_SV11
#undef  CONFIG_COSA
#undef  CONFIG_RCPCI
#undef  CONFIG_WAN_DRIVERS
#undef  CONFIG_LAPBETHER
#undef  CONFIG_X25_ASY
/*
 * Amateur Radio support
 */
#undef  CONFIG_HAMRADIO
/*
 * ISDN subsystem
 */
#undef  CONFIG_ISDN
/*
 * Old CD-ROM drivers (not SCSI, not IDE)
 */
#undef  CONFIG_CD_NO_IDESCSI
/*
 * Console drivers
 */
/*
 * Character devices
 */
#undef  CONFIG_VT
#undef  CONFIG_SERIAL
#undef  CONFIG_SERIAL_EXTENDED
#undef  CONFIG_SERIAL_NONSTANDARD
#undef  CONFIG_UNIX98_PTYS
#undef  CONFIG_MOUSE
#undef  CONFIG_QIC02_TAPE
#undef  CONFIG_WATCHDOG
#undef  CONFIG_NVRAM
#undef  CONFIG_RTC
/*
 * Video For Linux
 */
#undef  CONFIG_VIDEO_DEV
/*
 * Joystick support
 */
#undef  CONFIG_JOYSTICK
#undef  CONFIG_DTLK
/*
 * Ftape, the floppy tape device driver
 */
#undef  CONFIG_FTAPE
/*
 * Filesystems
*/
#undef  CONFIG_QUOTA
#undef  CONFIG_AUTOFS_FS
#undef  CONFIG_AFFS_FS
#undef  CONFIG_HFS_FS
#define CONFIG_FAT_FS 1
#define CONFIG_MSDOS_FS 1
#undef  CONFIG_UMSDOS_FS
#define CONFIG_VFAT_FS 1
#undef  CONFIG_ISO9660_FS
#undef  CONFIG_JOLIET
#undef  CONFIG_MINIX_FS

#undef  CONFIG_NTFS_FS
#undef  CONFIG_HPFS_FS
#define CONFIG_PROC_FS 1
#undef  CONFIG_ROMFS_FS
#define CONFIG_EXT2_FS 1
#undef  CONFIG_SYSV_FS
#undef  CONFIG_UFS_FS
/*
 * Network File Systems
 */
#define CONFIG_CODA_FS 1
#define CONFIG_NFS_FS 1
#define CONFIG_ROOT_NFS 1
#undef  CONFIG_NFSD_SUN
#define CONFIG_SUNRPC 1
#define CONFIG_LOCKD 1
#undef  CONFIG_SMB_FS
#undef  CONFIG_NCP_FS
/*
 * Partition Types
 */
#undef  CONFIG_BSD_DISKLABEL
#undef  CONFIG_MAC_PARTITION
#undef  CONFIG_SMD_DISKLABEL
#undef  CONFIG_SOLARIS_X86_PARTITION
#define CONFIG_NLS 1
/*
 * Native Language Support
 */
#define CONFIG_NLS_CODEPAGE_437 1
#undef  CONFIG_NLS_CODEPAGE_737
#undef  CONFIG_NLS_CODEPAGE_775
#undef  CONFIG_NLS_CODEPAGE_850
#undef  CONFIG_NLS_CODEPAGE_852
#undef  CONFIG_NLS_CODEPAGE_855
#undef  CONFIG_NLS_CODEPAGE_857
#undef  CONFIG_NLS_CODEPAGE_860
#undef  CONFIG_NLS_CODEPAGE_861
#undef  CONFIG_NLS_CODEPAGE_862
#undef  CONFIG_NLS_CODEPAGE_863
#undef  CONFIG_NLS_CODEPAGE_864
#undef  CONFIG_NLS_CODEPAGE_865
#undef  CONFIG_NLS_CODEPAGE_866
#undef  CONFIG_NLS_CODEPAGE_869
#undef  CONFIG_NLS_CODEPAGE_874
#undef  CONFIG_NLS_ISO8859_1
#undef  CONFIG_NLS_ISO8859_2
#undef  CONFIG_NLS_ISO8859_3
#undef  CONFIG_NLS_ISO8859_4
#undef  CONFIG_NLS_ISO8859_5
#undef  CONFIG_NLS_ISO8859_6
#undef  CONFIG_NLS_ISO8859_7
#undef  CONFIG_NLS_ISO8859_8
#undef  CONFIG_NLS_ISO8859_9
#undef  CONFIG_NLS_ISO8859_15
#undef  CONFIG_NLS_KOI8_R
/*
 * Sound
 */
#undef  CONFIG_SOUND

/*
 * Kernel hacking
 */
#undef  CONFIG_MAGIC_SYSRQ
#undef  CONFIG_KGDB
#undef  CONFIG_XMON

I hope it will work in futur!

Some modifications:

In arch/ppc/vmliux.lds L2: I replace
'....powerpc-any-elf/lib.'in the variable SEARCH_DIR
by powerpc-linux/lib/ldsrcipt which corresponds to the
path of the environment built with egcs.

I think that the QSPANPCI option isn't necessary
because in arch/ppc/mbxboot/Makefile, CONFIG_MBX
includes qspanpci.o.
I assume the option in menuconfig is for another board
like RPX.

I had problems with the #include <sys/type.h> in the
arch/ppc/mbxboot/qspanpci.c and pci.c because the sys
directory doesn't exist at all.
I commented them out.

I had the following errors during compilation:

m8xx_setup.c: In function `m8xx_init_IRQ':
m8xx_setup.c:280: warning: implicit declaration of
function `cpm_interrupt_init'
m8xx_setup.c:285: `i8259_pic' undeclared (first use in
this function)
m8xx_setup.c:285: (Each undeclared identifier is
reported only once
m8xx_setup.c:285: for each function it appears in.)
m8xx_setup.c:287: warning: implicit declaration of
function `i8259_init'
m8xx_setup.c:288: `mbx_i8259_action' undeclared (first
use in this function)
make[1]: *** [m8xx_setup.o] Error 1
make[1]: Leaving directory
`/home/linux-2.2.5/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2

In arch/ppc/kernel/m8xx_setup.c:

L270:In the function '__initfunc(void
m8xx_init_IRQ...'

I declared:
extern void mbx_i8259_action(int cpl, void *dev_id,
struct pt_regs *regs);
and
extern void cpm_interrupt_init();

I added an #include "i8259.h" for the i8259_pic
variable.

In arch/ppc/kernel/ppc8xx_pic.c:

I added #include "i8259.h" and <asm/io.h> for the
'inl'
'outb' and 'inb' functions.

I think there's a typo L151: I replace the parameter
'defname' by 'devname'.

And L121 I supprime the 'Static' in the definition of 
 
mbx_i8259_action. (she's used in m8xx_setup.c).

No change with the EXPORT_SYMBOL of ppc_ksyms.c
directory.

In drivers/char/Makefile:L47
I commented out the heading 'arch=m68k...'

And indrivers/macintosh/Makefile:L18
I replace (like Graham) ifndef CONFIG_MBX by 
ifdef CONFIG_PMAC.

Now I try to make a zImage.initrd, but I don't now
very well how to build the ramdisk.image.gz file.

I saw some line like '#RAMDISK = -DRAMDISK=512' in the
Makefile files...?
I don't know to how and especially where the
bootloader is configured (I assume in Head.S mainly).

I hope that somoene had some info on this points and
he could tell them me.

Have a good Day.
Sébastien Tadéoni.

=====


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
