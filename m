Return-Path: <aaronleefly@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.190])
	by ozlabs.org (Postfix) with ESMTP id 9CC7DDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 01:51:49 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j67so212349rne.16
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Feb 2009 06:51:48 -0800 (PST)
From: "Li Jun (Aaron)" <aaronleefly@gmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: linux2.6.23-rc2 enable APU for ppc405
Date: Thu, 5 Feb 2009 22:51:39 +0800
Message-ID: <001701c987a1$41c4f100$c54ed300$@com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0018_01C987E4.4FE83100"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.

------=_NextPart_000_0018_01C987E4.4FE83100
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Anybody can help? Thanks a lot!

 

Hi,

I am now using impulse c and xilinx virtex4 ml403 board to do a project.

And I want to run the application through APU in the linux environment.

 

So I need to enable the apu for the linux 2.6.23-rc kernel. Then use cross
compiler(crosstool-0.43) to make zImage.

 

Does anybody have patch for linux 2.6 to enable apu/fpu? Or any guide for
this?

 

I am a new guy in this field, hope can get help!

 

Thanks very much!

 

Best regards,

Li Jun

 


------=_NextPart_000_0018_01C987E4.4FE83100
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'color:#1F497D'>Anybody =
can help? Thanks
a lot!<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dleft style=3D'text-align:left'><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Hi,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:"Verdana","sans-serif";
color:#222222'>I am now using impulse c and xilinx virtex4 ml403 board =
to do a
project.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:"Verdana","sans-serif";
color:#222222'>And I want to run the application through APU in the =
linux
environment.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:"Verdana","sans-serif";
color:#222222'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:"Verdana","sans-serif";
color:#222222'>So I need to enable the apu for the linux 2.6.23-rc =
kernel. Then
use cross compiler(crosstool-0.43) to make zImage.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:"Verdana","sans-serif";
color:#222222'>&nbsp;<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:"Verdana","sans-serif";
color:#222222'>Does anybody have patch for linux 2.6 to enable apu/fpu? =
Or any
guide for this?<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:"Verdana","sans-serif";
color:#222222'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:"Verdana","sans-serif";
color:#222222'>I am a new guy in this field, hope can get =
help!<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:"Verdana","sans-serif";
color:#222222'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span lang=3DEN-US
style=3D'font-size:9.0pt;font-family:"Verdana","sans-serif";color:#222222=
'>Thanks
very much!</span><span lang=3DEN-US><o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Best =
regards,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Li Jun<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

</div>

</body>

</html>

------=_NextPart_000_0018_01C987E4.4FE83100--
