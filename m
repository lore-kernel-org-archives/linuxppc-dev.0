Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 85D3DDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 07:25:01 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75208.8316573B"
Subject: MPC85xx git branch - problem with Marvel SATA driver...
Date: Fri, 16 Feb 2007 15:25:10 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>
Cc: Geary Sean-R60898 <sean.geary@freescale.com>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75208.8316573B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am looking for ideas here about a problem I am having.

=20

I am working with a new git branch that is supposed to PCI Express on
the CDS.

=20

I have a MPC8548E CDS system plugged into an Arcadia motherboard. I=20

have a PCI Marvel Sata Card plugged into the same Arcadia mother board.

=20

The driver works flawless when there is NO actual SATA Drive plugged
into

this card (the sata_mv driver recognizes and enumerates the ports on
marvel card).=20

=20

The problem comes when I plug a SATA drive into one of the SATA ports on
this card.

When I boot the kernel after doing this and as the sata/ata driver
starts probing the

Sata card/jport for devices - it jumps off to 'never never land' (never
returns from the=20

second write flush of the control register (writing 0x301 to SCR_CONTROL
(and=20

reading it  back) and then writing 0x300 to same register - it never
actually returns

from the writefl of that 0x300 value  to the SCR_Control. =20

=20

FWIW, I have cross ported this driver (and its slightly different ata
infrastructure to a

x86 platform (running a 2.6.19.x kernel) and it does work in that
environment . Further,=20

I have cross ported the original working 2.6.19.1 driver to this git
branch - and it fails=20

in exactly the same spot.

=20

It smells that there is some type of interrupt / configuration mismatch
for the PCI bus for the=20

CDS that is executed upon this probe sequence of a valid SATA/ATA Port?

=20

Has anyone experienced this problem themselves? What can I do? Thanks in
advance=20

for all of your support!

Tom Morrison
Principal Software Engineer

EMPIRIX=20
20 Crosby Drive - Bedford, MA  01730
p: 781.266.3567 f: 781.266.3670=20
email: tmorrison@empirix.com <mailto:tmorrison@empirix.com> =20
www.empirix.com <http://www.empirix.com/>=20




=20


------_=_NextPart_001_01C75208.8316573B
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PostalCode"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"State"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"Street"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"address"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Verdana;
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
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am looking for ideas here about a problem I am =
having.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am working with a new git branch that is supposed =
to PCI
Express on the CDS.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have a MPC8548E CDS system plugged into an =
<st1:City
w:st=3D"on"><st1:place w:st=3D"on">Arcadia</st1:place></st1:City> =
motherboard. I <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>have a PCI Marvel Sata Card plugged into the same =
<st1:City
w:st=3D"on"><st1:place w:st=3D"on">Arcadia</st1:place></st1:City> mother =
board.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The driver works flawless when there is NO actual =
<st1:Street
w:st=3D"on"><st1:address w:st=3D"on">SATA =
Drive</st1:address></st1:Street> plugged
into<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>this card (the sata_mv driver recognizes and =
enumerates the ports
on marvel card). <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The problem comes when I plug a SATA drive into one =
of the
SATA ports on this card.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>When I boot the kernel after doing this and as the =
sata/ata
driver starts probing the<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Sata card/jport for devices &#8211; it jumps off to =
&#8216;never
never land&#8217; (never returns from the <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>second write flush of the control register (writing =
0x301 to
SCR_CONTROL (and <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>reading it&nbsp; back) and then writing 0x300 to same
register &#8211; it never actually returns<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>from the writefl of that 0x300 value&nbsp; to the
SCR_Control. &nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>FWIW, I have cross ported this driver (and its =
slightly
different ata infrastructure to a<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>x86 platform (running a 2.6.19.x kernel) and it does =
work in
that environment . Further, <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have cross ported the original working 2.6.19.1 =
driver to
this git branch &#8211; and it fails <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>in exactly the same =
spot.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>It smells that there is some type of interrupt /
configuration mismatch for the PCI bus for the =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CDS that is executed upon this probe sequence of a =
valid
SATA/ATA Port?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Has anyone experienced this problem themselves? What =
can I
do? Thanks in advance <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>for all of your support!<o:p></o:p></span></font></p>

<p style=3D'margin-bottom:12.0pt'><strong><b><font size=3D2 color=3Dnavy
face=3DVerdana><span =
style=3D'font-size:10.0pt;font-family:Verdana;color:navy'>Tom
Morrison</span></font></b></strong><font size=3D2 color=3Dnavy =
face=3DVerdana><span
style=3D'font-size:10.0pt;font-family:Verdana;color:navy'><br>
</span></font><font color=3Dnavy><span style=3D'color:navy'>Principal =
Software
Engineer</span></font><o:p></o:p></p>

<p style=3D'margin-bottom:12.0pt'><strong><b><font size=3D2 color=3Dnavy
face=3DVerdana><span =
style=3D'font-size:10.0pt;font-family:Verdana;color:navy'>EMPIRIX</span><=
/font></b></strong><font
size=3D2 color=3Dnavy face=3DVerdana><span =
style=3D'font-size:10.0pt;font-family:Verdana;
color:navy'> </span></font><font color=3Dnavy><span =
style=3D'color:navy'><br>
<u1:Street u2:st=3D"on"><u1:address u2:st=3D"on"><st1:Street =
w:st=3D"on"><st1:address
 w:st=3D"on">20 Crosby =
Drive</u1:address></u1:Street></st1:address></st1:Street> =
</span></font><b><font
color=3D"#ff6600"><span =
style=3D'color:#FF6600;font-weight:bold'>-</span></font></b><font
size=3D2 color=3Dnavy face=3DVerdana><span =
style=3D'font-size:10.0pt;font-family:Verdana;
color:navy'> <u1:place u2:st=3D"on"><u1:City u2:st=3D"on"><st1:place =
w:st=3D"on"><st1:City
 w:st=3D"on">Bedford</u1:City></st1:City>, <u1:State =
u2:st=3D"on"><st1:State w:st=3D"on">MA</u1:State></st1:State><b><font
 size=3D3 color=3Dblack face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;
 font-family:"Times New =
Roman";color:black;font-weight:bold'>&nbsp;</span></font></b><font
 size=3D3 color=3Dblack face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;
 font-family:"Times New Roman";color:black'>&nbsp;<u1:PostalCode =
u2:st=3D"on"></span></font><st1:PostalCode
 =
w:st=3D"on">01730</u1:PostalCode></u1:place></st1:PostalCode></st1:place>=
</span></font><br>
<b><font color=3D"#ff6600"><span =
style=3D'color:#FF6600;font-weight:bold'>p:</span></font></b><font
color=3D"#ff6600"><span style=3D'color:#FF6600'> </span></font><font =
size=3D2
color=3Dnavy face=3DVerdana><span =
style=3D'font-size:10.0pt;font-family:Verdana;
color:navy'>781.266.3567 </span></font><b><font size=3D2 =
color=3D"#ff6600"
face=3DVerdana><span =
style=3D'font-size:10.0pt;font-family:Verdana;color:#FF6600;
font-weight:bold'>f:</span></font></b> <font size=3D2 color=3Dnavy =
face=3DVerdana><span
style=3D'font-size:10.0pt;font-family:Verdana;color:navy'>781.266.3670 =
</span></font><b><span
style=3D'font-weight:bold'><br>
</span></b><b><font size=3D2 color=3D"#ff6600" face=3DVerdana><span =
style=3D'font-size:
10.0pt;font-family:Verdana;color:#FF6600;font-weight:bold'>email:</span><=
/font></b>
<u><font size=3D2 color=3Dblue face=3DVerdana><span =
style=3D'font-size:10.0pt;
font-family:Verdana;color:blue'><a =
href=3D"mailto:tmorrison@empirix.com"><font
size=3D3><span =
style=3D'font-size:12.0pt'>tmorrison@empirix.com</span></font></a></span>=
</font></u><font
size=3D2 color=3Dnavy face=3DVerdana><span =
style=3D'font-size:10.0pt;font-family:Verdana;
color:navy'> </span></font><font size=3D2 color=3D"#ff6600" =
face=3DVerdana><span
style=3D'font-size:10.0pt;font-family:Verdana;color:#FF6600'><br>
<a href=3D"http://www.empirix.com/"><font size=3D3><span =
style=3D'font-size:12.0pt'>www.empirix.com</span></font></a></span></font=
><font
size=3D2 color=3Dnavy face=3DVerdana><span =
style=3D'font-size:10.0pt;font-family:Verdana;
color:navy'><br>
<br>
<br>
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C75208.8316573B--
