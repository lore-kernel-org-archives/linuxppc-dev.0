Return-Path: <Chetan.S.Anantharaman@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id BE0EA67A73
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 06:00:04 +1000 (EST)
Received: from il06exr01.mot.com (il06exr01.mot.com [129.188.137.131])
	by motgate8.mot.com (8.12.11/Motgate7) with ESMTP id k4UK01wM008517
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 13:00:01 -0700 (MST)
Received: from de01exm68.ds.mot.com (de01exm68.am.mot.com [10.176.8.24])
	by il06exr01.mot.com (8.13.5/8.13.0) with ESMTP id k4UJxxo2027007
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 15:00:00 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C68423.A18848D1"
Subject: execve of /sbin/init fails
Date: Tue, 30 May 2006 15:59:59 -0400
Message-ID: <EDF27F298D4B03498AE0C249A941DFF803D6DE@de01exm68.ds.mot.com>
From: "Anantharaman Chetan-W16155" <Chetan.S.Anantharaman@motorola.com>
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

------_=_NextPart_001_01C68423.A18848D1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,=20

I am trying to bring up a custom board with a PPC405 processor running
Linux 2.4.20 (MontaVista Release) and am having problems with the call
to execve("/sbin/init", argv_init, envp_init) not returning in the file
main.c. The processor just hangs and there is no output on the terminal.
I have tried to see if I can run "bin/sh" and even this execve call does
not return. Some things about the board are, the networking option has
been disabled in the Linux .config file. I am running U-Boot 1.1.1 as
the bootloader and am downloading the uImage (compressed kernel) and the
initrd.boot (filesystem) into RAM and accessing the filesystem in RAM.=20

=20

Any help as to what could be causing this to happen or how to debug this
issue would be appreciated. Also, I've tried to capture the return value
of the execve call but since the call does not return, this has not
helped any.

=20

Thanks,

Chetan Anantharaman

=20

=20


------_=_NextPart_001_01C68423.A18848D1
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
font-family:Arial'>Hi, <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am trying to bring up a custom board with a PPC405
processor running Linux 2.4.20 (MontaVista Release) and am having =
problems with
the call to execve(&#8220;/sbin/init&#8221;, argv_init, envp_init) not
returning in the file main.c. The processor just hangs and there is no =
output
on the terminal. I have tried to see if I can run &#8220;bin/sh&#8221; =
and even
this execve call does not return. Some things about the board are, the =
networking
option has been disabled in the Linux .config file. I am running U-Boot =
1.1.1
as the bootloader and am downloading the uImage (compressed kernel) and =
the
initrd.boot (filesystem) into RAM and accessing the filesystem in RAM. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any help as to what could be causing this to happen =
or how
to debug this issue would be appreciated. Also, I&#8217;ve tried to =
capture the
return value of the execve call but since the call does not return, this =
has
not helped any.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Chetan Anantharaman<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C68423.A18848D1--
