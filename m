Return-Path: <rmcguire@uwbt.com>
Received: from mail19e.g19.rapidsite.net (mail19e.g19.rapidsite.net
	[204.202.242.20]) by ozlabs.org (Postfix) with SMTP id F38A5DDECB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 23:49:41 +1100 (EST)
Received: from mx86.stngva01.us.mxservers.net (198.173.112.3)
	by mail19e.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id
	3-0156926578 for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 07:49:38 -0500 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC8360E Linux and 2.6.19.2
Date: Tue, 23 Jan 2007 04:49:25 -0800
Message-ID: <000301c73eec$ea489de0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0004_01C73EA9.DC255DE0"
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

------=_NextPart_000_0004_01C73EA9.DC255DE0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

All,

 

Trying to boot up / debug my board with a Rev 1.2 MPC8360E. 

After the kernel launches from U-boot I receive no serial debug, and the
system hangs.

 

I am running U-boot 1.1.6. Dirty <which does contains support for the 8360>,


 

I have walked through the DTS/blob file, after U-boot modifies it, <I turned
on all the debug info>, and can clearly see that the /chosen node, etc.. is
getting entered. My original DTS file already has all of the clock speeds
entered <modeled after the MPC8360xx.dts file that was already in the
DENX-2.6.19.2 kernel release>.

 

I have limited debug ability via some GPIO leds on our board, I can see that
the kernel starts to run and at least gets to the point where it clears all
the BATs <powerpc/boot/head_32.S and setup_32.c>, at which point I lose
access to the IO space and can no longer write out to the debug lights.
Unfortunately I do not have access to a COP debugger at this point. It
doesn't seem to get to the platform files, or at least I can get the GPIO
access inside the IMMR space to work correctly.

 

Does anyone have any suggestion per software only debug method that might be
enabled? Or a way to temporarily hack the early serial output so I can see
what is going on?

-Russ

 


------=_NextPart_000_0004_01C73EA9.DC255DE0
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
font-family:Arial'>All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Trying to boot up / debug my board with a Rev 1.2 =
MPC8360E. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>After the kernel launches from U-boot I receive no =
serial
debug, and the system hangs.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am running U-boot 1.1.6. Dirty &lt;which does =
contains
support for the 8360&gt;, <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have walked through the DTS/blob file, after U-boot
modifies it, &lt;I turned on all the debug info&gt;, and can clearly see =
that
the /chosen node, etc.. is getting entered. My original DTS file already =
has
all of the clock speeds entered &lt;modeled after the MPC8360xx.dts file =
that
was already in the DENX-2.6.19.2 kernel =
release&gt;.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have limited debug ability via some GPIO leds on =
our
board, I can see that the kernel starts to run and at least gets to the =
point
where it clears all the BATs &lt;powerpc/boot/head_32.S and =
setup_32.c&gt;, at
which point I lose access to the IO space and can no longer write out to =
the
debug lights. Unfortunately I do not have access to a COP debugger at =
this
point. It doesn&#8217;t seem to get to the platform files, or at least I =
can
get the GPIO access inside the IMMR space to work =
correctly.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Does anyone have any suggestion per software only =
debug
method that might be enabled? Or a way to temporarily hack the early =
serial output
so I can see what is going on?<o:p></o:p></span></font></p>

<p><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>-Russ</span></font><o:p></o:=
p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0004_01C73EA9.DC255DE0--
