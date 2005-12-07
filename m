Return-Path: <kabinchou@mcdigitsz.com>
Received: from hk31.infolinknet.com (unknown [202.83.221.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5834D6886E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 16:18:40 +1100 (EST)
Received: from zhoujun ([219.134.52.50]) (authenticated bits=0)
	by hk31.infolinknet.com (8.12.11/8.12.11) with ESMTP id jB749WnD003182
	for <linuxppc-embedded@ozlabs.org>; Wed, 7 Dec 2005 12:09:37 +0800
Message-Id: <200512070409.jB749WnD003182@hk31.infolinknet.com>
From: "zhouzao" <kabinchou@mcdigitsz.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 7 Dec 2005 12:05:00 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0004_01C5FB26.8A342790"
Subject: Problem with customized MPC5200 board(copy from lite5200 design)
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

------=_NextPart_000_0004_01C5FB26.8A342790
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello:
      Yeo Kee Wee!
      Can you resolve the problem on lite5200 or MPC5200 on your board?
      The same problem is puzzling for me, But I kwon where is problem, the
cause is that U-boot has working on the lite5200 before BDI2000 control the
CPU, U-boot has init MPC5200.If you set the BDI2000 waiting time as reset in
the cfg file, you will find the same error on the lite5200!
     
        Best regard!
 
 

Kabin chou

2005-12-7


------=_NextPart_000_0004_01C5FB26.8A342790
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
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

<div class=3DSection1><pre><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Hello:<o:p></o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yeo Kee =
Wee!<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Can you =
resolve the problem on lite5200 or MPC5200 on your =
board?<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The same =
problem is puzzling for me, But I kwon where is problem, the cause is =
that U-boot has working on the lite5200 before BDI2000 control the CPU, =
U-boot has init MPC5200.If you set the BDI2000 waiting time as reset in =
the cfg file, you will find the same error on the =
lite5200!<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp; =
<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Best regard!<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre>

<div =
style=3D'mso-element:para-border-div;border:none;border-bottom:solid =
windowtext 1.0pt;
padding:0in 0in 1.0pt 0in'><pre style=3D'border:none;padding:0in'><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre></div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Kabin chou<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>2005-12-7<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0004_01C5FB26.8A342790--
