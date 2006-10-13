Return-Path: <kwkang@pontusys.com>
Received: from bLinux.pontusys.com (unknown [221.145.251.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04FC067C29
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 17:06:48 +1000 (EST)
Received: from bigskang (william.pontusys.com [192.168.0.27])
	by bLinux.pontusys.com (8.12.8/8.12.8) with ESMTP id k9D6r0Jq028482
	for <linuxppc-embedded@ozlabs.org>; Fri, 13 Oct 2006 15:53:01 +0900
Message-Id: <200610130653.k9D6r0Jq028482@bLinux.pontusys.com>
From: "kwkang" <kwkang@pontusys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: unresolved symbol on target ... while insmod
Date: Fri, 13 Oct 2006 15:49:14 +0900
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_002B_01C6EEDF.22933BF0"
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

------=_NextPart_000_002B_01C6EEDF.22933BF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Srideep,

 

Can anyone show me how I can overcome below problem?

I have searched mailing list but I can not find any answer for that problem.

 

[test ~]#insmod linux-kernel-bde.o 

Using linux-kernel-bde.o

Using linux-kernel-bde.o

insmod: Warning: kernel-module version mismatch

        linux-kernel-bde.o was compiled for kernel version 2.4.20_dev

        while this kernel is version 2.4.21-pre5

insmod: unresolved symbol devfs_register

insmod: unresolved symbol devfs_unregister

 

Thanks.

William.


------=_NextPart_000_002B_01C6EEDF.22933BF0
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
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:Gulim;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:GulimChe;
	panose-1:2 11 6 9 0 1 1 1 1 1;}
@font-face
	{font-family:Gulim;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:GulimChe;
	panose-1:2 11 6 9 0 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-autospace:none;
	word-break:break-hangul;
	font-size:10.0pt;
	font-family:Batang;}
h1
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:24.0pt;
	font-family:Gulim;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
pre
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:GulimChe;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Gulim;
	color:windowtext;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:99.25pt 3.0cm 3.0cm 3.0cm;
	layout-grid:18.0pt;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1481921397;
	mso-list-template-ids:207785204;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1
	{mso-list-id:1943997518;
	mso-list-template-ids:1678000630;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DKO link=3Dblue vlink=3Dpurple>

<div class=3DSection1 style=3D'layout-grid:18.0pt'>

<p class=3DMsoNormal><font size=3D2 face=3D&#48148;&#53461;><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>Hi Srideep,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#48148;&#53461;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#48148;&#53461;><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>Can anyone show me how I can overcome below =
problem?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#48148;&#53461;><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>I have searched mailing list but I can not =
find any
answer for that problem.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#44404;&#47548;><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Gulim'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#44404;&#47548;><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Gulim'>[test ~]#insmod =
linux-kernel-bde.o <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#44404;&#47548;><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Gulim'>Using =
linux-kernel-bde.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#44404;&#47548;><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Gulim'>Using =
linux-kernel-bde.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#44404;&#47548;><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Gulim'>insmod: Warning: =
kernel-module
version mismatch<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#44404;&#47548;><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
linux-kernel-bde.o was compiled for kernel version =
2.4.20_dev<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#44404;&#47548;><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Gulim'>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
while this kernel is version 2.4.21-pre5<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#44404;&#47548;><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Gulim'>insmod: unresolved symbol
devfs_register<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#44404;&#47548;><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Gulim'>insmod: unresolved symbol
devfs_unregister<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#44404;&#47548;><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Gulim'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#44404;&#47548;><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Gulim'>Thanks.<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#44404;&#47548;><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Gulim'>William.<o:p></o:p></span></=
font></p>

</div>

</body>

</html>

------=_NextPart_000_002B_01C6EEDF.22933BF0--
