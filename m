Return-Path: <SHorton@kodiaknetworks.com>
Received: from planomail.kodiaknetworks.com (planomail.kodiaknetworks.com
	[76.203.108.6]) by ozlabs.org (Postfix) with ESMTP id 18962DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Dec 2008 10:40:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C954D5.ADF74BEE"
Subject: Marvell mv64462 + mpc744x PCI Interrupt Cause Error Handling
Date: Tue, 2 Dec 2008 17:28:27 -0600
Message-ID: <295C5089A56CE143B316E5F67CA99CB001F4389F@cowboy.inovate.inovate.com>
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

------_=_NextPart_001_01C954D5.ADF74BEE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi folks,

=20

I'm really hoping Mark Greer or Dale Farnsworth sees this email. In my
current project, we are in the process of updating a board that has a
Marvell mv64462 system controller and a Freescale mpc7447A processor on
it. The board was originally developed with Gentoo Linux 2.6.9, but we
have ported Linux 2.6.24 kernel onto it. The new kernel is working well
thanks to help from people on this list. However, in examining the
differences between the 2 kernels, I can see that the 2.6.24 kernel
registers no interrupt error handling routines (see PCI Error Report
Register Map in the Marvell documentation). The error handlers for cpu,
sram, and specifically for the PCI bus that were previously in:

            /arch/ppc/syslib/mv64460_pic.c

are absent from:

            /arch/powerpc/sysdev/mv64x60_pic.c

=20

Can someone who is familiar with the history of the ppc->powerpc
migration for this architecture help me figure out why the error
handling wasn't ported over? Is there some reason for this, such as it
didn't work properly or had some disadvantages? Is this error handling
done in 2.6.24 in some more generic manner that I have not yet found? Is
this an exercise left for me to implement?

=20

Thanks,

Stephen


------_=_NextPart_001_01C954D5.ADF74BEE
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
font-family:Arial'>Hi folks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m really hoping Mark Greer or Dale Farnsworth =
sees
this email. In my current project, we are in the process of updating a =
board
that has a Marvell mv64462 system controller and a Freescale mpc7447A =
processor
on it. The board was originally developed with Gentoo Linux 2.6.9, but =
we have
ported Linux 2.6.24 kernel onto it. The new kernel is working well =
thanks to
help from people on this list. However, in examining the differences =
between
the 2 kernels, I can see that the 2.6.24 kernel registers no interrupt =
error
handling routines (see PCI Error Report Register Map in the Marvell
documentation). The error handlers for cpu, sram, and specifically for =
the PCI
bus that were previously in:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /arch/ppc/syslib/mv64460_pic.c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>are absent from:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
/arch/powerpc/sysdev/mv64x60_pic.c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Can someone who is familiar with the history of the
ppc-&gt;powerpc migration for this architecture help me figure out why =
the
error handling wasn&#8217;t ported over? Is there some reason for this, =
such as
it didn&#8217;t work properly or had some disadvantages? Is this error =
handling
done in 2.6.24 in some more generic manner that I have not yet found? Is =
this
an exercise left for me to implement?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Stephen<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C954D5.ADF74BEE--
