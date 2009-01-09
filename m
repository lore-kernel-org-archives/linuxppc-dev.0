Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE001.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id F1299DDFCE
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jan 2009 02:52:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C97272.4A36E7ED"
Subject: RE: Linux on Memec Virtex4 FX12 Minimodule
Date: Fri, 9 Jan 2009 08:52:33 -0700
In-Reply-To: <20090107010200.GA89569@taurus.el-kfa.net>
References: <20090107010200.GA89569@taurus.el-kfa.net>
From: John Linn <John.Linn@xilinx.com>
To: "Pawel P. Kusmierski" <loko-r@el-kfa.net>,
	<linuxppc-dev@ozlabs.org>
Message-ID: <20090109155237.38F0914005C@mail39-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C97272.4A36E7ED
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pawel,

 =


Sorry for the delay, I just missed this message.

 =


You should really be building arch/powerpc not arch/ppc as no one is
going to support that.  I realize that's a pain, but arch/ppc has been
dead for about 6 months now.

 =


http://xilinx.wikidot.com <http://xilinx.wikidot.com/>  has a lot more
information about building the kernel from our GIT tree.

 =


You can also post to http://forums.xilinx.com
<http://forums.xilinx.com/>  in the Embedded Linux forum for more Xilinx
specific help.

 =


I don't understand you're problem either, but I would try building 1st
with arch=3Dpowerpc and using the ramdisk image that we have on our wiki
to get a good baseline.  You'll need to generate a device tree for your
hardware platform but that's not too hard and is explained on the wiki
also.

 =


Thanks,

John

 =


 =


________________________________

From: linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf
Of Pawel P. Kusmierski
Sent: Tuesday, January 06, 2009 6:02 PM
To: linuxppc-dev@ozlabs.org
Subject: Linux on Memec Virtex4 FX12 Minimodule

 =


 =




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C97272.4A36E7ED
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
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
10.0pt;font-family:Arial;color:navy'>Hi Pawel,<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Sorry for the delay, I just missed thi=
s
message.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>You should really be building arch/pow=
erpc
not arch/ppc as no one is going to support that.&nbsp; I realize that&#8217=
;s a
pain, but arch/ppc has been dead for about 6 months now.<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><a href=3D"http://xilinx.wikidot.com/"=
>http://xilinx.wikidot.com</a>
has a lot more information about building the kernel from our GIT tree.<o:p=
></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>You can also post to <a
href=3D"http://forums.xilinx.com/">http://forums.xilinx.com</a> in the Embe=
dded
Linux forum for more Xilinx specific help.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I don&#8217;t understand you&#8217;re
problem either, but I would try building 1<sup>st</sup> with arch=3Dpowerpc=
 and
using the ramdisk image that we have on our wiki to get a good baseline. &n=
bsp;You&#8217;ll
need to generate a device tree for your hardware platform but that&#8217;s =
not
too hard and is explained on the wiki also.<o:p></o:p></span></font></p>

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
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> linuxppc=
-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org] <b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>Pawel P. Kusmierski<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Tuesday, January 06, 2=
009
6:02 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> linuxppc-dev@ozlabs.org<=
br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Linux on Memec Virt=
ex4
FX12 Minimodule</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

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


------_=_NextPart_001_01C97272.4A36E7ED--
