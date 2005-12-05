Return-Path: <jsaari@mc.com>
Received: from mc.com (iris-63.mc.com [63.96.239.141])
	by ozlabs.org (Postfix) with ESMTP id 82ECD68847
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 04:35:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5F9C2.1A383E6A"
Date: Mon, 5 Dec 2005 12:34:10 -0500
Message-ID: <9CE608B28EA97C489DF1A47D8C6E7153B83E65@ad-email1.ad.mc.com>
From: "Saari, James" <jsaari@mc.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RFI doesn't branch off?
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

------_=_NextPart_001_01C5F9C2.1A383E6A
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

I am chasing a very similar problem. Did you ever find resolution to
your problem? Can you share what you did to get past this?

=20

Thanks.

=20

--

=20

Amit Shah shahamit at gmail.com
<mailto:linuxppc-embedded%40ozlabs.org?Subject=3DRFI%20doesn%27t%20branch=
%
20off%3F&In-Reply-To=3D>=20
Wed Aug 25 20:20:33 EST 2004=20

*	Previous message: RFI doesn't branch off?
<http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/015393.html>=20
*	Next message: value of XIP? and whether it works with 2.6
kernel?
<http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/015394.html>=20
*	Messages sorted by: [ date ]
<http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/date.html#154
10>  [ thread ]
<http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/thread.html#1
5410>  [ subject ]
<http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/subject.html#
15410>  [ author ]
<http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/author.html#1
5410> =20

  _____ =20

Amit Shah wrote:
=20
>=20
> Hi all,
>=20
> I have a strange issue with a custom board running a 750GX on a
> Marvell 64360 bridge. I transferred control to the uImage via u-boot
> (which I had to modify for my board-specific UART and SDRAM inits,
> also disabling PCI).
>=20
> Using the UART that's initialized by u-boot, I put some putchar()s in
> head.S to figure out where the kernel was freezing. It seems 'rfi' in
> mmu_off doesn't jump off to '__after_mmu_off' as expected. I also put
> some pattern into SDRAM before an after mmu_off. I just see the
> pattern (via a PCI interface) put before mmu_off.
>=20
> The contents of SRR0 correctly point to __after_mmu_off just before
> the 'rfi'. However, the 'rfi' documentation says the value of SRR0 is
> concatenated with '0x0b00'. I don't think this should be done.
> Anyways, since this code is supposed to work, I'm not sure why it
> isn't working.
=20
If I keep the DR enabled in MSR, the RFI goes back properly... disabling
DR
causes some randomness.
=20
>=20
> Can any u-boot initializations be causing this? I guess not, I've not
> touched any CPU-specific settings in u-boot.
>=20
> Can anyone give me some pointers?
=20
--
Amit Shah
http://amitshah.nav.to/
=20
=20

=20


------_=_NextPart_001_01C5F9C2.1A383E6A
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
 /* List Definitions */
 @list l0
	{mso-list-id:773551598;
	mso-list-template-ids:-386084854;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
10.0pt'>I am chasing a very similar problem. Did you ever find =
resolution to
your problem? Can you share what you did to get past =
this?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
10.0pt'>Thanks.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
10.0pt'>--<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D3 face=3D"Times New Roman"><span
style=3D'font-size:12.0pt;font-weight:bold'>Amit Shah</span></font></b> =
<a
href=3D"mailto:linuxppc-embedded%40ozlabs.org?Subject=3DRFI%20doesn%27t%2=
0branch%20off%3F&amp;In-Reply-To=3D"
title=3D"RFI doesn't branch off?">shahamit at gmail.com </a><br>
<i><span style=3D'font-style:italic'>Wed Aug 25 20:20:33 EST =
2004</span></i> <o:p></o:p></p>

<ul type=3Ddisc>
 <li class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;
     mso-list:l0 level1 lfo1'><font size=3D3 face=3D"Times New =
Roman"><span
     style=3D'font-size:12.0pt'>Previous message: <a
     =
href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/015393.=
html">RFI
     doesn't branch off? </a><o:p></o:p></span></font></li>
 <li class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;
     mso-list:l0 level1 lfo1'><font size=3D3 face=3D"Times New =
Roman"><span
     style=3D'font-size:12.0pt'>Next message: <a
     =
href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/015394.=
html">value
     of XIP? and whether it works with 2.6 kernel? =
</a><o:p></o:p></span></font></li>
 <li class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;
     mso-list:l0 level1 lfo1'><b><font size=3D3 face=3D"Times New =
Roman"><span
     style=3D'font-size:12.0pt;font-weight:bold'>Messages sorted =
by:</span></font></b>
     <a
     =
href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/date.ht=
ml#15410">[
     date ]</a> <a
     =
href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/thread.=
html#15410">[
     thread ]</a> <a
     =
href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/subject=
.html#15410">[
     subject ]</a> <a
     =
href=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/author.=
html#15410">[
     author ]</a> <o:p></o:p></li>
</ul>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter>

</span></font></div>

<pre><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><!--beginarticle-->Amit Shah =
wrote:<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'><o:p>&nbsp;</o:p></span></i></span></font></p=
re><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> Hi =
all,<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'><o:p>&nbsp;</o:p></span></i></span></font></p=
re><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> I have a strange issue with a custom board =
running a 750GX on a<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> Marvell 64360 bridge. I transferred control =
to the uImage via =
u-boot<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> (which I had to modify for my =
board-specific UART and SDRAM =
inits,<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> also disabling =
PCI).<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'><o:p>&nbsp;</o:p></span></i></span></font></p=
re><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> Using the UART that's initialized by =
u-boot, I put some putchar()s =
in<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> head.S to figure out where the kernel was =
freezing. It seems 'rfi' =
in<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> mmu_off doesn't jump off to =
'__after_mmu_off' as expected. I also =
put<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> some pattern into SDRAM before an after =
mmu_off. I just see =
the<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> pattern (via a PCI interface) put before =
mmu_off.<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'><o:p>&nbsp;</o:p></span></i></span></font></p=
re><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> The contents of SRR0 correctly point to =
__after_mmu_off just =
before<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> the 'rfi'. However, the 'rfi' documentation =
says the value of SRR0 =
is<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> concatenated with '0x0b00'. I don't think =
this should be done.<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> Anyways, since this code is supposed to =
work, I'm not sure why =
it<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> isn't =
working.<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>If I keep =
the DR enabled in MSR, the RFI goes back properly... disabling =
DR<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>causes =
some randomness.<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'><o:p>&nbsp;</o:p></span></i></span></font></p=
re><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> Can any u-boot initializations be causing =
this? I guess not, I've =
not<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> touched any CPU-specific settings in =
u-boot.<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'><o:p>&nbsp;</o:p></span></i></span></font></p=
re><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&gt;<i><span
style=3D'font-style:italic'> Can anyone give me some =
pointers?<o:p></o:p></span></i></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>--<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>Amit =
Shah<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'><a
href=3D"http://amitshah.nav.to/">http://amitshah.nav.to/</a><o:p></o:p></=
span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C5F9C2.1A383E6A--
