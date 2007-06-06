Return-Path: <C.vdKruit@fugro.nl>
Received: from smtp.eu1.fugro.com (smtp.eu1.fugro.com [212.189.46.151])
	by ozlabs.org (Postfix) with ESMTP id 00A3BDDEB9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jun 2007 19:46:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7A81E.17021086"
Subject: MPC8272 LPT support
Date: Wed, 6 Jun 2007 11:35:46 +0200
Message-ID: <C89EFD3CD56F64468D3D206D683A8D22351B7A@ldam-msx2.fugro-nl.local>
From: "Kruit, Chris van der [FINT]" <C.vdKruit@fugro.nl>
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

------_=_NextPart_001_01C7A81E.17021086
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I'm new to Linux and PowerPC.=20

Last days I did some research to find out if we could use a specific
board for our new project.  I found a board with a MPC8272 processor; it
got all the IO we need, except for a LPT port that we use now for
driving a HD44780 based display.

=20

Now the MPC8272 has a lot free GPIO pins which can be used for driving
the HD44780 controller.=20

Now my question is if there are drivers for these GPIO pins and if there
is a way too emulate a parallel port on GPIO pins.

=20

Thanks in advanced.

=20

Regards,

=20

Chris

=20


------_=_NextPart_001_01C7A81E.17021086
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
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m new to Linux and PowerPC. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Last days I did some research to find out if we could =
use a
specific board for our new project. &nbsp;I found a board with a MPC8272 =
processor;
it got all the IO we need, except for a LPT port that we use now for =
driving a <font
color=3Dblack><span style=3D'color:black'>HD44780 based =
display.<o:p></o:p></span></font></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:black'>Now the </span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'>MPC8272 =
has a lot
free GPIO pins which can be used for driving the <font =
color=3Dblack><span
style=3D'color:black'>HD44780 controller. =
<o:p></o:p></span></font></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:black'>Now my question is if there are =
drivers
for these GPIO pins and if there is a way too emulate a parallel port on =
GPIO
pins.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:black'>Thanks in =
advanced.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:black'><o:p>&nbsp;</o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:black'>Regards,<o:p></o:p></span></font></=
p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DNL =
style=3D'font-size:10.0pt;
font-family:Arial'>Chris</span></font><span =
lang=3DNL><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C7A81E.17021086--
