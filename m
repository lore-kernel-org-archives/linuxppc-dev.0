Return-Path: <moises.dominguez@ctag.com>
Received: from jupiter.ctag.com (smtp.ctag.com [193.144.40.36])
	by ozlabs.org (Postfix) with ESMTP id AF68EB7D57
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 May 2010 01:21:32 +1000 (EST)
Received: from [193.144.40.38] (helo=INN0072)
	by jupiter.ctag.com with esmtpa (Exim 4.63)
	(envelope-from <moises.dominguez@ctag.com>) id 1OF72n-0004vA-7P
	for linuxppc-dev@lists.ozlabs.org; Thu, 20 May 2010 16:48:18 +0200
From: =?iso-8859-1?Q?CTAG_/_Mois=E9s_Dom=EDnguez?= <moises.dominguez@ctag.com>
To: <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 20 May 2010 16:48:17 +0200
Message-ID: <B597D6E3752845929B21C3369FB41730@ctag>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_004F_01CAF83C.3F048EF0"
Subject: MBX drivers ads5121-rev4-v20090603
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_004F_01CAF83C.3F048EF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

=20

I am trying to use MBX 3D engine driver of my ads5121. AFAIK, drivers =
were
built against same kernel as mine but I get problems for testing the =
demos
and for loading the service:

[root@freescale /]# etc/init.d/rc.pvr start

[   29.526994] dbgdrv: module license 'unspecified' taints kernel.

[   29.721065] _IORemapWrapper: mapping 1048576 bytes uncached from
0x80000000 to 0xe5280000

=85=20

=20

I read in previous threads of this list about similar problems:

- MBX on kernel 2.6.31:
ttp://old.nabble.com/MPC5121ADS-PowerVR-MBX-driver-on-2.6.31-kernel--td26=
613
966.html

- MBX on kernel 2.6.24:
http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-February/067967.html

=20

According those posts, I would need to recompile modules against my =
kernel,
but, of course, I do not have the sources.  Reading ltib doc I read:

=93Proprietary Packages:
mbx_build13_binaries: This package provides proprietary binary kernel
modules, libraries,
and test code built from the MBX OpenGL ES DDK.=94
=20
Have anybody tested MBX demos provided with freescale SDK with ltib
v20090603 without having to recompile provided .ko=92s?=20
=20

Regards,

Moises

=20

Board ads5121

Ltib version 20090603

Linux kernel version 2.6.24.6


------=_NextPart_000_004F_01CAF83C.3F048EF0
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
pre
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
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
font-family:Arial'>Hi all,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>I am trying to use MBX 3D engine driver of my =
ads5121.
AFAIK, drivers were built against same kernel as mine but I get problems =
for
testing the demos and for loading the service:</span></font></p>

<p class=3DMsoNormal><i><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>[root@free=
scale
/]# etc/init.d/rc.pvr start</span></font></i></p>

<p class=3DMsoNormal><i><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>[=A0=A0 =
29.526994] dbgdrv:
module license 'unspecified' taints kernel.</span></font></i></p>

<p class=3DMsoNormal><i><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>[=A0=A0 =
29.721065] _IORemapWrapper:
mapping 1048576 bytes uncached from 0x80000000 to =
0xe5280000</span></font></i></p>

<p class=3DMsoNormal><i><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>&#8230; =
</span></font></i></p>

<p class=3DMsoNormal><b><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-weight:bold'>&nbsp;</spa=
n></font></b></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>I read in previous threads of this list about =
similar
problems:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>- MBX on kernel 2.6.31: =
ttp://old.nabble.com/MPC5121ADS-PowerVR-MBX-driver-on-2.6.31-kernel--td26=
613966.html</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>- MBX on kernel 2.6.24: =
http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-February/067967.html<=
/span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>According those posts, I would need to =
recompile
modules against my kernel, but, of course, I do not have the sources. =
=A0Reading ltib
doc I read:</span></font></p>

<pre><i><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;
font-family:Arial;font-style:italic'>&#8220;Proprietary =
Packages:</span></font></i></pre><pre><i><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
font-style:italic'>mbx_build13_binaries: This package provides =
proprietary binary kernel modules, =
libraries,</span></font></i></pre><pre><i><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial;
font-style:italic'>and test code built from the MBX OpenGL ES =
DDK.&#8221;</span></font></i></pre><pre><i><font
size=3D2 face=3D"Courier New"><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-style:
italic'>&nbsp;</span></font></i></pre><pre><font size=3D2 =
face=3DArial><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>Have anybody =
tested MBX demos provided with freescale SDK with ltib v20090603 without =
having to recompile provided .ko&#8217;s? </span></font></pre><pre><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;</span></font></pre>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Regards,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Moises</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><i><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>Board =
ads5121</span></font></i></p>

<p class=3DMsoNormal><i><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>Ltib =
version 20090603</span></font></i></p>

<p class=3DMsoNormal><i><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'>Linux =
kernel version
2.6.24.6</span></font></i></p>

</div>

</body>

</html>

------=_NextPart_000_004F_01CAF83C.3F048EF0--
