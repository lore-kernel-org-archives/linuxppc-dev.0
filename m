Return-Path: <kho@belairnetworks.com>
Received: from mail.belairnetworks.com (mail.belairnetworks.com
	[142.46.200.253]) by ozlabs.org (Postfix) with ESMTP id DE245B717C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Feb 2011 06:07:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CBCA1E.EBF40BEA"
Subject: Question on setting up external interrupt for P1020 (MPC8xxx) with
	device tree
Date: Fri, 11 Feb 2011 14:07:26 -0500
Message-ID: <92C536451C241244A14F3001819BF6688A503B@bnott05.belairnetworks.com>
From: "Kenny Ho" <kho@belairnetworks.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CBCA1E.EBF40BEA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I am trying to write a device driver that uses an external interrupt
(one of the 16 irq lines) for the Freescale P1020 processor and I hope
some of you can help.  Am I suppose to setup a separate node in the dts
and look for that node in my driver to setup the interrupt?  Or does the
dts interrupt declaration belong to the interrupt-controller
declaration?  I noticed the mpc8xxx_gpio driver defined its own irq_chip
but I thought that may be because each gpio pin can trigger an
interrupt.  Do I need to define my own irq_chip structure for my device
even if I am using one of the hard irq lines? =20

=20

Regards,

Kenny


------_=_NextPart_001_01CBCA1E.EBF40BEA
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
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 2 3 0 0 0 0 0 0 0;}
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
font-family:Arial'>I am trying to write a device driver that uses an =
external
interrupt (one of the 16 irq lines) for the Freescale P1020 processor =
and I
hope some of you can help.&nbsp; Am I suppose to setup a separate node =
in the
dts and look for that node in my driver to setup the interrupt? &nbsp;Or =
does
the dts interrupt declaration belong to the interrupt-controller =
declaration? &nbsp;I
noticed the mpc8xxx_gpio driver defined its own irq_chip but I thought =
that may
be because each gpio pin can trigger an interrupt. &nbsp;Do I need to =
define my
own irq_chip structure for my device even if I am using one of the hard =
irq
lines? &nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Kenny<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01CBCA1E.EBF40BEA--
