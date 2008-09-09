Return-Path: <venkatakrishnap@vrindatech.com>
Received: from server.indiadomain.com (server.indiadomain.com [69.50.220.104])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56D4BDDF07
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 16:43:33 +1000 (EST)
Received: from [122.169.160.98] (helo=venkatakrishna)
	by server.indiadomain.com with esmtpa (Exim 4.69)
	(envelope-from <venkatakrishnap@vrindatech.com>) id 1Kcwwf-0003lq-RY
	for linuxppc-embedded@ozlabs.org; Mon, 08 Sep 2008 23:43:26 -0700
From: "VenkataKrishna" <venkatakrishnap@vrindatech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: ELDK
Date: Tue, 9 Sep 2008 12:03:50 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C91274.229A3E90"
Message-Id: <20080909064333.56D4BDDF07@ozlabs.org>
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

------=_NextPart_000_0000_01C91274.229A3E90
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I followed your sequence which is I show below. But I got problem shown
below. Plz Suggest me. How can I solve this one.

 

 

make mrproper

  CLEAN   scripts/basic

  CLEAN   scripts/kconfig

  CLEAN   include/config

  CLEAN   .config .config.old include/linux/autoconf.h

[root@VenkaKrisha linux-2.6-denx]# make ARCH=powerpc CROSS_COMPILE=ppc_6xx-
ppc6xx_defconfig

  HOSTCC  scripts/basic/fixdep

  HOSTCC  scripts/basic/docproc

  HOSTCC  scripts/kconfig/conf.o

  HOSTCC  scripts/kconfig/kxgettext.o

  SHIPPED scripts/kconfig/zconf.tab.c

  SHIPPED scripts/kconfig/lex.zconf.c

  SHIPPED scripts/kconfig/zconf.hash.c

  HOSTCC  scripts/kconfig/zconf.tab.o

  HOSTLD  scripts/kconfig/conf

#

# configuration written to .config

#

[root@VenkaKrisha linux-2.6-denx]# make ARCH=powerpc CROSS_COMPILE=ppc_6xx-
uImage

make: ppc_6xx-gcc: Command not found

?B?Bo lo?scripts/kconfig/conf -s arch/powerpc/Kconfig

#

# configuration written to .config

#

make: ppc_6xx-gcc: Command not found

?B?Bree directly.  Replace <dt> with the'

 

  @ech??B/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line 1:
ppc_6xx-gcc: command not found

/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line 1:
ppc_6xx-gcc: command not found

/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line 1:
ppc_6xx-gcc: command not found

/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line 1:
ppc_6xx-gcc: command not found

/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line 1:
ppc_6xx-gcc: command not found

*** 2.6 kernels no longer build correctly with old versions of binutils.

*** Please upgrade your binately to 2.12.1 or newer

make: *** [checkbin] Error 1

[root@VenkaKrisha linux-2.6-denx]#

 

 


------=_NextPart_000_0000_01C91274.229A3E90
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
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

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>I followed your sequence which is I show below. But I got =
problem shown
below. Plz Suggest me. How can I solve this =
one.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>make mrproper<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; CLEAN&nbsp;&nbsp; =
scripts/basic<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; CLEAN&nbsp;&nbsp; =
scripts/kconfig<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; CLEAN&nbsp;&nbsp; =
include/config<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; CLEAN&nbsp;&nbsp; .config .config.old =
include/linux/autoconf.h<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>[root@VenkaKrisha linux-2.6-denx]# make ARCH=3Dpowerpc
CROSS_COMPILE=3Dppc_6xx- ppc6xx_defconfig<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; HOSTCC&nbsp; =
scripts/basic/fixdep<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; HOSTCC&nbsp; =
scripts/basic/docproc<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; HOSTCC&nbsp; =
scripts/kconfig/conf.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; HOSTCC&nbsp; =
scripts/kconfig/kxgettext.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; SHIPPED =
scripts/kconfig/zconf.tab.c<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; SHIPPED =
scripts/kconfig/lex.zconf.c<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; SHIPPED =
scripts/kconfig/zconf.hash.c<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; HOSTCC&nbsp; =
scripts/kconfig/zconf.tab.o<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; HOSTLD&nbsp; =
scripts/kconfig/conf<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>#<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'># configuration written to .config<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>#<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>[root@VenkaKrisha linux-2.6-denx]# make ARCH=3Dpowerpc
CROSS_COMPILE=3Dppc_6xx- uImage<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>make: ppc_6xx-gcc: Command not =
found<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>?B?Bo lo?scripts/kconfig/conf -s =
arch/powerpc/Kconfig<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>#<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'># configuration written to .config<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>#<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>make: ppc_6xx-gcc: Command not =
found<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>?B?Bree directly.&nbsp; Replace &lt;dt&gt; with =
the'<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp; =
@ech??B/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line
1: ppc_6xx-gcc: command not found<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line 1:
ppc_6xx-gcc: command not found<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line 1:
ppc_6xx-gcc: command not found<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line 1:
ppc_6xx-gcc: command not found<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line 1:
ppc_6xx-gcc: command not found<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>*** 2.6 kernels no longer build correctly with old versions of
binutils.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>*** Please upgrade your binately to 2.12.1 or =
newer<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>make: *** [checkbin] Error 1<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>[root@VenkaKrisha linux-2.6-denx]#<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0000_01C91274.229A3E90--
