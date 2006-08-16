Return-Path: <keith.redfern@uk.flextronics.com>
Received: from ducmta01.flextronics.com (ducmta01.flextronics.com
	[217.79.214.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ducmta01.flextronics.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 1CFA1679E1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Aug 2006 18:53:15 +1000 (EST)
Received: from euduc502.europe.ad.flextronics.com
	(euduc502.europe.ad.flextronics.com [10.219.244.17])
	by ducmta01.flextronics.com (Symantec Mail Security) with ESMTP id
	D37224A0 for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Aug 2006 10:53:04 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6C111.62A4C3E9"
Subject: Problems dynamically linking busybox with ppc libs.
Date: Wed, 16 Aug 2006 10:53:04 +0200
Message-ID: <367F3B3911959C4DA9991C00166F620C1DE208@EUDUCEX2.europe.ad.flextronics.com>
From: "Keith Redfern" <keith.redfern@uk.flextronics.com>
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

------_=_NextPart_001_01C6C111.62A4C3E9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am trying to dynamically link busybox with the correct libraries but=0D=
=0A
run into problems with directory paths and CC/LD flags.=0D=0A
=0D=0A
I am using the toolchain supplied with ELDK and my target board is=0D=0A
ppc_8xx based. The busybox version that I am using is 1.1.3.=0D=0A
=0D=0A
 =0D=0A
=0D=0A
I see the following in Rules.mak and have been trying different variable=0D=
=0A
options but with no success.=0D=0A
=0D=0A
 =0D=0A
=0D=0A
# To compile vs some other alternative libc, you may need to use/adjust=0D=
=0A
=0D=0A
# the following lines to meet your needs...=0D=0A
=0D=0A
#=0D=0A
=0D=0A
# If you are using Red Hat 6.x with the compatible RPMs (for developing=0D=
=0A
under=0D=0A
=0D=0A
# Red Hat 5.x and glibc 2.0) uncomment the following.  Be sure to read=0D=
=0A
about=0D=0A
=0D=0A
# using the compatible RPMs (compat-*) at http://www.redhat.com !=0D=0A
=0D=0A
#LIBCDIR:=3D/usr/i386-glibc20-linux=0D=0A
=0D=0A
#=0D=0A
=0D=0A
# For other libraries, you are on your own.  But these may (or may not)=0D=
=0A
help...=0D=0A
=0D=0A
#LDFLAGS+=3D-nostdlib=0D=0A
=0D=0A
#LIBRARIES:=3D$(LIBCDIR)/lib/libc.so.6=0D=0A
=0D=0A
#CROSS_CFLAGS+=3D-nostdinc -I$(LIBCDIR)/include -I$(GCCINCDIR)=0D=0A
-funsigned-char=0D=0A
=0D=0A
#GCCINCDIR:=3D$(shell gcc -print-search-dirs | sed -ne "s/install:=0D=0A
\(.*\)/\1include/gp")=0D=0A
=0D=0A
 =0D=0A
=0D=0A
=0D=0A
#=0D=0A
=0D=0A
# For other libraries, you are on your own.  But these may (or may not)=0D=
=0A
help...=0D=0A
=0D=0A
 =0D=0A
=0D=0A
 =0D=0A
=0D=0A
Is this the correct place to make modifications?=0D=0A
=0D=0A
Has anyone already figured the changes required to get this to work with=0D=
=0A
ELDK toolchain?=0D=0A
=0D=0A
Any insight would be useful.=0D=0A
=0D=0A
 =0D=0A
=0D=0A
......Keith=0D=0A
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

------_=_NextPart_001_01C6C111.62A4C3E9
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:=
schemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html=
40">=0D=0A
=0D=0A
<head>=0D=0A
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii"=
>=0D=0A
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
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-IE style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'>I am trying to dynamically link busybox with th=
e=0D=0A
correct libraries but run into problems with directory paths and CC/LD fl=
ags.<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-IE style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'>I am using the toolchain supplied with ELDK and=
 my=0D=0A
target board is ppc_8xx based. The busybox version that I am using is 1.1=
.3.<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-IE style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-IE style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'>I see the following in Rules.mak and have been =
trying=0D=0A
different variable options but with no success.<o:p></o:p></span></font><=
/p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-IE style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'># To compile vs some=
 other=0D=0A
alternative libc, you may need to use/adjust<o:p></o:p></span></font></p>=
=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'># the following line=
s to=0D=0A
meet your needs...<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o:p></span><=
/font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'># If you are using R=
ed Hat=0D=0A
6.x with the compatible RPMs (for developing under<o:p></o:p></span></fon=
t></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'># Red Hat 5.x and gl=
ibc 2.0)=0D=0A
uncomment the following.&nbsp; Be sure to read about<o:p></o:p></span></f=
ont></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'># using the compatib=
le RPMs=0D=0A
(compat-*) at http://www.redhat.com !<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>#LIBCDIR:=3D/usr/i38=
6-glibc20-linux<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o:p></span><=
/font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'># For other librarie=
s, you=0D=0A
are on your own.&nbsp; But these may (or may not) help...<o:p></o:p></spa=
n></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>#LDFLAGS+=3D-nostdli=
b<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>#LIBRARIES:=3D$(LIBC=
DIR)/lib/libc.so.6<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>#CROSS_CFLAGS+=3D-no=
stdinc=0D=0A
-I$(LIBCDIR)/include -I$(GCCINCDIR) -funsigned-char<o:p></o:p></span></fo=
nt></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>#GCCINCDIR:=3D$(shel=
l gcc=0D=0A
-print-search-dirs | sed -ne &quot;s/install: \(.*\)/\1include/gp&quot;)<=
o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;=0D=0A
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></font></p>=0D=
=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o:p></span><=
/font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span style=3D'f=
ont-size:10.0pt;=0D=0A
font-family:"Courier New"'># For other libraries, you are on your own.&nb=
sp;=0D=0A
But these may (or may not) help...<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span style=3D'f=
ont-size:10.0pt;=0D=0A
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span style=3D'f=
ont-size:10.0pt;=0D=0A
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span style=3D'f=
ont-size:10.0pt;=0D=0A
font-family:"Courier New"'>Is this the correct place to make modification=
s?<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span style=3D'f=
ont-size:10.0pt;=0D=0A
font-family:"Courier New"'>Has anyone already figured the changes require=
d to=0D=0A
get this to work with ELDK toolchain?<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span style=3D'f=
ont-size:10.0pt;=0D=0A
font-family:"Courier New"'>Any insight would be useful.<o:p></o:p></span>=
</font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span style=3D'f=
ont-size:10.0pt;=0D=0A
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span style=3D'f=
ont-size:10.0pt;=0D=0A
font-family:"Courier New"'>...&#8230;Keith</span></font><font size=3D2=0D=
=0A
face=3DArial><span lang=3DEN-IE style=3D'font-size:10.0pt;font-family:Ari=
al'><o:p></o:p></span></font></p>=0D=0A
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

------_=_NextPart_001_01C6C111.62A4C3E9--
