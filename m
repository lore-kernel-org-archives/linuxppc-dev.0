Return-Path: <zhangsb@rcs-9000.com>
Received: from RCS-9000.COM (unknown [218.94.131.104])
	by ozlabs.org (Postfix) with ESMTP id C22FC67BA3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Jul 2006 18:16:25 +1000 (EST)
From: "zhangshaobo" <zhangsb@rcs-9000.com>
To: <linuxppc-dev@ozlabs.org>
Subject: RE: Problems of Compiling Kernel with linux-2.4.27 and linux-2.6.17
	for PowerPC405EP Board (Gerhard Jaeger)
Date: Thu, 13 Jul 2006 16:14:20 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000E_01C6A697.65BEBF70"
Message-Id: <200607131620390.SM01172@stridenote>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_000E_01C6A697.65BEBF70
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

gvb mention that  "machine check exception" is caused by memory map problems
which lead to bus error , now I meet a problem under MPC5200, there is a
peripherally pci netcard named "e100" , when application to use it,
sometimes system will enter into machine check .

would you meet the same problem, can you give me a more detail ?

thanks!


------=_NextPart_000_000E_01C6A697.65BEBF70
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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
	{font-family:&#23435;&#20307;;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@&#23435;&#20307;";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
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
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>gvb mention that &nbsp;&#8220;machine check =
exception&#8221; is
caused by memory map problems which lead to bus error , now I meet a =
problem
under MPC5200, there is a peripherally pci netcard named =
&#8220;e<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"100"
UnitName=3D"&#8221;" w:st=3D"on">100&#8221;</st1:chmetcnv> , when =
application to use it,
sometimes system will enter into machine check =
.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>would you meet the same problem, can you give =
me a more
detail ?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>thanks!<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_000E_01C6A697.65BEBF70--
