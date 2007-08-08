Return-Path: <yoni.l@slyde-tech.com>
Received: from smtpin.livedns.co.il (smtpin.livedns.co.il [62.219.78.209])
	by ozlabs.org (Postfix) with ESMTP id 73B9BDDE48
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 01:27:21 +1000 (EST)
From: "Yoni Levin" <yoni.l@slyde-tech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: how the bytes ordered in mpc8313
Date: Wed, 8 Aug 2007 18:26:48 +0300
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0003_01C7D9E9.AF697580"
Message-ID: <CE785D12544843B49C5D1315CAE61C23.MAI@mail.livedns.co.il>
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

------=_NextPart_000_0003_01C7D9E9.AF697580
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I have mpc83xx,

I saw that I need to use swab32 to any read\write operation from registers,

I don't understand why I need it?

Do I need it for all registers?

Why in the mpc8313 reference in registers description some bits look like
31,30,29,.,3,2,1,0

And some: 0,1,2,3.,30,31

Is it just mistake? Or some registers are different then other? 


------=_NextPart_000_0003_01C7D9E9.AF697580
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
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:right;
	direction:rtl;
	unicode-bidi:embed;
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

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1 dir=3DRTL>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>I
have mpc83xx,<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>I
saw that I need to use swab32 to any read\write operation from =
registers,<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>I
don&#8217;t understand why I need it?<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Do
I need it for all registers?<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Why
in the mpc8313 reference in registers description some bits look like =
31,30,29,&#8230;,3,2,1,0<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>And
some: 0,1,2,3&#8230;,30,31<o:p></o:p></span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Is
it just mistake? Or some registers are different then other? =
<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0003_01C7D9E9.AF697580--
