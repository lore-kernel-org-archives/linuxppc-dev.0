Return-Path: <srinavakalav@hcl.in>
Received: from gws04.hcl.in (gws04.mail.hcl.in [203.105.186.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gws04.hcl.in",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BA66DDDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 03:47:15 +1100 (EST)
Received: from gws04.hcl.in (gws04 [10.249.64.135])
	by localhost.hcl.in (Postfix) with ESMTP id 5C5B53663DE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Nov 2007 22:11:51 +0530 (IST)
Received: from chn-egw02-out.corp.hcl.in (unknown [10.249.64.38])by
	gws04.hcl.in (Postfix) with ESMTP id 361F736600Bfor
	<linuxppc-embedded@ozlabs.org>; Mon, 12 Nov 2007 22:11:51 +0530 (IST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8254A.ECA1D2C6"
Subject: MPC5200B - Mapping Micrel Ethernet Controller Chip 
Date: Mon, 12 Nov 2007 22:11:49 +0530
Message-ID: <66E8AEE9980BB44CA5FCAD39EBA56AC602D55576@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
From: "Sri nava kala devi Valteti, TLS-Chennai" <srinavakalav@hcl.in>
To: <linuxppc-embedded@ozlabs.org>
Cc: "Prakash Palanisamy, TLS-Chennai" <prakashp@hcl.in>
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

------_=_NextPart_001_01C8254A.ECA1D2C6
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable


Hi,

We are using MPC5200B based custom board=2E In that we have an external
Micrel's ethernet controller mapped at 0xE0000000=2E=20

We have taken Lite5200 code as a reference to port linux to our new
board=2E We have integrated the ethernet driver given by the vendor
(Micrel)=2E=20

Unfortunately, we are not able to access the chip mapped at 0xE0000000=2E

=20

We performed the following steps to access the chip:

i) We mapped this address range of the Ethernet Controller Chip in
function "mpc52xx_map_io" as

"io_block_mapping(0xE0000000, 0xE0000000, 0x10000000, _PAGE_IO)"

=20

ii) We tried to remap the address range using ioremap function, but we
got the same address (Virtual Address similar to IO logical Address)
even after the ioremap=2E

=20

Can any one plz help us on how to map and access our chip?  =20

=20

Thanks,

Kala=2E



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
 is strictly prohibited=2E If you have=20
received this email in error please delete it and notify the sender=
 immediately=2E Before opening any mail and=20
attachments please check them for viruses and defect=2E

---------------------------------------------------------------------------=
--------------------------------------------
------_=_NextPart_001_01C8254A.ECA1D2C6
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=
=3D"urn:schemas-microsoft-com:office:word" xmlns=3D"http://www=2Ew3=
=2Eorg/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
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
font-family:Arial'>We are using MPC5200B based custom board=2E In that we=
 have an
external Micrel's ethernet controller mapped at 0xE0000000=2E=
 <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>We have taken Lite5200 code as a reference to port linux=
 to
our new board=2E We have integrated the ethernet driver given by the vendor=
 (Micrel)=2E
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Unfortunately, we are not able to access the chip mapped=
 at
0xE0000000=2E<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>We performed the following steps to access the=
 chip:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>i) We mapped this address range of the Ethernet=
 Controller
Chip in function &quot;mpc52xx_map_io&quot; as<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:=2E5in'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=
=2E0pt;font-family:Arial'>&quot;io_block_mapping(0xE0000000,
0xE0000000, 0x10000000, _PAGE_IO)&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-indent:=2E5in'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=
=2E0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>ii) We tried to remap the address range using ioremap
function, but we got the same address (Virtual Address similar to IO=
 logical
Address) even after the ioremap=2E<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Can any one plz help us on how to map and access our=
 chip?&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Kala=2E<o:p></o:p></span></font></p>

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
 is strictly prohibited=2E If you have <br>
received this email in error please delete it and notify the sender=
 immediately=2E Before opening any mail and <br>
attachments please check them for viruses and defect=2E<br>
<br>
---------------------------------------------------------------------------=
--------------------------------------------<br>
</font></td></tr></table>
------_=_NextPart_001_01C8254A.ECA1D2C6--
