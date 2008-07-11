Return-Path: <SHorton@kodiaknetworks.com>
Received: from cowboy.inovate.inovate.com (planomail.kodiaknetworks.com
	[76.203.108.6]) by ozlabs.org (Postfix) with ESMTP id 88B6CDDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 13:59:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8E308.C07769E3"
Subject: mpc744x, Marvell mv6446x kernel guidance please
Date: Thu, 10 Jul 2008 22:46:49 -0500
Message-ID: <295C5089A56CE143B316E5F67CA99CB001C9E4BD@cowboy.inovate.inovate.com>
From: "Stephen Horton" <SHorton@kodiaknetworks.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C8E308.C07769E3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello folks,

In a current work project, I have inherited a compactPCI board that has
an mpc7447/7448 powerpc processor as well as a Marvell system
controller, model mv64462 (stripped down mv64460). The board has a
somewhat working Gentoo Linux port running on it from long ago and a
company far far away (kernel version 2.6.9 built using arch/ppc). To
prepare for an upcoming deployment, I would like to bring the OS
up-to-date on this board with a newer kernel (targeting Gentoo 2008),
but I am unsure of the approach to take. I am a software developer, but
normally do not work on kernel porting / board integration. I have
researched the arch/ppc to arch/powerpc migration, but I'm a bit
intimidated by the 'new' device tree symantics and other changes to the
stream. Here are some questions:

1.	Is it possible with the 2.6.24 (Gentoo 2008) kernel to still use
arch/ppc for this platform architecture?  I've tried to get this to
compile, but am having trouble with files from arch/powerpc getting
pulled in; then I read some comments (from I believe this forum) that
indicated that arch/ppc is not longer supposed to compile
2.	Does anyone have example code for this platform architecture?
Any freebees I could use for creating my device tree?
3.	Any advice of any kind?

Regards,

Stephen


------_=_NextPart_001_01C8E308.C07769E3
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
 /* List Definitions */
 @list l0
	{mso-list-id:1055928783;
	mso-list-type:hybrid;
	mso-list-template-ids:-517066650 67698703 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
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
font-family:Arial'>Hello folks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>In a current work project, I have inherited a =
compactPCI
board that has an mpc7447/7448 powerpc processor as well as a Marvell =
system
controller, model mv64462 (stripped down mv64460). The board has a =
somewhat
working Gentoo Linux port running on it from long ago and a company far =
far
away (kernel version 2.6.9 built using arch/ppc). To prepare for an =
upcoming
deployment, I would like to bring the OS up-to-date on this board with a =
newer
kernel (targeting Gentoo 2008), but I am unsure of the approach to take. =
I am a
software developer, but normally do not work on kernel porting / board
integration. I have researched the arch/ppc to arch/powerpc migration, =
but I&#8217;m
a bit intimidated by the &#8216;new&#8217; device tree symantics and =
other
changes to the stream. Here are some =
questions:<o:p></o:p></span></font></p>

<ol style=3D'margin-top:0in' start=3D1 type=3D1>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1'><font size=3D2 =
face=3DArial><span
     style=3D'font-size:10.0pt;font-family:Arial'>Is it possible with =
the 2.6.24
     (Gentoo 2008) kernel to still use arch/ppc for this platform =
architecture?
     &nbsp;I&#8217;ve tried to get this to compile, but am having =
trouble with
     files from arch/powerpc getting pulled in; then I read some =
comments (from
     I believe this forum) that indicated that arch/ppc is not longer =
supposed
     to compile<o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1'><font size=3D2 =
face=3DArial><span
     style=3D'font-size:10.0pt;font-family:Arial'>Does anyone have =
example code
     for this platform architecture? Any freebees I could use for =
creating my
     device tree?<o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1'><font size=3D2 =
face=3DArial><span
     style=3D'font-size:10.0pt;font-family:Arial'>Any advice of any =
kind?<o:p></o:p></span></font></li>
</ol>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Stephen<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8E308.C07769E3--
