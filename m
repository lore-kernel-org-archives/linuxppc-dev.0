Return-Path: <srideep.devireddy@wipro.com>
Received: from wip-cdctls-mx3.wipro.com (wip-cdctls-mx3.wipro.com
	[203.91.201.23])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-cdctls-mx3.wipro.com",
	Issuer "wip-cdctls-mx3.wipro.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DFB7968714
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Nov 2005 07:05:52 +1100 (EST)
Received: from wip-cdctls-mx3.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 0DF7529C004
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Nov 2005 01:35:47 +0530 (IST)
Received: from chn-snr-bh2.wipro.com (chn-snr-bh2.wipro.com [10.145.50.92])
	by wip-cdctls-mx3.wipro.com (Postfix) with ESMTP id 00A5229C002
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Nov 2005 01:35:46 +0530 (IST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5E6FB.4DAE17B1"
Date: Sat, 12 Nov 2005 01:35:57 +0530
Message-ID: <6AD9F6A5F6E096408F0B703773355A07605E5D@CHN-SNR-MBX01.wipro.com>
From: <srideep.devireddy@wipro.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC8272 + kernel 
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

------_=_NextPart_001_01C5E6FB.4DAE17B1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi Sir ,

=0D

      With the help of mailing list I am able to get my u-boot 1.1.3
version ... right held up with kernel

....

I am able to boot my MPC8272ADS  with u-boot 1.1.3 version . how can
build my uImaze(compressed linux image so that I can boot it ) ,what are
the options .. I got the source from Montavista BSP for MPC 8272 .. so
can  you guide me in making a compressed image so that I can boot my
Linux kernel .

=0D

As of now I am getting and error of=0D

=0D

## Booting image at 01000000 ...

=0D

   Image Name:   Linux-2.4.22

=0D

   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

=0D

   Data Size:    782360 Bytes =3D 764 kB

=0D

   Load Address: 00000000

=0D

   Entry Point:  00000000

=0D

   Verifying Checksum ... OK

=0D

   Uncompressing Kernel Image ... OK

=0D

=0D

That's it ... kernel hangs .. why is this ? can you kindly help me
resolving in the issue=0D

=0D

=0D

Best Regards

=0D





Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
------_=_NextPart_001_01C5E6FB.4DAE17B1
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=
=3D"urn:schemas-microsoft-com:office:office" xmlns:w=
=3D"urn:schemas-microsoft-com:office:word" xmlns=
=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3Dus-ascii">
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
	color:black;}
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

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Hi Sir=
 ,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; With the help of
mailing list I am able to get my u-boot 1.1.3 version &#8230; right held up
with kernel<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'>&#8230;.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>I am able to boot my
MPC8272ADS&nbsp; with u-boot 1.1.3 version . how can build my=
 uImaze(compressed
linux image so that I can boot it ) ,what are the options .. I got the=
 source
from Montavista BSP for MPC 8272 .. so can&nbsp; you guide me in making a=
 compressed
image so that I can boot my Linux kernel .<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>As of now I am getting=
 and
error of <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>## Booting image at=
 01000000
...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp; Image=
 Name:&nbsp;&nbsp;
Linux-2.4.22<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp; Image=
 Type:&nbsp;&nbsp; PowerPC
Linux Kernel Image (gzip compressed)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp; Data=
 Size:&nbsp;&nbsp;&nbsp; 782360
Bytes =3D 764 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp; Load=
 Address: 00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp; Entry=
 Point:&nbsp; 00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp; Verifying=
 Checksum ... OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;=
 Uncompressing Kernel
Image ... OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>That&#8217;s it ...=
 kernel
hangs .. why is this ? can you kindly help me resolving in the issue=
 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier=
 New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Best=
 Regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><br>
<br>
Confidentiality Notice <br>
<br>
The information contained in this electronic message and any attachments to=
 this message are intended<br>
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If<br>
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately<br>
and destroy all copies of this message and any attachments.<br>
</font></td></tr></table>
------_=_NextPart_001_01C5E6FB.4DAE17B1--
