Return-Path: <Chad.Rowan@thyssenkrupp.com>
Received: from mail004.thyssenkrupp.com (mail004.thyssenkrupp.com
	[149.211.153.66])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 17DF567B17
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 05:05:31 +1000 (EST)
Received: from srv880.thyssen.com (srv880.thyssen.com [149.206.119.110])
	by mail004.thyssenkrupp.com (8.13.6/8.13.6) with ESMTP id
	k5RIbmpb022319
	for <linuxppc-embedded@ozlabs.org>; Tue, 27 Jun 2006 20:37:52 +0200
Received: from localhost (localhost [127.0.0.1])
	by srv880.thyssen.com (Postfix) with ESMTP id 59E55155B4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 20:37:44 +0200 (CEST)
Received: from mdcexc03.na.ops.local (tkeweb06.thyssenkruppelevator.com
	[66.194.145.37])
	by srv880.thyssen.com (Postfix) with ESMTP id 07710155AC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 20:37:43 +0200 (CEST)
Message-ID: <86EC6E02268B3D4BA41C1B0C61FB14E60AFCD219@mdcexc01.na.ops.local>
From: "Rowan, Chad" <Chad.Rowan@thyssenkrupp.com>
To: linuxppc-embedded@ozlabs.org
Subject: Lite5200 MTD partitions in 2.6 build
Date: Tue, 27 Jun 2006 13:38:25 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C69A18.E03C7930"
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

------_=_NextPart_001_01C69A18.E03C7930
Content-Type: text/plain

In the 2.4 build I had to modify icecube.c in /linux/drivers/mtd/maps/ to
specify the u-boot, kernel image, and root fs partitions.  Icecube.c doesn't
exist in the 2.6 drop.  I got the top of the tree from the denx git
yesterday.  How do you config the partitions for the 2.6 kernel?

 

Thanks,
Chad


------_=_NextPart_001_01C69A18.E03C7930
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
font-family:Arial'>In the 2.4 build I had to modify icecube.c in
/linux/drivers/mtd/maps/ to specify the u-boot, kernel image, and root =
fs
partitions. &nbsp;Icecube.c doesn&#8217;t exist in the 2.6 drop.&nbsp; =
I got
the top of the tree from the denx git yesterday. &nbsp;How do you =
config the
partitions for the 2.6 kernel?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<br>
Chad<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C69A18.E03C7930--
