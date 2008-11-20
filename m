Return-Path: <nanda74pg@rediffmail.com>
Date: 20 Nov 2008 14:23:13 -0000
MIME-Version: 1.0
To: <kim.phillips@freescale.com>
Message-ID: <DFTSjB77IF.old.1227190993.15428@webmail.rediffmail.com>
Subject: Re :Re: 8360E MDS - linux 2.6.20
From: "nanda" <nanda74pg@rediffmail.com>
Content-Type: multipart/mixed;
	boundary="=_29eb7b78d12a57b7ff82a597449e2362"
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=_29eb7b78d12a57b7ff82a597449e2362
Content-Type: multipart/alternative;
	boundary="=_3a402add1303e5149b29c11b14e82ab7"

--=_3a402add1303e5149b29c11b14e82ab7
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi Kim,I did the following steps, but Iam unable to generate the rootfs.ext2.gz.uboot - Executed the ./install command from the 8360CD. As a result of it generated the ltib directory- In the ltib directory ./ltib --configureIn the configure menu, I specified the following, before saving the configs- Tool chain as (gcc-3.4.3/glibc-2.3.3)- uboot 1.1.3- "Kernel (local linux directory build)" which refers to the local directory where linux-2.6.20.6 is placed- "Kernel config file"specified as mpc8360emds_defconfig, which is the file copied from /home/nanda/linux2.6.20.6/arch/powerpc/configs/mpc8360emds_defconfig to the ltib/config/platform/mpc8360epb directory) - Linux Target Architecture as "powerpc"After the above process by saving the configuration (it started building kernel and generated uImage) and failed in the below place (Refer also the attached build.txt file)================================Processing: skell =================== Testing ppp_url connectivity: FAIL, disabling Testing gpp_url connectivity: FAIL, disabling No network download connection availableStarted: Thu Nov 20 14:44:45 2008 Ended: Thu Nov 20 14:57:32 2008 Elapsed: 767 seconds Build Failed=====================================I have attached the below files for boot and build logs with this mail, 1) defconfig.dev - default config generated for "./ltib configure"&nbsp;from config/platform/mpc8360epb&nbsp;2) build.txt - Error build during "./ltib configure" output3) mpc8360emds_defconfig - Default config file from /home/nanda/linux2.6.20.6/arch/powerpc/configs/ The end result was I could only see the uImage generated without rootfs.ext2.gz.uboot. &nbsp;Please clarify on the same Thanks in advance,Regards,NandaOn Wed, 19 Nov 2008 11:47:51 -0600 Kim Phillips wroteOn 19 Nov 2008 09:08:10 -0000"nanda" wrote:&gt; I could successfully build the uImage for linux 2.6.20.6 on the mpc8360E MDS. But I also need the rootfs.ext2.gz.uboot(RAMDisk Image) required for bringing up the board. Can also get the steps for the building the rootfs?&gt; &gt; Since the reference board mpc8360E MDS which I got from freescale had default (uImage and rootfs.ext2.gz.uboot) only for linux 2.6.11. Iam finding difficulty in bringing for linux 2.6.20.6 kernel.What problems are you seeing running the 2.6.20 based kernel image andthe rootfs you built with ltib?Kim_______________________________________________Linuxppc-dev mailing listLinuxppc-dev@ozlabs.orghttps://ozlabs.org/mailman/listinfo/linuxppc-dev
--=_3a402add1303e5149b29c11b14e82ab7
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; mso-pagination: none; mso-=
layout-grid-align: none">Hi Kim,</p><p></p><p></p><p class=3D"MsoNormal" st=
yle=3D"MARGIN: 5pt 0in; mso-pagination: none; mso-layout-grid-align: none">=
I did the following steps, but Iam unable to generate the rootfs.ext2.gz.ub=
oot </p><p></p><p></p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; mso-=
pagination: none; mso-layout-grid-align: none">- Executed the ./install com=
mand from the 8360CD. As a result of it generated the ltib directory</p><p>=
</p><p></p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; mso-pagination:=
 none; mso-layout-grid-align: none">- In the ltib directory </p><p></p><p><=
/p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; mso-pagination: none; m=
so-layout-grid-align: none">./ltib --configure</p><p></p><p></p><p class=3D=
"MsoNormal" style=3D"MARGIN: 5pt 0in; mso-pagination: none; mso-layout-grid=
-align: none">In the configure menu, I specified the following, before savi=
ng the configs</p><p></p><p></p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt=
 0in; mso-pagination: none; mso-layout-grid-align: none">- Tool chain as (g=
cc-3.4.3/glibc-2.3.3)</p><p></p><p></p><p class=3D"MsoNormal" style=3D"MARG=
IN: 5pt 0in; mso-pagination: none; mso-layout-grid-align: none">- uboot 1.1=
.3</p><p></p><p></p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; mso-pa=
gination: none; mso-layout-grid-align: none">- "Kernel (local linux directo=
ry build)" which refers to the local directory where linux-2.6.20.6 is plac=
ed</p><p></p><p></p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; mso-pa=
gination: none; mso-layout-grid-align: none">- "Kernel config file"specifie=
d as mpc8360emds_defconfig, which is the file copied from /home/nanda/linux=
2.6.20.6/arch/powerpc/configs/mpc8360emds_defconfig to the ltib/config/plat=
form/mpc8360epb directory) </p><p></p><p></p><p class=3D"MsoNormal" style=
=3D"MARGIN: 5pt 0in; mso-pagination: none; mso-layout-grid-align: none">- L=
inux Target Architecture as "powerpc"</p><p></p><p></p><p class=3D"MsoNorma=
l" style=3D"MARGIN: 5pt 0in; mso-pagination: none; mso-layout-grid-align: n=
one">After the above process by saving the configuration (it started buildi=
ng kernel and generated uImage) and failed in the below place (Refer also t=
he attached build.txt file)</p><p></p><p></p><p class=3D"MsoNormal" style=
=3D"MARGIN: 5pt 0in; mso-pagination: none; mso-layout-grid-align: none">=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D</p><p></p><p></p><p class=3D"MsoNormal" style=3D"MARGIN:=
 5pt 0in; mso-pagination: none; mso-layout-grid-align: none">Processing: sk=
ell </p><p></p><p></p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; mso-=
pagination: none; mso-layout-grid-align: none">=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D </p><p></p><p></p><p class=3D"MsoNormal" sty=
le=3D"MARGIN: 5pt 0in; mso-pagination: none; mso-layout-grid-align: none">T=
esting ppp_url connectivity: FAIL, disabling </p><p></p><p></p><p class=3D"=
MsoNormal" style=3D"MARGIN: 5pt 0in; mso-pagination: none; mso-layout-grid-=
align: none">Testing gpp_url connectivity: FAIL, disabling </p><p></p><p></=
p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; mso-pagination: none; ms=
o-layout-grid-align: none">No network download connection available</p><p><=
/p><p></p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; mso-pagination: =
none; mso-layout-grid-align: none">Started: Thu Nov 20 14:44:45 2008 </p><p=
></p><p></p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; mso-pagination=
: none; mso-layout-grid-align: none">Ended: Thu Nov 20 14:57:32 2008 </p><p=
></p><p></p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; mso-pagination=
: none; mso-layout-grid-align: none">Elapsed: 767 seconds </p><p></p><p></p=
><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; mso-pagination: none; mso=
-layout-grid-align: none">Build Failed</p><p></p><p></p><p class=3D"MsoNorm=
al" style=3D"MARGIN: 5pt 0in; mso-pagination: none; mso-layout-grid-align: =
none">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</p><p></p><p></p><p class=3D"Mso=
Normal" style=3D"MARGIN: 5pt 0in; mso-pagination: none; mso-layout-grid-ali=
gn: none">I have attached the below files for boot and build logs with this=
 mail, </p><p></p><p></p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; m=
so-pagination: none; mso-layout-grid-align: none">1) defconfig.dev - defaul=
t config generated for "./ltib configure"&nbsp;from config/platform/mpc8360=
epb&nbsp;</p><p></p><p></p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in;=
 mso-pagination: none; mso-layout-grid-align: none">2) build.txt - Error bu=
ild during "./ltib configure" output</p><p></p><p></p><p class=3D"MsoNormal=
" style=3D"MARGIN: 5pt 0in; mso-pagination: none; mso-layout-grid-align: no=
ne">3) mpc8360emds_defconfig - Default config file from /home/nanda/linux2.=
6.20.6/arch/powerpc/configs/ </p><p></p><p></p><p class=3D"MsoNormal" style=
=3D"MARGIN: 5pt 0in; mso-pagination: none; mso-layout-grid-align: none">The=
 end result was I could only see the uImage generated without rootfs.ext2.g=
z.uboot. <span style=3D"mso-spacerun: yes">&nbsp;</span>Please clarify on t=
he same </p><p></p><p></p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; =
mso-pagination: none; mso-layout-grid-align: none">Thanks in advance,</p><p=
></p><p></p><p class=3D"MsoNormal" style=3D"MARGIN: 5pt 0in; mso-pagination=
: none; mso-layout-grid-align: none">Regards,</p><p></p><p></p><p class=3D"=
MsoNormal" style=3D"MARGIN: 5pt 0in; mso-pagination: none; mso-layout-grid-=
align: none">Nanda</p><p></p><p></p><p class=3D"MsoNormal" style=3D"MARGIN:=
 0in 0in 0pt; mso-pagination: none; mso-layout-grid-align: none"><span styl=
e=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><p></p></span></p><p></p><p></p><=
br />On Wed, 19 Nov 2008 11:47:51 -0600 Kim Phillips wrote<br />On 19 Nov 2=
008 09:08:10 -0000<br />"nanda" wrote:<br /><br />&gt; I could successfully=
 build the uImage for linux 2.6.20.6 on the mpc8360E MDS. But I also need t=
he rootfs.ext2.gz.uboot(RAMDisk Image) required for bringing up the board. =
Can also get the steps for the building the rootfs?<br />&gt; <br />&gt; Si=
nce the reference board mpc8360E MDS which I got from freescale had default=
 (uImage and rootfs.ext2.gz.uboot) only for linux 2.6.11. Iam finding diffi=
culty in bringing for linux 2.6.20.6 kernel.<br /><br />What problems are y=
ou seeing running the 2.6.20 based kernel image and<br />the rootfs you bui=
lt with ltib?<br /><br />Kim<br />_________________________________________=
______<br />Linuxppc-dev mailing list<br />Linuxppc-dev@ozlabs.org<br />htt=
ps://ozlabs.org/mailman/listinfo/linuxppc-dev<br /><br /><br><Table border=
=3D0 Width=3D644 Height=3D57 cellspacing=3D0 cellpadding=3D0 style=3D'font-=
family:Verdana;font-size:11px;line-height:15px;'><TR><td><a href=3D'http://=
adworks.rediff.com/cgi-bin/AdWorks/click.cgi/www.rediff.com/signature-defau=
lt.htm/1050715198@Middle5/2206641_2199021/2201651/1?PARTNER=3D3&OAS_QUERY=
=3Dnull' target=3Dnew ><img src =3D'http://imadworks.rediff.com/cgi-bin/AdW=
orks/adimage.cgi/2206641_2199021/creative_2201651.gif'  alt=3D'Rediff Shopp=
ing'  border=3D0></a></td></TR></Table>
--=_3a402add1303e5149b29c11b14e82ab7--

--=_29eb7b78d12a57b7ff82a597449e2362
Content-Type: text/plain, English; charset=us-ascii
Content-Disposition: attachment; filename="defconfig.dev"

#
# Automatically generated make config: don't edit
# LTIB version: 6.2.1
#
CONFIG_CONFIG_TITLE="LTIB: Freescale MPC8360E PB PowerPC board"
CONFIG_CPU="MPC8360EPB"
CONFIG_PLATFORM_COMMENT="Freescale MPC8360E PB PowerPC board"
CONFIG_VENDOR="Freescale"
CONFIG_PLATFORM="mpc8360epb"
CONFIG_GNUTARCH="powerpc"
CONFIG_CFGHOST="powerpc-linux"

#
# Choose the platform revision
#
# CONFIG_PLATFORM_REV1 is not set
CONFIG_PLATFORM_REV2=y
CONFIG_ENDIAN="big"

#
# Choose the target C library type
#
CONFIG_GLIBC=y
# CONFIG_UCLIBC is not set

#
# Choose your toolchain
#
CONFIG_TOOLCHAIN1=y
# CONFIG_TOOLCHAIN2 is not set
# CONFIG_TOOLCHAIN3 is not set
# CONFIG_TOOLCHAIN_CUSTOM is not set
CONFIG_TOOLCHAIN="mtwk-lnx-powerpc-gcc-3.4.3-glibc-2.3.3-0.28-1.i686.rpm"
CONFIG_TOOLCHAIN_PATH="/opt/mtwk/usr/local/powerpc-linux/gcc-3.4.3-glibc-2.3.3"
CONFIG_TOOLCHAIN_PREFIX="powerpc-linux-"
CONFIG_TOOLCHAIN_CFLAGS=""

#
# Choose bootloader
#
CONFIG_BOOTLOADER1=y
# CONFIG_BOOTLOADER2 is not set
# CONFIG_BOOTLOADER_NONE is not set
CONFIG_PKG_U_BOOT="u-boot-1.1.3-mpc8360epb-rev2"
CONFIG_PKG_U_BOOT_GENERAL=y
# CONFIG_PKG_U_BOOT_PCI33M is not set
# CONFIG_PKG_U_BOOT_PCI66M is not set
# CONFIG_PKG_U_BOOT_PCIAGENT is not set
CONFIG_PKG_U_BOOT_CONFIG_TYPE="MPC8360EPB_config"
CONFIG_PKG_U_BOOT_BUILD_ARGS="OPTFLAGS=-Os"

#
# Choose your Kernel
#
# CONFIG_KERNEL1 is not set
# CONFIG_KERNEL2 is not set
CONFIG_KERNEL_DIR_BUILD=y
# CONFIG_KERNEL_NONE is not set
CONFIG_PKG_KERNEL="kernel26-dir-build"

#
# Choose the Linux Target Architecture
#
# CONFIG_LINTARCH_PPC is not set
CONFIG_LINTARCH_POWERPC=y
CONFIG_LINTARCH="powerpc"
CONFIG_PKG_KERNEL_PATH_PRECONFIG="/home/nanda/linux-2.6.20.6/"
CONFIG_PKG_KERNEL_KBUILD_PRECONFIG="$PKG_KERNEL_PATH_PRECONFIG/../kbuild/$PLATFORM"
CONFIG_KERNEL_CONFIG1=y
# CONFIG_KERNEL_CONFIG2 is not set
# CONFIG_KERNEL_CONFIG3 is not set
# CONFIG_KERNEL_CONFIG4 is not set
# CONFIG_KERNEL_CONFIG5 is not set
# CONFIG_KERNEL_CONFIG6 is not set
# CONFIG_KERNEL_CONFIG7 is not set
# CONFIG_KERNEL_CONFIG8 is not set
# CONFIG_KERNEL_CONFIG9 is not set
# CONFIG_KERNEL_CONFIG_CUSTOM is not set
CONFIG_PKG_KERNEL_PRECONFIG="mpc8360emds_defconfig.config"
# CONFIG_PKG_KERNEL_WANT_HEADERS is not set
# CONFIG_PKG_KERNEL_WANT_CF is not set
# CONFIG_PKG_KERNEL_LEAVESRC is not set
CONFIG_DISTRO="dist/lfs-5.1"

#
# Package selection
#

#
# Package list
#
CONFIG_PKG_APPTRK_PPCBIN=y
# CONFIG_PKG_AUTOCONF is not set
# CONFIG_PKG_AUTOMAKE is not set
CONFIG_LIBC_WANTED=y
CONFIG_PKG_LIBC="base_libs"
# CONFIG_PKG_LIBC_WANT_LOCALES is not set
# CONFIG_PKG_LIBC_WANT_HEADERS is not set
# CONFIG_PKG_LIBC_WANT_STATIC_LIBS is not set
# CONFIG_PKG_ALSA_LIB is not set
# CONFIG_PKG_ALSA_UTILS is not set
# CONFIG_PKG_BASH is not set
# CONFIG_PKG_BIND is not set
# CONFIG_PKG_BINUTILS is not set
# CONFIG_PKG_BISON is not set
# CONFIG_PKG_BOA is not set
# CONFIG_PKG_BONNIE_PLUS_PLUS is not set
# CONFIG_PKG_BRIDGE_UTILS is not set
CONFIG_PKG_BUSYBOX=y
CONFIG_PKG_BUSYBOX_PRECONFIG="busybox.config"
# CONFIG_PKG_BUSYBOX_WANT_CF is not set
# CONFIG_PKG_BZIP2 is not set
# CONFIG_PKG_CAN4LINUX is not set
# CONFIG_PKG_CLAMAV is not set
# CONFIG_PKG_COREUTILS is not set
# CONFIG_PKG_CPIO is not set
# CONFIG_PKG_CRACKLIB is not set
# CONFIG_PKG_CRAMFS is not set
# CONFIG_PKG_DAEMONIZER is not set
# CONFIG_PKG_DEVMEM2 is not set
# CONFIG_PKG_DHCP is not set
# CONFIG_PKG_DB1 is not set
CONFIG_PKG_DEV=y
# CONFIG_PKG_DEVFSD is not set
# CONFIG_PKG_DEV_NONE is not set
# CONFIG_PKG_DIFFUTILS is not set
# CONFIG_PKG_DIRECTFB is not set
# CONFIG_PKG_DISTCC is not set
# CONFIG_PKG_DOSFSTOOLS is not set
# CONFIG_PKG_DROPBEAR is not set
# CONFIG_PKG_DTC is not set
# CONFIG_PKG_E2FSPROGS is not set
# CONFIG_PKG_ED is not set
# CONFIG_PKG_ETHTOOL is not set
# CONFIG_PKG_EXPAT is not set
# CONFIG_PKG_FAKEROOT is not set
CONFIG_PKG_FAKE_PROVIDES=y
# CONFIG_PKG_FINDUTILS is not set
CONFIG_PKG_FLEX=y
# CONFIG_PKG_FREETYPE is not set
# CONFIG_PKG_GAWK is not set
# CONFIG_PKG_GCC is not set
# CONFIG_PKG_GDB is not set
# CONFIG_PKG_GENEXT2FS is not set
# CONFIG_PKG_GENROMFS is not set
# CONFIG_PKG_GETTEXT is not set
# CONFIG_PKG_GMP is not set
# CONFIG_PKG_GREP is not set
# CONFIG_PKG_GROFF is not set
# CONFIG_PKG_HDPARM is not set
# CONFIG_PKG_HELLOWORLD is not set
# CONFIG_PKG_HESIOD is not set
# CONFIG_PKG_HOTPLUG is not set
# CONFIG_PKG_HTTPD is not set
CONFIG_PKG_I2C_TOOLS=y
# CONFIG_PKG_IPROUTE is not set
# CONFIG_PKG_PIDENTD is not set
# CONFIG_PKG_INETUTILS is not set
# CONFIG_PKG_IPERF is not set
# CONFIG_PKG_IPSEC_TOOLS is not set
# CONFIG_PKG_IPSECADM is not set
# CONFIG_PKG_IPTABLES is not set
# CONFIG_PKG_IPUTILS is not set
# CONFIG_PKG_IRATTACH is not set
# CONFIG_PKG_KBD is not set
# CONFIG_PKG_LESS is not set
# CONFIG_PKG_LFS_UTILS is not set
# CONFIG_PKG_LIBID3TAG is not set
# CONFIG_PKG_LIBMAD is not set
# CONFIG_PKG_LIBJPEG is not set
# CONFIG_PKG_LIBELF is not set
# CONFIG_PKG_LIBPCAP is not set
# CONFIG_PKG_LIBPNG is not set
# CONFIG_PKG_LIBTERMCAP is not set
# CONFIG_PKG_LIBTOOL is not set
# CONFIG_PKG_LIBUSB is not set
# CONFIG_PKG_LIBXML2 is not set
CONFIG_PKG_LINUX_ATM=y
# CONFIG_PKG_LINUX_WLAN is not set
# CONFIG_PKG_LKC is not set
# CONFIG_PKG_LTP is not set
# CONFIG_PKG_LMBENCH is not set
# CONFIG_PKG_LRZSZ is not set
# CONFIG_PKG_M4 is not set
# CONFIG_PKG_MADPLAY is not set
# CONFIG_PKG_MAKE is not set
# CONFIG_PKG_MAN is not set
# CONFIG_PKG_MDADM is not set
CONFIG_PKG_MERGE=y
# CONFIG_PKG_MICROWINDOWS is not set
# CONFIG_PKG_MODUTILS is not set
CONFIG_PKG_MODULE_INIT_TOOLS=y
# CONFIG_MODUTILS_NONE is not set
# CONFIG_PKG_MTD_UTILS is not set
# CONFIG_PKG_MYSQL is not set
# CONFIG_PKG_NCURSES is not set
# CONFIG_PKG_NET_TOOLS is not set
# CONFIG_PKG_NETPERF is not set
CONFIG_PKG_NTPCLIENT=y
# CONFIG_PKG_OPENSSH is not set
# CONFIG_PKG_OPENSSL is not set
# CONFIG_PKG_OPENSWAN is not set
# CONFIG_PKG_OPROFILE is not set
# CONFIG_PKG_PATCH is not set
CONFIG_PKG_PCIUTILS=y
# CONFIG_PKG_PCMCIA_CS is not set
# CONFIG_PKG_PCRE is not set
# CONFIG_PKG_PERL is not set
# CONFIG_PKG_PHP is not set
# CONFIG_PKG_POPT is not set
# CONFIG_PKG_PORTMAP is not set
# CONFIG_PKG_PPP is not set
# CONFIG_PKG_PROCINFO is not set
# CONFIG_PKG_PROCPS is not set
# CONFIG_PKG_PSMISC is not set
CONFIG_PKG_PTPD=y
# CONFIG_PKG_PYTHON is not set
# CONFIG_PKG_QTOPIA is not set
# CONFIG_PKG_RPM is not set
# CONFIG_PKG_RNG_TOOLS is not set
# CONFIG_PKG_RSYNC is not set
# CONFIG_PKG_SAMBA is not set
# CONFIG_PKG_SASH is not set
# CONFIG_PKG_SCHEDUTILS is not set
# CONFIG_PKG_SCREEN is not set
# CONFIG_PKG_SED is not set
# CONFIG_PKG_SEQ is not set
# CONFIG_PKG_SETSERIAL is not set
CONFIG_PKG_SKELL=y
# CONFIG_PKG_SKELL_WANT_TERMINFO is not set
# CONFIG_PKG_STRACE is not set
CONFIG_PKG_SYSCONFIG=y
# CONFIG_PKG_SYSKLOGD is not set
# CONFIG_PKG_SYSVINIT is not set
# CONFIG_PKG_TAR is not set
# CONFIG_PKG_TCPDUMP is not set
# CONFIG_PKG_TCP_WRAPPERS is not set
# CONFIG_PKG_TEXINFO is not set
# CONFIG_PKG_TIME is not set
# CONFIG_PKG_TIMEZONE is not set
# CONFIG_PKG_TINYLOGIN is not set
# CONFIG_PKG_UDEV is not set
# CONFIG_PKG_USBUTILS is not set
# CONFIG_PKG_UCLINUX_CKSUM is not set
# CONFIG_PKG_UTIL_LINUX is not set
# CONFIG_PKG_U_BOOT_TOOLS is not set
# CONFIG_PKG_UNZIP is not set
# CONFIG_PKG_VIM is not set
# CONFIG_PKG_VSFTPD is not set
# CONFIG_PKG_WGET is not set
# CONFIG_PKG_WHICH is not set
# CONFIG_PKG_WIRELESS_TOOLS is not set
# CONFIG_PKG_YAFFS_UTILS is not set
# CONFIG_PKG_ZLIB is not set

#
# Target System Configuration
#

#
# Options
#
CONFIG_SYSCFG_HOSTNAME="freescale"
CONFIG_SYSCFG_WANT_LOGIN_TTY=y
CONFIG_SYSCFG_LOGING_TTY="::respawn:/sbin/getty -L ttyS0 115200 vt100"
CONFIG_SYSCFG_MODLIST=""
# CONFIG_SYSCFG_START_DEVFSD is not set
CONFIG_SYSCFG_START_NETWORK=y

#
# Network setup
#

#
# 
#
CONFIG_SYSCFG_IFACE0=y
CONFIG_SYSCFG_NET_INTERFACE0="eth0"
# CONFIG_SYSCFG_DHCPC0 is not set
CONFIG_SYSCFG_IPADDR0="192.168.0.254"
CONFIG_SYSCFG_NET_MASK0="255.255.255.0"
CONFIG_SYSCFG_NET_BROADCAST0="192.168.0.255"
CONFIG_SYSCFG_NET_GATEWAY0="192.168.0.1"
CONFIG_SYSCFG_NAMESERVER0="192.168.0.1"

#
# 
#
# CONFIG_SYSCFG_IFACE1 is not set

#
# 
#
# CONFIG_SYSCFG_IFACE2 is not set

#
# 
#
# CONFIG_SYSCFG_IFACE3 is not set

#
# 
#
# CONFIG_SYSCFG_IFACE4 is not set
# CONFIG_SYSCFG_SETTIME is not set
# CONFIG_SYSCFG_START_SYSLOG is not set
CONFIG_SYSCFG_START_INETD=y
CONFIG_SYSCFG_INETD_ARGS=""

#
# Target Image Generation
#

#
# Options
#

#
# Choose your root filesystem image type
#
# CONFIG_DEPLOYMENT_JFFS2 is not set
CONFIG_DEPLOYMENT_RAMDISK=y
# CONFIG_DEPLOYMENT_CRAMFS is not set
# CONFIG_DEPLOYMENT_ROMFS is not set
# CONFIG_DEPLOYMENT_NFS is not set
CONFIG_SYSCFG_DEPLOYMENT_STYLE="RAMDISK"
# CONFIG_SYSCFG_READONLY_FS is not set
CONFIG_SYSCFG_RAM_DIRS=""
CONFIG_DEPLOYMENT_RAMDISK_U_BOOT=y
CONFIG_DEPLOYMENT_ROOTFS_DIR=""
# CONFIG_DEPLOYMENT_ROOTFS_KEEPSTAGE is not set
CONFIG_DEPLOYMENT_RM_DOCS=y
CONFIG_DEPLOYMENT_RM_BOOT=y
CONFIG_DEPLOYMENT_RM_USR_SRC=y
CONFIG_DEPLOYMENT_RM_USR_INCLUDE=y
CONFIG_DEPLOYMENT_RM_USER_DIRS=""
CONFIG_DEPLOYMENT_RM_USER_FILES=""
CONFIG_DEPLOYMENT_RM_STATIC_LIBS=y
CONFIG_DEPLOYMENT_STRIP=y
CONFIG_DEPLOYMENT_PADDING_KB="0"
CONFIG_ERASE_BLOCK_SIZE="64"
CONFIG_CAP_UCLIBC=y
CONFIG_CAP_GLIBC=y
CONFIG_CAP_LFS_5_1=y
CONFIG_SYSCFG_TMPFS="tmpfs"
CONFIG_INITTAB_LINE="::respawn:/sbin/getty -L console 0 screen"
CONFIG_LTIB_RELEASE="6.2.1"


--=_29eb7b78d12a57b7ff82a597449e2362
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="build.txt"

  LD      init/built-in.o
  LD      vmlinux
  SYSMAP  System.map
  MODPOST vmlinux
  WRAP    arch/powerpc/boot/uImage
Image Name:   Linux-2.6.20.6
Created:      Thu Nov 20 14:54:04 2008
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    1205859 Bytes = 1177.60 kB = 1.15 MB
Load Address: 0x00000000
Entry Point:  0x00000000
+ grep -q '^CONFIG_MODULES='
/home/nanda/linux-2.6.20.6//../kbuild/mpc8360epb/.config
+ make ARCH=powerpc CROSS_COMPILE= 'HOSTCC=/usr/bin/gcc -B/usr/bin//' modules
  Using /home/nanda/linux-2.6.20.6 as source for kernel
  GEN     /home/nanda/kbuild/mpc8360epb/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CC [M]  crypto/ecb.o
  Building modules, stage 2.
  MODPOST 1 modules
  CC      crypto/ecb.mod.o
  LD [M]  crypto/ecb.ko
+ '[' powerpc = powerpc -a -d '/home/nanda/linux-2.6.20.6//%{dtc_path}' ']'
+ exit 0
Executing(%install): /bin/sh -e
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/rpm-tmp.94803
+ umask 022
+ cd /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/BUILD
+ KSRC_DIR=/home/nanda/linux-2.6.20.6/
+ cd /home/nanda/linux-2.6.20.6/
++ pwd
+ KSRC_DIR=/home/nanda/linux-2.6.20.6
++ eval echo '$PKG_KERNEL_PATH_PRECONFIG/../kbuild/$PLATFORM'
+++ echo /home/nanda/linux-2.6.20.6//../kbuild/mpc8360epb
+ KBOUT=/home/nanda/linux-2.6.20.6//../kbuild/mpc8360epb
+ KBOUT=/home/nanda/linux-2.6.20.6//../kbuild/mpc8360epb
+ '[' /home/nanda/linux-2.6.20.6//../kbuild/mpc8360epb '!=' . ']'
+ export KBUILD_OUTPUT=/home/nanda/linux-2.6.20.6//../kbuild/mpc8360epb
+ KBUILD_OUTPUT=/home/nanda/linux-2.6.20.6//../kbuild/mpc8360epb
+ grep -q CONFIG_PPC_MERGE=y
/home/nanda/linux-2.6.20.6//../kbuild/mpc8360epb/.config
+ LINTARCH=powerpc
+ case $LINTARCH in
+ BOOT_KERNEL=arch/powerpc/boot/uImage
+ grep -q CONFIG_PPCMERGE=y
/home/nanda/linux-2.6.20.6//../kbuild/mpc8360epb/.config
+ rm -rf /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/kernel
+ mkdir -p
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/kernel//opt/freescale/rootfs/powerpc/boot
+ cd /home/nanda/linux-2.6.20.6//../kbuild/mpc8360epb
+ SYSCFG_BOOT_KERNEL=arch/powerpc/boot/uImage
+ '[' -n '' ']'
+ for i in vmlinux System.map '$SYSCFG_BOOT_KERNEL'
+ cp vmlinux
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/kernel//opt/freescale/rootfs/powerpc/boot/
+ for i in vmlinux System.map '$SYSCFG_BOOT_KERNEL'
+ cp System.map
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/kernel//opt/freescale/rootfs/powerpc/boot/
+ for i in vmlinux System.map '$SYSCFG_BOOT_KERNEL'
+ cp arch/powerpc/boot/uImage
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/kernel//opt/freescale/rootfs/powerpc/boot/
++ basename arch/powerpc/boot/uImage
+ ln -s uImage
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/kernel//opt/freescale/rootfs/powerpc/boot/bootable_kernel
+ cp .config
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/kernel//opt/freescale/rootfs/powerpc/boot/linux.config
+ grep -q '^CONFIG_MODULES=' .config
+ make ARCH=powerpc CROSS_COMPILE= 'HOSTCC=/usr/bin/gcc -B/usr/bin//'
DEPMOD=/bin/true
INSTALL_MOD_PATH=/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/kernel//opt/freescale/rootfs/powerpc
modules_install
make -C /home/nanda/linux-2.6.20.6 O=/home/nanda/kbuild/mpc8360epb
modules_install
Warning: you may need to install module-init-tools
See http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt
  INSTALL crypto/ecb.ko
if [ -r System.map -a -x /bin/true ]; then /bin/true -ae -F System.map -b
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/kernel//opt/freescale/rootfs/powerpc
-r 2.6.20.6; fi
+ '[' powerpc = powerpc -a -d '/home/nanda/linux-2.6.20.6/%{dtc_path}' ']'
+ '[' -n '' ']'
+ /opt/freescale/ltib/usr/lib/rpm/brp-compress
+ /opt/freescale/ltib/usr/lib/rpm/brp-strip
+ /opt/freescale/ltib/usr/lib/rpm/brp-strip-comment-note
Processing files: kernel-local-1
Finding  Provides: (using /opt/freescale/ltib/usr/lib/rpm/find-provides)...
Finding  Requires: (using /opt/freescale/ltib/usr/lib/rpm/find-requires)...
PreReq: rpmlib(PayloadFilesHavePrefix) <= 4.0-1 rpmlib(CompressedFileNames) <=
3.0.4-1
Requires(rpmlib): rpmlib(PayloadFilesHavePrefix) <= 4.0-1
rpmlib(CompressedFileNames) <= 3.0.4-1
Wrote:
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/RPMS/powerpc/kernel-local-1.powerpc.rpm
Executing(%clean): /bin/sh -e
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/rpm-tmp.6373
+ umask 022
+ cd /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/BUILD
+ rm -rf /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/kernel
+ '[' -z '' ']'
+ rm -f /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/BUILD/linux
+ exit 0
Executing(--clean): /bin/sh -e
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/rpm-tmp.6373+ umask 022
+ cd /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/BUILD
+ exit 0
Build time for kernel26-dir-build: 336 seconds

sudo /opt/freescale/ltib/usr/bin/rpm --dbpath
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpmdb -e --allmatches
--nodeps kernel 2>/dev/null
sudo /opt/freescale/ltib/usr/bin/rpm --dbpath
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpmdb --prefix
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rootfs --ignorearch -ivh
--force --excludedocs
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/RPMS/powerpc/kernel-local-1.powerpc.rpm
Preparing...                ########################################### [100%]
   1:kernel                 ########################################### [100%]
sysconfig rebuild forced by kernel26-dir-build

Processing: dev
=================
rpmbuild --dbpath /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpmdb
--define '_unpackaged_files_terminate_build 0' --define '_target_cpu powerpc'
--define '__strip strip' --define '_topdir
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm' --define '_prefix /usr'
--define '_tmppath /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp'
--define '_mandir /usr/share/man' --define '_sysconfdir /etc' --define
'_localstatedir /var' -bb  --clean --rmsource
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/dist/lfs-5.1/dev/dev.spec
Executing(%prep): /bin/sh -e
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/rpm-tmp.32072
+ umask 022
+ cd /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/BUILD
+ cd /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/BUILD
+ rm -rf dev-1.1
+ /bin/gzip -dc
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/SOURCES/dev-1.1.tar.gz
+ tar -xvvf -
drwxr-xr-x seh/users         0 2005-03-23 17:18:28 dev-1.1/
-rw-r--r-- seh/users      5643 2005-03-23 01:19:36 dev-1.1/device_table.txt
-rwxr-xr-x seh/users      2187 2005-03-23 17:13:40 dev-1.1/mkrpmdev
-rw-r--r-- seh/users       766 2005-03-23 17:18:28 dev-1.1/dev.spec
-rw-r--r-- seh/users        34 2005-03-23 17:16:01 dev-1.1/Makefile
-rw-r--r-- seh/users       262 2005-03-23 17:17:45 dev-1.1/README
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd dev-1.1
+ exit 0
Executing(%build): /bin/sh -e
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/rpm-tmp.32072+ umask 022
+ cd /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/BUILD
+ cd dev-1.1
+ exit 0
Executing(%install): /bin/sh -e
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/rpm-tmp.32072
+ umask 022
+ cd /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/BUILD
+ cd dev-1.1
+ rm -rf /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/dev
+ '[' -f
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/bin/device_table.txt ']'
+
DEV_TABLE=/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/bin/device_table.txt
+ mkdir -p
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/dev//opt/freescale/rootfs/powerpc//dev
+ ln -s /var/tmp/log
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/dev//opt/freescale/rootfs/powerpc//dev/log
+ ln -s /proc/mounts
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/dev//opt/freescale/rootfs/powerpc//dev/mtab
+ PREFIX=/opt/freescale/rootfs/powerpc/
+ perl mkrpmdev
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/bin/device_table.txt
+ /opt/freescale/ltib/usr/lib/rpm/brp-compress
+ /opt/freescale/ltib/usr/lib/rpm/brp-strip
+ /opt/freescale/ltib/usr/lib/rpm/brp-strip-comment-note
Processing files: dev-1.1-1
Finding  Provides: (using /opt/freescale/ltib/usr/lib/rpm/find-provides)...
Finding  Requires: (using /opt/freescale/ltib/usr/lib/rpm/find-requires)...
PreReq: rpmlib(PayloadFilesHavePrefix) <= 4.0-1 rpmlib(CompressedFileNames) <=
3.0.4-1
Requires(rpmlib): rpmlib(PayloadFilesHavePrefix) <= 4.0-1
rpmlib(CompressedFileNames) <= 3.0.4-1
Wrote:
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/RPMS/powerpc/dev-1.1-1.powerpc.rpm
Executing(%clean): /bin/sh -e
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/rpm-tmp.87940+ umask 022
+ cd /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/BUILD
+ cd dev-1.1
+ rm -rf /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/dev
+ rm -f /tmp/manifest
+ exit 0
Executing(--clean): /bin/sh -e
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/tmp/rpm-tmp.87940
+ umask 022
+ cd /home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/BUILD
+ rm -rf dev-1.1
+ exit 0
Build time for dev: 3 seconds

sudo /opt/freescale/ltib/usr/bin/rpm --dbpath
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpmdb -e --allmatches
--nodeps dev 2>/dev/null
sudo /opt/freescale/ltib/usr/bin/rpm --dbpath
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpmdb --prefix
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rootfs --ignorearch -ivh
--force --excludedocs
/home/nanda/BoardBringUp/ltib-mpc8360epb-20061208/rpm/RPMS/powerpc/dev-1.1-1.powerpc.rpm
Preparing...                ########################################### [100%]
   1:dev                    ########################################### [100%]

Processing: skell
===================
Testing ppp_url connectivity: FAIL, disabling
Testing gpp_url connectivity: FAIL, disabling
No network download connection available

Started: Thu Nov 20 14:44:45 2008
Ended:   Thu Nov 20 14:57:32 2008
Elapsed: 767 seconds

Build Failed

Exiting on error or interrupt



--=_29eb7b78d12a57b7ff82a597449e2362
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mpc8360emds_defconfig.config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.20-rc5
# Mon Jan 22 22:24:40 2007
#
# CONFIG_PPC64 is not set
CONFIG_PPC32=y
CONFIG_PPC_MERGE=y
CONFIG_MMU=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_IRQ_PER_CPU=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_ARCH_HAS_ILOG2_U32=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_PPC=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_NVRAM=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_PPC_OF=y
CONFIG_PPC_UDBG_16550=y
# CONFIG_GENERIC_TBSYNC is not set
CONFIG_AUDIT_ARCH=y
CONFIG_GENERIC_BUG=y
CONFIG_DEFAULT_UIMAGE=y

#
# Processor support
#
# CONFIG_CLASSIC32 is not set
# CONFIG_PPC_82xx is not set
CONFIG_PPC_83xx=y
# CONFIG_PPC_85xx is not set
# CONFIG_PPC_86xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_8xx is not set
# CONFIG_E200 is not set
CONFIG_6xx=y
CONFIG_83xx=y
CONFIG_PPC_FPU=y
# CONFIG_PPC_DCR_NATIVE is not set
# CONFIG_PPC_DCR_MMIO is not set
CONFIG_PPC_STD_MMU=y
CONFIG_PPC_STD_MMU_32=y
# CONFIG_SMP is not set
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_IPC_NS is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
CONFIG_SYSFS_DEPRECATED=y
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_EMBEDDED=y
CONFIG_SYSCTL_SYSCALL=y
# CONFIG_KALLSYMS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
# CONFIG_EPOLL is not set
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_KMOD is not set

#
# Block layer
#
CONFIG_BLOCK=y
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"
CONFIG_QUICC_ENGINE=y
CONFIG_PPC_GEN550=y
# CONFIG_WANT_EARLY_SERIAL is not set

#
# Platform support
#
# CONFIG_MPC832x_MDS is not set
# CONFIG_MPC834x_SYS is not set
# CONFIG_MPC834x_ITX is not set
CONFIG_MPC8360E_PB=y
CONFIG_PPC_MPC836x=y
# CONFIG_MPIC is not set

#
# Kernel options
#
# CONFIG_HIGHMEM is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_MATH_EMULATION=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_PROC_DEVICETREE=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_PM is not set
CONFIG_SECCOMP=y
CONFIG_ISA_DMA_API=y

#
# Bus options
#
CONFIG_GENERIC_ISA_DMA=y
# CONFIG_MPIC_WEIRD is not set
# CONFIG_PPC_I8259 is not set
CONFIG_PPC_INDIRECT_PCI=y
CONFIG_FSL_SOC=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

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
CONFIG_BOOT_LOAD=0x00800000

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
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
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
# CONFIG_SYS_HYPERVISOR is not set

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
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=32768
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
CONFIG_BLK_DEV_INITRD=y
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# Misc devices
#
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SRP is not set

#
# Serial ATA (prod) and Parallel ATA (experimental) drivers
#
# CONFIG_ATA is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Macintosh device drivers
#
# CONFIG_MAC_EMUMOUSEBTN is not set
# CONFIG_WINDFARM is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_GIANFAR is not set
CONFIG_UCC_GETH=y
# CONFIG_UGETH_NAPI is not set
# CONFIG_UGETH_MAGIC_PACKET is not set
# CONFIG_UGETH_FILTERING is not set
# CONFIG_UGETH_TX_ON_DEMOND is not set
# CONFIG_QLA3XXX is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set
# CONFIG_NETXEN_NIC is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
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
# CONFIG_INPUT_FF_MEMLESS is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
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
# CONFIG_VT is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
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
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_83xx_WDT=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
CONFIG_HW_RANDOM=y
# CONFIG_NVRAM is not set
CONFIG_GEN_RTC=y
# CONFIG_GEN_RTC_X is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_MPC=y
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_M41T00 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

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
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

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
CONFIG_FIRMWARE_EDID=y
# CONFIG_FB is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# HID Devices
#
CONFIG_HID=y

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
# CONFIG_USB is not set

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
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# Virtualization
#

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
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
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
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
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
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
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# QE Options
#
CONFIG_UCC_SLOW=y
CONFIG_UCC_FAST=y
CONFIG_UCC=y

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_PLIST=y
CONFIG_IOMAP_COPY=y

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_MUST_CHECK=y
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_DEBUG_BUGVERBOSE is not set
# CONFIG_BOOTX_TEXT is not set
# CONFIG_SERIAL_TEXT_DEBUG is not set
# CONFIG_PPC_EARLY_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_MANAGER=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_GF128MUL is not set
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_LRW is not set
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


--=_29eb7b78d12a57b7ff82a597449e2362--
