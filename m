Return-Path: <srideep.devireddy@wipro.com>
Received: from wip-cdctls-mx1.wipro.com (wip-cdctls-mx1.wipro.com
	[203.91.201.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-cdctls-mx1.wipro.com",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AB767686EB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 21:55:44 +1100 (EST)
Received: from wip-cdctls-mx1.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 4A5D53C4072
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 16:22:46 +0530 (IST)
Received: from chn-snr-bh2.wipro.com (chn-snr-bh2.wipro.com [10.145.50.92])
	by wip-cdctls-mx1.wipro.com (Postfix) with ESMTP id 3F4393C4008
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 16:22:46 +0530 (IST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5E51C.1EA3D6DD"
Date: Wed, 9 Nov 2005 16:25:48 +0530
Message-ID: <6AD9F6A5F6E096408F0B703773355A075BB210@CHN-SNR-MBX01.wipro.com>
From: <srideep.devireddy@wipro.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: u-boot + kernel (help required)
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

------_=_NextPart_001_01C5E51C.1EA3D6DD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


=0D

Hi ,

  =0D

we were able to get the u-boot up on MPC8272ADS board . We are just
struck up in bringing up the Linux... we get the following errors ..
actually we made a uImage  from vmlinux and tried to tftp and used bootm
100000 , we eneded up with these errors ...actually after the message
Uncompressing Kernel Image ... OK board gets reset .Any help would be
thankfull.

=0D

=0D

=3D> tftp 100000 vmlinux.72

Using FCC1 ETHERNET device

TFTP from server 10.0.0.1; our IP address is 10.0.0.2

Filename 'vmlinux.72'.

Load address: 0x100000

Loading:
#################################################################

=0D
#################################################################

         #######################

done

Bytes transferred =3D 782424 (bf058 hex)

=3D> bootm 100000

## Booting image at 00100000 ...

   Image Name:   Linux-2.4.22

   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

   Data Size:    782360 Bytes =3D 764 kB

   Load Address: 00000000

   Entry Point:  00000000

   Verifying Checksum ... OK

   Uncompressing Kernel Image ... OK

=0D


=0D


U-Boot 1.1.1 (Nov  8 2005 - 16:19:13)

=0D


MPC8272 Reset Status: Check Stop, External Soft, External Hard

=0D


MPC8272 Clock Configuration

 - Bus-to-Core Mult 3.5x, VCO Div 2, 60x Bus Freq  30-85 , Core Freq
100-300

 - dfbrg 1, corecnf 0x1e, busdf 3, cpmdf 1, plldf 0, pllmf 3

 - vco_out  400000000, scc_clk  100000000, brg_clk   25000000

 - cpu_clk  350000000, cpm_clk  200000000, bus_clk  100000000

 - pci_clk   66666666

=0D


CPU:   MPC8272 (HiP7 Rev 14, Mask A.0 1K50M) at 350 MHz

Board: Motorola MPC8272ADS

DRAM:  64 MB

FLASH:  8 MB

In:    serial

Out:   serial

Err:   serial

Net:   FCC1 ETHERNET

Hit any key to stop autoboot:  0

=3D>

=0D

=0D

Best Regards

=0D

Srideep

=0D




Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
------_=_NextPart_001_01C5E51C.1EA3D6DD
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=
=3D"urn:schemas-microsoft-com:office:office" xmlns:w=
=3D"urn:schemas-microsoft-com:office:word" xmlns=
=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:Arial;
	color:black;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:black;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 77.95pt 1.0in 77.95pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>Hi ,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;<font color=3Dblack><span style=
=3D'color:black'><o:p></o:p></span></font></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>we were able to get the u-boot up <font color=3Dblack><span
style=3D'color:black'>on MPC8272ADS board </span></font>. We are just=
 struck up
in bringing up the Linux... we get the following errors .. actually we made=
 a
uImage&nbsp; from vmlinux and tried to tftp and used bootm 100000 , we=
 eneded up
with these errors ...<font color=3Dblack><span style=
=3D'color:black'>actually after
the message </span></font><font color=3Dolive><span style=
=3D'color:olive'>Uncompressing
Kernel Image ... OK </span></font>board gets reset .Any help would be
thankfull.<font color=3Dolive><span style=
=3D'color:olive'><o:p></o:p></span></font></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dolive face=3D"Courier=
 New"><span
style=3D'font-size:10.0pt;color:olive'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>=
=3D&gt;
tftp 100000 vmlinux.72<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>Usin=
g
FCC1 ETHERNET device<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>TFTP
from server 10.0.0.1; our IP address is=
 10.0.0.2<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>File=
name
'vmlinux.72'.<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>Load
address: 0x100000<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>Load=
ing:
#################################################################<o:p></o:p=
></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
#################################################################<o:p></o:p=
></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
#######################<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>done=
<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>Byte=
s
transferred =3D 782424 (bf058 hex)<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>=
=3D&gt;
bootm 100000<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>##
Booting image at 00100000 ...<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;&nbsp;
Image Name:&nbsp;&nbsp; Linux-2.4.22<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;&nbsp;
Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip=
 compressed)<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;&nbsp;
Data Size:&nbsp;&nbsp;&nbsp; 782360 Bytes =3D 764=
 kB<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;&nbsp;
Load Address: 00000000<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;&nbsp;
Entry Point:&nbsp; 00000000<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;&nbsp;
Verifying Checksum ... OK<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;&nbsp;
Uncompressing Kernel Image ... OK<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>U-Bo=
ot
1.1.1 (Nov&nbsp; 8 2005 - 16:19:13)<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>MPC8=
272
Reset Status: Check Stop, External Soft, External=
 Hard<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>MPC8=
272
Clock Configuration<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;-
Bus-to-Core Mult 3.5x, VCO Div 2, 60x Bus Freq&nbsp; 30-85 , Core Freq=
 100-300<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;-
dfbrg 1, corecnf 0x1e, busdf 3, cpmdf 1, plldf 0, pllmf=
 3<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;-
vco_out&nbsp; 400000000, scc_clk&nbsp; 100000000, brg_clk&nbsp;&nbsp;=
 25000000<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;-
cpu_clk&nbsp; 350000000, cpm_clk&nbsp; 200000000, bus_clk&nbsp;=
 100000000<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;-
pci_clk&nbsp;&nbsp; 66666666<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>CPU:=
&nbsp;&nbsp;
MPC8272 (HiP7 Rev 14, Mask A.0 1K50M) at 350=
 MHz<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>Boar=
d:
Motorola MPC8272ADS<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>DRAM=
:&nbsp;
64 MB<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>FLAS=
H:&nbsp;
8 MB<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>In:&=
nbsp;&nbsp;&nbsp;
serial<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>Out:=
&nbsp;&nbsp;
serial<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>Err:=
&nbsp;&nbsp;
serial<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>Net:=
&nbsp;&nbsp;
FCC1 ETHERNET<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>Hit
any key to stop autoboot:&nbsp; 0<o:p></o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 color=3D"#003366" face=3DArial><span
style=
=3D'font-size:10.0pt;font-family:Arial;color:#003366;font-weight:bold'>=
=3D&gt;<o:p></o:p></span></font></b></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dolive face=3D"Courier=
 New"><span
style=3D'font-size:10.0pt;color:olive'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dolive face=3D"Courier=
 New"><span
style=3D'font-size:10.0pt;color:olive'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dolive face=3D"Courier=
 New"><span
style=3D'font-size:10.0pt;color:olive'>Best=
 Regards<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dolive face=3D"Courier=
 New"><span
style=3D'font-size:10.0pt;color:olive'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'>Srideep<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span style=
=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><br>
Confidentiality Notice <br>
<br>
The information contained in this electronic message and any attachments to=
 this message are intended<br>
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If<br>
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately<br>
and destroy all copies of this message and any attachments.<br>
</font></td></tr></table>
------_=_NextPart_001_01C5E51C.1EA3D6DD--
