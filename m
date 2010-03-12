Return-Path: <R66092@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE4FAB7D21
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Mar 2010 11:27:17 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o2C0QvHB003446 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Mar 2010 17:27:08 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o2C0ZKri009060
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Mar 2010 18:35:21 -0600 (CST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CAC17A.B82D2BD6"
Subject: RE: Linus' kernel tree over ads5121-rev4
Date: Fri, 12 Mar 2010 08:26:55 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED01723493@zch01exm26.fsl.freescale.net>
In-Reply-To: <DCD09CE7A7B046EA9AD832CD4648A26E@ctag>
References: <DCD09CE7A7B046EA9AD832CD4648A26E@ctag>
From: "Chen Hongjun-R66092" <r66092@freescale.com>
To: =?iso-8859-1?Q?CTAG_/_Mois=E9s_Dom=EDnguez?= <moises.dominguez@ctag.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CAC17A.B82D2BD6
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Pls make sure that you have the following enrionment variable in uboot =
bootargs.
=20
diufb=3D15M
=20
B.R,
Hongjun


________________________________

	From: =
linuxppc-dev-bounces+hong-jun.chen=3Dfreescale.com@lists.ozlabs.org =
[mailto:linuxppc-dev-bounces+hong-jun.chen=3Dfreescale.com@lists.ozlabs.o=
rg] On Behalf Of CTAG / Mois=E9s Dom=EDnguez
	Sent: Thursday, March 11, 2010 8:54 PM
	To: linuxppc-dev@lists.ozlabs.org
	Subject: Linus' kernel tree over ads5121-rev4
=09
=09

	Hi,

	=20

	I am started with freescale LTIB but I decided to make a clone of =
Linus' kernel tree mainly to have the latest and fixed mscan driver.

	=20

	Linux is uncompressed and starts right, but when DIU driver probe =
function is called (exactly when first framebuffer device is registered) =
linux restarts. This behaviour repeats indefinitely.

	(same behaviour with denx kernel tree).

	=20

	I am using .dts that comes in the Linus'kernel tree. Maybe this .dts =
board revision dependent?=20

	=20

	I updated u-boot to with the denx one but similar results.

	=20

	=20

	Maybe basic questions. Sorry for that.

	=20

	Regards, Moises.


------_=_NextPart_001_01CAC17A.B82D2BD6
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16981" name=3DGENERATOR>
<STYLE>@page Section1 {size: 595.3pt 841.9pt; margin: 70.85pt 3.0cm =
70.85pt 3.0cm; }
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
SPAN.EstiloCorreo17 {
	COLOR: windowtext; FONT-FAMILY: Arial
}
DIV.Section1 {
	page: Section1
}
</STYLE>
</HEAD>
<BODY lang=3DES vLink=3Dpurple link=3Dblue>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D791302300-12032010>Pls make sure that you have the following =
enrionment=20
variable&nbsp;in uboot bootargs.</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D791302300-12032010></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D791302300-12032010><SPAN class=3DApple-style-span=20
style=3D"WORD-SPACING: 0px; FONT: medium Simsun; TEXT-TRANSFORM: none; =
COLOR: rgb(0,0,0); TEXT-INDENT: 0px; WHITE-SPACE: normal; =
LETTER-SPACING: normal; BORDER-COLLAPSE: separate; orphans: 2; widows: =
2; -webkit-border-horizontal-spacing: 0px; =
-webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0px"><PRE style=3D"FONT-SIZE: 10pt; =
MARGIN: 0in 0in 0pt 0.75in; TEXT-INDENT: -0.25in; FONT-FAMILY: 'Courier =
New'"><SPAN style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New =
Roman'"><SPAN =
class=3DSpellE>diufb</SPAN>=3D15M</SPAN></PRE></SPAN></SPAN></FONT></DIV>=

<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D791302300-12032010></SPAN>B<SPAN=20
class=3D791302300-12032010>.R,</SPAN></DIV>
<DIV><SPAN class=3D791302300-12032010></SPAN><SPAN=20
class=3D791302300-12032010></SPAN>H<SPAN=20
class=3D791302300-12032010>ongjun</SPAN><BR></DIV>
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
  <B>On Behalf Of </B>CTAG / Mois=E9s Dom=EDnguez<BR><B>Sent:</B> =
Thursday, March=20
  11, 2010 8:54 PM<BR><B>To:</B>=20
  linuxppc-dev@lists.ozlabs.org<BR><B>Subject:</B> Linus' kernel tree =
over=20
  ads5121-rev4<BR></FONT><BR></DIV>
  <DIV></DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Hi,</SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">I am started with =
freescale LTIB=20
  but I decided to make a clone of Linus' kernel tree mainly to have the =
latest=20
  and fixed mscan driver.</SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Linux is uncompressed =
and starts=20
  right, but when </SPAN></FONT><FONT face=3DArial size=3D2><SPAN =
lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">DIU</SPAN></FONT><FONT =
face=3DArial=20
  size=3D2><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"> driver=20
  probe function is called (exactly when first framebuffer device is =
registered)=20
  linux restarts. This behaviour repeats i</SPAN></FONT><FONT =
face=3DArial=20
  size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">ndefinitely.</SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">(same behaviour with =
denx kernel=20
  tree).</SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">I am using .dts that =
comes in the=20
  Linus=92kernel tree. Maybe this .dts board revision dependent?=20
</SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">I updated u-boot to with =
the denx=20
  one but similar results.</SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Maybe basic questions. =
Sorry for=20
  that.</SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"></SPAN></FONT>&nbsp;</P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN lang=3DEN-GB=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Regards,=20
  Moises.</SPAN></FONT></P></DIV></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01CAC17A.B82D2BD6--
