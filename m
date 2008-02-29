Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (unknown [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id 4945ADDF04
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Mar 2008 05:25:58 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C87AFF.347D55DC"
Subject: RE: ML403 Linux port questions
Date: Fri, 29 Feb 2008 10:13:44 -0800
Message-ID: <D61182AC8012EA4EBC531B3AF23BE1095827C2@tranzeo-mail2.12stewart.tranzeo.com>
In-Reply-To: <ADA5878BA63680469C75C14CEEE2FE28012F482B@mail.serveron.com>
References: <ADA5878BA63680469C75C14CEEE2FE28012F482B@mail.serveron.com>
From: "Darcy Watkins" <DWatkins@tranzeo.com>
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

------_=_NextPart_001_01C87AFF.347D55DC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

I am using an AMCC PPC405EP based system and find that the following
works...

=20

Development / build machine --> Fedora core 6 or 7 on x86 PC

Cross compile and target rootfs generation --> Buildroot

Linux kernel (at least to start with) --> 2.6.19.2 from DENX ELDK 4.1

=20

Of course, you can use the cross compile environment from ELDK if you
like.  I used it at first (had a very good out-of-box experience on AMCC
Taihu with it) and then switched to Buildroot later.

=20

http://www.denx.de <http://www.denx.de/>  for ELDK / kernel

http://buildroot.uclibc.org <http://buildroot.uclibc.org/>  for
Buildroot

=20

I am presently using the Linux 2.6.19.2 kernel with I-Pipe real time
extension (2.3.0) from the Xenomai project - as bundled in ELDK 4.1 by
DENX.  I have also experimented with some newer stuff, but this involves
diving into the board support migration from arch/ppc to arch/powerpc
which is still pretty bleeding edge. 2.6.19.2 is pretty safe and not too
old - and is probably the newest available with RT option while still
being in the arch/ppc tree.

=20

Don't attempt to have buildroot automatically build the kernel for you
as part of its config - that may cause you grief as their integration
for PowerPC kernels appears hit-and-miss for 40x series due to all the
arch/ppc versus arch/powerpc stuff.  Also, the buildroot automatic
kernel generation doesn't include RT support (in case you need it).

=20

=20

Regards,

=20

Darcy

=20

=20

________________________________

From: linuxppc-embedded-bounces+dwatkins=3Dtranzeo.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+dwatkins=3Dtranzeo.com@ozlabs.org] On
Behalf Of Phil Hochstetler
Sent: Friday, February 29, 2008 9:25 AM
To: linuxppc-embedded@ozlabs.org
Subject: ML403 Linux port questions

=20

I'm setting up a new development environment to get a working port of
Linux on the Xilinx Virtex-4 chip  (I have a Xilinx ML403 board).  I'm
looking for the quickest way to get a working development environment
for the 2.6 kernel without paying thousands of $$=20

--snip!--

I guess what I am looking for is advise on the lowest risk, easiest to
set up environment to setup that will just work.  Also advise on which
kernel to use.=20

--snip!-

=20


------_=_NextPart_001_01C87AFF.347D55DC
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" =
name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--a:link
	{mso-style-priority:99;}
span.MSOHYPERLINK
	{mso-style-priority:99;}
a:visited
	{mso-style-priority:99;}
span.MSOHYPERLINKFOLLOWED
	{mso-style-priority:99;}

 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Calibri;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:Calibri;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:Calibri;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <u1:shapedefaults u2:ext=3D"edit" spidmax=3D"1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <u3:shapelayout u4:ext=3D"edit">
  <u3:idmap u4:ext=3D"edit" data=3D"1"/>
 </u3:shapelayout>
</xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I am using an AMCC PPC405EP based =
system
and find that the following works&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Development / build machine =
</span></font><font
size=3D2 color=3Dnavy face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:
Wingdings;color:navy'>&agrave;</span></font><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'> Fedora core 6 =
or 7 on
x86 PC<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Cross compile and target rootfs =
generation
</span></font><font size=3D2 color=3Dnavy face=3DWingdings><span =
style=3D'font-size:
10.0pt;font-family:Wingdings;color:navy'>&agrave;</span></font><font =
size=3D2
color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:navy'> Buildroot<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Linux kernel (at least to start =
with) </span></font><font
size=3D2 color=3Dnavy face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:
Wingdings;color:navy'>&agrave;</span></font><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'> 2.6.19.2 from =
DENX ELDK
4.1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Of course, you can use the cross =
compile
environment from ELDK if you like.&nbsp; I used it at first (had a very =
good
out-of-box experience on AMCC Taihu with it) and then switched to =
Buildroot
later.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><a =
href=3D"http://www.denx.de/">http://www.denx.de</a>
for ELDK / kernel<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><a =
href=3D"http://buildroot.uclibc.org/">http://buildroot.uclibc.org</a>
for Buildroot<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I am presently using the Linux =
2.6.19.2
kernel with I-Pipe real time extension (2.3.0) from the Xenomai project =
&#8211;
as bundled in ELDK 4.1 by DENX.&nbsp; I have also experimented with some =
newer
stuff, but this involves diving into the board support migration from =
arch/ppc
to arch/powerpc which is still pretty bleeding edge. 2.6.19.2 is pretty =
safe
and not too old &#8211; and is probably the newest available with RT =
option
while still being in the arch/ppc tree.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Don&#8217;t attempt to have =
buildroot automatically
build the kernel for you as part of its config &#8211; that may cause =
you grief
as their integration for PowerPC kernels appears hit-and-miss for 40x =
series
due to all the arch/ppc versus arch/powerpc stuff.&nbsp; Also, the =
buildroot
automatic kernel generation doesn&#8217;t include RT support (in case =
you need
it).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Regards,<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Darcy<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New Roman"'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-embedded-bounces+dwatkins=3Dtranzeo.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+dwatkins=3Dtranzeo.com@ozlabs.org] =
<b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>Phil Hochstetler<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Friday, February =
29, 2008
9:25 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> ML403 Linux port
questions</span></font><font size=3D3 face=3D"Times New Roman"><span
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'><o:p></o:p></span></font></p>

</div>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>I&#8217;m
setting up a new development environment to get a working <st1:place =
w:st=3D"on"><st1:PlaceType
 w:st=3D"on">port</st1:PlaceType> of <st1:PlaceName =
w:st=3D"on">Linux</st1:PlaceName></st1:place>
on the Xilinx Virtex-4 chip&nbsp; (I have a Xilinx ML403 board).&nbsp; =
I&#8217;m
looking for the quickest way to get a working development environment =
for the
2.6 kernel without paying thousands of $$ <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>--snip!--<o:p></o:p></span></font></=
p>

<p class=3DMsoNormal><font size=3D2 face=3DCalibri><span =
style=3D'font-size:11.0pt'>I
guess what I am looking for is advise on the lowest risk, easiest to set =
up
environment to setup that will just work.&nbsp; Also advise on which =
kernel to
use.&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>--snip!&#8212;<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C87AFF.347D55DC--
