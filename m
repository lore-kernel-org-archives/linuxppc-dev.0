Return-Path: <lacrimosa02@sina.com>
Received: from smtp.sina.com.cn (smtp.sina.com.cn [202.108.3.233])
	by ozlabs.org (Postfix) with ESMTP id 9FE77DDDFE
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Oct 2007 15:51:20 +1000 (EST)
Received: from neukxpax3m59t7 (unknown [58.154.193.229])
	by smtp.sina.com.cn (SINAMAIL) with ESMTP id 682393B60C6
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Oct 2007 13:24:41 +0800 (CST)
From: =?gb2312?B?zfXW2A==?= <lacrimosa02@sina.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: aty128fb PCI card on ppc 405ep taihu board
Date: Sun, 14 Oct 2007 13:24:40 +0800
Message-ID: <616984B041004305BF2F004AEC6B3BA5@neukxpax3m59t7>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C80E65.94739E30"
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

------=_NextPart_000_0000_01C80E65.94739E30
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

         I got a taihu board. Now I want to display graphics (based on =
Qt)
through an ATI 128RAGE PCI card. The kernel is DENX Linux Kernel 2.6.19. =
I
found aty128fb framebuffer driver in menu configuration and build-in =
kernel.
Then I compile the boot logo into the kernel. I append
=A1=B0video=3Daty128fb:640x480-16@70=A1=B1 to the kernel command line to =
enable
framebuffer. When the kernel is booting, there should be a penguin logo =
on
the VGA display (a CRT), but there=A1=AFs noting. The display got no =
signal all
the time.=20

         Bootloader is U-Boot 1.1.4. It can recognize the PCI device:

=20

PCI:   Bus Dev  VenId  DevId  Class Int

        00  06  1002  524b  0300  19

        00  07  104c  ac56  0607  1b

=20

         The first line is my card, VenId and DevId are correct.

         Then the kernel is booting, but output nothing to VGA display. =
I
type =A1=B0lspci=A1=B1 in serial console. Below is the output:

=20

         #lspci

         00:06.0 Class 0300: 1002:524b

00:07.0 Class 0607: 104c:ac56

=20

#lspci =A8Cv

00:06.0 Class 0300: 1002:524b

        Subsystem: 1002:524c

        Flags: bus master, stepping, medium devsel, latency 128, IRQ 25

        Memory at 00000000bc000000 (32-bit, prefetchable) [size=3D64M]

        I/O ports at e8021f00 [size=3D256]

        Memory at 00000000bbffc000 (32-bit, non-prefetchable) =
[size=3D16K]

        Expansion ROM at <unassigned> [disabled] [size=3D128K]

        Capabilities: [5c] Power Management version 1

=20

00:07.0 Class 0607: 104c:ac56

        Flags: bus master, medium devsel, latency 168, IRQ 26

        Memory at 00000000bbffb000 (32-bit, non-prefetchable) =
[size=3D4K]

        Bus: primary=3D00, secondary=3D01, subordinate=3D04, =
sec-latency=3D176

        Memory window 0: bbbfb000-bbffa000 (prefetchable)

        Memory window 1: 80000000-803ff000

        I/O window 0: 0000bf00-0000feff

        I/O window 1: 00001000-000011ff

        16-bit legacy interface ports at 0001

=20

It seems that the board found the PCI device but didn=A1=AFt recognize =
it is an
ATI graphics card, framebuffer didn=A1=AFt start up at all. When I run a =
Qt
application compiled for ppc_4xx, the serial console displays:

=20

Can't open framebuffer device /dev/fb0

: driver cannot connect

=20

How can I enable framebuffer? Should I modify the aty128fb driver or
something?

Thanks a lot!

=20

Best Regards,

Wang Zhong

=20


------=_NextPart_000_0000_01C80E65.94739E30
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chsdate"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chmetcnv"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>Hi,<o:p></o:p></span></font><=
/p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
I got a taihu board. Now I want to display graphics (based on Qt) =
through an
ATI 128RAGE PCI card. The kernel is DENX Linux Kernel <st1:chsdate
IsROCDate=3D"False" IsLunarDate=3D"False" Day=3D"30" Month=3D"12" =
Year=3D"1899" w:st=3D"on">2.6.19</st1:chsdate>.
I found aty128fb framebuffer driver in menu configuration and build-in =
kernel.
Then I compile the boot logo into the kernel. I append
=A1=B0video=3Daty128fb:640x480-16@<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"70" =
UnitName=3D"=A1=B1" w:st=3D"on">70=A1=B1</st1:chmetcnv>
to the kernel command line to enable framebuffer. When the kernel is =
booting,
there should be a penguin logo on the VGA display (a CRT), but =
there=A1=AFs noting.
The display got no signal all the time. <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
Bootloader is U-Boot <st1:chsdate IsROCDate=3D"False" =
IsLunarDate=3D"False" Day=3D"30"
Month=3D"12" Year=3D"1899" w:st=3D"on">1.1.4</st1:chsdate>. It can =
recognize the PCI
device:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal =
style=3D'margin-left:31.5pt;mso-para-margin-left:3.0gd;
layout-grid-mode:char'><font size=3D1 face=3DArial><span lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial'>PCI:&nbsp;&nbsp; Bus Dev =
&nbsp;VenId
&nbsp;DevId &nbsp;Class Int<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:31.5pt;mso-para-margin-left:3.0gd;
layout-grid-mode:char'><font size=3D1 face=3DArial><span lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
00&nbsp; 06&nbsp; 1002&nbsp; 524b&nbsp; 0300&nbsp; =
19<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:31.5pt;mso-para-margin-left:3.0gd;
layout-grid-mode:char'><font size=3D1 face=3DArial><span lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
00&nbsp; 07&nbsp; <st1:chmetcnv TCSC=3D"0" NumberType=3D"1" =
Negative=3D"False"
HasSpace=3D"False" SourceValue=3D"104" UnitName=3D"C" =
w:st=3D"on">104c</st1:chmetcnv>&nbsp;
ac56&nbsp; 0607&nbsp; 1b<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:31.5pt;mso-para-margin-left:3.0gd;
layout-grid-mode:char'><font size=3D1 face=3DArial><span lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
The first line is my card, VenId and DevId are =
correct.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
Then the kernel is booting, but output nothing to VGA display. I type =
=A1=B0lspci=A1=B1
in serial console. Below is the output:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
#lspci<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
00:06.0 Class 0300: 1002:524b<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>00:07.0
Class 0607: <st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False"
HasSpace=3D"False" SourceValue=3D"104" UnitName=3D"C" =
w:st=3D"on">104c</st1:chmetcnv>:ac56<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>#lspci
=A8Cv<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>00:06.0
Class 0300: 1002:524b<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
Subsystem: 1002:<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" =
Negative=3D"False"
HasSpace=3D"False" SourceValue=3D"524" UnitName=3D"C" =
w:st=3D"on">524c</st1:chmetcnv><o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
Flags: bus master, stepping, medium devsel, latency 128, IRQ =
25<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
Memory at 00000000bc000000 (32-bit, prefetchable) [size=3D<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"64" UnitName=3D"m"
w:st=3D"on">64M</st1:chmetcnv>]<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
I/O ports at e<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" =
Negative=3D"False"
HasSpace=3D"False" SourceValue=3D"8021" UnitName=3D"F" =
w:st=3D"on">8021f</st1:chmetcnv>00
[size=3D256]<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
Memory at 00000000bbffc000 (32-bit, non-prefetchable) =
[size=3D16K]<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
Expansion ROM at &lt;unassigned&gt; [disabled] =
[size=3D128K]<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
Capabilities: [<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" =
Negative=3D"False"
HasSpace=3D"False" SourceValue=3D"5" UnitName=3D"C" =
w:st=3D"on">5c</st1:chmetcnv>]
Power Management version 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>00:07.0
Class 0607: <st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False"
HasSpace=3D"False" SourceValue=3D"104" UnitName=3D"C" =
w:st=3D"on">104c</st1:chmetcnv>:ac56<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
Flags: bus master, medium devsel, latency 168, IRQ =
26<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
Memory at 00000000bbffb000 (32-bit, non-prefetchable) =
[size=3D4K]<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
Bus: primary=3D00, secondary=3D01, subordinate=3D04, =
sec-latency=3D176<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
Memory window 0: bbbfb000-bbffa000 =
(prefetchable)<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
Memory window 1: 80000000-803ff000<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I/O window 0: =
0000bf00-0000feff<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
I/O window 1: 00001000-000011ff<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
16-bit legacy interface ports at 0001<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>It
seems that the board found the PCI device but didn=A1=AFt recognize it =
is an ATI
graphics card, framebuffer didn=A1=AFt start up at all. When I run a Qt =
application compiled
for ppc_4xx, the serial console displays:<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>Can't
open framebuffer device /dev/fb0<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>:
driver cannot connect<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>How
can I enable framebuffer? Should I modify the aty128fb driver or =
something?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'text-indent:21.0pt;layout-grid-mode:char'><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'>Thanks
a lot!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>Best =
Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'layout-grid-mode:char'><font size=3D1 =
face=3DArial><span
lang=3DEN-US style=3D'font-size:9.0pt;font-family:Arial'>Wang =
Zhong<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0000_01C80E65.94739E30--
