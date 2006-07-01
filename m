Return-Path: <hamidm@cyberwatch-security.com>
Received: from mail11c.verio-web.com (mail11c.verio-web.com [204.202.242.55])
	by ozlabs.org (Postfix) with SMTP id DC61A679FD
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  2 Jul 2006 06:13:26 +1000 (EST)
Received: from mx27.stngva01.us.mxservers.net (204.202.242.104)
	by mail11c.verio-web.com (RS ver 1.0.95vs) with SMTP id 4-0617894404
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Jul 2006 16:06:45 -0400 (EDT)
From: "Hamid Marshall" <hamidm@cyberwatch-security.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Booting 2.4 RT-Linux build from FSMlabs
Date: Sat, 1 Jul 2006 13:06:50 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001E_01C69D0F.380352D0"
Message-ID: <20060701160645.GA61789@mail11c.verio-web.com>
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

------=_NextPart_000_001E_01C69D0F.380352D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I am working on a Lite5200B board with the U-Boot build dated April-2006.
After loading of the uImage file which is 2.4 kernel RT-Linux build from FSM
labs the board get hang up right after the decompressing the kernel, never
getting to mach(). I looked at the memory dumps and with logic analyzer
peeked at the address bus as well. Look like after the decompressing the
kernel there is no entry to the main or init modules.

 

Has anyone encounter this problem before?

 

Thanks,

 

 

## Booting image at 00200000 ...
   Image Name:   Linux-2.6.16-rc1
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    658050 Bytes = 642.6 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

 

 

 

 

Hamid Marshall

 

Cyberwatch Communication

http://www.cyberwatch-security.com

 


------=_NextPart_000_001E_01C69D0F.380352D0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
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
p.MsoAutoSig, li.MsoAutoSig, div.MsoAutoSig
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle19
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
font-family:Arial'>I am working on a Lite5200B board with the U-Boot =
build
dated April-2006. After loading of the uImage file which is 2.4 kernel =
RT-Linux
build from FSM labs the board get hang up right after the decompressing =
the
kernel, never getting to mach(). I looked at the memory dumps and with =
logic
analyzer peeked at the address bus as well. Look like after the =
decompressing
the kernel there is no entry to the main or init =
modules.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Has anyone encounter this problem =
before?<o:p></o:p></span></font></p>

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
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<pre><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>## Booting image at 00200000 =
...<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-2.6.16-rc1<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC =
Linux Kernel Image (gzip =
compressed)<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; =
658050 Bytes =3D 642.6 kB<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp; Load Address: =
00000000<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp; Entry Point:&nbsp; =
00000000<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp; Verifying Checksum ... =
OK<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp; Uncompressing Kernel Image ... =
OK<o:p></o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoAutoSig><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoAutoSig><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoAutoSig><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Hamid <st1:City w:st=3D"on"><st1:place =
w:st=3D"on">Marshall</st1:place></st1:City><o:p></o:p></span></font></p>

<p class=3DMsoAutoSig><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoAutoSig><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Cyberwatch Communication<o:p></o:p></span></font></p>

<p class=3DMsoAutoSig><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>http://www.cyberwatch-security.com<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_001E_01C69D0F.380352D0--
