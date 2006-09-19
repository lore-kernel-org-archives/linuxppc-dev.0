Return-Path: <brian.rutledge@uk.flextronics.com>
Received: from ducmta01.flextronics.com (ducmta01.flextronics.com
	[217.79.214.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ducmta01.flextronics.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id DA2EA67B22
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Sep 2006 20:12:04 +1000 (EST)
Received: from euduc502.europe.ad.flextronics.com
	(euduc502.europe.ad.flextronics.com [10.219.244.17])
	by ducmta01.flextronics.com (Symantec Mail Security) with ESMTP id
	CD6C1539 for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Sep 2006 11:42:19 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DBCF.E6657616"
Subject: booting monta vista 2.6
Date: Tue, 19 Sep 2006 11:42:18 +0200
Message-ID: <D62BA2DDF7501846974F6752E0456E730110BD88@EUDUCEX1.europe.ad.flextronics.com>
From: "Brian Rutledge" <brian.rutledge@uk.flextronics.com>
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

------_=_NextPart_001_01C6DBCF.E6657616
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi =0D=0A
=0D=0A
I have an Embedded Planet 852T board with the planet core bootloader and=0D=
=0A
trying to boot monta vista 2.6.=0D=0A
=0D=0A
The code starts up and enters the function load_kernel() however it is=0D=
=0A
not passed board information in the load_kernel() parameter *bp.=0D=0A
=0D=0A
 =0D=0A
=0D=0A
Is there some way to set this via .config or some other means by which=0D=
=0A
this can be picked up. =0D=0A
=0D=0A
 =0D=0A
=0D=0A
Thanks Brian=0D=0A
=0D=0A
=0D=0A
Legal Disclaimer:=0A
The information contained in this message may be privileged and confident=
ial. It is intended to be read only by the individual or entity to whom i=
t is addressed or by their designee. If the reader of this message is not=
 the intended recipient, you are on notice that any distribution of this =
message, in any form, is strictly prohibited. If you have received this m=
essage in error, please immediately notify the sender and delete or destr=
oy any copy of this message=0D=0A

------_=_NextPart_001_01C6DBCF.E6657616
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:=
schemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html=
40">=0D=0A
=0D=0A
<head>=0D=0A
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-asci=
i">=0D=0A
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">=0D=
=0A
<style>=0D=0A
<!--=0D=0A
 /* Style Definitions */=0D=0A
 p.MsoNormal, li.MsoNormal, div.MsoNormal=0D=0A
	{margin:0cm;=0D=0A
	margin-bottom:.0001pt;=0D=0A
	font-size:12.0pt;=0D=0A
	font-family:"Times New Roman";}=0D=0A
a:link, span.MsoHyperlink=0D=0A
	{color:blue;=0D=0A
	text-decoration:underline;}=0D=0A
a:visited, span.MsoHyperlinkFollowed=0D=0A
	{color:purple;=0D=0A
	text-decoration:underline;}=0D=0A
span.EmailStyle17=0D=0A
	{mso-style-type:personal-compose;=0D=0A
	font-family:Arial;=0D=0A
	color:windowtext;}=0D=0A
@page Section1=0D=0A
	{size:612.0pt 792.0pt;=0D=0A
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}=0D=0A
div.Section1=0D=0A
	{page:Section1;}=0D=0A
-->=0D=0A
</style>=0D=0A
=0D=0A
</head>=0D=0A
=0D=0A
<body lang=3DEN-US link=3Dblue vlink=3Dpurple>=0D=0A
=0D=0A
<div class=3DSection1>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'>Hi <o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'>I have an Embedded Planet 852T board with the p=
lanet=0D=0A
core bootloader and trying to boot monta vista 2.6.<o:p></o:p></span></fo=
nt></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'>The code starts up and enters the function=0D=0A
load_kernel() however it is not passed board information in the load_kern=
el()=0D=0A
parameter *bp.<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'>Is there some way to set this via .config or so=
me=0D=0A
other means by which this can be picked up. <o:p></o:p></span></font></p>=
=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'>Thanks Brian<o:p></o:p></span></font></p>=0D=0A
=0D=0A
</div>=0D=0A
=0D=0A
Legal Disclaimer:=0A
The information contained in this message may be privileged and confident=
ial. It is intended to be read only by the individual or entity to whom i=
t is addressed or by their designee. If the reader of this message is not=
 the intended recipient, you are on notice that any distribution of this =
message, in any form, is strictly prohibited. If you have received this m=
essage in error, please immediately notify the sender and delete or destr=
oy any copy of this message</body>=0D=0A
=0D=0A
</html>=0D=0A

------_=_NextPart_001_01C6DBCF.E6657616--
