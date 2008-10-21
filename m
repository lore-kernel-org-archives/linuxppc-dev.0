Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE002.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 24ECDDDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Oct 2008 07:00:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C933B7.9F05E00C"
Subject: RE: Xilininx GPIO
Date: Tue, 21 Oct 2008 14:00:09 -0600
In-Reply-To: <425A3BC99494A4409BEF99524478ED52092E7F36@esealmw103.eemea.ericsson.se>
References: <425A3BC99494A4409BEF99524478ED52092E7F36@esealmw103.eemea.ericsson.se>
From: John Linn <John.Linn@xilinx.com>
To: "Peter Scott" <peter.scott@ericsson.com>,
	<linuxppc-embedded@ozlabs.org>
Message-ID: <20081021200032.C96759C8065@mail164-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C933B7.9F05E00C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

 =


Sorry for the delay.  Are you using arch/powerpc and the xilinx_gpio
driver from the Xilinx Git tree has not been converted to use device
tree yet?

 =


We have a new gpio driver that we have not released out yet that is
flattened and designed to work with arch/powerpc.  I have recently been
testing it with success in general.

 =


However it is a new driver that is not a char driver as the old one, but
a true gpio driver that is accessed from sysfs in user space.  =


 =


What are you trying to use the GPIO for? =


 =


Thanks,

John

 =


 =


________________________________

From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of Peter Scott
Sent: Monday, October 20, 2008 1:43 PM
To: linuxppc-embedded@ozlabs.org
Subject: Xilininx GPIO

 =


Hello there, =


I am having difficulties with some xilinx gpios and the xilinx-2.6-xlnx
kernel. As far as I can tell the kernel is configured correctly for
gpio.

  =

I can see that the module_init function "xgpio_init" is called, and that
bus_add_driver and driver_add_groups returns without error. But I cannot
see that the probe function is called.  /proc/misc doesnt list a driver
for the gpios. I am not sure where to go next as there is no error
printouts.

I have seen other peoples consoles stating that the gpio is mapped to xx
but this doesn't happen for me. =


I am using the default bit file for the ml507 board, and have created
device files =

/dev/xgpio0 =

/dev/xgpio1 etc with major 10 and minor 185 =


However if I try to open these devices the open fails. =


I would rally appreciate it if someone could give me some pointers as to
what to look for, or how a to go about debugging this.

Many thanks =

Peter Scott =




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C933B7.9F05E00C
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<title>Xilininx GPIO</title>
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
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
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

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hi Peter,<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Sorry for the delay.&nbsp; Are you usi=
ng
arch/powerpc and the xilinx_gpio driver from the Xilinx Git tree has not be=
en
converted to use device tree yet?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>We have a new gpio driver that we have=
 not
released out yet that is flattened and designed to work with arch/powerpc.&=
nbsp;
I have recently been testing it with success in general.<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>However it is a new driver that is not=
 a
char driver as the old one, but a true gpio driver that is accessed from sy=
sfs
in user space.&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>What are you trying to use the GPIO fo=
r? <o:p></o:p></span></font></p>

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
linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org [mailto:linuxpp=
c-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org]
<b><span style=3D'font-weight:bold'>On Behalf Of </span></b>Peter Scott<br>=

<b><span style=3D'font-weight:bold'>Sent:</span></b> Monday, October 20, 20=
08
1:43 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> linuxppc-embedded@ozlabs=
.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Xilininx GPIO</span=
></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p><font size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:=
Arial'>Hello
there,</span></font> <o:p></o:p></p>

<p><font size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:=
Arial'>I
am having difficulties with some xilinx gpios and the xilinx-2.6-xlnx kerne=
l.
As far as I can tell the kernel is configured correctly for gpio.</span></f=
ont><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:=
Arial'>&nbsp;</span></font>
<br>
<font size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:Ari=
al'>I can
see that the module_init function &quot;xgpio_init&quot; is called, and tha=
t
bus_add_driver and driver_add_groups returns without error. But I cannot se=
e
that the probe function is called.&nbsp; /proc/misc doesnt list a driver fo=
r
the gpios. I am not sure where to go next as there is no error printouts.</=
span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:=
Arial'>I
have seen other peoples consoles stating that the gpio is mapped to xx but =
this
doesn't happen for me.</span></font> <o:p></o:p></p>

<p><font size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:=
Arial'>I
am using the default bit file for the ml507 board, and have created device
files </span></font><br>
<font size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:Ari=
al'>/dev/xgpio0
</span></font><br>
<font size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:Ari=
al'>/dev/xgpio1
etc with major 10 and minor 185 </span></font><o:p></o:p></p>

<p><font size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:=
Arial'>However
if I try to open these devices the open fails. </span></font><o:p></o:p></p=
>

<p><font size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:=
Arial'>I
would rally appreciate it if someone could give me some pointers as to what=
 to
look for, or how a to go about debugging this.</span></font><o:p></o:p></p>=


<p><font size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:=
Arial'>Many
thanks</span></font> <br>
<font size=3D2 face=3DArial><span style=3D'font-size:10.0pt;font-family:Ari=
al'>Peter
Scott</span></font> <o:p></o:p></p>

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


------_=_NextPart_001_01C933B7.9F05E00C--
