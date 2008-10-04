Return-Path: <venkatakrishnap@vrindatech.com>
From: "VenkataKrishna" <venkatakrishnap@vrindatech.com>
To: <Linuxppc-embedded@ozlabs.org>
Subject: linux compiling in ELDK
Date: Sat, 4 Oct 2008 16:48:02 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C92640.FA468DA0"
Message-Id: <20081004112414.525C8DDD0C@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C92640.FA468DA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

    

    The tooks arch/ppc/configs/TQM8260_defconfig files and change to
VTPLM8260_defconfig in that I changed CONFIG_TQMM8260=y to
CONFIG_VTPLM8260=y.

    I executed commands given sequences.

 

1.       Make ARCH=ppc CROSS_COMPILE=ppc_82xx- VTPLM8260_defconfig.

2.       Make ARCH=ppc CROSS_COMPILE=ppc_82xx- uImage

 

   I got error shown below how I can solve this problem. But I used
TQM8260_defconfig file that time working fine. 

arch/ppc/kernel/built-in.o: In function `DoSyscall':

arch/ppc/kernel/entry.S:(.init.text+0x2dc): undefined reference to
`prep_init'

arch/ppc/syslib/built-in.o: In function `todc_direct_read_val':

: undefined reference to `todc_info'

arch/ppc/syslib/built-in.o: In function `todc_direct_read_val':

: undefined reference to `todc_info'

arch/ppc/syslib/built-in.o: In function `todc_direct_write_val':

: undefined reference to `todc_info'

arch/ppc/syslib/built-in.o: In function `todc_direct_write_val':

: Undefined reference to `todc_info'

arch/ppc/syslib/built-in.o: In function `todc_m48txx_write_val':

: undefined reference to `todc_info'

arch/ppc/syslib/built-in.o:: more undefined references to `todc_info' follow

make: *** [vmlinux] Error 1

 

 

   Kindly suggest me.

 

Thanks and Regards

Venkatakrishna Pari.

 

            


------=_NextPart_000_0000_01C92640.FA468DA0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:85880831;
	mso-list-type:hybrid;
	mso-list-template-ids:-863353014 67698703 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; &nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; &nbsp;&nbsp;The tooks
arch/ppc/configs/TQM8260_defconfig files and change to =
VTPLM8260_defconfig in
that I changed CONFIG_TQMM8260=3Dy to =
CONFIG_VTPLM8260=3Dy.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; I executed commands given =
sequences.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>1.<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Make
ARCH=3Dppc CROSS_COMPILE=3Dppc_82xx- =
VTPLM8260_defconfig.<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>2.<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Make
ARCH=3Dppc CROSS_COMPILE=3Dppc_82xx- uImage<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; I got error shown below how I can solve =
this problem.
But I used TQM8260_defconfig file that time working fine. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>arch/ppc/kernel/built-in.o: In function =
`DoSyscall':<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>arch/ppc/kernel/entry.S:(.init.text+0x2dc): =
undefined
reference to `prep_init'<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>arch/ppc/syslib/built-in.o: In function
`todc_direct_read_val':<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>: undefined reference to =
`todc_info'<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>arch/ppc/syslib/built-in.o: In function
`todc_direct_read_val':<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>: undefined reference to =
`todc_info'<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>arch/ppc/syslib/built-in.o: In function
`todc_direct_write_val':<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>: undefined reference to =
`todc_info'<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>arch/ppc/syslib/built-in.o: In function
`todc_direct_write_val':<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>: Undefined reference to =
`todc_info'<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>arch/ppc/syslib/built-in.o: In function
`todc_m48txx_write_val':<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>: undefined reference to =
`todc_info'<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>arch/ppc/syslib/built-in.o:: more undefined =
references
to `todc_info' follow<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>make: *** [vmlinux] Error =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Kindly suggest =
me.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks and Regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Venkatakrishna Pari.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; <o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0000_01C92640.FA468DA0--
