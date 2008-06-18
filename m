Return-Path: <sanandkumar@hcl.in>
Received: from gws03.hcl.in (gws03.mail.hcl.in [203.105.186.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gws03.hcl.in",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2F787DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jun 2008 17:14:16 +1000 (EST)
Received: from gws03.hcl.in (gws03 [10.249.64.134])
	by localhost.hcl.in (Postfix) with ESMTP id 7508E37C167
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jun 2008 12:34:49 +0530 (IST)
Received: from chn-egw02-out.corp.hcl.in (unknown [10.249.64.38])by
	gws03.hcl.in (Postfix) with ESMTP id 4331337C1A0for
	<linuxppc-embedded@ozlabs.org>; Wed, 18 Jun 2008 12:34:49 +0530 (IST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8D111.988F31FE"
Subject: u-boot for ML403
Date: Wed, 18 Jun 2008 12:34:48 +0530
Message-ID: <66E8AEE9980BB44CA5FCAD39EBA56AC6049EC842@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
From: "Anand Kumar S" <sanandkumar@hcl.in>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8D111.988F31FE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,

=20

I am new to virtex 4 platform and i am trying to bringup u-boot on ML403
board=2E I download u-boot=2Ezip ftrom ML410 site and am trying to compile
it for

ML403 using the following command

=20

make ml403_config

make

=20

and i am getting the following error=2E

=20

 =2E=2E/xilinx_iic/iic_adapter=2Ec: In function 'receive':

=2E=2E=2E/xilinx_iic/iic_adapter=2Ec:91: error: 'XIIC_STOP' undeclared=
 (first use
in this function)

=2E=2E=2E/xilinx_iic/iic_adapter=2Ec:91: error: too many arguments to=
 function
'XIic_Send'

=2E=2E=2E/xilinx_iic/iic_adapter=2Ec:96: error: too many arguments to=
 function
'XIic_Recv'

make[1]: *** [=2E=2E/xilinx_iic/iic_adapter=2Eo] Error 1

=20

Am i missing some files or patch here? Does someone have a ready made
code for u-boot on ML403? If so can you

please share it with me=2E =20

=20

=20

Thanks & Rgds

=20

Anand

=20



DISCLAIMER:
---------------------------------------------------------------------------=
--------------------------------------------

The contents of this e-mail and any attachment(s) are confidential and=
 intended for the named recipient(s) only=2E
It shall not attach any liability on the originator or HCL or its=
 affiliates=2E Any views or opinions presented in=20
this email are solely those of the author and may not necessarily reflect=
 the opinions of HCL or its affiliates=2E
Any form of reproduction, dissemination, copying, disclosure, modification,=
 distribution and / or publication of=20
this message without the prior written consent of the author of this e-mail=
 is strictly prohibited=2E If you have
received this email in error please delete it and notify the sender=
 immediately=2E Before opening any mail and=20
attachments please check them for viruses and defect=2E

---------------------------------------------------------------------------=
--------------------------------------------
------_=_NextPart_001_01C8D111.988F31FE
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=
=3D"urn:schemas-microsoft-com:office:word" xmlns=3D"http://www=2Ew3=
=2Eorg/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p=2EMsoNormal, li=2EMsoNormal, div=2EMsoNormal
	{margin:0in;
	margin-bottom:=2E0001pt;
	font-size:12=2E0pt;
	font-family:"Times New Roman";}
a:link, span=2EMsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span=2EMsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span=2EEmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8=2E5in 11=2E0in;
	margin:1=2E0in 1=2E25in 1=2E0in 1=2E25in;}
div=2ESection1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>I am
new to virtex 4 platform and i am trying to bringup u-boot on ML403 board=
=2E I
download u-boot=2Ezip ftrom ML410 site and am trying to compile it=
 for<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>ML403
using the following command<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>make
ml403_config<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>make<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>and i
am getting the following error=2E<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>&nbsp;=2E=2E/xilinx_iic/iic_adapter=
=2Ec:
In function 'receive':<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>=2E=2E/xilinx_iic/iic_adapter=2Ec:91:
error: 'XIIC_STOP' undeclared (first use in this=
 function)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>=2E=2E/xilinx_iic/iic_adapter=2Ec:91:
error: too many arguments to function=
 'XIic_Send'<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>=2E=2E/xilinx_iic/iic_adapter=2Ec:96:
error: too many arguments to function=
 'XIic_Recv'<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>make[1]:
*** [=2E=2E/xilinx_iic/iic_adapter=2Eo] Error=
 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>Am i
missing some files or patch here? Does someone have a ready made code for
u-boot on ML403? If so can you<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>please
share it with me=2E &nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>Thanks
&amp; Rgds<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-align:justify'><font size=3D2 color=
=3Dblack
face=3DArial><span style=3D'font-size:10=
=2E0pt;font-family:Arial;color:black'>Anand<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000>DISCLAIMER:<br>
---------------------------------------------------------------------------=
--------------------------------------------<br>
<br>
The contents of this e-mail and any attachment(s) are confidential and=
 intended for the named recipient(s) only=2E<br>
It shall not attach any liability on the originator or HCL or its=
 affiliates=2E Any views or opinions presented in <br>
this email are solely those of the author and may not necessarily reflect=
 the opinions of HCL or its affiliates=2E<br>
Any form of reproduction, dissemination, copying, disclosure, modification,=
 distribution and / or publication of <br>
this message without the prior written consent of the author of this e-mail=
 is strictly prohibited=2E If you have<br>
received this email in error please delete it and notify the sender=
 immediately=2E Before opening any mail and <br>
attachments please check them for viruses and defect=2E<br>
<br>
---------------------------------------------------------------------------=
--------------------------------------------<br>
</font></td></tr></table>
------_=_NextPart_001_01C8D111.988F31FE--
