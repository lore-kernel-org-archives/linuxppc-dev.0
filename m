Return-Path: <rmcguire@uwbt.com>
Received: from mail19i.g19.rapidsite.net (mail19i.g19.rapidsite.net
	[204.202.242.121]) by ozlabs.org (Postfix) with SMTP id 98EC6DDF2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Jan 2007 17:08:44 +1100 (EST)
Received: from mx31.stngva01.us.mxservers.net (204.202.242.105)
	by mail19i.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id
	1-0213741646 for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Jan 2007 01:07:27 -0500 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: 8360 UCC_GETH INIT_WORK compile error
Date: Thu, 25 Jan 2007 22:07:24 -0800
Message-ID: <000301c74110$40d7b8b0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0004_01C740CD.32B478B0"
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

------=_NextPart_000_0004_01C740CD.32B478B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Kumar / ALL,

 

I was having problems compiling the UCC_GETH driver for 8360.

INIT_WORK declared with 2 parameters instead of 3.

 

Googling around, I noticed that somebody posted a temporary patch back in
December 14, 2006.

 

Has this been resolved?

I am not able to boot the 2.6.19.2 Kernel the moment since the Ethernet/UCCF
driver won't compile.

 

-Russ


------=_NextPart_000_0004_01C740CD.32B478B0
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
font-family:Arial'>Kumar / ALL,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I was having problems compiling the UCC_GETH driver =
for 8360.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>INIT_WORK declared with 2 parameters instead of =
3.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Googling around, I noticed that somebody posted a =
temporary
patch back in December 14, 2006.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Has this been resolved?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am not able to boot the 2.6.19.2 Kernel the moment =
since the
Ethernet/UCCF driver won&#8217;t compile.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>-Russ<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0004_01C740CD.32B478B0--
