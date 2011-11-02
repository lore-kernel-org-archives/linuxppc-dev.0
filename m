Return-Path: <Brad.Giffel@hbm.com>
Received: from relay.medianet-world.de (relay.medianet-world.de
 [213.157.0.172]) by ozlabs.org (Postfix) with SMTP id B9489B6F71
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 08:09:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----_=_NextPart_001_01CC99A2.C1306865"
Subject: Support for multiple MSI interrupts on MPC8377
Date: Wed, 2 Nov 2011 16:02:34 -0500
Message-ID: <FBC631D6B23BAB40AF19415483130F7A6FD458@HBMURBX.hbm.com>
From: "Giffel, Brad" <Brad.Giffel@hbm.com>
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

------_=_NextPart_001_01CC99A2.C1306865
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm working a project using a Spartan 6 FPGA with a PCIe interface and
MSI interrupts.  I want to use multiple MSI interrupts (MSI-X is not
supported in the FPGA PCIe core) but the current Linux distribution
(3.0.8) prevents that (lines 23 to 25 in arch/powerpc/kernel/msi.c).

=20

What's the story here?  Is the code in place but not tested?  I tried
commenting out those lines but a request_irq() called failed for the
second interrupt requested.  Am I wasting my time here?  Should I
re-architect to use a single MSI interrupt?

=20

            Thanks,

            - Brad

=20


------_=_NextPart_001_01CC99A2.C1306865
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
font-family:Arial'>I&#8217;m working a project using a Spartan 6 FPGA =
with a
PCIe interface and MSI interrupts. &nbsp;I want to use multiple MSI =
interrupts
(MSI-X is not supported in the FPGA PCIe core) but the current Linux
distribution (3.0.8) prevents that (lines 23 to 25 in =
arch/powerpc/kernel/msi.c).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>What&#8217;s the story here?&nbsp; Is the code in =
place but
not tested? &nbsp;I tried commenting out those lines but a request_irq() =
called
failed for the second interrupt requested. &nbsp;Am I wasting my time
here?&nbsp; Should I re-architect to use a single MSI =
interrupt?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; -
Brad<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01CC99A2.C1306865--
