Return-Path: <moises.dominguez@ctag.com>
Received: from jupiter.ctag.com (smtp.ctag.com [193.144.40.36])
	by ozlabs.org (Postfix) with ESMTP id 02D07B7D24
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Apr 2010 17:40:05 +1000 (EST)
Received: from [193.144.40.38] (helo=INN0072)
	by jupiter.ctag.com with esmtpa (Exim 4.63)
	(envelope-from <moises.dominguez@ctag.com>) id 1O1xCO-00063J-58
	for linuxppc-dev@lists.ozlabs.org; Wed, 14 Apr 2010 09:39:58 +0200
From: =?iso-8859-1?Q?CTAG_/_Mois=E9s_Dom=EDnguez?= <moises.dominguez@ctag.com>
To: <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 14 Apr 2010 09:39:47 +0200
Message-ID: <E70643A89AF74DE1BCA25C3C4AE2CE29@ctag>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_003F_01CADBB6.6C4D3350"
Subject: mpc5121e-Real Time Clock
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_003F_01CADBB6.6C4D3350
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I am trying  to use internal Real Time Clock of my ads5121 board .So =
that I
am using /dev/rtc-0 device with linux/Documentation/rtc.txt example. I =
can
read and write time/date but I notice RTC is not being updated as if =
VBAT
was off or there was not oscillator (I tested oscillator and VBAT).

=20

According MPC5121e errdata of freescale doc., there=92s an issue =
involving
RTC:

=20

Description:

=93The TAMP bit in the SRTC does not reliably provide an indication that =
the
RTC power supply or the RTC

oscillator has been interrupted=94

=20

Workaround:

=93In your system=92s design, do not rely on the tamper indication to be
reliable=94

=20

=20

Looking in rtc-mpc5121.c code I didn=92t find anything related to Keep =
Alive
Register (where TAMP bit is) so I would like to know where this issue is
taking into account or if it is really being taking into account in the
driver.

=20

=20

Regards,  Mois=E9s.


------=_NextPart_000_003F_01CADBB6.6C4D3350
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

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
span.EstiloCorreo17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 3.0cm 70.85pt 3.0cm;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DES link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D3 face=3DVerdana><span =
style=3D'font-size:12.0pt;
font-family:Verdana'>Hi,</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DVerdana><span =
style=3D'font-size:12.0pt;
font-family:Verdana'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DVerdana><span =
style=3D'font-size:12.0pt;
font-family:Verdana'>I am trying =A0to use internal Real Time Clock of =
my ads5121
board .So that I am using /dev/rtc-0 device with =
linux/Documentation/rtc.txt example.
I can read and write time/date but I notice RTC is not being updated as =
if VBAT
was off or there was not oscillator (I tested oscillator and =
VBAT).</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DVerdana><span =
style=3D'font-size:12.0pt;
font-family:Verdana'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DVerdana><span =
style=3D'font-size:12.0pt;
font-family:Verdana'>According MPC5121e errdata of freescale doc., =
there&#8217;s
an issue involving RTC:</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DVerdana><span =
style=3D'font-size:12.0pt;
font-family:Verdana'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DVerdana><span =
style=3D'font-size:12.0pt;
font-family:Verdana'>Description:</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><b><i><font size=3D3 =
face=3DVerdana><span
style=3D'font-size:12.0pt;font-family:Verdana;font-weight:bold;font-style=
:italic'>&#8220;</span></font></i></b><i><font
face=3DVerdana><span style=3D'font-family:Verdana;font-style:italic'>The =
TAMP bit
in the SRTC does not reliably provide an indication that the RTC power =
supply
or the RTC</span></font></i></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><i><font size=3D3 =
face=3DVerdana><span
style=3D'font-size:12.0pt;font-family:Verdana;font-style:italic'>oscillat=
or has
been interrupted&#8221;</span></font></i></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3 =
face=3DVerdana><span
style=3D'font-size:12.0pt;font-family:Verdana'>&nbsp;</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3 =
face=3DVerdana><span
style=3D'font-size:12.0pt;font-family:Verdana'>Workaround:</span></font><=
/p>

<p class=3DMsoNormal style=3D'text-autospace:none'><i><font size=3D3 =
face=3DVerdana><span
style=3D'font-size:12.0pt;font-family:Verdana;font-style:italic'>&#8220;I=
n your
system&#8217;s design, do not rely on the tamper indication to be =
reliable&#8221;</span></font></i></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><i><font size=3D3 =
face=3DVerdana><span
style=3D'font-size:12.0pt;font-family:Verdana;font-style:italic'>&nbsp;</=
span></font></i></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DVerdana><span
style=3D'font-size:10.0pt;font-family:Verdana'>=A0</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DVerdana><span =
style=3D'font-size:12.0pt;
font-family:Verdana'>Looking in rtc-mpc5121.c code I didn&#8217;t find =
anything
related to Keep Alive Register (where TAMP bit is) so I would like to =
know where
this issue is taking into account or if it is really being taking into =
account in
the driver.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DVerdana><span =
style=3D'font-size:12.0pt;
font-family:Verdana'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DVerdana><span =
style=3D'font-size:12.0pt;
font-family:Verdana'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DVerdana><span =
style=3D'font-size:12.0pt;
font-family:Verdana'>Regards, =A0Mois=E9s.</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_003F_01CADBB6.6C4D3350--
