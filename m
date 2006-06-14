Return-Path: <Orges.Furxhi@thyssenkrupp.com>
Received: from mail002.triaton.com (mail002.triaton.com [149.250.222.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail002.triaton.com",
	Issuer "TC TrustCenter for Security in Data Networks GmbH" (not
	verified)) by ozlabs.org (Postfix) with ESMTP id C855367B5A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Jun 2006 07:45:02 +1000 (EST)
Message-ID: <162B449665D6D643AD9E1D50FC6F4B1403F16E83@mdcexc05.na.ops.local>
From: "Furxhi, Orges" <Orges.Furxhi@thyssenkrupp.com>
To: Wolfgang Denk <wd@denx.de>, "Furxhi, Orges"
	<Orges.Furxhi@thyssenkrupp.com>, Igor Luri <iluri@fagorautomation.es>
Subject: RE: USB flashdrive on Motorola MPC5200 (IceCube) board, linux ke
	rnel 2.4.20
Date: Wed, 14 Jun 2006 16:48:16 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C68FFC.3E3C5630"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C68FFC.3E3C5630
Content-Type: text/plain

Thank you al for your help.

 

 

>> I downloaded the kernel you recommended and now I am trying to build a
>>UBoot

>> image that I can load unto flash.

>> I use the following commands: 

>> $ make mrproper

>> $ make menuconfig

>>   (select arch/ppc/configs/icecube_5200_defconfig file, exit and save)

>> $ make uImage

 

>Try instead:

 

>     $ make mrproper

>     $ make icecube_5200_config

>     $ make oldconfig

>     $ make dep

>     $ make uImage

 

 

I was able to build the UBoot image and load it unto my boards flash.
However, as of now I do not have a functioning board. 

I am using the kernel build using the ELDK 3.1.1 tools and a file system
which was build using Montavista tools (DevRocket 1.1). Is that a problem???

 

The kernel is uncompressed on the board and loads, but the Login prompt
never comes up. Following are my boot up messages.

 

      U-Boot 1.1.4 (Mar 21 2006 - 15:07:57)

 

CPU:   MPC5200 v1.2 at 462 MHz

       Bus 132 MHz, IPB 66 MHz, PCI 33 MHz

Board: Motorola MPC5200 (IceCube)

I2C:   85 kHz, ready

DRAM:  64 MB

FLASH:  8 MB

In:    serial

Out:   serial

Err:   serial

Net:   FEC ETHERNET

 

Type "run flash_nfs" to mount root filesystem over NFS

 

Hit any key to stop autoboot:  0

## Booting image at ff900000 ...

   Image Name:   Linux-2.4.25

   Created:      2006-06-14  21:07:25 UTC

   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

   Data Size:    870906 Bytes = 850.5 kB

   Load Address: 00000000

   Entry Point:  00000000

   Verifying Checksum ... OK

   Uncompressing Kernel Image ... OK

Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb

Linux version 2.4.25 (root@localhost.localdomain) (gcc version 3.3.3 (DENX
ELDK

3.1.1 3.3.3-9)) #7 Wed Jun 14 16:02:04 CDT 2006

On node 0 totalpages: 16384

zone(0): 16384 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: root=/dev/mtdblock2 rw rootfstype=jffs2
ip=192.168.0.7:192.

168.0.2:192.168.0.2:255.255.255.0:cpua::off

Calibrating delay loop... 307.20 BogoMIPS

Memory: 62224k available (1492k kernel code, 460k data, 76k init, 0k
highmem)

Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)

Inode cache hash table entries: 4096 (order: 3, 32768 bytes)

Mount cache hash table entries: 512 (order: 0, 4096 bytes)

Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)

Page-cache hash table entries: 16384 (order: 4, 65536 bytes)

POSIX conformance testing by UNIFIX

PCI: Probing PCI hardware

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

Starting kswapd

Journalled Block Device driver loaded

devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)

devfs: boot_options: 0x1

JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.

pty: 256 Unix98 ptys configured

devfs_register(ttyS): could not append to parent, err: -17

devfs_register(ttyS): could not append to parent, err: -17

devfs_register(cua): could not append to parent, err: -17

devfs_register(cua): could not append to parent, err: -17

ttyS0 on PSC1

ttyS1 on PSC2

ttyS2 on PSC3

RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize

loop: loaded (max 8 devices)

SCSI subsystem driver Revision: 1.00

Icecube Bank 0: Found 1 x16 devices at 0x0 in 8-bit mode

 Intel/Sharp Extended Query Table at 0x0031

cfi_cmdset_0001: Erase suspend on write enabled

Using buffer write method

Icecube flash bank 0: Using static image partition definition

Creating 3 MTD partitions on "Icecube Bank 0":

0x00000000-0x00100000 : "u-boot"

0x00100000-0x00200000 : "kernel"

0x00200000-0x00800000 : "jffs2"

usb.c: registered new driver usbdevfs

usb.c: registered new driver hub

host/usb-ohci.c: USB OHCI at membase 0xf0001000, IRQ 44

host/usb-ohci.c: usb-0, Built-In ohci

usb.c: new USB bus registered, assigned bus number 1

Product: USB OHCI Root Hub

SerialNumber: f0001000

hub.c: USB hub found

hub.c: 2 ports detected

Initializing USB Mass Storage driver...

usb.c: registered new driver usb-storage

USB Mass Storage support registered.

eth0: Phy @ 0x0, type LXT971 (0x001378e2)

NET4: Linux TCP/IP 1.0 for NET4.0

IP Protocols: ICMP, UDP, TCP, IGMP

IP: routing cache hash table of 512 buckets, 4Kbytes

TCP: Hash tables configured (established 4096 bind 8192)

eth0: config: auto-negotiation off, 100FDX, 100HDX, 10FDX, 10HDX.

IP-Config: Complete:

      device=eth0, addr=192.168.0.7, mask=255.255.255.0, gw=192.168.0.2,

     host=cpua, domain=, nis-domain=(none),

     bootserver=192.168.0.2, rootserver=192.168.0.2, rootpath=

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

Empty flash at 0x0000fffc ends at 0x00010000

CLEANMARKER node found at 0x00010000, not first node in block (0x00000000)

Empty flash at 0x0002fffc ends at 0x00030000

CLEANMARKER node found at 0x00030000, not first node in block (0x00020000)

Empty flash at 0x0004fffc ends at 0x00050000

CLEANMARKER node found at 0x00050000, not first node in block (0x00040000)

Empty flash at 0x0006fffc ends at 0x00070000

CLEANMARKER node found at 0x00070000, not first node in block (0x00060000)

Empty flash at 0x0008fffc ends at 0x00090000

CLEANMARKER node found at 0x00090000, not first node in block (0x00080000)

Empty flash at 0x000afffc ends at 0x000b0000

CLEANMARKER node found at 0x000b0000, not first node in block (0x000a0000)

Empty flash at 0x000cfffc ends at 0x000d0000

CLEANMARKER node found at 0x000d0000, not first node in block (0x000c0000)

Empty flash at 0x000efffc ends at 0x000f0000

CLEANMARKER node found at 0x000f0000, not first node in block (0x000e0000)

Empty flash at 0x0010fffc ends at 0x00110000

CLEANMARKER node found at 0x00110000, not first node in block (0x00100000)

Empty flash at 0x0012fffc ends at 0x00130000

CLEANMARKER node found at 0x00130000, not first node in block (0x00120000)

CLEANMARKER node found at 0x00150000, not first node in block (0x00140000)

Empty flash at 0x0016fffc ends at 0x00170000

CLEANMARKER node found at 0x00170000, not first node in block (0x00160000)

Empty flash at 0x0018fffc ends at 0x00190000

CLEANMARKER node found at 0x00190000, not first node in block (0x00180000)

Empty flash at 0x001afffc ends at 0x001b0000

CLEANMARKER node found at 0x001b0000, not first node in block (0x001a0000)

Empty flash at 0x001cffe8 ends at 0x001d0000

CLEANMARKER node found at 0x001d0000, not first node in block (0x001c0000)

VFS: Mounted root (jffs2 filesystem).

Mounted devfs on /dev

Freeing unused kernel memory: 76k init

serial console detected.  Disabling virtual terminals.

init started:  BusyBox v0.60.3 (2004.01.09-22:53+0000) multi-call binary

System initialized

eth0: status: link up, 100 Mbps Full Duplex, auto-negotiation complete.

hub.c: Cannot enable port 2 of hub 1, disabling port.

hub.c: Maybe the USB cable is bad?

 

>> Is there another sequence of make commands that I need to follow to
>>create a

>> UBoot image?

 

>Not really.

 

>Note that above is for  the  old  Lite5200  board.  For  the  (newer)

>Lite5200B boards you must use latest version of U-Boot and Linux (top

>of  tree  from  our git repositories), and "make lite5200b_config" to

>start.


The board we are using contains the Lite5200

 

 

The purpose for doing all this is to get the USB flash drive to work on the
board (read, write files to it)

 

Thanks again for all your help.

 

 

Orges

 


------_=_NextPart_001_01C68FFC.3E3C5630
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 77.95pt 1.0in 77.95pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Thank you al for your help.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; I downloaded the kernel you recommended and now I am =
trying to
build a &gt;&gt;UBoot<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; image that I can load unto =
flash.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; I use the following commands: =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; $ make mrproper<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; $ make menuconfig<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt;&nbsp;&nbsp; (select =
arch/ppc/configs/icecube_5200_defconfig
file, exit and save)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; $ make uImage<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;Try instead:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&nbsp;&nbsp;&nbsp;&nbsp; $ make =
mrproper<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&nbsp;&nbsp;&nbsp;&nbsp; $ make =
icecube_5200_config<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&nbsp;&nbsp;&nbsp;&nbsp; $ make oldconfig<o:p></o:p></span><=
/font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&nbsp;&nbsp;&nbsp;&nbsp; $ make =
dep<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&nbsp;&nbsp;&nbsp;&nbsp; $ make =
uImage<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></=
p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>I was able to build the UBoot =
image and
load it unto my boards flash. However, as of now I do not have a =
functioning
board. <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>I am using the kernel build =
using the ELDK
3.1.1 tools and a file system which was build using Montavista tools =
(DevRocket
1.1). Is that a problem???<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></=
p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>The kernel is uncompressed on =
the board and
loads, but the Login prompt never comes up. Following are my boot up =
messages.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></=
p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
U-Boot
1.1.4 (Mar 21 2006 - 15:07:57)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></=
p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CPU:&nbsp;&nbsp;
MPC5200 v1.2 at 462 MHz<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
Bus 132 MHz, IPB 66 MHz, PCI 33 MHz<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Board: Motorola
MPC5200 (IceCube)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>I2C:&nbsp;&nbsp;
85 kHz, ready<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>DRAM:&nbsp; 64 =
MB<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>FLASH:&nbsp; 8 =
MB<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>In:&nbsp;&nbsp;&nbsp;
serial<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Out:&nbsp;&nbsp;
serial<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Err:&nbsp;&nbsp;
serial<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Net:&nbsp;&nbsp;
FEC ETHERNET<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></=
p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Type =
&quot;run
flash_nfs&quot; to mount root filesystem over =
NFS<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></=
p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Hit =
any key to
stop autoboot:&nbsp; 0<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>## =
Booting image
at ff900000 ...<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&nbsp;&nbsp; Image
Name:&nbsp;&nbsp; Linux-2.4.25<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&nbsp;&nbsp;
Created:&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;2006-06-14&nbsp; 21:07:25 =
UTC<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&nbsp;&nbsp;
Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&nbsp;&nbsp; Data
Size:&nbsp;&nbsp;&nbsp; 870906 Bytes =3D 850.5 =
kB<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&nbsp;&nbsp; Load
Address: 00000000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&nbsp;&nbsp;
Entry Point:&nbsp; 00000000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&nbsp;&nbsp;
Verifying Checksum ... OK<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&nbsp;&nbsp;
Uncompressing Kernel Image ... OK<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Memory BAT
mapping: BAT2=3D64Mb, BAT3=3D0Mb, residual: =
0Mb<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Linux =
version
2.4.25 (root@localhost.localdomain) (gcc version 3.3.3 (DENX =
ELDK<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>3.1.1 =
3.3.3-9))
#7 Wed Jun 14 16:02:04 CDT 2006<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>On =
node 0
totalpages: 16384<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>zone(0): 16384
pages.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>zone(1): 0 =
pages.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>zone(2): 0 =
pages.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Kernel command
line: root=3D/dev/mtdblock2 rw rootfstype=3Djffs2 =
ip=3D192.168.0.7:192.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>168.0.2:192.168.0.2:255.255.255.0=
:cpua::off<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Calibrating delay
loop... 307.20 BogoMIPS<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Memory: 62224k
available (1492k kernel code, 460k data, 76k init, 0k =
highmem)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Dentry cache hash
table entries: 8192 (order: 4, 65536 =
bytes)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Inode =
cache hash
table entries: 4096 (order: 3, 32768 =
bytes)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Mount =
cache hash
table entries: 512 (order: 0, 4096 bytes)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Buffer cache hash
table entries: 4096 (order: 2, 16384 =
bytes)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Page-cache hash
table entries: 16384 (order: 4, 65536 =
bytes)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>POSIX =
conformance
testing by UNIFIX<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>PCI: =
Probing PCI
hardware<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Linux =
NET4.0 for
Linux 2.4<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Based =
upon <st1:place
w:st=3D"on"><st1:PlaceName w:st=3D"on">Swansea</st1:PlaceName> =
<st1:PlaceType
 w:st=3D"on">University</st1:PlaceType></st1:place> Computer Society =
NET3.039<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Initializing RT
netlink socket<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Starting =
kswapd<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Journalled Block
Device driver loaded<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>devfs: v1.12c
(20020818) Richard Gooch (rgooch@atnf.csiro.au)<o:p></o:p></span></font>=
</p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>devfs:
boot_options: 0x1<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>JFFS2 =
version
2.2. (C) 2001-2003 Red Hat, Inc.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>pty: =
256 Unix98
ptys configured<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>devfs_register(ttyS):
could not append to parent, err: -17<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>devfs_register(ttyS):
could not append to parent, err: -17<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>devfs_register(cua):
could not append to parent, err: -17<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>devfs_register(cua):
could not append to parent, err: -17<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>ttyS0 =
on PSC1<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>ttyS1 =
on PSC2<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>ttyS2 =
on PSC3<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>RAMDISK driver
initialized: 16 RAM disks of 8192K size 1024 =
blocksize<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>loop: =
loaded (max
8 devices)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>SCSI =
subsystem
driver Revision: 1.00<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Icecube Bank 0:
Found 1 x16 devices at 0x0 in 8-bit mode<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&nbsp;Intel/Sharp
Extended Query Table at 0x0031<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>cfi_cmdset_0001:
Erase suspend on write enabled<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Using =
buffer
write method<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Icecube flash
bank 0: Using static image partition =
definition<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Creating 3 MTD
partitions on &quot;Icecube Bank 0&quot;:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>0x00000000-0x00100000
: &quot;u-boot&quot;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>0x00100000-0x00200000
: &quot;kernel&quot;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>0x00200000-0x00800000
: &quot;jffs2&quot;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>usb.c: registered
new driver usbdevfs<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>usb.c: registered
new driver hub<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>host/usb-ohci.c:
USB OHCI at membase 0xf0001000, IRQ 44<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>host/usb-ohci.c:
usb-0, Built-In ohci<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>usb.c: new USB
bus registered, assigned bus number 1<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Product: USB OHCI
Root Hub<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>SerialNumber:
f0001000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>hub.c: USB hub
found<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>hub.c: 2 ports
detected<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Initializing USB
Mass Storage driver...<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>usb.c: registered
new driver usb-storage<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>USB =
Mass Storage
support registered.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>eth0: =
Phy @ 0x0,
type LXT971 (0x001378e2)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>NET4: =
Linux
TCP/IP 1.0 for NET4.0<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>IP =
Protocols:
ICMP, UDP, TCP, IGMP<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>IP: =
routing cache
hash table of 512 buckets, 4Kbytes<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>TCP: =
Hash tables
configured (established 4096 bind 8192)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>eth0: =
config:
auto-negotiation off, 100FDX, 100HDX, 10FDX, =
10HDX.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>IP-Config:
Complete:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
device=3Deth0, addr=3D192.168.0.7, mask=3D255.255.255.0, =
gw=3D192.168.0.2,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;
host=3Dcpua, domain=3D, =
nis-domain=3D(none),<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&nbsp;&nbsp;&nbsp;&nbsp;
bootserver=3D192.168.0.2, rootserver=3D192.168.0.2, =
rootpath=3D<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>NET4: =
Unix domain
sockets 1.0/SMP for Linux NET4.0.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Empty =
flash at
0x0000fffc ends at 0x00010000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x00010000, not first node in block =
(0x00000000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Empty =
flash at
0x0002fffc ends at 0x00030000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x00030000, not first node in block =
(0x00020000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Empty =
flash at
0x0004fffc ends at 0x00050000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x00050000, not first node in block =
(0x00040000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Empty =
flash at
0x0006fffc ends at 0x00070000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x00070000, not first node in block =
(0x00060000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Empty =
flash at
0x0008fffc ends at 0x00090000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x00090000, not first node in block =
(0x00080000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Empty =
flash at
0x000afffc ends at 0x000b0000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x000b0000, not first node in block =
(0x000a0000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Empty =
flash at
0x000cfffc ends at 0x000d0000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x000d0000, not first node in block =
(0x000c0000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Empty =
flash at
0x000efffc ends at 0x000f0000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x000f0000, not first node in block =
(0x000e0000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Empty =
flash at
0x0010fffc ends at 0x00110000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x00110000, not first node in block =
(0x00100000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Empty =
flash at 0x0012fffc
ends at 0x00130000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x00130000, not first node in block =
(0x00120000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x00150000, not first node in block =
(0x00140000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Empty =
flash at
0x0016fffc ends at 0x00170000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x00170000, not first node in block =
(0x00160000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Empty =
flash at
0x0018fffc ends at 0x00190000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x00190000, not first node in block =
(0x00180000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Empty =
flash at
0x001afffc ends at 0x001b0000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x001b0000, not first node in block =
(0x001a0000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>Empty =
flash at
0x001cffe8 ends at 0x001d0000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>CLEANMARKER node
found at 0x001d0000, not first node in block =
(0x001c0000)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>VFS: =
Mounted root
(jffs2 filesystem).<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Mounted devfs on
/dev<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Freeing unused
kernel memory: 76k init<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>serial console
detected.&nbsp; Disabling virtual =
terminals.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>init
started:&nbsp; BusyBox v0.60.3 (2004.01.09-22:53+0000) multi-call =
binary<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>System
initialized<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span style=3D'font-size:10.0pt;color:black'>eth0: =
status:
link up, 100 Mbps Full Duplex, auto-negotiation =
complete.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>hub.c: Cannot
enable port 2 of hub 1, disabling port.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
color=3Dblack
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>hub.c: Maybe the
USB cable is bad?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></=
p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; Is there another sequence of make commands that I need =
to
follow to &gt;&gt;create a<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;&gt; UBoot image?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;Not really.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;Note that above is for&nbsp; the&nbsp; old&nbsp; =
Lite5200&nbsp;
board.&nbsp; For&nbsp; the&nbsp; (newer)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;Lite5200B boards you must use latest version of U-Boot and =
Linux
(top<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;of&nbsp; tree&nbsp; from&nbsp; our git repositories), and
&quot;make lite5200b_config&quot; to<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt;start.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><br>
The board we are using contains the =
Lite5200<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></=
p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></=
p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>The purpose for doing all this =
is to get
the USB flash drive to work on the board (read, write files to =
it)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></=
p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>Thanks again for all your =
help.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></=
p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></=
p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>Orges<o:p></o:p></span></font></p=
>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C68FFC.3E3C5630--
