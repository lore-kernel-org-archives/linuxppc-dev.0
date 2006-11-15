Return-Path: <SRane@alphion.com>
Received: from alphion.com (unknown [66.147.184.82])
	by ozlabs.org (Postfix) with ESMTP id 1F55867CA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 01:33:34 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C708C1.56ED8136"
Subject: Processor reset and cache inhibit
Date: Wed, 15 Nov 2006 09:21:28 -0500
Message-ID: <8584FDC94AFF7640B17B8A89B23B19B36CEF45@sbsserver.AlphionCorp.local>
From: "Sachin Rane" <SRane@alphion.com>
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

------_=_NextPart_001_01C708C1.56ED8136
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

While reading PPC440 processor's User Manual, I came across following
lines:

"After processor reset, hardware automatically sets the caching
inhibited storage attribute for the memory

page containing the reset address, and also automatically flash
invalidates the instruction cache."

=20

Could you explain me why it is necessary to set the caching inhibit
storage attribute of the memory page containing the reset address?

=20

Thanks and Regards,

Sachin Rane


------_=_NextPart_001_01C708C1.56ED8136
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
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>While reading PPC440 processor&#8217;s User Manual, I =
came
across following lines:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&#8220;After processor =
reset,
hardware automatically sets the caching inhibited storage attribute for =
the
memory<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>page containing the reset =
address,
and also automatically flash invalidates the instruction =
cache.&#8220;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Could you explain me why it =
is
necessary to set the caching inhibit storage attribute of the memory =
page
containing the reset address?<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Thanks and =
Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Sachin =
Rane<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C708C1.56ED8136--
