Return-Path: <robert.wood@gefanuc.com>
Received: from ext-nj2ut-5.online-age.net (ext-nj2ut-5.online-age.net
	[64.14.54.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A0254DE316
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Mar 2008 02:56:16 +1100 (EST)
Received: from int-nj2ut-4.online-age.net (int-nj2ut-4.online-age.net
	[3.159.237.73])
	by ext-nj2ut-5.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m2DFloqU007590
	for <linuxppc-embedded@ozlabs.org>; Thu, 13 Mar 2008 11:47:50 -0400
Received: from ALPMLEF02.e2k.ad.ge.com (int-nj2ut-4.online-age.net
	[3.159.237.73])
	by int-nj2ut-4.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m2DFll8R012021
	for <linuxppc-embedded@ozlabs.org>; Thu, 13 Mar 2008 11:47:48 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C88521.8D72DCC8"
Subject: Using GDB with Abatron's BDI2000 and the ppc405 in the Xilinx Virtex
	II Pro
Date: Thu, 13 Mar 2008 11:47:33 -0400
Message-ID: <0F3B2CB6574F1A488E62523706BF8A7703F295E7@LOUMLVEM03.e2k.ad.ge.com>
From: "Wood, Robert (GE EntSol,
	Intelligent Platforms)" <robert.wood@gefanuc.com>
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

------_=_NextPart_001_01C88521.8D72DCC8
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi, sorry for what is probably  previously covered subject., I am
searching the archives.

=20

We need a simple description of how to get GDB running with the BDI2000.
We have the '2000 communicating and can access the registers and like
through the telnet link but don't know how to configure the unit or GDB
to work together.

=20

Robert Wood

Senior Engineer

GE Fanuc Intelligent Platforms

=20

T +613 749 9241 x270

F +613 749 9461

E robert.wood@gefanuc.com

www.ge.com

=20

5430 Canotek Road

Ottawa, Ontario

Canada K1J 9G2

General Electric Company

=20

=20


------_=_NextPart_001_01C88521.8D72DCC8
Content-Type: text/html;
	charset="US-ASCII"
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
 name=3D"country-region"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"State"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"Street"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"address"/>
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
font-family:Arial'>Hi, sorry for what is probably&nbsp; previously =
covered
subject., I am searching the archives.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>We need a simple description of how to get GDB =
running with
the BDI2000. We have the &#8216;2000 communicating and can access the =
registers
and like through the telnet link but don&#8217;t know how to configure =
the unit
or GDB to work together.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><strong><b><font size=3D2 face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial'>Robert =
Wood</span></font></b></strong><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Senior Engineer</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>GE Fanuc Intelligent =
Platforms</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>T +613 749 9241 x270</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>F +613 749 9461</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>E <a =
href=3D"mailto:robert.wood@gefanuc.com">robert.wood@gefanuc.com</a></span=
></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><a =
href=3D"http://www.ge.com">www.ge.com</a></span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><st1:Street w:st=3D"on"><st1:address =
w:st=3D"on"><font size=3D2
  face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'>5430 =
Canotek Road</span></font></st1:address></st1:Street><o:p></o:p></p>

<p class=3DMsoNormal><st1:place w:st=3D"on"><st1:City w:st=3D"on"><font =
size=3D2
  face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Ottawa</span></font></st1:Ci=
ty><font
 size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>, <st1:State
 =
w:st=3D"on">Ontario</st1:State></span></font></st1:place><o:p></o:p></p>

<p class=3DMsoNormal><st1:country-region w:st=3D"on"><st1:place =
w:st=3D"on"><font
  size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Canada</span></font></st1:pl=
ace></st1:country-region><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> K1J =
9G2</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span =
style=3D'font-size:7.5pt;
font-family:Arial'>General Electric Company</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;</span><o:p></o:p></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C88521.8D72DCC8--
