Return-Path: <venkatakrishnap@vrindatech.com>
Received: from server.indiadomain.com (server.indiadomain.com [69.50.220.104])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00E65DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Sep 2008 21:45:37 +1000 (EST)
Received: from [122.169.152.62] (helo=venkatakrishna)
	by server.indiadomain.com with esmtpa (Exim 4.69)
	(envelope-from <venkatakrishnap@vrindatech.com>) id 1KfYzo-00040A-2B
	for linuxppc-embedded@ozlabs.org; Tue, 16 Sep 2008 04:45:32 -0700
From: "VenkataKrishna" <venkatakrishnap@vrindatech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: module compilation linux
Date: Tue, 16 Sep 2008 17:13:12 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C9181F.863B8430"
Message-Id: <20080916114538.00E65DDDEC@ozlabs.org>
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

------=_NextPart_000_0000_01C9181F.863B8430
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 

I compiled modules in ELDK 4.0 installed in Linux. I got the  configure
error in show in the below. How to solve that. What are configure values
should need compile MPC8260 freescale device driver in linux.

 

[root@VenkaKrisha linux-2.6-denx]# make ARCH=PowerPC CROSS_COMPILE=ppc_82xx-
modules

:0: error: -m64 not supported in this configuration

:0: error: -m64 not supported in this configuration

/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line 31: printf: #:
invalid number/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line
31: printf: #: invalid number/bin/sh: line 1: [: too many arguments

scripts/kconfig/conf -s arch/powerpc/Kconfig

*

* Restart config...

*

*

* Linux Kernel Configuration

*

64-bit kernel (PPC64) [N/y/?] (NEW)

 

 

With Regards

 

Venkatakrishna Pari


------=_NextPart_000_0000_01C9181F.863B8430
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I compiled modules in ELDK 4.0 installed in Linux. I =
got the
&nbsp;configure error in show in the below. How to solve that. What are =
configure
values should need compile MPC8260 freescale device driver in =
linux.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>[root@VenkaKrisha linux-2.6-denx]# make ARCH=3DPowerPC
CROSS_COMPILE=3Dppc_82xx- modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>:0: error: -m64 not supported in this =
configuration<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>:0: error: -m64 not supported in this =
configuration<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line =
31: printf:
#: invalid =
number/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line
31: printf: #: invalid number/bin/sh: line 1: [: too many =
arguments<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>scripts/kconfig/conf -s =
arch/powerpc/Kconfig<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>*<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>* Restart config...<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>*<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>*<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>* Linux Kernel Configuration<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>*<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>64-bit kernel (PPC64) [N/y/?] (NEW)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>With Regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Venkatakrishna Pari<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0000_01C9181F.863B8430--
