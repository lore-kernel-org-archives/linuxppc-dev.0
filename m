Return-Path: <moises.dominguez@ctag.com>
Received: from jupiter.ctag.com (smtp.ctag.com [193.144.40.36])
	by ozlabs.org (Postfix) with ESMTP id BC1E1B7C98
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Mar 2010 00:37:36 +1100 (EST)
Received: from [193.144.40.38] (helo=INN0072)
	by jupiter.ctag.com with esmtpa (Exim 4.63)
	(envelope-from <moises.dominguez@ctag.com>) id 1NphtZ-00014A-GO
	for linuxppc-dev@lists.ozlabs.org; Thu, 11 Mar 2010 13:53:46 +0100
From: =?iso-8859-1?Q?CTAG_/_Mois=E9s_Dom=EDnguez?= <moises.dominguez@ctag.com>
To: <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 11 Mar 2010 13:53:45 +0100
Message-ID: <DCD09CE7A7B046EA9AD832CD4648A26E@ctag>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0025_01CAC122.446EC780"
Subject: Linus' kernel tree over ads5121-rev4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0025_01CAC122.446EC780
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I am started with freescale LTIB but I decided to make a clone of Linus'
kernel tree mainly to have the latest and fixed mscan driver.

=20

Linux is uncompressed and starts right, but when DIU driver probe =
function
is called (exactly when first framebuffer device is registered) linux
restarts. This behaviour repeats indefinitely.

(same behaviour with denx kernel tree).

=20

I am using .dts that comes in the Linus=92kernel tree. Maybe this .dts =
board
revision dependent?=20

=20

I updated u-boot to with the denx one but similar results.

=20

=20

Maybe basic questions. Sorry for that.

=20

Regards, Moises.


------=_NextPart_000_0025_01CAC122.446EC780
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>I am started with freescale LTIB but I decided =
to make
a clone of Linus' kernel tree mainly to have the latest and fixed mscan =
driver.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Linux is uncompressed and starts right, but =
when </span></font><font
 size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'>DIU</span></font><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'>
driver probe function is called (exactly when first framebuffer device =
is
registered) linux restarts. This behaviour repeats i</span></font><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>ndefinitely.</span></font></=
p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>(same behaviour with denx kernel =
tree).</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am using .dts that comes in the Linus&#8217;kernel =
tree. Maybe
this .dts board revision dependent? </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I updated u-boot to with the denx one but similar =
results.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Maybe basic questions. Sorry for =
that.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Regards, Moises.</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0025_01CAC122.446EC780--
