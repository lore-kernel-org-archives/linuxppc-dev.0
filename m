Return-Path: <robert.wood@gefanuc.com>
Received: from ext-ch1gw-8.online-age.net (ext-ch1gw-8.online-age.net
	[64.37.194.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-ch1gw.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8FC0ADE042
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Mar 2008 05:00:33 +1100 (EST)
Received: from int-ch1gw-3.online-age.net (int-ch1gw-3 [3.159.232.67])
	by ext-ch1gw-8.online-age.net (8.13.6/8.13.6/20051111-SVVS-TLS-DNSBL)
	with ESMTP id m2DGtXvJ001505
	for <linuxppc-embedded@ozlabs.org>; Thu, 13 Mar 2008 12:55:33 -0400
Received: from cinmlef10.e2k.ad.ge.com (int-ch1gw-3 [3.159.232.67])
	by int-ch1gw-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m2DGtVLn021720 for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 12:55:32 -0400 (EDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8852B.09641B5E"
Subject: RE: Using GDB with Abatron's BDI2000 and the ppc405 in the Xilinx
	VirtexII Pro
Date: Thu, 13 Mar 2008 12:55:26 -0400
Message-ID: <0F3B2CB6574F1A488E62523706BF8A7703F295EB@LOUMLVEM03.e2k.ad.ge.com>
In-Reply-To: <EE63F03D9E04774997AEBCD21FC77F251BB1CC@ccomm-ex1.ccomm.com>
References: <EE63F03D9E04774997AEBCD21FC77F251BB1CC@ccomm-ex1.ccomm.com>
From: "Wood, Robert (GE EntSol,
	Intelligent Platforms)" <robert.wood@gefanuc.com>
To: "Sugathan, Rupesh" <rs@carriercomm.com>, <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C8852B.09641B5E
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Thanks for the help. The archives were tedious to search but very
enlightening.

=20

Robert Wood

Senior Engineer

GE Fanuc Intelligent Platforms

=20

T +613 749 9241 x270

F +613 749 9461

E robert.wood@gefanuc.com

www.ge.com

=20

5430 Canotek Road

Ottawa, Ontario

Canada K1J 9G2

General Electric Company

=20

________________________________

From: Sugathan, Rupesh [mailto:rs@carriercomm.com]=20
Sent: Thursday, March 13, 2008 12:52 PM
To: Wood, Robert (GE EntSol, Intelligent Platforms);
linuxppc-embedded@ozlabs.org
Subject: RE: Using GDB with Abatron's BDI2000 and the ppc405 in the
Xilinx VirtexII Pro

=20

We need a simple description of how to get GDB running with the BDI2000.
We have the '2000 communicating and can access the registers and like
through the telnet link but don't know how to configure the unit or GDB
to work together.

=20

See if these helps

http://www.unimax.co.kr/unimax_2003_11/products/datasheets/ManGDBPPC-200
0C5.pdf
http://microcross.com/Debugging_Linux_Kernel.pdf
<http://microcross.com/Debugging_Linux_Kernel.pdf>=20

http://ultsol.com/pdfs/ <http://ultsol.com/pdfs/>=20

=20

=20

Thanks

--

Rupesh Sugathan

=20


------_=_NextPart_001_01C8852B.09641B5E
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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
name=3D"country-region"/>
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
	color:windowtext;}
span.EmailStyle18
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

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Thanks for the help. The archives =
were
tedious to search but very enlightening.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal><strong><b><font size=3D2 color=3Dnavy =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>Robert =
Wood</span></font></b></strong><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Senior Engineer</span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>GE Fanuc Intelligent =
Platforms</span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'>&nbsp;<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>T +613 749 9241 =
x270</span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>F +613 749 9461</span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>E <a =
href=3D"mailto:robert.wood@gefanuc.com">robert.wood@gefanuc.com</a></span=
></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><a =
href=3D"http://www.ge.com">www.ge.com</a></span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'>&nbsp;<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><st1:Street w:st=3D"on"><st1:address =
w:st=3D"on"><font size=3D2
  color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
  color:navy'>5430 Canotek =
Road</span></font></st1:address></st1:Street><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><st1:place w:st=3D"on"><st1:City w:st=3D"on"><font =
size=3D2
  color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
  color:navy'>Ottawa</span></font></st1:City><font size=3D2 color=3Dnavy
 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>, <st1:State
 w:st=3D"on">Ontario</st1:State></span></font></st1:place><font =
color=3Dnavy><span
style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><st1:country-region w:st=3D"on"><st1:place =
w:st=3D"on"><font
  size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
  color:navy'>Canada</span></font></st1:place></st1:country-region><font
size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial;
color:navy'> K1J 9G2</span></font><font color=3Dnavy><span =
style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
style=3D'font-size:
7.5pt;font-family:Arial;color:navy'>General Electric =
Company</span></font><font
color=3Dnavy><span style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New =
Roman"><span
style=3D'font-size:12.0pt;color:navy'>&nbsp;</span></font><o:p></o:p></p>=


</div>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> =
Sugathan, Rupesh
[mailto:rs@carriercomm.com] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Thursday, March 13, =
2008
12:52 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Wood, Robert (GE =
EntSol,
Intelligent Platforms); linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> RE: Using GDB =
with
Abatron's BDI2000 and the ppc405 in the Xilinx VirtexII =
Pro</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>We need a simple description of how to get GDB =
running with
the BDI2000. We have the &#8216;2000 communicating and can access the =
registers
and like through the telnet link but don&#8217;t know how to configure =
the unit
or GDB to work together.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;</span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>See if these helps<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><a
href=3D"http://www.unimax.co.kr/unimax_2003_11/products/datasheets/ManGDB=
PPC-2000C5.pdf">http://www.unimax.co.kr/unimax_2003_11/products/datasheet=
s/ManGDBPPC-2000C5.pdf</a><br>
<a href=3D"http://microcross.com/Debugging_Linux_Kernel.pdf" =
target=3D"_blank"><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'>http://microcross.com/Debugging_Linux_Kernel.pdf</span></font></a=
><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><a href=3D"http://ultsol.com/pdfs/" =
target=3D"_blank"><wbr><font
size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman"'>http://ultsol.com/pdfs/</span></font></a><o:p></o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;</span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>--<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Rupesh Sugathan<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;</span></font><font color=3Dblue face=3DArial><span =
style=3D'font-family:
Arial;color:blue'><o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8852B.09641B5E--
