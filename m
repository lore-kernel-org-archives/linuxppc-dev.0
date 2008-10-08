Return-Path: <John.Linn@xilinx.com>
Received: from IE1EHSOBE005.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 9C214DDF12
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 01:32:01 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C92952.987E76BD"
Subject: RE: Could XUP be uesd as a SMP platform
Date: Wed, 8 Oct 2008 08:31:47 -0600
In-Reply-To: <2c8360dd0810072349v4409f49ei7c0c45fc8dd4e798@mail.gmail.com>
References: <2c8360dd0810072349v4409f49ei7c0c45fc8dd4e798@mail.gmail.com>
From: John Linn <John.Linn@xilinx.com>
To: =?GB2312?B?1cXp8w==?= <zhangyihere@gmail.com>,
	<linuxppc-dev@ozlabs.org>
Message-ID: <20081008143150.0FA1A1440071@mail97-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C92952.987E76BD
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable

No, the PowerPC 405s can=A1=AFt be used as a SMP platform.  The 405 caches =
are not designed with cache coherency for SMP.

 =


Thanks,

John

 =


 =


________________________________

From: linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org [mailto:linuxp=
pc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of ??
Sent: Wednesday, October 08, 2008 12:49 AM
To: linuxppc-dev@ozlabs.org
Subject: Could XUP be uesd as a SMP platform

 =


Hi  all,

I am working with a Xilinx Virtex II Pro evaluation board, which has two Po=
werPC 405 and I have ported linux 2.6.24 onto that board when there is one =
PPC405 configured.

I'd like to use this board as a SMP platform. Is it feasible?

If it works, what steps should i follow? Could you give me some recommendat=
ions or any literatures I could refer to?

Thanks a lot!



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C92952.987E76BD
Content-Type: text/html; charset="GB2312"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dgb2312">
<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>

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

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>No, the PowerPC 405s can=A1=AFt be use=
d as a
SMP platform. &nbsp;The 405 caches are not designed with cache coherency fo=
r SMP.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>John<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div style=3D'border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt'>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font siz=
e=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span style=3D'font-si=
ze:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org] <b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>??<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Wednesday, October 08,=
 2008
12:49 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> linuxppc-dev@ozlabs.org<=
br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Could XUP be uesd a=
s a
SMP platform</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Hi&nbsp; all,<br>=

<br>
I am working with a Xilinx Virtex II Pro evaluation board, which has two
PowerPC 405 and I have ported linux 2.6.24 onto that board when there is on=
e
PPC405 configured.<br>
<br>
I'd like to use this board as a SMP platform. Is it feasible?<br>
<br>
If it works, what steps should i follow? Could you give me some recommendat=
ions
or any literatures I could refer to?<br>
<br>
Thanks a lot!<o:p></o:p></span></font></p>

</div>

</div>

</div>

<br clear=3Dall> This email and any attachments are intended for the sole u=
se of the named recipient(s) and contain(s) confidential information that m=
ay be proprietary, privileged or copyrighted under applicable law. If you a=
re not the intended recipient, do not read, copy, or forward this email mes=
sage or any attachments. Delete this email message and any attachments imme=
diately.
</body>

</html>


------_=_NextPart_001_01C92952.987E76BD--
