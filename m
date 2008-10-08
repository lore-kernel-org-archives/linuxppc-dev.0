Return-Path: <juan-antonio.medina@anafocus.com>
Received: from mail.anafocus.com (mail.anafocus.com [213.227.43.181])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 61F5DDDF64
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Oct 2008 18:49:18 +1100 (EST)
From: "Juan Antonio Medina Guerrero" <juan-antonio.medina@anafocus.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: DMA IRQ Linux configuring problem
Date: Wed, 8 Oct 2008 09:42:51 +0200
Message-ID: <86DF51AEEB064389B85403E2C27FE6B7@svq.anafocus.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000B_01C9292A.3B36EB70"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C9292A.3B36EB70
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

      

      We are facing some issues when trying to implement the interrup-driven
DMA. The function request_irq returns error when trying to use the DMA
interrupt. Following you can find some tests we've performed to try to solve
this trouble:

 

      - We have been trying various IRQ ID. If we use the spi IRQ_ID the
function request_irq returns error because this IRQ is already being used,
as expected. If we use the usb IRQ_ID the function doesn't return error but
of course doesn't launch the IRQ handle.

 

      - We have changed the IRQ_ID from USB to DMA in device usb section in
file mpc8313erdb.dts. Then we use dma IRQ_ID and there are launchs of
IRQ_DMA_handler. This method isn't the solution but gives us an idea of the
problem.

 

      - Finally, we make a new device section in dts file but it doesn't
work. We believe that we have created bad the device section or that we need
to do something else. Could you please help us with this?

 

Kind regards,

Medina


------=_NextPart_000_000B_01C9292A.3B36EB70
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
	margin:70.85pt 3.0cm 70.85pt 3.0cm;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DES link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; We
are facing some issues when trying to implement the interrup-driven DMA. =
The
function request_irq returns error when trying to use the DMA interrupt. =
Following
you can find some tests we've performed to try to solve this =
trouble:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -
We have been trying various IRQ ID. If we use the spi IRQ_ID the =
function
request_irq returns error because this IRQ is already being used, as =
expected. If
we use the usb IRQ_ID the function doesn't return error but of course =
doesn't
launch the IRQ handle.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -
We have changed the IRQ_ID from USB to DMA in device usb section in file
mpc8313erdb.dts. Then we use dma IRQ_ID and there are launchs of
IRQ_DMA_handler. This method isn't the solution but gives us an idea of =
the
problem.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -
Finally, we make a new device section in dts file but it doesn't work. =
We
believe that we have created bad the device section or that we need to =
do
something else. </span></font><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Could you please =
help us
with this?<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Kind =
regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Medina</span></font><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

</body>

</html>

------=_NextPart_000_000B_01C9292A.3B36EB70--
