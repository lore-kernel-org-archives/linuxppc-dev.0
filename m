Return-Path: <tim.martin@viasat.com>
Received: from annex.viasat.com (eagle.viasat.com [199.106.52.54])
	by ozlabs.org (Postfix) with ESMTP id DFA47688D1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Dec 2005 09:50:15 +1100 (EST)
Message-ID: <821B2170E9E7F04FA38DF7EC21DE4871022BB9A9@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 16 Dec 2005 14:34:44 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C60290.EA02EFDD"
Subject: POSIX High Resolution Timers in LinuxPPC 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C60290.EA02EFDD
Content-Type: text/plain

Could someone give me a brief history lesson on POSIX high resolution timers
(e.g. timer_create() function) implemented in the Linux kernel on the
PowerPC 405 architecture?  Specifically:

 

Confirm they are in the mainline 2.6 kernel now (e.g. kernel.org)?

 

Were they ever a part of the "mainline" 2.4 linuxppc kernel (e.g
ppc.bkbits.net)?

 

If no, were they ever available as a patch? The stuff at
sourceforge.net/projects/high-res-timers stops at 2.4.20 and looks like it
was only ever working for i386, not ppc.

 

Tim


------_=_NextPart_001_01C60290.EA02EFDD
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">


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
font-family:Arial'>Could someone give me a brief history lesson on =
POSIX high
resolution timers (e.g. timer_create() function) implemented in the =
Linux
kernel on the PowerPC 405 architecture?&nbsp; =
Specifically:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Confirm they are in the mainline 2.6 kernel now =
(e.g.
kernel.org)?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Were they ever a part of the &#8220;mainline&#8221; =
2.4
linuxppc kernel (e.g ppc.bkbits.net)?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>If no, were they ever available as a patch? The =
stuff at sourceforge.net/projects/high-res-timers
stops at 2.4.20 and looks like it was only ever working for i386, not =
ppc.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Tim<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C60290.EA02EFDD--
