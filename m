Return-Path: <yhkim93@keti.re.kr>
Received: from smf.keti.re.kr (unknown [203.253.128.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6F71DDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 13:22:52 +1100 (EST)
From: =?ks_c_5601-1987?B?sei/tciv?= <yhkim93@keti.re.kr>
To: <linuxppc-embedded@ozlabs.org>
Subject: Exceptions during PCIe initialization at u-boot-1.2.0
Date: Fri, 23 Feb 2007 10:11:48 +0900
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0022_01C75733.07C443C0"
Message-Id: <20070223022252.D6F71DDDE9@ozlabs.org>
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

------=_NextPart_000_0022_01C75733.07C443C0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

I have a problem. Please help me!

=20

I am using ppc440SPe yucca board as PCIe rootpoint. And I installed a
adapter which is LSI-Logic RAID Controller with PCIe interface.=20

Now it=A1=AFs getting reset and machine check exception coming all the =
time
continuously and board is not booting up. It shows the following error.

=20

What am I to do? EMR, ESR have to be cleared. right?=20

=20

=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20

U-Boot 1.2.0 (Feb 22 2007 - 16:23:38)

=20

CPU:   AMCC PowerPC 440SPe Rev. B at 533.328 MHz (PLB=3D133, OPB=3D66, =
EBC=3D66
MHz)

       RAID 6 support

       I2C boot EEPROM enabled

       Bootstrap Option D - Boot ROM Location I2C (Addr 0x50)

       Internal PCI arbiter enabled

       32 kB I-Cache 32 kB D-Cache

Board: Yucca - AMCC 440SPe Evaluation Board

I2C:   ready

DRAM:  1024 MB

FLASH:  5 MB

*** Warning - bad CRC, using default environment

=20

PCI:   Bus Dev VenId DevId Class Int

PCI Autoconfig: Memory region: [80000000-8fffffff]

PCI Autoconfig: I/O region: [0-ffff]

pci_set_region

pci_register_hose

PCIE:2 successfully set as rootpoint

ppc440spe_setup_pcie_rootpoint

PCI Autoconfig: Memory region: [b2000000-b2ffffff]

=20

=3D=3D> This point is before pci_hose_read_config_byte() calll in
pci_hose_scan_bus()function

=20

Bus Fault @ 0x00000000, fixup 0x00000000

Machine check in kernel mode.

Caused by (from msr): regs 3ff31d28 Unknown values in msr

NIP: 00000000 XER: 20000000 LR: 3FFD48B4 REGS: 3ff31d28 TRAP: 0200 DAR:
49642043MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00

=20

GPR00: 000000FF 3FF31E18 7FFFFFFF 3FFF004C 00010800 0000000E 00000001
3FF31E30

GPR08: 3FFBCC04 C0002000 03F93E10 07F27C20 44FFFF82 00000000 3FFE6600
40002000

GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00010000

GPR24: 00000000 00000002 00000000 00000001 3FF31E68 3FF31F50 3FFE6DD8
00010800

Call backtrace:

machine check


------=_NextPart_000_0022_01C75733.07C443C0
Content-Type: text/html;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dks_c_5601-1987">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"time"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:=B9=D9=C5=C1;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:=B1=BC=B8=B2;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"\@=B1=BC=B8=B2";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"\@=B9=D9=C5=C1";
	panose-1:2 3 6 0 0 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-autospace:none;
	word-break:break-hangul;
	font-size:10.0pt;
	font-family:=B9=D9=C5=C1;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:=B1=BC=B8=B2;
	color:windowtext;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:99.25pt 3.0cm 3.0cm 3.0cm;
	layout-grid:18.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DKO link=3Dblue vlink=3Dpurple>

<div class=3DSection1 style=3D'layout-grid:18.0pt'>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>I have a problem. Please help =
me!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>I am using ppc440SPe yucca board as PCIe =
rootpoint. And I installed
a adapter which is LSI-Logic RAID Controller with PCIe interface. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>Now it</span></font><font face=3DArial><span =
lang=3DEN-US
style=3D'font-family:Arial'>=A1=AF</span></font><font =
face=3D=B1=BC=B8=B2><span lang=3DEN-US
style=3D'font-family:=B1=BC=B8=B2'>s getting reset and machine check =
exception coming all
the time continuously and board is not booting up. It shows the =
following
error.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>What am I to do? EMR, ESR have to be cleared. =
right? <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>U-Boot 1.2.0 (Feb 22 2007 - <st1:time =
o:ls=3D"trans" Hour=3D"16"
Minute=3D"23" =
w:st=3D"on">16:23:38</st1:time>)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>CPU:&nbsp;&nbsp; AMCC PowerPC 440SPe Rev. B at =
533.328 MHz
(PLB=3D133, OPB=3D66, EBC=3D66 MHz)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RAID 6 =
support<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2C boot =
EEPROM enabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bootstrap =
Option D - Boot
ROM Location I2C (Addr 0x50)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal =
PCI arbiter
enabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32 kB =
I-Cache 32 kB
D-Cache<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>Board: Yucca - AMCC 440SPe Evaluation =
Board<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>I2C:&nbsp;&nbsp; =
ready<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>DRAM:&nbsp; 1024 =
MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>FLASH:&nbsp; 5 MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>*** Warning - bad CRC, using default =
environment<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>PCI:&nbsp;&nbsp; Bus Dev VenId DevId Class =
Int<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>PCI Autoconfig: Memory region: =
[80000000-8fffffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>PCI Autoconfig: I/O region: =
[0-ffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>pci_set_region<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>pci_register_hose<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>PCIE:2 successfully set as =
rootpoint<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>ppc440spe_setup_pcie_rootpoint<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue =
face=3D=B1=BC=B8=B2><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=B1=BC=B8=B2;color:blue'>PCI =
Autoconfig: Memory
region: [b2000000-b2ffffff]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:
10.0pt;font-family:=B1=BC=B8=B2;font-weight:bold'><o:p>&nbsp;</o:p></span=
></font></b></p>

<p class=3DMsoNormal><font size=3D2 color=3Dred face=3DWingdings><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Wingdings;color:red'>&egrave;</span=
></font><font
color=3Dred face=3D=B1=BC=B8=B2><span lang=3DEN-US =
style=3D'font-family:=B1=BC=B8=B2;color:red'> This point
is before pci_hose_read_config_byte() calll in =
pci_hose_scan_bus()function<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue =
face=3D=B1=BC=B8=B2><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:=B1=BC=B8=B2;color:blue'>Bus Fault =
@ 0x00000000,
fixup 0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>Machine check in kernel =
mode.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>Caused by (from msr): regs 3ff31d28 Unknown =
values in msr<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>NIP: 00000000 XER: 20000000 LR: 3FFD48B4 REGS: =
3ff31d28 TRAP:
0200 DAR: 49642043MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: =
00<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>GPR00: 000000FF 3FF31E18 7FFFFFFF 3FFF004C =
00010800 0000000E
00000001 3FF31E30<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>GPR08: 3FFBCC04 C0002000 03F93E10 07F27C20 =
44FFFF82 00000000
3FFE6600 40002000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>GPR16: 00000000 00000000 00000000 00000000 =
00000000 00000000
00000000 00010000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>GPR24: 00000000 00000002 00000000 00000001 =
3FF31E68 3FF31F50
3FFE6DD8 00010800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>Call backtrace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>machine check<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0022_01C75733.07C443C0--
