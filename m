Return-Path: <hong-jun.chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D8C11B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Sep 2009 10:09:04 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8908x9W002133 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 8 Sep 2009 17:09:00 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n890AekK000611
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 8 Sep 2009 19:10:42 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA30E1.B90EAF91"
Subject: RE: Queries regarding I2C and GPIO driver for Freescale MPC5121e in
	Linux2.6.24 of BSP: MPC512xADS_20090603-ltib.iso
Date: Wed, 9 Sep 2009 08:08:55 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED64C5B2@zch01exm26.fsl.freescale.net>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAACk7Zq0ADiBFlLw+tPrMt1bCgAAAEAAAAMhVxXG9wghAjqGQWiEYvY8BAAAAAA==@implantaire.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAACk7Zq0ADiBFlLw+tPrMt1bCgAAAEAAAAMhVxXG9wghAjqGQWiEYvY8BAAAAAA==@implantaire.com>
From: "Chen Hongjun-R66092" <hong-jun.chen@freescale.com>
To: "Uma Kanta Patro" <upatro@implantaire.com>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA30E1.B90EAF91
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

One I2C driver has been included in 0603 bsp, you can refer to it.
=20
It has no specific driver for GPIO, but you can find some initializing
code for GPIO in arch/powerpc/platforms/512x/mpc5125_ads.c. and
mpc512x_pm_test.c.



________________________________

	From:
linuxppc-dev-bounces+hong-jun.chen=3Dfreescale.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+hong-jun.chen=3Dfreescale.com@lists.ozlabs.o=
r
g] On Behalf Of Uma Kanta Patro
	Sent: Tuesday, September 08, 2009 6:56 PM
	To: linuxppc-dev@lists.ozlabs.org
	Subject: Queries regarding I2C and GPIO driver for Freescale
MPC5121e in Linux2.6.24 of BSP: MPC512xADS_20090603-ltib.iso
=09
=09

	Hi all,

	                I am a newbie to the powerpc linux kernel, but I
have worked on some drivers in arm architecture. I am finding powerpc
architecture to be fully different than that.

	I am working on Freescale MPC5121e with the BSP
MPC512xADS_20090603-ltib.iso running in it on the ADS512101 Rev4.1
development kit.

	Can anyone help me in finding some documentation for
understanding and working on the powerpc kernel. Any links to the
powerpc forums will also be appreciable.

	=20

	=20

	-> Currently I am going to develop an I2C client driver for one
slave microcontroller of our project.

	I have some knowledge in the I2C client driver making(legacy
style and new style).

	=20

	I made a basic I2C client driver to probe for the chip address
and for testing I gave it the chip address 0x68(I2C chip address of the
M4T162 RTC, present on the board).

	But while inserting my driver I am getting failure message for
the detection of my chip.

	=20

	So I would like to know what other formalities am I lagging in
my I2C chip driver.

	=20

	-> Also I am in a need for the GPIO driver for my controller ot
get interrupt on ht estate change. When I searched in the kernel code I
could not find any procedure to do that, also I could not find out the
procedure to access either any GPIO pin macros or any register to remap
with ioremap(). So please guide me in finding the proper way to do the
GPIO accessing and interrupt registration.

	Will the ioremap() work on powerpc arch? If yes where can I find
the memory mapping(register definitions) to use for my GPIO driver
making.

	=20

	Thanks for patience in reading my queries.

	Any help is appreciable.

	=20

	Thanks & Regards,

	Uma

	=20


------_=_NextPart_001_01CA30E1.B90EAF91
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:v =3D=20
"urn:schemas-microsoft-com:vml" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word" xmlns:m =3D=20
"http://schemas.microsoft.com/office/2004/12/omml"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3562" name=3DGENERATOR>
<STYLE>@font-face {
	font-family: Batang;
}
@font-face {
	font-family: Batang;
}
@font-face {
	font-family: Calibri;
}
@font-face {
	font-family: @Batang;
}
@page Section1 {size: 8.5in 11.0in; margin: 1.0in 1.0in 1.0in 1.0in; }
P.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: =
"Calibri","sans-serif"
}
LI.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: =
"Calibri","sans-serif"
}
DIV.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: =
"Calibri","sans-serif"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.EmailStyle17 {
	COLOR: windowtext; FONT-FAMILY: "Calibri","sans-serif"; mso-style-type: =
personal-compose
}
.MsoChpDefault {
	mso-style-type: export-only
}
DIV.Section1 {
	page: Section1
}
</STYLE>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]--></HEAD>
<BODY lang=3DEN-US vLink=3Dpurple link=3Dblue>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D900410000-09092009>One I2C driver has been included in 0603 bsp, =
you can=20
refer to it.</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D900410000-09092009></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D900410000-09092009>It has no&nbsp;specific driver for GPIO, but =
you can=20
find some initializing&nbsp;code for GPIO in=20
arch/powerpc/platforms/512x/mpc5125_ads.c. and=20
mpc512x_pm_test.c.</SPAN></FONT></DIV><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT><BR>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B>=20
  linuxppc-dev-bounces+hong-jun.chen=3Dfreescale.com@lists.ozlabs.org=20
  =
[mailto:linuxppc-dev-bounces+hong-jun.chen=3Dfreescale.com@lists.ozlabs.o=
rg]=20
  <B>On Behalf Of </B>Uma Kanta Patro<BR><B>Sent:</B> Tuesday, September =
08,=20
  2009 6:56 PM<BR><B>To:</B> =
linuxppc-dev@lists.ozlabs.org<BR><B>Subject:</B>=20
  Queries regarding I2C and GPIO driver for Freescale MPC5121e in =
Linux2.6.24 of=20
  BSP: MPC512xADS_20090603-ltib.iso<BR></FONT><BR></DIV>
  <DIV></DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal>Hi all,<o:p></o:p></P>
  <P=20
  =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  I am a newbie to the powerpc linux kernel, but I have worked on some =
drivers=20
  in arm architecture. I am finding powerpc architecture to be fully =
different=20
  than that.<o:p></o:p></P>
  <P class=3DMsoNormal>I am working on Freescale MPC5121e with the BSP=20
  MPC512xADS_20090603-ltib.iso running in it on the ADS512101 Rev4.1 =
development=20
  kit.<o:p></o:p></P>
  <P class=3DMsoNormal>Can anyone help me in finding some documentation =
for=20
  understanding and working on the powerpc kernel. Any links to the =
powerpc=20
  forums will also be appreciable.<o:p></o:p></P>
  <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
  <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
  <P class=3DMsoNormal>-&gt; Currently I am going to develop an I2C =
client driver=20
  for one slave microcontroller of our project.<o:p></o:p></P>
  <P class=3DMsoNormal>I have some knowledge in the I2C client driver=20
  making(legacy style and new style).<o:p></o:p></P>
  <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
  <P class=3DMsoNormal>I made a basic I2C client driver to probe for the =
chip=20
  address and for testing I gave it the chip address 0x68(I2C chip =
address of=20
  the M4T162 RTC, present on the board).<o:p></o:p></P>
  <P class=3DMsoNormal>But while inserting my driver I am getting =
failure message=20
  for the detection of my chip.<o:p></o:p></P>
  <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
  <P class=3DMsoNormal>So I would like to know what other formalities am =
I lagging=20
  in my I2C chip driver.<o:p></o:p></P>
  <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
  <P class=3DMsoNormal>-&gt; Also I am in a need for the GPIO driver for =
my=20
  controller ot get interrupt on ht estate change. When I searched in =
the kernel=20
  code I could not find any procedure to do that, also I could not find =
out the=20
  procedure to access either any GPIO pin macros or any register to =
remap with=20
  ioremap(). So please guide me in finding the proper way to do the GPIO =

  accessing and interrupt registration.<o:p></o:p></P>
  <P class=3DMsoNormal>Will the ioremap() work on powerpc arch? If yes =
where can I=20
  find the memory mapping(register definitions) to use for my GPIO =
driver=20
  making.<o:p></o:p></P>
  <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
  <P class=3DMsoNormal>Thanks for patience in reading my =
queries.<o:p></o:p></P>
  <P class=3DMsoNormal>Any help is appreciable.<o:p></o:p></P>
  <P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 12pt">Thanks &amp;=20
  Regards,<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 12pt">Uma</SPAN><SPAN=20
  style=3D"FONT-SIZE: 12pt"><o:p></o:p></SPAN></P>
  <P =
class=3DMsoNormal><o:p>&nbsp;</o:p></P></DIV></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01CA30E1.B90EAF91--
