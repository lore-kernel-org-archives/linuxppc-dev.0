Return-Path: <skoroneos@digital-opsis.com>
Received: from memova2.tellas.gr (memova2.tellas.gr [62.169.194.61])
	by ozlabs.org (Postfix) with ESMTP id 0C360DDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Jun 2007 09:49:34 +1000 (EST)
From: "Stelios Koroneos" <skoroneos@digital-opsis.com>
To: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: Kernel and rootfs in ONE image?
Date: Mon, 4 Jun 2007 02:42:00 +0300
Message-ID: <HOECLKEKOHLAMMGDLLBHAEMOLDAA.skoroneos@digital-opsis.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_01C8_01C7A651.ED1DBF60"
In-Reply-To: <29DC34A6B43468409F5A371CFE34E8491B5A4A@ex01.ads.ubidyne.de>
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

------=_NextPart_000_01C8_01C7A651.ED1DBF60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Yes it is.
There are basically two ways in doing it
One is to create a binary "blob" where each part (kernel and  fs)  is placed
at a certain location and the space between them is padded
These location should match exactly the kernel mtd partition settings in
terms of size.

The other method i have used, uses some "magic bytes" at the end of a jffs2
filesystem to mark it
Then kernel and the fs are joint and a kernel patch is used to find where
the filesystem starts/ends
This is the method used by Openwrt (in the kamikaze version)

Stelios S. Koroneos

Digital OPSiS - Embedded Intelligence
http://www.digital-opsis.com


  -----Original Message-----
  From: linuxppc-embedded-bounces+stelios=stelioscellar.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+stelios=stelioscellar.com@ozlabs.org]On
Behalf Of Frank Prepelica
  Sent: Friday, June 01, 2007 2:15 PM
  To: linuxppc-embedded@ozlabs.org
  Subject: Kernel and rootfs in ONE image?


  Hi all,



  in normal case you have got a kernel image and a rootfs image. Place

  that images into flash memory, set correct bootargs and it should work.



  But, is it possible to generate one image which includes the linux kernel

  and a rootfs, place that single image into flash memory and it should also
work?



  Thanks in advance!



  Beste regrads

  Frank

------=_NextPart_000_01C8_01C7A651.ED1DBF60
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:v =3D=20
"urn:schemas-microsoft-com:vml" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16441" name=3DGENERATOR>
<STYLE>@page Section1 {size: 595.3pt 841.9pt; margin: 70.85pt 70.85pt =
2.0cm 70.85pt; }
P.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"
}
LI.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"
}
DIV.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: "Times New Roman"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline
}
SPAN.E-MailFormatvorlage17 {
	COLOR: windowtext; FONT-FAMILY: Arial; mso-style-type: personal-compose
}
DIV.Section1 {
	page: Section1
}
</STYLE>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1027" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]--></HEAD>
<BODY lang=3DDE vLink=3Dpurple link=3Dblue>
<DIV>
<DIV><SPAN class=3D671155022-03062007><FONT face=3DArial color=3D#0000ff =
size=3D2>Yes it=20
is.</FONT></SPAN></DIV>
<DIV><SPAN class=3D671155022-03062007><FONT face=3DArial color=3D#0000ff =
size=3D2>There=20
are basically two ways in doing it</FONT></SPAN></DIV>
<DIV><SPAN class=3D671155022-03062007><FONT face=3DArial color=3D#0000ff =
size=3D2>One is=20
to create a binary "blob" where each part (kernel and &nbsp;fs) &nbsp;is =
placed=20
at a certain location and the space between them is =
padded</FONT></SPAN></DIV>
<DIV><SPAN class=3D671155022-03062007><FONT face=3DArial color=3D#0000ff =
size=3D2>These=20
location should match exactly the kernel mtd partition settings in terms =
of=20
size.</FONT></SPAN></DIV>
<DIV><SPAN class=3D671155022-03062007><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D671155022-03062007><FONT face=3DArial color=3D#0000ff =
size=3D2>The=20
other method i have used, uses some "magic bytes" at the end of a jffs2=20
filesystem to mark it</FONT></SPAN></DIV>
<DIV><SPAN class=3D671155022-03062007><FONT face=3DArial color=3D#0000ff =
size=3D2>Then=20
kernel and the fs are joint and a kernel patch is used to find where the =

filesystem starts/ends</FONT></SPAN></DIV>
<DIV><SPAN class=3D671155022-03062007><FONT face=3DArial color=3D#0000ff =
size=3D2>This=20
is the method used by Openwrt (in the kamikaze=20
version)</FONT></SPAN></DIV></DIV>
<DIV>&nbsp;</DIV>
<P><FONT size=3D2>Stelios S. Koroneos<BR><BR>Digital OPSiS - Embedded=20
Intelligence<BR><A href=3D"http://www.digital-opsis.com/"=20
target=3D_blank>http://www.digital-opsis.com</A><BR></FONT></P>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Original Message-----<BR><B>From:</B>=20
  linuxppc-embedded-bounces+stelios=3Dstelioscellar.com@ozlabs.org=20
  =
[mailto:linuxppc-embedded-bounces+stelios=3Dstelioscellar.com@ozlabs.org]=
<B>On=20
  Behalf Of </B>Frank Prepelica<BR><B>Sent:</B> Friday, June 01, 2007 =
2:15=20
  PM<BR><B>To:</B> linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> =
Kernel and=20
  rootfs in ONE image?<BR><BR></FONT></DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Hi=20
  all,<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">in normal case you have =
got a=20
  kernel image and a rootfs image. Place<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">that images into flash =
memory, set=20
  correct bootargs and it should work.<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">But, is it possible to =
generate=20
  one image which includes the linux kernel =
<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">and a rootfs, place that =
single=20
  image into flash memory and it should also =
work?<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Thanks in=20
  advance!<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Beste=20
  regrads<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Frank<o:p></o:p></SPAN></FONT></P></DIV></BLOCKQUOTE></BODY></HTML=
>

------=_NextPart_000_01C8_01C7A651.ED1DBF60--
