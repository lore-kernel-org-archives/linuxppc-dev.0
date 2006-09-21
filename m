Return-Path: <brian.rutledge@uk.flextronics.com>
Received: from ducmta01.flextronics.com (ducmta01.flextronics.com
	[217.79.214.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ducmta01.flextronics.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 29A5F67BD3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Sep 2006 00:50:16 +1000 (EST)
Received: from euduc501.europe.ad.flextronics.com
	(euduc501.europe.ad.flextronics.com [10.219.244.16])
	by ducmta01.flextronics.com (Symantec Mail Security) with ESMTP id
	A3AF38B3 for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 16:50:09 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DD8D.3B5FC3AB"
Subject: Kernel hangs after "Now booting the kernel"
Date: Thu, 21 Sep 2006 16:50:07 +0200
Message-ID: <D62BA2DDF7501846974F6752E0456E73011E0C6E@EUDUCEX1.europe.ad.flextronics.com>
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

------_=_NextPart_001_01C6DD8D.3B5FC3AB
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi=0D=0A
=0D=0A
            I am using an Embedded Planet 852T board with a planet core=0D=
=0A
bootloader. I am trying to boot the kernel (2.6) and the boot sequence=0D=
=0A
gets as far as:=0D=0A
=0D=0A
 =0D=0A
=0D=0A
>go=0D=0A
=0D=0A
[Go 00200000]=0D=0A
=0D=0A
=0D=0A
loaded at:     00200000 0030A160=0D=0A
=0D=0A
relocated to:  00400000 0050A160=0D=0A
=0D=0A
board data at: 00508124 00508140=0D=0A
=0D=0A
relocated to:  004050B4 004050D0=0D=0A
=0D=0A
zimage at:     004058FD 0050704A=0D=0A
=0D=0A
avail ram:     0050B000 01000000=0D=0A
=0D=0A
 =0D=0A
=0D=0A
=0D=0A
Linux/PPC load: console=3DttyS0,9600 console=3Dtty0 root=3D/dev/ram0=0D=0A
init=3D/linuxrc rw=0D=0A
=0D=0A
Uncompressing Linux...done.=0D=0A
=0D=0A
Now booting the kernel=0D=0A
=0D=0A
 =0D=0A
=0D=0A
 =0D=0A
=0D=0A
            After which nothing happens.=0D=0A
=0D=0A
 =0D=0A
=0D=0A
            Does the kernel try an set up the serial port at this point=0D=
=0A
or can I assume that the serial is operational based on the output up to=0D=
=0A
this point?=0D=0A
=0D=0A
 =0D=0A
=0D=0A
            Are there any other areas I should be looking at?=0D=0A
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

------_=_NextPart_001_01C6DD8D.3B5FC3AB
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
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'>Hi<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; I=0D=0A
am using an Embedded Planet 852T board with a planet core bootloader. I a=
m=0D=0A
trying to boot the kernel (2.6) and the boot sequence gets as far as:<o:p=
></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><i><font size=3D2=0D=0A
face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"Courier=
 New";=0D=0A
font-style:italic'>&gt;go<o:p></o:p></span></font></i></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><i><font size=3D2=0D=0A
face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"Courier=
 New";=0D=0A
font-style:italic'>[Go 00200000]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D=0A
<o:p></o:p></span></font></i></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><i><font size=3D2=0D=0A
face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"Courier=
 New";=0D=0A
font-style:italic'>loaded at:&nbsp;&nbsp;&nbsp;&nbsp; 00200000 0030A160<o=
:p></o:p></span></font></i></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><i><font size=3D2=0D=0A
face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"Courier=
 New";=0D=0A
font-style:italic'>relocated to:&nbsp; 00400000 0050A160<o:p></o:p></span=
></font></i></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><i><font size=3D2=0D=0A
face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"Courier=
 New";=0D=0A
font-style:italic'>board data at: 00508124 00508140<o:p></o:p></span></fo=
nt></i></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><i><font size=3D2=0D=0A
face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"Courier=
 New";=0D=0A
font-style:italic'>relocated to:&nbsp; 004050B4 004050D0<o:p></o:p></span=
></font></i></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><i><font size=3D2=0D=0A
face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"Courier=
 New";=0D=0A
font-style:italic'>zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 004058FD 0050704A<o=
:p></o:p></span></font></i></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><i><font size=3D2=0D=0A
face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"Courier=
 New";=0D=0A
font-style:italic'>avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 0050B000 01000000<o=
:p></o:p></span></font></i></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><i><font size=3D2=0D=0A
face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"Courier=
 New";=0D=0A
font-style:italic'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D=0A
<o:p></o:p></span></font></i></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><i><font size=3D2=0D=0A
face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"Courier=
 New";=0D=0A
font-style:italic'>Linux/PPC load: console=3DttyS0,9600 console=3Dtty0=0D=
=0A
root=3D/dev/ram0 init=3D/linuxrc rw<o:p></o:p></span></font></i></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><i><font size=3D2=0D=0A
face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family:"Courier=
 New";=0D=0A
font-style:italic'>Uncompressing Linux...done.<o:p></o:p></span></font></=
i></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><i><font size=3D2 face=3D"Courier New"><span style=3D=
'font-size:=0D=0A
10.0pt;font-family:"Courier New";font-style:italic'>Now booting the kerne=
l</span></font></i><font=0D=0A
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt;font-family=
:"Courier New"'><o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><i><font size=3D2 face=3DArial><span lang=3DEN-GB=0D=
=0A
style=3D'font-size:10.0pt;font-family:Arial;font-style:italic'><o:p>&nbsp=
;</o:p></span></font></i></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; After=0D=0A
which nothing happens.<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; Does=0D=0A
the kernel try an set up the serial port at this point or can I assume th=
at the=0D=0A
serial is operational based on the output up to this point?<o:p></o:p></s=
pan></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; Are=0D=0A
there any other areas I should be looking at?<o:p></o:p></span></font></p=
>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; Thanks=0D=0A
Brian<o:p></o:p></span></font></p>=0D=0A
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

------_=_NextPart_001_01C6DD8D.3B5FC3AB--
