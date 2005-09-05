Return-Path: <kirankumar_a@mindtree.com>
Received: from MTW01EXOG01.mindtree.com (mtwmail.mindtree.com [203.200.60.136])
	by ozlabs.org (Postfix) with SMTP id 2800868110
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Sep 2005 00:32:07 +1000 (EST)
MIME-Version: 1.0
Date: Mon, 5 Sep 2005 19:39:43 +0530
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_12E7_01C5B251.90478AF0"
Message-ID: <2C15D00D262B7245B1D8D1799F04D88F021BA0@mtw01ex01.mindtree.com>
From: "Kiran A. Kumar" <kirankumar_a@mindtree.com>
To: <linuxppc-dev@ozlabs.org>
Subject: mvme6100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_12E7_01C5B251.90478AF0
Content-Transfer-Encoding: 7bit
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5B223.76787FD2"


------_=_NextPart_001_01C5B223.76787FD2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi ,

=20

As per following dump..i'm clueless help me out..

We r doing mvme6100 linux 2.6.7 bluecat

=20

Passing control to the loaded file/image.

loaded at:     00800000start at:      00800000image begin at:  =
00805930image
end at   :  00990FDB 00DD5800

zimage at:     00805930 00990FDB

initrd at:     00995000 00DD5800

avail ram:     00400000 00800000

=20

Linux/PPC load: console=3DttyS0,9600 console=3Dtty0 root=3D/dev/sda2
console=3DttyS0,9600 root=3D/dev/ram rw

Uncompressing Linux...done.

Now booting the kernel...

=20

It hangs here..plz help me what could be wrong..

=20

Regards,

Kiran kumar A


------_=_NextPart_001_01C5B223.76787FD2
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
 /* Font Definitions */
 @font-face
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"\@Batang";}
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
font-family:Arial'>Hi ,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>As per following dump..i&#8217;m clueless help me =
out..<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>We r doing mvme6100 linux 2.6.7 =
bluecat<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Passing control to the loaded =
file/image.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>loaded at:&nbsp;&nbsp;&nbsp;&nbsp; 00800000start
at:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00800000image begin at:&nbsp; =
00805930image
end at&nbsp;&nbsp; :&nbsp; 00990FDB =
00DD5800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 00805930 =
00990FDB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>initrd at:&nbsp;&nbsp;&nbsp;&nbsp; 00995000 =
00DD5800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 00400000 =
00800000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Linux/PPC load: console=3DttyS0,9600 console=3Dtty0
root=3D/dev/sda2 console=3DttyS0,9600 root=3D/dev/ram =
rw<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Uncompressing =
Linux...done.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Now booting the =
kernel&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>It hangs here..plz help me what could be =
wrong..<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Kiran kumar A<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C5B223.76787FD2--

------=_NextPart_000_12E7_01C5B251.90478AF0
Content-Type: text/plain;
	name="disclaimer.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="disclaimer.txt"

-------------------------------------------------------------------------=
----------------------------------------------------
Disclaimer
-------------------------------------------------------------------------=
----------------------------------------------------

"This message(including attachment if any)is confidential and may be =
privileged.Before opening attachments please check them
for viruses and defects.MindTree Consulting Private Limited =
(MindTree)will not be responsible for any viruses or defects or
any forwarded attachments emanating either from within MindTree or =
outside.If you have received this message by mistake please notify the =
sender by return  e-mail and delete this message from your system. Any =
unauthorized use or dissemination of this message in whole or in part is =
strictly prohibited.  Please note that e-mails are susceptible to change =
and MindTree shall not be liable for any improper, untimely or =
incomplete transmission."

-------------------------------------------------------------------------=
----------------------------------------------------
------=_NextPart_000_12E7_01C5B251.90478AF0--
