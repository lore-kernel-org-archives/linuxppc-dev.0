Return-Path: <John.Linn@xilinx.com>
Received: from IE1EHSOBE004.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 13567DDF87
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Oct 2008 06:48:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C92FC8.25D4E884"
Subject: RE: xparameters file in the Xilinx kernel tree version 2.6.27-rc4
Date: Thu, 16 Oct 2008 13:48:22 -0600
In-Reply-To: <COL107-W14F82F8CC72D8E57C374ABB2330@phx.gbl>
References: <COL107-W14F82F8CC72D8E57C374ABB2330@phx.gbl>
From: John Linn <John.Linn@xilinx.com>
To: "MingLiu" <eemingliu@hotmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-ID: <20081016194824.BBC2B10F8083@mail171-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C92FC8.25D4E884
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi Ming,

 =


Arch/ppc has gone away.  We don=A1=AFt support it any longer as it went awa=
y in the mainline kernel also.  You should migrate to arch/powerpc.

 =


There is a git tag, last-arch-ppc, that is visible from http://git.xilinx.c=
om/linux-2.6-xlnx.git.  You can use that tag in git to reset back to that t=
ag.  Or after clicking on that tag towards the bottom on the http page, you=
 can go to the tree view and get any individual files you would like.

 =


You should go to our wiki site, http://xilinx.wikidot.com <http://xilinx.wi=
kidot.com/>  to get more data on how to build the newer kernel. =


 =


Thanks,

John

 =


________________________________

From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org [mailto:l=
inuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Mi=
ngLiu
Sent: Thursday, October 16, 2008 1:39 PM
To: linuxppc-embedded@ozlabs.org
Subject: xparameters file in the Xilinx kernel tree version 2.6.27-rc4

 =


Dear all,
I downloaded the newest version 2.6.27 kernel from the Xilinx tree. I found=
 that it is much different with the previous version 2.6.24-rc8 we are usin=
g. Maybe my question is stupid, but I cannot find the previous xparameters_=
ml40x.h file in arch/ppc/platform/4xx/xparameters/ in the new arch/powerpc =
folder. So how can I import my BSP parameters in the new kernel for the cus=
tomized design?
 =

One more question is, I tried "make zImage". But I cannot find the generate=
d zImage.elf, as the previous kernel will do.How to generate the .elf kerne=
l file?
 =

Thanks for your help and answering.
 =

BR
Ming
 =


________________________________

=CA=B9=D3=C3=D0=C2=D2=BB=B4=FA Windows Live Messenger =C7=E1=CB=C9=BD=BB=C1=
=F7=BA=CD=B9=B2=CF=ED=A3=A1 =C1=A2=BC=B4=CC=E5=D1=E9=A3=A1 <http://messenge=
r.live.cn/> =




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C92FC8.25D4E884
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:SimSun;}
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

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hi Ming,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Arch/ppc has gone away. &nbsp;We don=
=A1=AFt
support it any longer as it went away in the mainline kernel also. &nbsp;Yo=
u
should migrate to arch/powerpc.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>There is a git tag, last-arch-ppc, tha=
t is
visible from <a href=3D"http://git.xilinx.com/linux-2.6-xlnx.git">http://gi=
t.xilinx.com/linux-2.6-xlnx.git</a>.
&nbsp;You can use that tag in git to reset back to that tag. &nbsp;Or after=

clicking on that tag towards the bottom on the http page, you can go to the=

tree view and get any individual files you would like.<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>You should go to our wiki site, <a
href=3D"http://xilinx.wikidot.com/">http://xilinx.wikidot.com</a> to get mo=
re
data on how to build the newer kernel. <o:p></o:p></span></font></p>

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

<div style=3D'border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt'>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font siz=
e=3D3
face=3DSimSun><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span style=3D'font-si=
ze:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> linuxppc=
-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] <b><sp=
an
style=3D'font-weight:bold'>On Behalf Of </span></b>MingLiu<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Thursday, October 16, =
2008
1:39 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> linuxppc-embedded@ozlabs=
.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> xparameters file in=
 the
Xilinx kernel tree version 2.6.27-rc4</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3DSimSun><span style=3D'font-size:=
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D1 face=3DT=
ahoma><span
style=3D'font-size:9.0pt;font-family:Tahoma'>Dear all,<br>
I downloaded the newest version 2.6.27 kernel from the Xilinx tree. I found=

that it is much different with the previous version 2.6.24-rc8 we are using=
.
Maybe my question is stupid, but I cannot find the previous xparameters_ml4=
0x.h
file in arch/ppc/platform/4xx/xparameters/ in the new arch/powerpc folder. =
So
how can I import my BSP parameters in the new kernel for the customized des=
ign?<br>
&nbsp;<br>
One more question is, I tried &quot;make zImage&quot;. But I cannot find th=
e
generated zImage.elf,&nbsp;as the previous kernel will do.How to generate t=
he
.elf kernel file?<br>
&nbsp;<br>
Thanks for your help and answering.<br>
&nbsp;<br>
BR<br>
Ming<br>
&nbsp;<o:p></o:p></span></font></p>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font siz=
e=3D1
face=3DTahoma><span style=3D'font-size:9.0pt;font-family:Tahoma'>

<hr size=3D2 width=3D"100%" align=3Dcenter>

</span></font></div>

<p class=3DMsoNormal><font size=3D1 face=3DSimSun><span lang=3DZH-CN style=
=3D'font-size:
9.0pt'>=CA=B9=D3=C3=D0=C2=D2=BB=B4=FA</span></font><font size=3D1 face=3DTa=
homa><span style=3D'font-size:9.0pt;
font-family:Tahoma'> Windows Live Messenger </span></font><font size=3D1><s=
pan
lang=3DZH-CN style=3D'font-size:9.0pt'>=C7=E1=CB=C9=BD=BB=C1=F7=BA=CD=B9=B2=
=CF=ED=A3=A1</span></font><font size=3D1
face=3DTahoma><span lang=3DZH-CN style=3D'font-size:9.0pt;font-family:Tahom=
a'> </span></font><font
size=3D1 face=3DTahoma><span style=3D'font-size:9.0pt;font-family:Tahoma'><=
a
href=3D"http://messenger.live.cn/" target=3D"_new"><font face=3DSimSun><spa=
n
lang=3DZH-CN style=3D'font-family:SimSun'>=C1=A2=BC=B4=CC=E5=D1=E9=A3=A1</s=
pan></font></a><o:p></o:p></span></font></p>

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


------_=_NextPart_001_01C92FC8.25D4E884--
