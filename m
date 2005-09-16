Return-Path: <JohnsonCheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.27])
	by ozlabs.org (Postfix) with SMTP id C25356828C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Sep 2005 13:28:12 +1000 (EST)
From: "JohnsonCheng" <JohnsonCheng@qnap.com.tw>
To: "linux-ppc-embedded" <linuxppc-embedded@ozlabs.org>
Date: Fri, 16 Sep 2005 11:28:09 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_020F_01C5BAB1.B79462A0"
Message-Id: <20050916032812.C25356828C@ozlabs.org>
Subject: A mtd timeout issue on ppc
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

------=_NextPart_000_020F_01C5BAB1.B79462A0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

The size of initrd.boot is about 8.5M, then

dd if=initrd.boot of=/dev/mtd2, cause

  MTD do_write_buffer(): software timeout

  dd: /dev/mtd2: Input/output error

 

When I change the size of initrd.boot to about 2M, it's OK. 

But this 8.5M file can transit by U-boot.

Why ?? Is kernel issue or MTD utility issue ?

 

Thanks,

Johnson Cheng


------=_NextPart_000_020F_01C5BAB1.B79462A0
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
 name=3D"chmetcnv" downloadurl=3D""/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
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
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:18.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-TW link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:18.0pt'>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>The size of initrd.boot is about <st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"8.5" UnitName=3D"m"
w:st=3D"on">8.5M</st1:chmetcnv>, then<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>dd if=3Dinitrd.boot of=3D/dev/mtd2, =
cause<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; MTD do_write_buffer(): software =
timeout<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; dd: /dev/mtd2: Input/output =
error<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>When I change the size of initrd.boot to about =
<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"2"
UnitName=3D"m" w:st=3D"on">2M</st1:chmetcnv>, it&#8217;s OK. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>But this <st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"8.5" UnitName=3D"m" =
w:st=3D"on">8.5M</st1:chmetcnv>
file can transit by U-boot.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Why ?? Is kernel issue or MTD utility issue =
?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Johnson Cheng<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_020F_01C5BAB1.B79462A0--
