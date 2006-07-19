Return-Path: <Chad.Rowan@thyssenkrupp.com>
Received: from mail003.thyssenkrupp.com (mail003.thyssenkrupp.com
	[149.211.153.64])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEDD367B76
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 05:00:33 +1000 (EST)
Received: from srv879.thyssen.com (srv879.thyssen.com [149.206.119.109])
	by mail003.thyssenkrupp.com (8.13.6/8.13.6) with ESMTP id
	k6JJ0HLR001615
	for <linuxppc-embedded@ozlabs.org>; Wed, 19 Jul 2006 21:00:23 +0200
Received: from localhost (localhost [127.0.0.1])
	by srv879.thyssen.com (Postfix) with ESMTP id 51D6316723
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jul 2006 21:00:13 +0200 (CEST)
Received: from mdcexc03.na.ops.local (unknown [66.194.145.37])
	by srv879.thyssen.com (Postfix) with ESMTP id D5E0A16717
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jul 2006 21:00:12 +0200 (CEST)
Message-ID: <86EC6E02268B3D4BA41C1B0C61FB14E60B3C8314@mdcexc01.na.ops.local>
From: "Rowan, Chad" <Chad.Rowan@thyssenkrupp.com>
To: linuxppc-embedded@ozlabs.org
Subject: export-objs in spi Makefile broke in latest linuxppc_2_4_devel?
Date: Wed, 19 Jul 2006 14:01:41 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6AB65.C5201AE0"
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

------_=_NextPart_001_01C6AB65.C5201AE0
Content-Type: text/plain

Shouldn't export-objs in drivers\spi be:

            export-objs := spi-core.o spi-algo-mpc5xxx.o
spi-algo-mpc5xxx-psc.o \
               spi-iti5200.o spi-eval.o

 

instead of:

            export-objs := spi-core.o spi-algo-mpc5xxx.o
spi-algo-mpc5200psc.o \
               spi-iti5200.o spi-eval.o

            



 


------_=_NextPart_001_01C6AB65.C5201AE0
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
 /* Font Definitions */
 @font-face
	{font-family:Fixedsys;
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
font-family:Arial'>Shouldn&#8217;t export-objs in drivers\spi =
be:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font><font
size=3D2 face=3DFixedsys><span =
style=3D'font-size:10.0pt;font-family:Fixedsys'>export-objs :=3D
spi-core.o spi-algo-mpc5xxx.o <u>spi-algo-mpc5xxx-psc</u>.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;
spi-iti5200.o spi-eval.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DFixedsys><span
style=3D'font-size:10.0pt;font-family:Fixedsys'><o:p>&nbsp;</o:p></span>=
</font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>instead =
of:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font><font
size=3D2 face=3DFixedsys><span =
style=3D'font-size:10.0pt;font-family:Fixedsys'>export-objs :=3D
spi-core.o spi-algo-mpc5xxx.o <u>spi-algo-mpc5200psc</u>.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;
spi-iti5200.o spi-eval.o</span></font><font size=3D2 face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></=
p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font><font
size=3D2 face=3DFixedsys><span =
style=3D'font-size:10.0pt;font-family:Fixedsys'><br>
<br>
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6AB65.C5201AE0--
