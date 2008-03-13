Return-Path: <John.Linn@xilinx.com>
Received: from outbound1-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 589C7DE409
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Mar 2008 04:12:08 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8852D.5889E8E2"
Subject: RE: Using GDB with Abatron's BDI2000 and the ppc405 in the Xilinx
	VirtexII Pro
Date: Thu, 13 Mar 2008 11:11:57 -0600
In-Reply-To: <0F3B2CB6574F1A488E62523706BF8A7703F295E7@LOUMLVEM03.e2k.ad.ge.com>
References: <0F3B2CB6574F1A488E62523706BF8A7703F295E7@LOUMLVEM03.e2k.ad.ge.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "Wood, Robert (GE EntSol, Intelligent Platforms)" <robert.wood@gefanuc.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080313171200.B4E22210078@mail227-sin.bigfish.com>
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

------_=_NextPart_001_01C8852D.5889E8E2
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi Robert,

=20

Here's a link to an app note on it. I'm using it on the 405 right now as
we speak.  I used the app note to get it working.

=20

If you have problems, let me know.

=20

http://www.xilinx.com/support/documentation/application_notes/xapp981.pd
f

=20

Thanks,

John Linn

Xilinx Open Source Linux Engineer

=20

________________________________

From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of Wood, Robert (GE EntSol,Intelligent Platforms)
Sent: Thursday, March 13, 2008 9:48 AM
To: linuxppc-embedded@ozlabs.org
Subject: Using GDB with Abatron's BDI2000 and the ppc405 in the Xilinx
VirtexII Pro

=20

Hi, sorry for what is probably  previously covered subject., I am
searching the archives.

=20

We need a simple description of how to get GDB running with the BDI2000.
We have the '2000 communicating and can access the registers and like
through the telnet link but don't know how to configure the unit or GDB
to work together.

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

=20


------_=_NextPart_001_01C8852D.5889E8E2
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
 name=3D"place"/>
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
h1
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.3in;
	text-indent:-.3in;
	page-break-after:avoid;
	mso-list:l0 level1 lfo3;
	font-size:16.0pt;
	font-family:Arial;}
h2
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:12.0pt;
	margin-left:.4in;
	text-indent:-.4in;
	page-break-after:avoid;
	mso-list:l0 level2 lfo3;
	font-size:14.0pt;
	font-family:"Times New Roman";}
h3
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:.5in;
	text-indent:-.5in;
	page-break-after:avoid;
	mso-list:l1 level3 lfo6;
	font-size:13.0pt;
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
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1143350910;
	mso-list-template-ids:1338282562;}
@list l0:level1
	{mso-level-style-link:"Heading 1";
	mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l0:level2
	{mso-level-style-link:"Heading 2";
	mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l0:level3
	{mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l0:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l0:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l0:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l0:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l0:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l0:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
@list l1
	{mso-list-id:1860200171;
	mso-list-template-ids:1400561736;}
@list l1:level1
	{mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l1:level2
	{mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l1:level3
	{mso-level-reset-level:level2;
	mso-level-style-link:"Heading 3";
	mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l1:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l1:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l1:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l1:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l1:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l1:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
@list l2
	{mso-list-id:2077240681;
	mso-list-template-ids:-762429638;}
@list l2:level1
	{mso-level-text:%1;
	mso-level-tab-stop:.3in;
	mso-level-number-position:left;
	margin-left:.3in;
	text-indent:-.3in;}
@list l2:level2
	{mso-level-text:"%1\.%2";
	mso-level-tab-stop:.4in;
	mso-level-number-position:left;
	margin-left:.4in;
	text-indent:-.4in;}
@list l2:level3
	{mso-level-text:"%1\.%2\.%3";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	margin-left:.5in;
	text-indent:-.5in;}
@list l2:level4
	{mso-level-text:"%1\.%2\.%3\.%4";
	mso-level-tab-stop:.6in;
	mso-level-number-position:left;
	margin-left:.6in;
	text-indent:-.6in;}
@list l2:level5
	{mso-level-text:"%1\.%2\.%3\.%4\.%5";
	mso-level-tab-stop:.7in;
	mso-level-number-position:left;
	margin-left:.7in;
	text-indent:-.7in;}
@list l2:level6
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6";
	mso-level-tab-stop:.8in;
	mso-level-number-position:left;
	margin-left:.8in;
	text-indent:-.8in;}
@list l2:level7
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7";
	mso-level-tab-stop:.9in;
	mso-level-number-position:left;
	margin-left:.9in;
	text-indent:-.9in;}
@list l2:level8
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8";
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	margin-left:1.0in;
	text-indent:-1.0in;}
@list l2:level9
	{mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9";
	mso-level-tab-stop:1.1in;
	mso-level-number-position:left;
	margin-left:1.1in;
	text-indent:-1.1in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hi =
Robert,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Here&#8217;s a link to an app note =
on it. I&#8217;m
using it on the 405 right now as we speak.&nbsp; I used the app note to =
get it
working.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>If you have problems, let me =
know.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>http://www.xilinx.com/support/docume=
ntation/application_notes/xapp981.pdf<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Thanks,<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>John =
Linn<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Xilinx Open Source Linux =
Engineer<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

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
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] =
<b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>Wood, Robert (GE
EntSol,Intelligent Platforms)<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Thursday, March 13, =
2008
9:48 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Using GDB with =
Abatron's
BDI2000 and the ppc405 in the Xilinx VirtexII =
Pro</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi, sorry for what is probably&nbsp; previously =
covered
subject., I am searching the archives.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>We need a simple description of how to get GDB =
running with
the BDI2000. We have the &#8216;2000 communicating and can access the =
registers
and like through the telnet link but don&#8217;t know how to configure =
the unit
or GDB to work together.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><strong><b><font size=3D2 face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial'>Robert =
Wood</span></font></b></strong><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Senior Engineer</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>GE Fanuc Intelligent =
Platforms</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>T +613 749 9241 x270</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>F +613 749 9461</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>E <a =
href=3D"mailto:robert.wood@gefanuc.com">robert.wood@gefanuc.com</a></span=
></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><a =
href=3D"http://www.ge.com">www.ge.com</a></span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><st1:Street w:st=3D"on"><st1:address =
w:st=3D"on"><font size=3D2
  face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'>5430 =
Canotek Road</span></font></st1:address></st1:Street><o:p></o:p></p>

<p class=3DMsoNormal><st1:place w:st=3D"on"><st1:City w:st=3D"on"><font =
size=3D2
  face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Ottawa</span></font></st1:Ci=
ty><font
 size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>, <st1:State
 =
w:st=3D"on">Ontario</st1:State></span></font></st1:place><o:p></o:p></p>

<p class=3DMsoNormal><st1:place w:st=3D"on"><st1:country-region =
w:st=3D"on"><font
  size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Canada</span></font></st1:co=
untry-region></st1:place><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> K1J =
9G2</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span =
style=3D'font-size:7.5pt;
font-family:Arial'>General Electric Company</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8852D.5889E8E2--
