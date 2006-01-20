Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id 1F21D68A38
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jan 2006 05:05:32 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k0KI5WtT014148
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jan 2006 10:05:32 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k0KI5VSA004547
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jan 2006 10:05:31 -0800 (PST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C61DEC.16C648F6"
Subject: RE: u-boot debugging
Date: Fri, 20 Jan 2006 10:06:06 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201AC2CC8@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <atul.sabharwal@exgate.tek.com>, <mustafa.cayir@bte.mam.gov.tr>,
	<linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C61DEC.16C648F6
Content-Type: text/plain;
	charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable

Besides, the BDI has only a 10Mbps Ethernet interface.  It might be =
enough for simple debug operation but they should

Have put a 100Mbps link to put it on a shared network.  For an isolated =
network configuration, it should suffice...

=20

The Metrowerks debugger is USB 2.0 based, so on a isolated network and =
faster data throughput for easy symbol/code

cross referencing.

=20

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Atul Sabharwal

c/o Azad. Inc.

503-962-9395

________________________________

From: Sabharwal, Atul=20
Sent: Friday, January 20, 2006 10:00 AM
To: Sabharwal, Atul; 'Mustafa =C7ay=FDr'; 'linuxppc-embedded@ozlabs.org'
Subject: RE: u-boot debugging

=20

My best guess is the PowerTap Pro supports code tracing from a trace =
buffer on the board or processor... Not sure if

you can sample the processor instruction stream over the JTAG chain as =
its too slow.  You could use a logic analyzer

or an in-circuit emulator to capture all signals.  The power pc has a =
SIU to pass the instruction stream for a logic analyzer

to use...

=20

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Atul Sabharwal

c/o Azad. Inc.

503-962-9395

________________________________

From: Sabharwal, Atul=20
Sent: Friday, January 20, 2006 9:57 AM
To: 'Mustafa =C7ay=FDr'; linuxppc-embedded@ozlabs.org
Subject: RE: u-boot debugging

=20

BDI works but PowerTap Pro from Metrowerks is better.  The debug =
interface is windows based and more user friendly than

Ddd on Linux.  Take your pick as a commercial product would be better =
than an opensource product till it has been perfected

(i.e. customized, all bugs fixed and usability issues resolved).  And no =
service from the community on occasion.

=20

=20

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Atul Sabharwal

c/o Azad. Inc.

503-962-9395

________________________________

From: linuxppc-embedded-bounces@ozlabs.org =
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Mustafa =
=C7ayir
Sent: Thursday, January 19, 2006 10:51 PM
To: linuxppc-embedded@ozlabs.org
Subject: u-boot debugging

=20

Hi,

=20

Which tool must i use to debuggin u-boot codes. BDI2000 or windriver =
visionclick, which one do you prefer? is step by step code tracing =
possible?

=20

thanks


------_=_NextPart_001_01C61DEC.16C648F6
Content-Type: text/html;
	charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-9">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
	color:navy;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:Arial;
	color:navy;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body bgcolor=3Dsilver lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Besides, the BDI has only a 10Mbps =
Ethernet
interface.=A0 It might be enough for simple debug operation but they =
should<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Have put a 100Mbps link to put it =
on a
shared network.=A0 For an isolated network configuration, it should =
suffice&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>The Metrowerks debugger is USB 2.0 =
based,
so on a isolated network and faster data throughput for easy =
symbol/code<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>cross =
referencing.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~</span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Atul Sabharwal</span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>c/o Azad. Inc.</span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>503-962-9395</span></font><o:p></o:p=
></p>

</div>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D3 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> =
Sabharwal, Atul <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Friday, January 20, =
2006
10:00 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Sabharwal, Atul; =
'Mustafa
=C7ay=FDr'; 'linuxppc-embedded@ozlabs.org'<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> RE: u-boot =
debugging</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>My best guess is the PowerTap Pro =
supports
code tracing from a trace buffer on the board or processor&#8230; Not =
sure if<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>you can sample the processor =
instruction
stream over the JTAG chain as its too slow.&nbsp; You could use a logic
analyzer<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>or an in-circuit emulator to =
capture all
signals.&nbsp; The power pc has a SIU to pass the instruction stream for =
a
logic analyzer<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>to =
use&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~</span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Atul Sabharwal</span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>c/o Azad. Inc.</span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>503-962-9395</span></font><o:p></o:p=
></p>

</div>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D3 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> =
Sabharwal, Atul <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Friday, January 20, =
2006
9:57 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> 'Mustafa =C7ay=FDr';
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> RE: u-boot =
debugging</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>BDI works but PowerTap Pro from =
Metrowerks
is better.&nbsp; The debug interface is windows based and more user =
friendly
than<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Ddd on Linux.&nbsp; Take your pick =
as a
commercial product would be better than an opensource product till it =
has been perfected<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>(i.e. customized, all bugs fixed =
and
usability issues resolved).&nbsp; And no service from the community on
occasion.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~</span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Atul Sabharwal</span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>c/o Azad. Inc.</span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>503-962-9395</span></font><o:p></o:p=
></p>

</div>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D3 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-embedded-bounces@ozlabs.org =
[mailto:linuxppc-embedded-bounces@ozlabs.org]
<b><span style=3D'font-weight:bold'>On Behalf Of </span></b>Mustafa =
=C7ayir<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Thursday, January =
19, 2006
10:51 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> u-boot =
debugging</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi,</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Which tool must i use to debuggin u-boot codes. =
BDI2000 or windriver
visionclick, which one do you prefer? is step by step code tracing =
possible?</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>thanks</span></font><o:p></o:p></p>

</div>

</div>

</body>

</html>

------_=_NextPart_001_01C61DEC.16C648F6--
