Return-Path: <rmcguire@uwbt.com>
Received: from mail19d.g19.rapidsite.net (mail19d.g19.rapidsite.net
	[204.202.242.120]) by ozlabs.org (Postfix) with SMTP id 9F70CDE198
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Jan 2007 12:05:14 +1100 (EST)
Received: from mx11.stngva01.us.mxservers.net (204.202.242.100)
	by mail19d.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id
	2-0782859912 for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Jan 2007 20:05:12 -0500 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: FW: Boot w/ VGA console - PCI nvidia
Date: Fri, 26 Jan 2007 17:05:09 -0800
Message-ID: <000001c741af$310ff4c0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C7416C.22ECB4C0"
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

------=_NextPart_000_0001_01C7416C.22ECB4C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

All,

 

I have finally got my linux kernel up and working and was able to log in via
the serial port, i.e. console=/dev/ttyS0, Using root file system over NFS.
Everything seems to work fine, thanks to Leo and Kumar for pointing me to
the right /git/ tree.

 

Next I have plugged in a nVidia GeForce FX5200 PCI card, and compiled in the
nvidafb driver.

I can see clearly the PCI card is being detected and the nvidiafb driver is
being registerd, it can even detect the monitor I have connected.

 

However, when I enabled the kernel to use the framer buffer console, by
compiling in that feature, it just 'seems' to hang after the console_init
call.

 

I know I am missing something with either a 'bootargs' variable, or perhaps
a mis-configured set of compile options, i.e. perhaps to many frame buffer
drivers inside the kernel that may conflict???

 

Does anyone have a 101 on how to enable basic 640x480 or 800x600 using
either the nvidiafb or perhaps a more rudimentary driver, vga only?

 

Thanks,

 

-Russ


------=_NextPart_000_0001_01C7416C.22ECB4C0
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
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
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
font-family:Arial'>All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have finally got my linux kernel up and working and =
was
able to log in via the serial port, i.e. console=3D/dev/ttyS0, Using =
root file
system over NFS. Everything seems to work fine, thanks to Leo and Kumar =
for
pointing me to the right /git/ tree.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Next I have plugged in a nVidia GeForce FX5200 PCI =
card, and
compiled in the nvidafb driver.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I can see clearly the PCI card is being detected and =
the
nvidiafb driver is being registerd, it can even detect the monitor I =
have
connected.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>However, when I enabled the kernel to use the framer =
buffer
console, by compiling in that feature, it just &#8216;seems&#8217; to =
hang
after the console_init call.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I know I am missing something with either a
&#8216;bootargs&#8217; variable, or perhaps a mis-configured set of =
compile
options, i.e. perhaps to many frame buffer drivers inside the kernel =
that may
conflict???<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Does anyone have a 101 on how to enable basic 640x480 =
or
800x600 using either the nvidiafb or perhaps a more rudimentary driver, =
vga
only?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-Russ<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01C7416C.22ECB4C0--
