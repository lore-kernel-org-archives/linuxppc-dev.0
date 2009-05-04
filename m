Return-Path: <tmorrison@empirix.com>
Received: from empbedexfe.empirix.com (empbedexfe.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id E8CBFDDDA9
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 08:36:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9CD07.40B7D272"
Subject: MSR_SPE - being turned off...
Date: Mon, 4 May 2009 18:25:38 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90110C30B99@EMPBEDEX.empirix.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9CD07.40B7D272
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have both a MPC8548 SBC and MPC8572 system that are running different
flavors of the=20

same Linux - 2.6.23.

=20

I explicitly am turning it on very early on. Later, I have an
application that is compiled=20

with SPE instructions (e.g.: evstdd) , and there is where the problems
happen. If I explicitly

make sure there are NO SPE instructions in the application, nothing bad
happens!=20

=20

I am polling the MSR - and it seems the SPE is turned OFF?=20

=20

What have I done wrong and/or has there been fixes in later kernels that
I should be aware of that might help this issue?

=20

Tom Morrison
Principal Software Engineer

EMPIRIX=20
20 Crosby Drive - Bedford, MA  01730
p: 781.266.3567 f: 781.266.3670=20
email: tmorrison@empirix.com <mailto:tmorrison@empirix.com> =20
www.empirix.com <http://www.empirix.com/>=20




=20


------_=_NextPart_001_01C9CD07.40B7D272
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
 name=3D"place"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"Street"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"address"/>
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
font-family:Arial'>I have both a MPC8548 SBC and MPC8572 system that are
running different flavors of the <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>same Linux &#8211; =
2.6.23.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I explicitly am turning it on very early on. Later, I =
have
an application that is compiled <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>with SPE instructions (e.g.: evstdd) , and there is =
where
the problems happen. If I explicitly<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make sure there are NO SPE instructions in the =
application,
nothing bad happens! <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am polling the MSR &#8211; and it seems the SPE is =
turned
OFF? <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>What have I done wrong and/or has there been fixes in =
later
kernels that I should be aware of that might help this =
issue?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

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

------_=_NextPart_001_01C9CD07.40B7D272--
