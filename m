Return-Path: <lacrimosa02@sina.com>
Received: from smtp.sina.com.cn (smtp.sina.com.cn [202.108.3.233])
	by ozlabs.org (Postfix) with ESMTP id C40FFDDE33
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 12:19:22 +1000 (EST)
Received: from neukxpax3m59t7 (unknown [58.154.193.229])
	by smtp.sina.com.cn (SINAMAIL) with ESMTP id B74DE3B6B10
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 10:19:13 +0800 (CST)
From: =?gb2312?B?zfXW2A==?= <lacrimosa02@sina.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.3.1192500005.32221.linuxppc-embedded@ozlabs.org>
Subject: Re: aty128fb PCI card on ppc 405ep taihu board
Date: Thu, 18 Oct 2007 10:19:09 +0800
Message-ID: <6E33812279E8474394974D11898C2BE2@neukxpax3m59t7>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0003_01C81170.54846030"
In-Reply-To: <mailman.3.1192500005.32221.linuxppc-embedded@ozlabs.org>
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

------=_NextPart_000_0003_01C81170.54846030
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

Thanks Bill and thanks Wolfgang! VGA BIOS is the problem. I use scitechsoft
videoboot to initialize the card. Videoboot is based on scitechsoft x86emu
which could run x86 code on other platforms. Now I successfully initialized
the card and get the framebuffer information. But the monitor still gets NO
SIGNAL through the card.

 

Serial console shows framebuffer is enabled: 

 

     videoboot: Booting PCI video card bus 0, function 0, device 6

     aty128fb: Found Intel x86 BIOS ROM Image

     aty128fb: Rage128 BIOS located

     aty128fb: Rage128 RK PCI [chip rev 0x2] 32M 64-bit SDR SGRAM (2:1)

     fb0: ATY Rage128 frame buffer device on Rage128 RK PCI

 

Some information I get from framebuffer:

 

     id = ATY Rage128

     depth =  16

       smemlen = 33554432

       line_length = 0

       FB_TYPE_ = 0

     type_aux = 0

     FB_VISUAL_ = 3

     xpanstep = 8

     ypanstep = 1

     ywrapstep = 0

     mmio_start = bbffc0000d

     mmio_len = 8192

     accel = 32

     xres = 640

     yres = 480

     xres_virtul = 640

     yres_virtul = 480

     xoffset = 0

     yoffset = 0

     bits_per_pixel = 16

 


------=_NextPart_000_0003_01C81170.54846030
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chmetcnv"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:9.0pt;
	font-family:=CB=CE=CC=E5;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 126.65pt 72.0pt 126.65pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:
9.0pt'>Thanks Bill and thanks Wolfgang! VGA BIOS is the problem. I use =
scitechsoft
videoboot to initialize the card. Videoboot is based on scitechsoft =
x86emu
which could run x86 code on other platforms. Now I successfully =
initialized the
card and get the framebuffer information. But the monitor still gets NO =
SIGNAL
through the card.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:
9.0pt'>Serial console shows framebuffer is enabled: =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:
9.0pt'>&nbsp;&nbsp;&nbsp;&nbsp; </span><span lang=3DEN-US>videoboot: =
Booting PCI
video card bus 0, function 0, device 6<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:
9.0pt'>&nbsp;&nbsp;&nbsp;&nbsp; </span><span lang=3DEN-US>aty128fb: =
Found Intel
x86 BIOS ROM Image<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:
9.0pt'>&nbsp;&nbsp;&nbsp;&nbsp; </span><span lang=3DEN-US>aty128fb: =
Rage128 BIOS
located<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:
9.0pt'>&nbsp;&nbsp;&nbsp;&nbsp; </span><span lang=3DEN-US>aty128fb: =
Rage128 RK
PCI [chip rev 0x2] <st1:chmetcnv TCSC=3D"0" NumberType=3D"1" =
Negative=3D"False"
HasSpace=3D"False" SourceValue=3D"32" UnitName=3D"m" =
w:st=3D"on">32M</st1:chmetcnv>
64-bit SDR SGRAM (2:1)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:
9.0pt'>&nbsp;&nbsp;&nbsp;&nbsp; </span><span lang=3DEN-US>fb0: ATY =
Rage128 frame
buffer device on Rage128 RK PCI<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:
9.0pt'>Some information I get from =
framebuffer:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:
9.0pt'>&nbsp;&nbsp;&nbsp;&nbsp; </span><span lang=3DEN-US>id =3D ATY =
Rage128<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:
9.0pt'>&nbsp;&nbsp;&nbsp;&nbsp; </span><span lang=3DEN-US>depth =
=3D&nbsp; 16<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.5pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font><font
size=3D1 face=3D=CB=CE=CC=E5><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:=CB=CE=CC=E5'>smemlen
=3D 33554432<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.5pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font><font
size=3D1 face=3D=CB=CE=CC=E5><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:=CB=CE=CC=E5'>line_length
=3D 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.5pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font><font
size=3D1 face=3D=CB=CE=CC=E5><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:=CB=CE=CC=E5'>FB_TYPE_
=3D 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; type_aux =3D =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; FB_VISUAL_ =3D =
3<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; xpanstep =3D =
8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; ypanstep =3D =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; ywrapstep =3D =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; mmio_start =3D =
bbffc0000d<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span lang=3DES =
style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; mmio_len =3D =
8192<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span lang=3DES =
style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; accel =3D =
32<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span lang=3DES =
style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; xres =3D =
640<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span lang=3DES =
style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; yres =3D =
480<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; xres_virtul =3D =
640<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; yres_virtul =3D =
480<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; xoffset =3D =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; yoffset =3D =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US style=3D'font-size:9.0pt;
font-family:=CB=CE=CC=E5'>&nbsp;&nbsp;&nbsp;&nbsp; bits_per_pixel =3D =
16<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D=CB=CE=CC=E5><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0003_01C81170.54846030--
