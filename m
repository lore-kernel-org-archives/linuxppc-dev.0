Return-Path: <JohnsonCheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.28])
	by ozlabs.org (Postfix) with SMTP id F055268629
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 14:48:46 +1000 (EST)
From: "JohnsonCheng" <JohnsonCheng@qnap.com.tw>
To: "linux-ppc-embedded" <linuxppc-embedded@ozlabs.org>
Date: Fri, 21 Oct 2005 12:48:37 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0097_01C5D63D.C36DA8A0"
In-Reply-To: 
Message-Id: <20051021044846.F055268629@ozlabs.org>
Subject: RE: How to make mudules on linux-ppc2.6.12
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

------=_NextPart_000_0097_01C5D63D.C36DA8A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks for your kindly suggestion. I have found out the problem.

Just do some modification as following:

 

$(MAKE) ARCH=ppc CROSS_COMPILE=powerpc-linux- -C /root/linux-2.6.12.3
M=$(PWD) modules

 

Good Luck.!!

 

 

  _____  

From: JohnsonCheng [mailto:JohnsonCheng@qnap.com.tw] 
Sent: Friday, October 21, 2005 11:36 AM
To: linux-ppc-embedded
Subject: RE: How to make mudules on linux-ppc2.6.12

 

Dear Andy,

 

Thanks your reply. But I am sorry that it doesn't work on my box.

My kernel had been configured and compiled, and I also modify my Makefile as
following:

 

Obj-m := test.o

All:

  $(MAKE) ARCH=ppc CROSS_COMPILE=powerpc-linux- -C /root/linux-2.6.12.3
SUBDIRS=$(PWD) modules

 

The output message is the same as before, no error message and no test.ko
module.

 

 

Thanks,

Johnson Cheng

 

 

  _____  

From: JohnsonCheng [mailto:JohnsonCheng@qnap.com.tw] 
Sent: Thursday, October 20, 2005 6:57 PM
To: linux-ppc-embedded
Subject: How to make mudules on linux-ppc2.6.12

 

Dear All,

 

I just write a "hello world" module code, but I can't compile it for
ppc2.6.12.

My Makefile is list as following:

 

obj-m := test.o

all:

  make ARCH=ppc CROSS_COMPILE=powerpc-linux- -C /root/linux-2.6.12.3
SUBDIR=. modules

 

When I run make, no error message output, but I find no test.ko modules. The
output message is list as following:

 

make ARCH=ppc CROSS_COMPILE=powerpc-linux- -C /root/linux-2.6.1

2.3 SUBDIR=. modules

make[1]: Entering directory `/root/linux-2.6.12.3'

  CHK     include/linux/version.h

make[2]: `arch/ppc/kernel/asm-offsets.s' is up to date.

  Building modules, stage 2.

  MODPOST

make[1]: Leaving directory `/root/linux-2.6.12.3'

 

Do anyone can give me some help ?

 

Thanks,

Johnson Cheng

 


------=_NextPart_000_0097_01C5D63D.C36DA8A0
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
name=3D"chsdate"
 downloadurl=3D""/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chmetcnv" downloadurl=3D""/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:Arial;
	color:navy;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:18.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-TW link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:18.0pt'>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>Thanks for your =
kindly
suggestion. I have found out the problem.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>Just do some =
modification
as following:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>$(MAKE) =
ARCH=3Dppc
CROSS_COMPILE=3Dpowerpc-linux- -C /root/linux-<st1:chsdate =
IsROCDate=3D"False"
IsLunarDate=3D"False" Day=3D"30" Month=3D"12" Year=3D"1899" =
w:st=3D"on">2.6.12</st1:chsdate>.3
</span></font><font size=3D1 color=3Dred face=3DArial><span lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:red'>M</span></font><fon=
t
size=3D1 color=3Dnavy face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;
font-family:Arial;color:navy'>=3D$(PWD) modules</span></font><font =
size=3D1
color=3Dnavy face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial;
color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>Good =
Luck.!!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span lang=3DEN-US style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Tahoma;font-weight:bold'>From:</spa=
n></font></b><font
size=3D2 face=3DTahoma><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Tahoma'>
JohnsonCheng [mailto:JohnsonCheng@qnap.com.tw] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Friday, October 21, =
2005
11:36 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> <st1:PersonName =
w:st=3D"on">linux-ppc-embedded</st1:PersonName><br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> RE: How to make =
mudules
on linux-ppc<st1:chsdate IsROCDate=3D"False" IsLunarDate=3D"False" =
Day=3D"30"
Month=3D"12" Year=3D"1899" =
w:st=3D"on">2.6.12</st1:chsdate></span></font><span
lang=3DEN-US><o:p></o:p></span></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>Dear =
Andy,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>Thanks your =
reply. But I
am sorry that it doesn&#8217;t work on my =
box.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>My kernel had =
been
configured and compiled, and I also modify my Makefile as =
following:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>Obj-m :=3D =
test.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>All:<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>&nbsp; $(MAKE) =
ARCH=3Dppc
CROSS_COMPILE=3Dpowerpc-linux- -C /root/linux-<st1:chsdate =
IsROCDate=3D"False"
IsLunarDate=3D"False" Day=3D"30" Month=3D"12" Year=3D"1899" =
w:st=3D"on">2.6.12</st1:chsdate>.3
SUBDIRS=3D$(PWD) modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>The output =
message is the
same as before, no error message and no test.ko =
module.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>Thanks,<o:p></o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>Johnson =
Cheng<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span lang=3DEN-US style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Tahoma;font-weight:bold'>From:</spa=
n></font></b><font
size=3D2 face=3DTahoma><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Tahoma'>
JohnsonCheng [mailto:JohnsonCheng@qnap.com.tw] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Thursday, October =
20, 2005
6:57 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> <st1:PersonName =
w:st=3D"on">linux-ppc-embedded</st1:PersonName><br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> How to make =
mudules on
linux-ppc<st1:chsdate IsROCDate=3D"False" IsLunarDate=3D"False" =
Day=3D"30" Month=3D"12"
Year=3D"1899" w:st=3D"on">2.6.12</st1:chsdate></span></font><span =
lang=3DEN-US><o:p></o:p></span></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Dear All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>I just write a &#8220;hello world&#8221; module =
code,
but I can&#8217;t compile it for ppc<st1:chsdate IsROCDate=3D"False"
IsLunarDate=3D"False" Day=3D"30" Month=3D"12" Year=3D"1899" =
w:st=3D"on">2.6.12</st1:chsdate>.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>My Makefile is list as =
following:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>obj-m :=3D test.o<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>all:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; make ARCH=3Dppc =
CROSS_COMPILE=3Dpowerpc-linux- -C
/root/linux-<st1:chsdate IsROCDate=3D"False" IsLunarDate=3D"False" =
Day=3D"30"
Month=3D"12" Year=3D"1899" w:st=3D"on">2.6.12</st1:chsdate>.3 SUBDIR=3D. =
modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>When I run make, no error message output, but I =
find
no test.ko modules. The output message is list as =
following:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>make ARCH=3Dppc CROSS_COMPILE=3Dpowerpc-linux- =
-C
/root/linux-<st1:chsdate IsROCDate=3D"False" IsLunarDate=3D"False" =
Day=3D"30"
Month=3D"12" Year=3D"1899" =
w:st=3D"on">2.6.1</st1:chsdate><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>2.3 SUBDIR=3D. =
modules<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>make[1]: Entering directory =
`/root/linux-<st1:chsdate
IsROCDate=3D"False" IsLunarDate=3D"False" Day=3D"30" Month=3D"12" =
Year=3D"1899" =
w:st=3D"on">2.6.12</st1:chsdate>.3'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp;
include/linux/version.h<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>make[2]: `arch/ppc/kernel/asm-offsets.s' is up =
to
date.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; Building modules, stage =
2.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>&nbsp; MODPOST<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>make[1]: Leaving directory =
`/root/linux-<st1:chsdate
IsROCDate=3D"False" IsLunarDate=3D"False" Day=3D"30" Month=3D"12" =
Year=3D"1899" =
w:st=3D"on">2.6.12</st1:chsdate>.3'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Do anyone can give me some help =
?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Johnson Cheng<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0097_01C5D63D.C36DA8A0--
