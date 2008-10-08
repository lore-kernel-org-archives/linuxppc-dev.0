Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE003.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id E0E70DE479
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Oct 2008 01:35:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C92952.F8EE135F"
Subject: RE: Linux driver for Xilinx ICAP
Date: Wed, 8 Oct 2008 08:34:28 -0600
In-Reply-To: <COL107-W38E2468E159F1CBB304906B23B0@phx.gbl>
References: <COL107-W38E2468E159F1CBB304906B23B0@phx.gbl>
From: John Linn <John.Linn@xilinx.com>
To: "MingLiu" <eemingliu@hotmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-ID: <20081008143431.326B3E1806A@mail96-sin.bigfish.com>
Cc: Stephen Neuendorffer <stephenn@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C92952.F8EE135F
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable

Hi Ming,

 =


I=A1=AFm copying our local expert on this core to see his thoughts as I don=
=A1=AFt actively use this core myself.

 =


Thanks,

John

 =


________________________________

From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org [mailto:l=
inuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Mi=
ngLiu
Sent: Wednesday, October 08, 2008 7:48 AM
To: linuxppc-embedded@ozlabs.org
Subject: Linux driver for Xilinx ICAP

 =


Dear all,
Has someone manage to use the driver for the Xilinx xps_hwicap core to reco=
nfigure bitstreams? I have enabled the driver in Linux configuration (versi=
on 2.6.24 from Xilinx tree). However I failed to use it to reconfigure bits=
treams. The operations are listed as follows:
 =

# cp partial.bit /dev/icap0
#
 =

No error information is shown, however the partial bitstream is not success=
fully configured. I checked /proc/devices and the device "icap" has been su=
ccessfully registered with the major of 259. But in /proc/interrupts, I did=
n't find any matching entry of the interrupt for icap core. I tried to reco=
nfigure the PR module with JTAG, and my design works well. =

 =

Any hints for this problem? Is the problem on the interrupt? Thanks so much=
 if someone can help me. =

 =

BR
Ming

________________________________

Windows Live Writer=A3=AC=D6=A7=B3=D6=C0=EB=CF=DF=D7=AB=D0=B4=B2=A9=BF=CD=
=C4=DA=C8=DD=A3=AC=CB=E6=CA=B1=CB=E6=B5=D8=CF=EB=D0=B4=BE=CD=D0=B4=A1=A3 =
=C1=A2=BC=B4=CA=B9=D3=C3=A3=A1 <http://get.live.cn/product/writer.html> =




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C92952.F8EE135F
Content-Type: text/html; charset="GB2312"
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
10.0pt;font-family:Arial;color:navy'>I=A1=AFm copying our local expert on t=
his core
to see his thoughts as I don=A1=AFt actively use this core myself.<o:p></o:=
p></span></font></p>

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
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] <b><sp=
an
style=3D'font-weight:bold'>On Behalf Of </span></b>MingLiu<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Wednesday, October 08,=
 2008
7:48 AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> linuxppc-embedded@ozlabs=
.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Linux driver for Xi=
linx
ICAP</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3DSimSun><span style=3D'font-size:=
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D1 face=3DT=
ahoma><span
style=3D'font-size:9.0pt;font-family:Tahoma'>Dear all,<br>
Has someone manage to use the driver for the Xilinx xps_hwicap core to
reconfigure bitstreams? I have enabled the driver in Linux configuration
(version 2.6.24 from Xilinx tree). However I failed to use it to reconfigur=
e
bitstreams. The operations are listed as follows:<br>
&nbsp;<br>
# cp partial.bit /dev/icap0<br>
#<br>
&nbsp;<br>
No error information is shown, however the partial bitstream is not
successfully configured. I checked /proc/devices and the device
&quot;icap&quot; has been successfully registered with the major of 259. Bu=
t in
/proc/interrupts, I didn't find any matching entry of the interrupt for ica=
p
core. I tried to reconfigure the PR module with JTAG, and my design works w=
ell.
<br>
&nbsp;<br>
Any hints for this problem? Is the problem on the interrupt? Thanks so much=
 if
someone can help me. <br>
&nbsp;<br>
BR<br>
Ming<o:p></o:p></span></font></p>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font siz=
e=3D1
face=3DTahoma><span style=3D'font-size:9.0pt;font-family:Tahoma'>

<hr size=3D2 width=3D"100%" align=3Dcenter>

</span></font></div>

<p class=3DMsoNormal><font size=3D1 face=3DTahoma><span style=3D'font-size:=
9.0pt;
font-family:Tahoma'>Windows Live Writer</span></font><font size=3D1><span
lang=3DZH-CN style=3D'font-size:9.0pt'>=A3=AC=D6=A7=B3=D6=C0=EB=CF=DF=D7=AB=
=D0=B4=B2=A9=BF=CD=C4=DA=C8=DD=A3=AC=CB=E6=CA=B1=CB=E6=B5=D8=CF=EB=D0=B4=BE=
=CD=D0=B4=A1=A3</span></font><font
size=3D1 face=3DTahoma><span lang=3DZH-CN style=3D'font-size:9.0pt;font-fam=
ily:Tahoma'>
</span></font><font size=3D1 face=3DTahoma><span style=3D'font-size:9.0pt;f=
ont-family:
Tahoma'><a href=3D"http://get.live.cn/product/writer.html" target=3D"_new">=
<font
face=3DSimSun><span lang=3DZH-CN style=3D'font-family:SimSun'>=C1=A2=BC=B4=
=CA=B9=D3=C3=A3=A1</span></font></a><o:p></o:p></span></font></p>

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


------_=_NextPart_001_01C92952.F8EE135F--
