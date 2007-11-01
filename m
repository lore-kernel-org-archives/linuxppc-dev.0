Return-Path: <mead@bnl.gov>
Received: from smtpout.bnl.gov (smtpout.bnl.gov [130.199.3.136])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0D66DDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 05:47:50 +1100 (EST)
Received: from smtpgateway3.bnl.local ([172.16.1.67] helo=smtpgateway.bnl.gov)
	by smtpout.bnl.gov with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(SMTP out virtual1) serial 1Inecr-0005hx-Gy
	for linuxppc-embedded@ozlabs.org; Thu, 01 Nov 2007 14:18:41 -0400
Received: from exchange2000-01.b459.bnl.gov ([130.199.74.94])
	by smtpgateway.bnl.gov with esmtp (bnl.gov SMTP on gw3)
	serial 1InecJ-0005Cz-AN
	for linuxppc-embedded@ozlabs.org; Thu, 01 Nov 2007 14:18:07 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C81CB3.8CF005AF"
Date: Thu, 1 Nov 2007 14:18:07 -0400
Message-ID: <D1AFFAE2CC4BD54CA4C1543CFF4A4FCC59788F@exchangemb3.bnl.gov>
From: "Mead, Joseph" <mead@bnl.gov>
To: <linuxppc-embedded@ozlabs.org>
Subject: 
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

------_=_NextPart_001_01C81CB3.8CF005AF
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am using a Xilinx ML403 board and created a custom IP that connects to
the PLB bus.   The PLB bus is 64 bits wide.   To communicate with the
custom IP I have been using iowrite32() and ioread32() function calls to
grab 32 bits at a time.  Is it possible to grab the full 64 bits in one
transfer?   I don't see an iowrite64() or ioread64() function...

=20

Thanks,
Joe=20

=20

=20


------_=_NextPart_001_01C81CB3.8CF005AF
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
font-family:Arial'>I am using a Xilinx ML403 board and created a custom =
IP that
connects to the PLB bus. &nbsp;&nbsp;The PLB bus is 64 bits =
wide.&nbsp;&nbsp; To communicate with
the custom IP I have been using iowrite32() and ioread32() function =
calls to
grab 32 bits at a time. &nbsp;Is it possible to grab the full 64 bits in =
one
transfer?&nbsp; &nbsp;I don&#8217;t see an iowrite64() or ioread64() =
function&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<br>
Joe <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C81CB3.8CF005AF--
