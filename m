Return-Path: <lichang.che@nec.com.au>
Received: from ns2.nec.com.au (ns2.nec.com.au [147.76.180.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ns2.nec.com.au", Issuer "LS Root" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4C12B67B93
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 13:29:03 +1000 (EST)
Received: from smtp1.nec.com.au (unknown [172.31.8.18])
	by ns2.nec.com.au (Postfix) with ESMTP id 48A173B6A7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 13:09:39 +1000 (EST)
Received: from CARLCHENXPPSP2 ([147.76.211.191])
	by tns.neca.nec.com.au (8.12.8/8.12.8) with ESMTP id k8T3EvZl005768
	for <linuxppc-embedded@ozlabs.org>; Fri, 29 Sep 2006 13:14:57 +1000
From: "Lichang Che" <lichang.che@nec.com.au>
To: <linuxppc-embedded@ozlabs.org>
Subject: scc ethernet driver error - bus contention? 
Date: Fri, 29 Sep 2006 13:07:55 +1000
Message-ID: <000d01c6e374$757f5b30$bfd34c93@mul7.nec.com.au>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000E_01C6E3C8.472B6B30"
Reply-To: lichang.che@nec.com.au
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

------=_NextPart_000_000E_01C6E3C8.472B6B30
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

 

I'm using Linux 2.6.16 + uboot on MPC8250 - SMC2 for UART and SCC4 for 10M
Ethernet. The problem I got is as follows:

 

1. If the GBL bit is set (with address snooping), an underrun happens for
each frame transmission.

 

2. If the GBL bit is disabled, the underrun problem disappears but nearly
all frames are corrupted - the frame can be received (without CRC etc) by
another machine but the data is not correct.

 

3. If the frame to be sent is copied into the dual port ram first and the
transmission is triggered, the frame can be successfully received.

 

Can anyone give me some hint?

 

Cheers


------=_NextPart_000_000E_01C6E3C8.472B6B30
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
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
	{margin:0cm;
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
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1029" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-AU link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m using Linux 2.6.16 + uboot on MPC8250 - =
SMC2 for
UART and SCC4 for 10M Ethernet. The problem I got is as =
follows:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>1. If the GBL bit is set (with address snooping), an
underrun happens for each frame =
transmission.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>2. If the GBL bit is disabled, the underrun problem =
disappears
but nearly all frames are corrupted &#8211; the frame can be received =
(without
CRC etc) by another machine but the data is not =
correct.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>3. If the frame to be sent is copied into the dual =
port ram
first and the transmission is triggered, the frame can be successfully =
received.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Can anyone give me some =
hint?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Cheers<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_000E_01C6E3C8.472B6B30--
