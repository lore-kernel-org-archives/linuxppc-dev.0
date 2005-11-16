Return-Path: <Alexey@waves.com>
Received: from exchange.waves.com (mail.waves.com [12.34.136.7])
	by ozlabs.org (Postfix) with ESMTP id A18116872D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 22:30:14 +1100 (EST)
From: "Alexey Dyatchkov" <alexey@waves.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 16 Nov 2005 13:14:28 +0200
Message-ID: <001f01c5ea9e$ea775a70$0100000a@Omerxp>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0020_01C5EAAF.AE002A70"
Cc: 'Ami Levi' <ami@waves.com>
Subject: Denx linux 2.4.25 on RPXLITE
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

------=_NextPart_000_0020_01C5EAAF.AE002A70
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi,

 

I'm trying to bring up Denx linux-2.4.25, latest found on
ftp.denx.de/pub/linux, on our proprietary board.

Our board is very much similar to RPXLITE. In fact it is RPXLITE with few
minor changes.

We did such works before, and all we usualy needed was to tune the io
mapping.

I did so with this kernel and it stucks in calibrate_delay() on "while
(ticks==jiffies)", row 207.

And it seems that no interrupts are coming to kernel (breakpoint in do_irq
is never achieved).

(No printk's on console, btw)

 

I'm not experienced enough in kernel debugging and feel stuck.

Please help!

 

Thanks in advance,

Alexey


------=_NextPart_000_0020_01C5EAAF.AE002A70
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
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
	{font-family:Arial;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
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
style=3D'font-size:10.0pt;font-family:Arial'>Hi,</span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>I'm
trying to bring up Denx linux-2.4.25, latest found on =
ftp.denx.de/pub/linux, on
our proprietary board.</span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Our
board is very much similar to RPXLITE. In fact it is RPXLITE with few =
minor
changes.</span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>We
did such works before, and all we usualy needed was to tune the io =
mapping.</span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>I
did so with this kernel and it stucks in calibrate_delay() on =
&quot;while (ticks=3D=3Djiffies)&quot;,
row 207.</span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>And
it seems that no interrupts are coming to kernel (breakpoint in do_irq =
is never
achieved).</span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>(No
printk's on console, btw)</span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>I'm
not experienced enough in kernel debugging and feel =
stuck.</span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Please
help!</span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Thanks
in advance,</span></font></p>

<p class=3DMsoNormal dir=3DLTR =
style=3D'text-align:left;direction:ltr;unicode-bidi:
embed'><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Alexey</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0020_01C5EAAF.AE002A70--
