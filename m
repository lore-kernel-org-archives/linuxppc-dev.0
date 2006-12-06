Return-Path: <Marta.Chamorro@XEROX.COM>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7197A.76775F36"
Subject: Power management for ppc 85xx
Date: Wed, 6 Dec 2006 21:06:56 -0000
Message-ID: <BFEE19E1D0DBF84698D76276388DCB843F207B@gbrwgceumf01.eu.xerox.net>
From: "Chamorro, Marta" <Marta.Chamorro@XEROX.COM>
To: <linuxppc-dev@ozlabs.org>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7197A.76775F36
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi there!

=20

Hope someone out there can give me some pointers here. I've got a 2.6.18
kernel on a ppc 8555, which I configured to enable power management
(CONFIG_PM=3Dy). After doing that, the file /sys/power/state appears on =
my
file system. If I cat the file I get "standby mem" (without the quotes),
but if I try to write to it (to change the state) I get an EPERM. I
assume it is because I have no code that implements any power save mode
changes, only the interface to change them. Am I wrong? How can I tell
for sure? (the file is writable, so it is not a problem with writing
permissions)

=20

So the question is (if I am right) where do I get the code from? I am
hoping someone has implemented power save for that processor already,
but I just don't know where to start looking for that code. Can someone
help?=20

=20

Thanks very much in advance.

=20

Marta Chamorro.


------_=_NextPart_001_01C7197A.76775F36
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
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
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-GB link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi there!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hope someone out there can give me some pointers =
here. I&#8217;ve
got a 2.6.18 kernel on a ppc 8555, which I configured to enable power
management (CONFIG_PM=3Dy). After doing that, the file /sys/power/state =
appears
on my file system. If I cat the file I get &#8220;standby mem&#8221; =
(without
the quotes), but if I try to write to it (to change the state) I get an =
EPERM. I
assume it is because I have no code that implements any power save mode =
changes,
only the interface to change them. Am I wrong? How can I tell for sure? =
(the
file is writable, so it is not a problem with writing =
permissions)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>So the question is (if I am right) where do I get the =
code
from? I am hoping someone has implemented power save for that processor
already, but I just don&#8217;t know where to start looking for that =
code. Can someone
help? <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks very much in =
advance.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Marta Chamorro.<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C7197A.76775F36--
