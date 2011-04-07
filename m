Return-Path: <moises.dominguez@ctag.com>
Received: from jupiter.ctag.com (smtp.ctag.com [193.144.40.36])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7BD2B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 19:38:28 +1000 (EST)
Received: from [193.144.40.38] (helo=INN0072)
	by jupiter.ctag.com with esmtpa (Exim 4.69)
	(envelope-from <moises.dominguez@ctag.com>) id 1Q7lEm-0005pu-OL
	for linuxppc-dev@lists.ozlabs.org; Thu, 07 Apr 2011 11:10:49 +0200
From: <moises.dominguez@ctag.com>
To: <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 7 Apr 2011 11:10:48 +0200
Message-ID: <9CF962889D6042E9AC8500BC8DA74236@ctag>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0039_01CBF514.730B69F0"
Subject: mscan status on DENX Linux 2.6 Kernel Tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0039_01CBF514.730B69F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Up to now I've been working ltib over and ads5121 based board.

So as not to work with frozen images I would like to change to u-boot and
kernel from denx. I did the following:

- Download and compile u-boot: OK.

- Download and kernel (mpc512x_defconfig): compilation fails if I enable
"Freescale MPC5xxx onboard CAN controller" with this message:

.

  LD      kernel/built-in.o

  CC      drivers/net/can/mscan/mscan.o

  CC      drivers/net/can/mscan/mpc5xxx_can.o

drivers/net/can/mscan/mpc5xxx_can.c: In function 'mpc5xxx_can_probe':

drivers/net/can/mscan/mpc5xxx_can.c:263: error: 'of_dev' undeclared (first
use in this function)

.

I have not much experience with this stuff but I've notice that there are
recent patches on mpc5xxx.c file, last from 2011-02-28 so I suppose this
should work. 

Am I missing something? I also wonder if ads5121-Rev4 is fully supported in
Linux Denx.

 

Thanks,

 

Moises.


------=_NextPart_000_0039_01CBF514.730B69F0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

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
span.EstiloCorreo17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 3.0cm 70.85pt 3.0cm;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DES link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Hi,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Up to now I&#8217;ve been working ltib over =
and ads5121
based board.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>So as not to work with frozen images I would =
like to
change to u-boot and kernel from denx. I did the =
following:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>- Download and compile u-boot: =
OK.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>- Download and kernel (mpc512x_defconfig):
compilation fails if I enable &#8220;Freescale MPC5xxx onboard CAN =
controller&#8221;
with this message:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&#8230;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
kernel/built-in.o</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
drivers/net/can/mscan/mscan.o</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
drivers/net/can/mscan/mpc5xxx_can.o</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>drivers/net/can/mscan/mpc5xxx_can.c: In =
function
'mpc5xxx_can_probe':</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>drivers/net/can/mscan/mpc5xxx_can.c:263: =
error: 'of_dev'
undeclared (first use in this function)</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>&#8230;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>I have not much experience with this stuff =
but I&#8217;ve
notice that there are recent patches on mpc5xxx.c file, last from =
2011-02-28 so
I suppose this should work. </span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>Am I missing something? I also wonder if =
ads5121-Rev4
is fully supported in Linux Denx.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>Thanks,</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>Moises.</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0039_01CBF514.730B69F0--
