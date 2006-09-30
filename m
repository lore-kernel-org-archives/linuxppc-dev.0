Return-Path: <baying@utstar.com>
Received: from hzvscan2.utstar.com.cn (hzvscan2.utstar.com.cn [218.109.8.16])
	by ozlabs.org (Postfix) with ESMTP id AFD8C67B9B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Sep 2006 15:19:33 +1000 (EST)
Received: from CNMAIL11.cn.utstarcom.com ([172.18.22.155])
	by bat.utstar.com.cn  with SMTP id k8U4sABO004461
	for <linuxppc-embedded@ozlabs.org>; Sat, 30 Sep 2006 12:54:10 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E44E.AC289F93"
Subject: extern struct module __this_module
Date: Sat, 30 Sep 2006 13:09:57 +0800
Message-ID: <90625507C4259B4CBF2FBDC3CF0AB3DC01699214@CNMAIL12.cn.utstarcom.com>
From: "Ba Ying" <baying@utstar.com>
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

------_=_NextPart_001_01C6E44E.AC289F93
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

A newbies here.

I think when a module is loaded into linux kernel,a extern variable
called __this_module will be assigned

for this module.My question is how kernel can identify each module using
the same name since all the modules

and the kernel are in the same kernel space?

Thanks.


------_=_NextPart_001_01C6E44E.AC289F93
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
	font-family:&#23435;&#20307;;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
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

<p class=3DMsoNormal><font size=3D2 face=3D&#23435;&#20307;><span =
lang=3DEN-US style=3D'font-size:11.0pt;
font-family:&#23435;&#20307;'>A newbies =
here.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#23435;&#20307;><span =
lang=3DEN-US style=3D'font-size:11.0pt;
font-family:&#23435;&#20307;'>I think when a module is loaded into linux =
kernel,a extern
variable called __this_module will be =
assigned<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#23435;&#20307;><span =
lang=3DEN-US style=3D'font-size:11.0pt;
font-family:&#23435;&#20307;'>for this module.My question is how kernel =
can identify each
module using the same name since all the =
modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#23435;&#20307;><span =
lang=3DEN-US style=3D'font-size:11.0pt;
font-family:&#23435;&#20307;'>and the kernel are in the same kernel =
space?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D&#23435;&#20307;><span =
lang=3DEN-US style=3D'font-size:11.0pt;
font-family:&#23435;&#20307;'>Thanks.<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6E44E.AC289F93--
