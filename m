Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id 1BF3767A44
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 05:23:11 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k27IN9tT022282
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Mar 2006 10:23:09 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k27IN9Sm011134
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Mar 2006 10:23:09 -0800 (PST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C64214.2F688E1C"
Subject: RE: help reqd
Date: Tue, 7 Mar 2006 10:23:56 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201C47D79@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <prabha.j@tcs.com>, <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C64214.2F688E1C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Possible answers: Module versioning turned on in kernel?  insmod module
format not compatible with kernel ?  Try modprobe which

checks the dependencies.  These calls are kernel space to user space
copy operations. Top 3GB to below 3GB on most systems

unless it's a 2GB/2GB split between user/kernel space.

=20

--

Atul

________________________________

From: linuxppc-embedded-bounces+atul.sabharwal=3Dtek.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+atul.sabharwal=3Dtek.com@ozlabs.org] =
On
Behalf Of prabha.j@tcs.com
Sent: Tuesday, March 07, 2006 3:17 AM
To: linuxppc-embedded@ozlabs.org
Subject: help reqd

=20


Hi all ,=20
I have  a driver and when i am doing insmod the driver its giving
unresolved symbol.=20

insmod: unresolved symbol copy_to_user=20
insmod: unresolved symbol down=20
insmod: unresolved symbol up=20
insmod: unresolved symbol copy_from_user=20

Can anyone suggest me where i am doing wrong.=20
I am using linux-2.4.25 kernel from denx and my board is a
customboard(mpc8260 processor).=20
This is a upm driver and built as a loadable module.=20

Please help me in this regard=20
Thanks in advance.=20
Regards=20

Prabha J.
Tata Consultancy Services Limited
Mailto: prabha.j@tcs.com
Website: http://www.tcs.com

=20
=20
Notice: The information contained in this e-mail message and/or
attachments to it may contain confidential or privileged information. If
you are not the intended recipient, any dissemination, use, review,
distribution, printing or copying of the information contained in this
e-mail message and/or attachments to it are strictly prohibited. If you
have received this communication in error, please notify us by reply
e-mail or telephone and immediately and permanently delete the message
and any attachments. Thank you
=20

------_=_NextPart_001_01C64214.2F688E1C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
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
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:sans-serif;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
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
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle18
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
	{mso-list-id:1245652072;
	mso-list-type:hybrid;
	mso-list-template-ids:1066071222 -286486120 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
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
10.0pt;font-family:Arial;color:navy'>Possible answers: Module versioning =
turned
on in kernel?&nbsp; insmod module format not compatible with kernel =
?&nbsp; Try modprobe
which<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>checks the dependencies.&nbsp; =
These calls are
kernel space to user space copy operations. Top 3GB to below 3GB on most
systems<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>unless it&#8217;s a 2GB/2GB split =
between
user/kernel space.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>--<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Atul<o:p></o:p></span></font></p>

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
linuxppc-embedded-bounces+atul.sabharwal=3Dtek.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+atul.sabharwal=3Dtek.com@ozlabs.org] =
<b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>prabha.j@tcs.com<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Tuesday, March 07, =
2006 3:17
AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> help =
reqd</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><br>
</span></font><font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;
font-family:sans-serif'>Hi all ,</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>I
have &nbsp;a driver and when i am doing insmod the driver its giving =
unresolved
symbol.</span></font> <br>
<br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>insmod:
unresolved symbol copy_to_user</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>insmod:
unresolved symbol down</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>insmod:
unresolved symbol up</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>insmod:
unresolved symbol copy_from_user</span></font> <br>
<br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Can
anyone suggest me where i am doing wrong.</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>I
am using linux-2.4.25 kernel from denx and my board is a =
customboard(mpc8260
processor).</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>This
is a upm driver and built as a loadable module.</span></font> <br>
<br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Please
help me in this regard</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Thanks
in advance.</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Regards</span></font>
<br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'><br>
Prabha J.<br>
Tata Consultancy Services Limited<br>
Mailto: prabha.j@tcs.com<br>
Website: http://www.tcs.com</span></font><o:p></o:p></p>

<pre><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>Notice: =
The information contained in this e-mail message and/or attachments to =
it may contain confidential or privileged information. If you are not =
the intended recipient, any dissemination, use, review, distribution, =
printing or copying of the information contained in this e-mail message =
and/or attachments to it are strictly prohibited. If you have received =
this communication in error, please notify us by reply e-mail or =
telephone and immediately and permanently delete the message and any =
attachments. Thank you<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre></div>

</body>

</html>

------_=_NextPart_001_01C64214.2F688E1C--
