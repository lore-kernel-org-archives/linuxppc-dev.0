Return-Path: <venkatakrishnap@vrindatech.com>
Received: from server.indiadomain.com (server.indiadomain.com [69.50.220.104])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82B33DDEDD
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Sep 2008 22:19:05 +1000 (EST)
Received: from [122.169.178.91] (helo=venkatakrishna)
	by server.indiadomain.com with esmtpa (Exim 4.69)
	(envelope-from <venkatakrishnap@vrindatech.com>) id 1KhkNY-00018B-DD
	for linuxppc-embedded@ozlabs.org; Mon, 22 Sep 2008 05:19:01 -0700
From: "VenkataKrishna" <venkatakrishnap@vrindatech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linux problem in mpc8260
Date: Mon, 22 Sep 2008 17:37:24 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0003_01C91CD9.E2B985E0"
Message-Id: <20080922121905.82B33DDEDD@ozlabs.org>
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

------=_NextPart_000_0003_01C91CD9.E2B985E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 

Hi,

 

 In our target board have two banks of flash device. Which is connected two
Chip select 0(CS0) and Chip select 1 (CS1). In Hardware our target board has
specialty   jumper setting change CS0 VsCS1. Booting device always connected
CS0. What is our problem is I want download my Linux uImage in one of flash
device in my board when change jumper setting in hardware the board should
be boot .Board  is Powerpc based processor (MPC8260). Any one suggest me
what can I do. Where can I initialization memory device. 

 

Thanks and Regards

Venkatakrishna Pari


------=_NextPart_000_0003_01C91CD9.E2B985E0
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
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;In our target board have two banks of flash =
device. Which
is connected two Chip select 0(CS0) and Chip select 1 (CS1). In Hardware =
our
target board has specialty&nbsp;&nbsp; jumper setting change CS0 VsCS1. =
Booting
device always connected CS0. What is our problem is I want download my =
Linux
uImage in one of flash device in my board when change jumper setting in
hardware the board should be boot .Board &nbsp;is Powerpc based =
processor (MPC8260).
Any one suggest me what can I do. Where can I initialization memory =
device. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks and Regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Venkatakrishna Pari<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0003_01C91CD9.E2B985E0--
