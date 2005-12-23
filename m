Return-Path: <Prabhat_Singh@Satyam.com>
Received: from chnmail.satyam.com (chnmail.satyam.com [210.18.90.100])
	by ozlabs.org (Postfix) with ESMTP id 64EA5688DA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Dec 2005 23:07:58 +1100 (EST)
Received: from blr.satyam.com (blr.satyam.com [208.220.245.73])
	by che2.satyam.com (8.12.8/8.12.8) with ESMTP id jBNBmsXU016681
	for <linuxppc-embedded@ozlabs.org>; Fri, 23 Dec 2005 17:19:04 +0530
Received: from Disclaimerbng.corp.satyam.ad (bng.satyam.com [172.19.57.211])
	by blr.satyam.com (8.12.8/8.12.8) with ESMTP id jBNBhIfA004636
	for <linuxppc-embedded@ozlabs.org>; Fri, 23 Dec 2005 17:13:19 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C607B7.7BF9028B"
Date: Fri, 23 Dec 2005 17:23:17 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED1070CAA@bsdmsg002.corp.satyam.ad>
From: "Prabhat_Singh" <Prabhat_Singh@Satyam.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: Prabhat_Singh <Prabhat_Singh@satyam.com>
Subject: Compilation Error
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

------_=_NextPart_001_01C607B7.7BF9028B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

          I am building  linux-2.4.32 kernel using ELDK tool  for
MPC8248(MPC8272 family) based target board. After configuring kernel as
follow:

   1)Make xconfig ARCH=3Dppc

=20

    Platform support:MPC8260 CPM support -y

                             MPC8272 family Support -y

=20

Machine type : ADS8272

=20

=20

And after saving configuration ..

=20

2)Make dep ARCH=3Dppc

3)Make bzImage ARCH=3Dppc

         Now  I am getting error like this..............

=20

************************************************************************
**************************************

=20

m /home/sibi/vpnporting/linux-2.4.32/include/linux/blk.h:4,

                 from m8260_setup.c:31:

/home/sibi/vpnporting/linux-2.4.32/include/asm/mpc8260.h:32:1: warning:
"PCI_DRAM_OFFSET" redefined

In file included from
/home/sibi/vpnporting/linux-2.4.32/include/asm/mpc8260.h:24,

                 from
/home/sibi/vpnporting/linux-2.4.32/include/asm/io.h:31,

                 from
/home/sibi/vpnporting/linux-2.4.32/include/linux/blkdev.h:11,

                 from
/home/sibi/vpnporting/linux-2.4.32/include/linux/blk.h:4,

                 from m8260_setup.c:31:

/home/sibi/vpnporting/linux-2.4.32/arch/ppc/platforms/pq2ads.h:85:1:
warning: this is the location of the previous
definitionm8260_setup.c:68: warning: `abort' was declared `extern' and
later `static'

m8260_setup.c: In function `abort':

m8260_setup.c:70: error: conflicting types for `xmon'

/home/sibi/vpnporting/linux-2.4.32/include/asm/system.h:49: error:
previous declaration of `xmon'

m8260_setup.c:70: warning: extern declaration of `xmon' doesn't match
global one

m8260_setup.c: In function `m8260_restart':

m8260_setup.c:129: warning: passing arg 1 of `m8260_gorom' makes pointer
from integer without a cast

m8260_setup.c: In function `m8260_show_percpuinfo':

m8260_setup.c:157: warning: int format, long unsigned int arg (arg 3)

m8260_setup.c:157: warning: int format, long unsigned int arg (arg 4)

m8260_setup.c:157: warning: int format, long unsigned int arg (arg 5)

m8260_setup.c: At top level:

m8260_setup.c:68: warning: `abort' defined but not used

make[1]: *** [m8260_setup.o] Error 1

make[1]: Leaving directory
`/home/sibi/vpnporting/linux-2.4.32/arch/ppc/kernel'

make: *** [_dir_arch/ppc/kernel] Error 2

=20

=20

=20

=20

=20

If anyone encountered this type of problem please through light on this.

=20

=20

Thanks in advance=20

=20

Thanks & Regards

Prabhat Singh

SE

Satyam Computer Services Ltd.

=20



DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.

------_=_NextPart_001_01C607B7.7BF9028B
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
font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 I am
building &nbsp;linux-2.4.32 kernel using ELDK tool&nbsp; for =
MPC8248(MPC8272
family) based target board. After configuring kernel as =
follow:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; 1)Make xconfig =
ARCH=3Dppc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; Platform support:MPC8260 CPM =
support &#8211;y<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
MPC8272 family Support &#8211;y<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Machine type : ADS8272<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>And after saving configuration =
..<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>2)Make dep ARCH=3Dppc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>3)Make bzImage =
ARCH=3Dppc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Now =
&nbsp;I
am getting error like =
this&#8230;&#8230;&#8230;&#8230;..<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>******************************************************=
********************************************************<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>m =
/home/sibi/vpnporting/linux-2.4.32/include/linux/blk.h:4,<o:p></o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from m8260_setup.c:31:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/home/sibi/vpnporting/linux-2.4.32/include/asm/mpc8260=
.h:32:1:
warning: &quot;PCI_DRAM_OFFSET&quot; =
redefined<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>In file included from =
/home/sibi/vpnporting/linux-2.4.32/include/asm/mpc8260.h:24,<o:p></o:p></=
span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from =
/home/sibi/vpnporting/linux-2.4.32/include/asm/io.h:31,<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from =
/home/sibi/vpnporting/linux-2.4.32/include/linux/blkdev.h:11,<o:p></o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from =
/home/sibi/vpnporting/linux-2.4.32/include/linux/blk.h:4,<o:p></o:p></spa=
n></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
from m8260_setup.c:31:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/home/sibi/vpnporting/linux-2.4.32/arch/ppc/platforms/=
pq2ads.h:85:1:
warning: this is the location of the previous =
definitionm8260_setup.c:68:
warning: `abort' was declared `extern' and later =
`static'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>m8260_setup.c: In function =
`abort':<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>m8260_setup.c:70: error: conflicting types for =
`xmon'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/home/sibi/vpnporting/linux-2.4.32/include/asm/system.=
h:49:
error: previous declaration of `xmon'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>m8260_setup.c:70: warning: extern declaration of =
`xmon'
doesn't match global one<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>m8260_setup.c: In function =
`m8260_restart':<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>m8260_setup.c:129: warning: passing arg 1 of =
`m8260_gorom'
makes pointer from integer without a cast<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>m8260_setup.c: In function =
`m8260_show_percpuinfo':<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>m8260_setup.c:157: warning: int format, long unsigned =
int
arg (arg 3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>m8260_setup.c:157: warning: int format, long unsigned =
int
arg (arg 4)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>m8260_setup.c:157: warning: int format, long unsigned =
int
arg (arg 5)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>m8260_setup.c: At top =
level:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>m8260_setup.c:68: warning: `abort' defined but not =
used<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[1]: *** [m8260_setup.o] Error =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[1]: Leaving directory
`/home/sibi/vpnporting/linux-2.4.32/arch/ppc/kernel'<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make: *** [_dir_arch/ppc/kernel] Error =
2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<div =
style=3D'mso-element:para-border-div;border:none;border-bottom:dotted =
windowtext 3.0pt;
padding:0in 0in 1.0pt 0in'>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

</div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>If anyone encountered this type of problem please =
through
light on this.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks in advance <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks &amp; Regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Prabhat Singh<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>SE<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Satyam Computer Services =
Ltd.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

<p></p><p>DISCLAIMER:<br>This email (including any attachments) is =
intended for the sole use of the intended recipient/s and may contain =
material that is CONFIDENTIAL AND PRIVATE COMPANY INFORMATION. Any =
review or reliance by others or copying or distribution or forwarding of =
any or all of the contents in this message is STRICTLY PROHIBITED. If =
you are not the intended recipient, please contact the sender by email =
and delete all copies; your cooperation in this regard is =
appreciated..</body>

</html>

------_=_NextPart_001_01C607B7.7BF9028B--
