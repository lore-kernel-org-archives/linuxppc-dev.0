Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from ex01.ads.ubidyne.de (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id 01210DDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Feb 2007 20:48:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/related;
	boundary="----_=_NextPart_001_01C75A54.636C7657";
	type="multipart/alternative"
Subject: Could not create MTD Partitions
Date: Tue, 27 Feb 2007 10:48:08 +0100
Message-ID: <29DC34A6B43468409F5A371CFE34E8490B614F@ex01.ads.ubidyne.de>
From: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C75A54.636C7657
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C75A54.636C7657"


------_=_NextPart_002_01C75A54.636C7657
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

=20

I got a problem during creating the MTD partitions. I'm using the=20

ELDK 4.1 with 2.6.19.2 Kernel and the MPC8343 board with 128MB RAM

and 64MB flash memory.=20

=20

flinfo returns:

=20

Bank # 1: CFI conformant FLASH (32 x 16)  Size: 64 MB in 256 Sectors

 Erase timeout 16384 ms, write timeout 1 ms, buffer write timeout 4096
ms, buffer size 32

  Sector Start Addresses:

    FC000000      FC040000      FC080000      FC0C0000      FC100000

    FC140000      FC180000      FC1C0000      FC200000      FC240000

    FC280000      FC2C0000      FC300000      FC340000      FC380000

    FC3C0000      FC400000      FC440000      FC480000      FC4C0000

    FC500000      FC540000      FC580000      FC5C0000      FC600000

    FC640000      FC680000      FC6C0000      FC700000      FC740000

    FC780000      FC7C0000      FC800000      FC840000      FC880000

    FC8C0000      FC900000      FC940000      FC980000      FC9C0000

    FCA00000      FCA40000      FCA80000      FCAC0000      FCB00000

    FCB40000      FCB80000      FCBC0000      FCC00000      FCC40000

    FCC80000      FCCC0000      FCD00000      FCD40000      FCD80000

    FCDC0000      FCE00000      FCE40000      FCE80000      FCEC0000

    FCF00000      FCF40000      FCF80000      FCFC0000      FD000000

    FD040000      FD080000      FD0C0000      FD100000      FD140000

    FD180000      FD1C0000      FD200000      FD240000      FD280000

    FD2C0000      FD300000      FD340000      FD380000      FD3C0000

    FD400000      FD440000      FD480000      FD4C0000      FD500000

    FD540000      FD580000      FD5C0000      FD600000      FD640000

    FD680000      FD6C0000      FD700000      FD740000      FD780000

    FD7C0000      FD800000      FD840000      FD880000      FD8C0000

    FD900000      FD940000      FD980000      FD9C0000      FDA00000

    FDA40000      FDA80000      FDAC0000      FDB00000      FDB40000

    FDB80000      FDBC0000      FDC00000      FDC40000      FDC80000

    FDCC0000      FDD00000      FDD40000      FDD80000      FDDC0000

    FDE00000      FDE40000      FDE80000      FDEC0000      FDF00000

    FDF40000      FDF80000      FDFC0000      FE000000      FE040000

    FE080000      FE0C0000      FE100000      FE140000      FE180000

    FE1C0000      FE200000      FE240000      FE280000      FE2C0000

    FE300000      FE340000      FE380000      FE3C0000      FE400000

    FE440000      FE480000      FE4C0000      FE500000      FE540000

    FE580000      FE5C0000      FE600000      FE640000      FE680000

    FE6C0000      FE700000      FE740000      FE780000      FE7C0000

    FE800000      FE840000      FE880000      FE8C0000      FE900000

    FE940000      FE980000      FE9C0000      FEA00000      FEA40000

    FEA80000      FEAC0000      FEB00000      FEB40000      FEB80000

    FEBC0000      FEC00000      FEC40000      FEC80000      FECC0000

    FED00000      FED40000      FED80000      FEDC0000      FEE00000

    FEE40000      FEE80000      FEEC0000      FEF00000      FEF40000

    FEF80000      FEFC0000      FF000000      FF040000      FF080000

    FF0C0000      FF100000      FF140000      FF180000      FF1C0000

    FF200000      FF240000      FF280000      FF2C0000      FF300000

    FF340000      FF380000      FF3C0000      FF400000      FF440000

    FF480000      FF4C0000      FF500000      FF540000      FF580000

    FF5C0000      FF600000      FF640000      FF680000      FF6C0000

    FF700000      FF740000      FF780000      FF7C0000      FF800000

    FF840000      FF880000      FF8C0000      FF900000      FF940000

    FF980000      FF9C0000      FFA00000      FFA40000      FFA80000

    FFAC0000      FFB00000      FFB40000      FFB80000      FFBC0000

    FFC00000      FFC40000      FFC80000      FFCC0000      FFD00000

    FFD40000      FFD80000      FFDC0000      FFE00000      FFE40000

    FFE80000      FFEC0000      FFF00000 (RO) FFF40000 (RO) FFF80000

    FFFC0000

=20

=20

That indicates me, that the flash begins at address FC00 0000 and ends=20

at FFFF FFFF. I assume the sectors FFF0 0000 and FFF4 0000 contains=20

the HRCW and U-Boot, because they are protected.

=20

Okay, so far so good.=20

=20

After that, I created my own flash map as followed:

=20

Unused:                       FC00 0000 - FF7F FFFF (56Mbyte)

JFFS2:                         FF80 0000 - FFCF FFFF (5MByte)

Kernel:                         FFD0 0000 - FFEF FFFF (2MByte)

HRCW + U-Boot:          FFF0 0000 - FFF7 FFFF (512kByte)

Unused:                       FFF8 0000 - FFFF FFFF (512kByte)

=20

Modyfied the corresponding source file:

=20

#define WINDOW_ADDR 0xFC000000  // flash start address

#define WINDOW_SIZE 0x04000000     // 64Mbyte

=20

static struct mtd_partition partition_info[]=3D{

       {

               .name           =3D "Unused1",

               .offset         =3D 0,

               .size           =3D 0x3800000

       },

       {

               .name           =3D "JFFS2",

               .offset         =3D 0x3800000,

               .size           =3D 0x500000

       },

              {

               .name           =3D "Kernel",

               .offset         =3D 0x3D00000,

               .size           =3D 0x200000

       },

              {

               .name           =3D "HRCW",

               .offset         =3D 0x3F00000,

               .size           =3D 0x80000

       },

       {

               .name           =3D "Unused2",

               .offset         =3D0x3F80000,

               .size           =3D 0x80000

       }

};

=20

=20

After that, building the kernel, cp.b into the designated address (FFD0
0000)

and booting the kernel (bootm ffd00000).

=20

I'll get these output messages:

=20

EP8343M flash device: 4000000 at fc000000 Partition number 5

EP8343M Flash Map Info: Found 1 x32 devices at 0x0 in 16-bit bank

 Amd/Fujitsu Extended Query Table at 0x0040

EP8343M Flash Map Info: CFI does not contain boot bank location.
Assuming top.

number of CFI chips: 1

cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.

Creating 5 MTD partitions on "EP8343M Flash Map Info":

0x00000000-0x03800000 : "Unused1"

mtd: partition "Unused1" extends beyond the end of device "EP8343M Flash
Map Info" -- size truncated to 0x2000000

0x03800000-0x03d00000 : "JFFS2"

mtd: partition "JFFS2" is out of reach -- disabled

0x03d00000-0x03f00000 : "Kernel"

mtd: partition "Kernel" is out of reach -- disabled

0x03f00000-0x03f80000 : "HRCW"

mtd: partition "HRCW" is out of reach -- disabled

0x03f80000-0x04000000 : "Unused2"

mtd: partition "Unused2" is out of reach -- disabled

EP8343M flash device initialized

=20

Could you please help me and tell me what I did wrong?

=20

Thanks for help and let me know if you need further information.

=20

Best regards

Frank

=20

=20

=20

=20

=20

=20

=09
	 	=20
=20


Frank Prepelica
Software Design Engineer

Ubidyne GmbH
Lise-Meitner-Str.-14
89081 Ulm - Germany

Phone:             +49 731 88 00 71 58

Fax:                 +49 731 88 00 71 99
Email:              frank.prepelica@ubidyne.com
Homepage:       www.ubidyne.com <http://www.ubidyne.com/>=20

=20


------_=_NextPart_002_01C75A54.636C7657
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" =
name=3D"place"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"country-region"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.E-MailFormatvorlage17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1027" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DDE link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>I got a problem during creating the MTD =
partitions. I&#8217;m
using the <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>ELDK 4.1 with 2.6.19.2 Kernel and the MPC8343 =
board
with 128MB RAM<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>and 64MB flash memory. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>flinfo returns:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Bank # 1: CFI conformant FLASH (32 x 16)&nbsp; =
Size:
64 MB in 256 Sectors<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;Erase timeout 16384 ms, write timeout 1 =
ms,
buffer write timeout 4096 ms, buffer size =
32<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp; Sector Start =
Addresses:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; FC000000&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;FC040000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC080000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FC0C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC100000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FC140000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FC180000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC1C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FC200000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC240000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FC280000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FC2C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC300000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FC340000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC380000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FC3C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FC400000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC440000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FC480000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC4C0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FC500000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FC540000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC580000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FC5C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC600000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FC640000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FC680000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC6C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FC700000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC740000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FC780000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FC7C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC800000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FC840000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC880000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FC8C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FC900000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC940000&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;FC980000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FC9C0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FCA00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FCA40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FCA80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FCAC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FCB00000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FCB40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FCB80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FCBC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FCC00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FCC40000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FCC80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FCCC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FCD00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FCD40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FCD80000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FCDC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FCE00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FCE40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FCE80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FCEC0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FCF00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FCF40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FCF80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FCFC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FD040000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD080000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD0C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD100000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD140000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FD180000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD1C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD200000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD240000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD280000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; =
FD2C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD300000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD340000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD380000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD3C0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FD400000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD440000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD480000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD4C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD500000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FD540000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD580000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD5C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD600000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD640000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FD680000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD6C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD700000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD740000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD780000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FD7C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD800000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD840000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD880000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD8C0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FD900000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD940000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FD980000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FD9C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FDA00000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FDA40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FDA80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FDAC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FDB00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FDB40000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FDB80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FDBC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FDC00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FDC40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FDC80000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FDCC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FDD00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FDD40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FDD80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FDDC0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FDE00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FDE40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FDE80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FDEC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FDF00000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FDF40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FDF80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FDFC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE040000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FE080000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE0C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE100000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE140000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE180000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FE1C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE200000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE240000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE280000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE2C0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FE300000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE340000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE380000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE3C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE400000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FE440000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FE480000&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;FE4C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE500000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE540000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FE580000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE5C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE600000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE640000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE680000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FE6C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE700000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE740000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE780000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE7C0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FE800000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE840000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE880000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE8C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE900000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; =
FE940000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FE980000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FE9C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FEA00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FEA40000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FEA80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FEAC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FEB00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FEB40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FEB80000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FEBC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FEC00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FEC40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FEC80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FECC0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FED00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FED40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FED80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEDC0000&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;FEE00000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FEE40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FEE80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FEEC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FEF00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FEF40000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FEF80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FEFC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF040000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF080000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FF0C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF100000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF140000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF180000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF1C0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FF200000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF240000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF280000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF2C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF300000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FF340000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF380000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF3C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF400000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF440000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FF480000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF4C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF500000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF540000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF580000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FF5C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF600000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF640000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF680000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF6C0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FF700000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF740000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF780000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF7C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF800000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FF840000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF880000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF8C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF900000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FF940000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FF980000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF9C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FFA00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FFA40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FFA80000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FFAC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FFB00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FFB40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FFB80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FFBC0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FFC00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FFC40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FFC80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FFCC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FFD00000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FFD40000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FFD80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FFDC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FFE00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FFE40000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
FFE80000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FFEC0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
FFF00000 (RO) FFF40000 (RO) FFF80000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp; =
FFFC0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>That indicates me, that the flash begins at =
address
FC00 0000 and ends <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>at FFFF FFFF. I assume the sectors FFF0 0000 =
and FFF4
0000 contains <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>the HRCW and U-Boot, because they are =
protected.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Okay, so far so good. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>After that, I created my own flash map as =
followed:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Unused:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; FC00
0000 &#8211; FF7F FFFF (56Mbyte)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>JFFS2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FF80
0000 &#8211; FFCF FFFF (5MByte)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Kernel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FFD0
0000 &#8211; FFEF FFFF (2MByte)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>HRCW + =
U-Boot:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FFF0
0000 &#8211; FFF7 FFFF (512kByte)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Unused:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FFF8
0000 &#8211; FFFF FFFF (512kByte)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Modyfied the corresponding source =
file:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>#define WINDOW_ADDR 0xFC000000&nbsp; // flash =
start
address<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>#define WINDOW_SIZE =
0x04000000&nbsp;&nbsp;&nbsp;&nbsp; //
64Mbyte<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>static struct mtd_partition =
partition_info[]=3D{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D
&quot;Unused1&quot;,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
0,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
0x3800000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
},<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D
&quot;JFFS2&quot;,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
0x3800000,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
0x500000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
},<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D
&quot;Kernel&quot;,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
0x3D00000,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
0x200000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
},<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D
&quot;HRCW&quot;,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
0x3F00000,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
0x80000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
},<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D
&quot;Unused2&quot;,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;.offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D0x3F80000,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
0x80000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>After that, building the kernel, cp.b into the =
designated
address (FFD0 0000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>and booting the kernel (bootm =
ffd00000).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>I&#8217;ll get these output =
messages:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>EP8343M flash device: 4000000 at fc000000 =
Partition
number 5<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>EP8343M Flash Map Info: Found 1 x32 devices at =
0x0 in
16-bit bank<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;Amd/Fujitsu Extended Query Table at =
0x0040<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>EP8343M Flash Map Info: CFI does not contain =
boot
bank location. Assuming top.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>number of CFI chips: =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>cfi_cmdset_0002: Disabling =
erase-suspend-program due
to code brokenness.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Creating 5 MTD partitions on &quot;EP8343M =
Flash Map
Info&quot;:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>0x00000000-0x03800000 : =
&quot;Unused1&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>mtd: partition &quot;Unused1&quot; extends =
beyond the
end of device &quot;EP8343M Flash Map Info&quot; -- size truncated to =
0x2000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>0x03800000-0x03d00000 : =
&quot;JFFS2&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>mtd: partition &quot;JFFS2&quot; is out of =
reach --
disabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>0x03d00000-0x03f00000 : =
&quot;Kernel&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>mtd: partition &quot;Kernel&quot; is out of =
reach --
disabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>0x03f00000-0x03f80000 : =
&quot;HRCW&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>mtd: partition &quot;HRCW&quot; is out of =
reach --
disabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>0x03f80000-0x04000000 : =
&quot;Unused2&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>mtd: partition &quot;Unused2&quot; is out of =
reach --
disabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>EP8343M flash device =
initialized<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Could you please help me and tell me what I =
did
wrong?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Thanks for help and let me know if you need =
further
information.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Best regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Frank<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><!--[if gte vml 1]><v:line id=3D"_x0000_s1026" =
style=3D'position:absolute;
 z-index:1' from=3D".45pt,9.75pt" to=3D"148.95pt,9.75pt" =
/><![endif]--><![if !vml]><span
style=3D'mso-ignore:vglayout'>

<table cellpadding=3D0 cellspacing=3D0 align=3Dleft>
 <tr>
  <td width=3D0 height=3D12></td>
 </tr>
 <tr>
  <td></td>
  <td><img width=3D200 height=3D2 =
src=3D"cid:image002.gif@01C75A5C.C48B19D0" =
v:shapes=3D"_x0000_s1026"></td>
 </tr>
</table>

</span><![endif]><font size=3D2 face=3DVerdana><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<br style=3D'mso-ignore:vglayout' clear=3DALL>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Verdana'>Frank Prepelica<br>
Software Design Engineer<br>
<br>
</span></font><strong><b><font face=3DVerdana><span lang=3DEN-GB =
style=3D'font-family:
Verdana'>Ubidyne GmbH</span></font></b></strong><font size=3D2 =
face=3DVerdana><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Verdana'><br>
Lise-Meitner-Str.-14<br>
89081 <st1:City w:st=3D"on">Ulm</st1:City> - <st1:place =
w:st=3D"on"><st1:country-region
 w:st=3D"on">Germany</st1:country-region></st1:place><br>
<br>
Phone:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; +49
731 88 00 71 58</span></font><span lang=3DEN-GB><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Verdana'>Fax:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
+49 731 88 00 71 99<br>
Email:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
frank.prepelica@ubidyne.com<br>
Homepage:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font><font =
size=3D2
face=3DVerdana><span style=3D'font-size:10.0pt;font-family:Verdana'><a
href=3D"http://www.ubidyne.com/" title=3D"http://www.ubidyne.com/"><span
lang=3DEN-GB>www.ubidyne.com</span></a></span></font><span =
lang=3DEN-GB><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_002_01C75A54.636C7657--

------_=_NextPart_001_01C75A54.636C7657
Content-Type: image/gif;
	name="image002.gif"
Content-Transfer-Encoding: base64
Content-ID: <image002.gif@01C75A5C.C48B19D0>
Content-Description: image002.gif
Content-Location: image002.gif

R0lGODlhyAACAHcAMSH+GlNvZnR3YXJlOiBNaWNyb3NvZnQgT2ZmaWNlACH5BAEAAAAALAEAAADG
AAEAgAAAAAAAAAIMjI+py+0Po5y02ssKADs=

------_=_NextPart_001_01C75A54.636C7657--
