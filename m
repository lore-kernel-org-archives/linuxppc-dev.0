Return-Path: <srivatsan@deccanetworld.com>
Received: from gatekeeper.deccanetworld.com (mail.deccanetworld.com
	[203.196.146.50])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98C172BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Dec 2004 16:57:38 +1100 (EST)
Received: from gatekeeper.deccanetworld.com (localhost [127.0.0.1])
	by gatekeeper.deccanetworld.com (8.12.2/8.12.2/SuSE Linux 0.6) with
	ESMTP id iBS5jJbJ027043
	for <linuxppc-embedded@ozlabs.org>; Tue, 28 Dec 2004 11:15:19 +0530
Received: from mail.deccanetworld.com (server.deccanetworld.com [192.168.1.32])
	by gatekeeper.deccanetworld.com (8.12.2/8.12.2/SuSE Linux 0.6) with
	ESMTP id iBS5jFRq026687
	for <linuxppc-embedded@ozlabs.org>; Tue, 28 Dec 2004 11:15:17 +0530
Received: (from root@localhost)
	by mail.deccanetworld.com (8.11.0/8.11.0) id iBS6Db814672
	for linuxppc-embedded@ozlabs.org; Tue, 28 Dec 2004 11:43:37 +0530
Received: from bgcw301 ([10.203.105.18])
	by mail.deccanetworld.com (8.11.0/8.11.0) with ESMTP id iBS6DaY14585
	for <linuxppc-embedded@ozlabs.org>; Tue, 28 Dec 2004 11:43:36 +0530
From: "Srivatsan" <srivatsan@deccanetworld.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Tue, 28 Dec 2004 11:22:49 +0530
Message-ID: <000601c4eca1$786596f0$1269cb0a@bgcw301>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0007_01C4ECCF.92201CE0"
Subject: Linux Kernel boot problem 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C4ECCF.92201CE0
Content-Type: text/plain;
Content-Transfer-Encoding: 7bit

Hi all,
 
    We are having a Rattler MPC8280 board. We are using Linux Kernel
2.4.21 and the configuration used for building the Linux Kernel is as
given under. 
 
When the Kernel is booted, it prints the following
Uncompressing Linux.......done
Now booting the kernel
 
The kernel hangs(or not detecting the console) after printing the above
messages. Any pointers would be of great help to us.
 
With thanks,
C.R.Srivatsan
 
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_HAVE_DEC_LOCK=y
 
#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_ADVANCED_OPTIONS is not set
 
#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
 
#
# Platform support
#
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_6xx=y
# CONFIG_40x is not set
# CONFIG_440 is not set
# CONFIG_POWER3 is not set
# CONFIG_8xx is not set
CONFIG_8260=y
CONFIG_PPC_STD_MMU=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_ADS8260 is not set
# CONFIG_EST8260 is not set
# CONFIG_SBS8260 is not set
# CONFIG_RPX6 is not set
CONFIG_AM_RATTLER=y
# CONFIG_TQM8260 is not set
# CONFIG_WILLOW is not set
# CONFIG_SMP is not set
CONFIG_REDBOOT=y
CONFIG_EMBEDDEDBOOT=y
 
#
# General setup
#
# CONFIG_HIGHMEM is not set
# CONFIG_ISA is not set
# CONFIG_EISA is not set
# CONFIG_SBUS is not set
# CONFIG_MCA is not set
# CONFIG_PCI is not set
# CONFIG_8260_PCI9 is not set
# CONFIG_PC_KEYBOARD is not set
CONFIG_NET=y
# CONFIG_SYSCTL is not set
# CONFIG_SYSVIPC is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_KCORE_ELF is not set
# CONFIG_BINFMT_ELF is not set
# CONFIG_KERNEL_ELF is not set
# CONFIG_BINFMT_MISC is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
 
#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_CONCAT=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
 
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set
 
#
# Networking options
#
# CONFIG_PACKET is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
# CONFIG_IP_PNP_DHCP is not set
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
 
#
# Network device support
#
CONFIG_NETDEVICES=y
 
#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MACE is not set
# CONFIG_BMAC is not set
# CONFIG_GMAC is not set
# CONFIG_SUNLANCE is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set
 
#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS_FS=y
CONFIG_JFFS_FS_VERBOSE=0
# CONFIG_JFFS_PROC_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
 
#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set
 
#
# MPC8260 CPM Options
#
CONFIG_SCC_CONSOLE=y
# CONFIG_SCC_ENET is not set
CONFIG_FEC_ENET=y
CONFIG_FCC1_ENET=y
CONFIG_FCC2_ENET=y
# CONFIG_FCC3_ENET is not set
# CONFIG_USE_MDIO is not set
 
#
# Library routines
#
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
 
 


********************************DISCLAIMER**********************************

This e-mail and any attachment is for authorised use by the intended
recipient(s) only. It may contain proprietary material, confidential
information and/or be subject to legal privilege of Deccanet Designs Ltd.
If you have received this message in error, please notify the originator
immediately. If you are not the intended recipient, you are notified that
you are strictly prohibited from retaining, using, copying, altering or
disclosing the contents of this message.

****************************************************************************
------=_NextPart_000_0007_01C4ECCF.92201CE0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C4ECCF.8ED42630">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName"/>
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Arial;
	mso-fareast-font-family:"Times New Roman";
	font-weight:bold;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:"Times New Roman";
	font-weight:bold;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:navy;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 77.95pt 1.0in 77.95pt;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-weight:normal;mso-bidi-font-weight:
bold'>Hi all,<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span>We are having a =
Rattler
MPC8280 board. We are using Linux Kernel 2.4.2</span></font></b><font
color=3Dnavy><span =
style=3D'color:navy;font-weight:normal;mso-bidi-font-weight:
bold'>1</span></font><font color=3Dblack><span =
style=3D'color:black;font-weight:
normal;mso-bidi-font-weight:bold'> and the configuration used for =
building the
Linux Kernel is as given under. <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>When the Kernel is booted, =
it
prints the following<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>Uncompressing =
Linux.......done<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>Now booting the =
kernel<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>The kernel hangs(or not =
detecting
the console) after printing the above messages. Any pointers would be of =
great
help to us.<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>With =
thanks,<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>C.R.Srivatsan<o:p></o:p></s=
pan></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_RWSEM_XCHGADD_ALGORI=
THM=3Dy<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_HAVE_DEC_LOCK=3Dy<o:=
p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># Code maturity level =
options<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_EXPERIMENTAL=3Dy<o:p=
></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_ADVANCED_OPTIONS =
is not
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># Loadable module =
support<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_MODULES=3Dy<o:p></o:=
p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_MODVERSIONS=3Dy<o:p>=
</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_KMOD=3Dy<o:p></o:p><=
/span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># Platform =
support<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_PPC=3Dy<o:p></o:p></=
span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_PPC32=3Dy<o:p></o:p>=
</span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_6xx=3Dy<o:p></o:p></=
span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_40x is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_440 is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_POWER3 is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_8xx is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_8260=3Dy<o:p></o:p><=
/span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_PPC_STD_MMU=3Dy<o:p>=
</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_SERIAL_CONSOLE=3Dy<o=
:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_ADS8260 is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_EST8260 is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_SBS8260 is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_RPX6 is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_AM_RATTLER=3Dy<o:p><=
/o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_TQM8260 is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_WILLOW is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_SMP is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_REDBOOT=3Dy<o:p></o:=
p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_EMBEDDEDBOOT=3Dy<o:p=
></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># General =
setup<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_HIGHMEM is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_ISA is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_EISA is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_SBUS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_MCA is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_PCI is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_8260_PCI9 is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_PC_KEYBOARD is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_NET=3Dy<o:p></o:p></=
span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_SYSCTL is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_SYSVIPC is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BSD_PROCESS_ACCT =
is not
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># =
CONFIG_</span></font></b><st1:PersonName><font
 color=3Dblack><span =
style=3D'color:black;font-weight:normal;mso-bidi-font-weight:
 bold'>KC</span></font></st1:PersonName><font color=3Dblack><span
style=3D'color:black;font-weight:normal;mso-bidi-font-weight:bold'>ORE_EL=
F is not
set<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BINFMT_ELF is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_KERNEL_ELF is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BINFMT_MISC is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_HOTPLUG is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_PCMCIA is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># Memory Technology =
Devices (MTD)<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_MTD=3Dy<o:p></o:p></=
span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_MTD_DEBUG is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_MTD_PARTITIONS=3Dy<o=
:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_MTD_CONCAT=3Dy<o:p><=
/o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_MTD_REDBOOT_PARTS =
is not
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_MTD_CMDLINE_PARTS =
is not
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_MTD_CHAR=3Dy<o:p></o=
:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_MTD_BLOCK=3Dy<o:p></=
o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_FTL is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NFTL is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># Block =
devices<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BLK_DEV_FD is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BLK_DEV_XD is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_PARIDE is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BLK_CPQ_DA is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BLK_CPQ_CISS_DA =
is not
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_CISS_SCSI_TAPE is =
not
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BLK_DEV_DAC960 is =
not
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BLK_DEV_UMEM is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BLK_DEV_LOOP is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BLK_DEV_NBD is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_BLK_DEV_RAM=3Dy<o:p>=
</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_BLK_DEV_RAM_SIZE=3D4=
096<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BLK_DEV_INITRD is =
not
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BLK_STATS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># Networking =
options<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_PACKET is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NETLINK_DEV is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NETFILTER is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_FILTER is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_UNIX=3Dy<o:p></o:p><=
/span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_INET=3Dy<o:p></o:p><=
/span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_IP_MULTICAST=3Dy<o:p=
></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># =
CONFIG_IP_ADVANCED_ROUTER is
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_IP_PNP=3Dy<o:p></o:p=
></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_IP_PNP_DHCP is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_IP_PNP_BOOTP=3Dy<o:p=
></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_IP_PNP_RARP=3Dy<o:p>=
</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NET_IPIP is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NET_IPGRE is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_IP_MROUTE is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_ARPD is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_INET_ECN is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_SYN_COOKIES=3Dy<o:p>=
</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_IPV6 is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_KHTTPD is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_ATM is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_VLAN_8021Q is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_IPX is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_ATALK is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># Network device =
support<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_NETDEVICES=3Dy<o:p><=
/o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># Ethernet (10 or =
100Mbit)<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_NET_ETHERNET=3Dy<o:p=
></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_MACE is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BMAC is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_GMAC is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_SUNLANCE is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_SUNBMAC is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_SUNQE is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_SUNGEM is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NET_VENDOR_3COM =
is not
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_LANCE is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NET_VENDOR_SMC is =
not
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NET_VENDOR_RACAL =
is not
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NET_ISA is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NET_PCI is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NET_POCKET is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># File =
systems<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_QUOTA is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_AUTOFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_AUTOFS4_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_REISERFS_FS is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_REISERFS_CHECK is =
not
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># =
CONFIG_REISERFS_PROC_INFO is
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_ADFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_ADFS_FS_RW is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_AFFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_HFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BEFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BEFS_DEBUG is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_BFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_EXT3_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_JBD is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_JBD_DEBUG is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_FAT_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_MSDOS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_UMSDOS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_VFAT_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_EFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_JFFS_FS=3Dy<o:p></o:=
p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_JFFS_FS_VERBOSE=3D0<=
o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_JFFS_PROC_FS is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_JFFS2_FS=3Dy<o:p></o=
:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_JFFS2_FS_DEBUG=3D0<o=
:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_CRAMFS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_TMPFS=3Dy<o:p></o:p>=
</span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_RAMFS=3Dy<o:p></o:p>=
</span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_ISO9660_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_JOLIET is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_ZISOFS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_JFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_JFS_DEBUG is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_JFS_STATISTICS is =
not
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_MINIX_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_VXFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NTFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NTFS_RW is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_HPFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_PROC_FS=3Dy<o:p></o:=
p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_DEVFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_DEVFS_MOUNT is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_DEVFS_DEBUG is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_DEVPTS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_QNX4FS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_QNX4FS_RW is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_ROMFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_EXT2_FS=3Dy<o:p></o:=
p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_SYSV_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_UDF_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_UDF_RW is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_UFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_UFS_FS_WRITE is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># Network File =
Systems<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_CODA_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_INTERMEZZO_FS is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_NFS_FS=3Dy<o:p></o:p=
></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NFS_V3 is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_ROOT_NFS=3Dy<o:p></o=
:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NFSD is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NFSD_V3 is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NFSD_TCP is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_SUNRPC is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_LOCKD is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_SMB_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NCP_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># =
CONFIG_NCPFS_PACKET_SIGNING is
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># =
CONFIG_NCPFS_IOCTL_LOCKING is
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NCPFS_STRONG is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NCPFS_NFS_NS is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NCPFS_OS2_NS is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NCPFS_SMALLDOS is =
not
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NCPFS_NLS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_NCPFS_EXTRAS is =
not set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_ZISOFS_FS is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># MPC8260 CPM =
Options<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_SCC_CONSOLE=3Dy<o:p>=
</o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_SCC_ENET is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_FEC_ENET=3Dy<o:p></o=
:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_FCC1_ENET=3Dy<o:p></=
o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_FCC2_ENET=3Dy<o:p></=
o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_FCC3_ENET is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># CONFIG_USE_MDIO is not =
set<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'># Library =
routines<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>#<o:p></o:p></span></font><=
/b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_ZLIB_INFLATE=3Dy<o:p=
></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'>CONFIG_ZLIB_DEFLATE=3Dy<o:p=
></o:p></span></font></b></p>

<p class=3DMsoPlainText><b style=3D'mso-ansi-font-weight:normal'><font =
size=3D2
color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black;
font-weight:normal;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></f=
ont></b></p>

<p class=3DMsoPlainText><b><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></b></p>

</div>


<PRE>

********************************DISCLAIMER**********************************

This e-mail and any attachment is for authorised use by the intended
recipient(s) only. It may contain proprietary material, confidential
information and/or be subject to legal privilege of Deccanet Designs Ltd.
If you have received this message in error, please notify the originator
immediately. If you are not the intended recipient, you are notified that
you are strictly prohibited from retaining, using, copying, altering or
disclosing the contents of this message.

****************************************************************************
</pre>
</body>

</html>

------=_NextPart_000_0007_01C4ECCF.92201CE0--
