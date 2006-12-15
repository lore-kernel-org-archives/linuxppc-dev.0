Return-Path: <yhkim93@keti.re.kr>
Received: from smf.keti.re.kr (unknown [203.253.128.44])
	by ozlabs.org (Postfix) with ESMTP id E49EC67BAD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Dec 2006 23:15:17 +1100 (EST)
From: =?ks_c_5601-1987?B?sei/tciv?= <yhkim93@keti.re.kr>
To: <linuxppc-embedded@ozlabs.org>
Subject: u-boot error on ppc440SPe yucca board.
Date: Fri, 15 Dec 2006 20:20:29 +0900
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0014_01C72086.772D9150"
Message-Id: <20061215121517.E49EC67BAD@ozlabs.org>
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

------=_NextPart_000_0014_01C72086.772D9150
Content-Type: text/plain;
 charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit

I have installed at a slot of yucca board PCIE with LSI-Logic Mega RAID SAS
adapter. But it was happened the following error. What is problem?

Yucca board continues to reboot u-boot code.

 

============================================================================
==================================

U-Boot 1.1.6 (Nov 13 2006 - 11:42:57)

CPU:   AMCC PowerPC 440SPe Rev. B at 533.328 MHz (PLB=133, OPB=66, EBC=66
MHz)

I2C boot EEPROM enabled

Bootstrap Option D - Boot ROM Location I2C (Addr 0x50)

Internal PCI arbiter enabled

32 kB I-Cache 32 kB D-Cache

Board: Yucca - AMCC 440SPe Evaluation Board

I2C:   ready

 DRAM:  1024 MB

 FLASH:  5 MB

 PCI:   Bus Dev VenId DevId Class Int

 PCIE:1 successfully set as rootpoint

 Bus Fault @ 0x00000000, fixup 0x00000000 Machine check in kernel mode.

 Caused by (from msr): regs 3ff31d28 Unknown values in msr

 NIP: 00000000 XER: 20000000 LR: 3FFD47E4 REGS: 3ff31d28 TRAP: 0200 DAR:

 49642043

 MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00

 

 GPR00: 000000FF 3FF31E18 7FFFFFFF 3FFEFE74 00010800 0000000E 00000001 

 3FF31E30

 GPR08: 00000014 C0001000 3FFEFE88 3FFEFE88 42FF2F82 00000000 3FFE6500 

 40002000

 GPR16: 00000000 00000000 00000000 00000000 00000000 3FF31D18 00000000 

 00010000

 GPR24: 3FFB4914 00000001 00000000 00000001 3FF31E68 3FF31F50 3FFE6CE0 

 00010800 Call backtrace:

 machine check

============================================================================
=================================================


------=_NextPart_000_0014_01C72086.772D9150
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
font-family:=B1=BC=B8=B2'>I have installed at a slot of yucca board PCIE =
with LSI-Logic
Mega RAID SAS adapter. But it was happened the following error. What is
problem?<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>Yucca
board continues to reboot u-boot code.<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>U-Boot
1.1.6 (Nov 13 2006 - <st1:time o:ls=3D"trans" Hour=3D"11" Minute=3D"42" =
w:st=3D"on">11:42:57</st1:time>)<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>CPU:&nbsp;&nbsp;
AMCC PowerPC 440SPe Rev. B at 533.328 MHz (PLB=3D133, OPB=3D66, EBC=3D66 =
MHz)<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>I2C
boot EEPROM enabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>Bootstrap
Option D - Boot ROM Location I2C (Addr =
0x50)<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>Internal
PCI arbiter enabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>32
kB I-Cache 32 kB D-Cache<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>Board:
Yucca - AMCC 440SPe Evaluation Board<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>I2C:&nbsp;&nbsp;
ready<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;DRAM:&nbsp;
1024 MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;FLASH:&nbsp;
5 MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;PCI:&nbsp;&nbsp;
Bus Dev VenId DevId Class Int<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;PCIE:1
successfully set as rootpoint<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;Bus
Fault @ 0x00000000, fixup 0x00000000 Machine check in kernel =
mode.<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;Caused
by (from msr): regs 3ff31d28 Unknown values in =
msr<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;NIP:
00000000 XER: 20000000 LR: 3FFD47E4 REGS: 3ff31d28 TRAP: 0200 =
DAR:<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;49642043<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;MSR:
00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;GPR00:
000000FF 3FF31E18 7FFFFFFF 3FFEFE74 00010800 0000000E 00000001 =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;3FF31E30<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;GPR08:
00000014 C0001000 3FFEFE88 3FFEFE88 42FF2F82 00000000 3FFE6500 =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;40002000<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;GPR16:
00000000 00000000 00000000 00000000 00000000 3FF31D18 00000000 =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;00010000<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;GPR24:
3FFB4914 00000001 00000000 00000001 3FF31E68 3FF31F50 3FFE6CE0 =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;00010800
Call backtrace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal align=3Dleft =
style=3D'text-align:left;word-break:keep-all'><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;machine
check<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0014_01C72086.772D9150--
