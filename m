Return-Path: <srideep.devireddy@wipro.com>
Received: from wip-cdctls-mx3.wipro.com (wip-cdctls-mx3.wipro.com
	[203.91.201.23])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-cdctls-mx3.wipro.com",
	Issuer "wip-cdctls-mx3.wipro.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9698E686A6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 15:32:47 +1100 (EST)
Received: from wip-cdctls-mx3.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id BB7B429C066
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 09:51:19 +0530 (IST)
Received: from chn-snr-bh1.wipro.com (chn-snr-bh1.wipro.com [10.145.50.91])
	by wip-cdctls-mx3.wipro.com (Postfix) with ESMTP id AF4EC29C031
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 09:51:19 +0530 (IST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5E4E5.08A7F11D"
Date: Wed, 9 Nov 2005 09:51:28 +0530
Message-ID: <6AD9F6A5F6E096408F0B703773355A075BB03B@CHN-SNR-MBX01.wipro.com>
From: <srideep.devireddy@wipro.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: FW: U-boot linux kernel
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

------_=_NextPart_001_01C5E4E5.08A7F11D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


=0D

=0D

Hi,

=0D

  I am right now working on MPC 8272 Ads board  to bring up the u-boot
and the linux kernel on it . As I am success full in bringing up the
u-boot . but I am finding it difficult in getting the linux up . As I
downloaded the vmlinux image from montavista linux site for 8272Ads
board and they  tried to tftp to 100000 at u-boot prompt I am not able
to compress the linus kernel image and go further I end up in getting
the following errors...I tried with two images ... VMLINUX.UBOOT is a
different board image but tried it ... but not able to go further..
later I used the Uimage (got it from vmlinux  using mkimage tool in
linux ) montavista image for mpc8272 ... it ended up giving me the
program check exception ...

=0D

=0D

=3D> tftp 100000 VMLINUX.UBOOT

Using FCC1 ETHERNET device

TFTP from server 10.0.0.1; our IP address is 10.0.0.2

Filename 'VMLINUX.UBOOT'.

Load address: 0x100000

Loading:
#################################################################

=0D
#################################################################

         #########

done

Bytes transferred =3D 708491 (acf8b hex)

=3D> bootm 0x100000

## Booting image at 00100000 ...

   Image Name:   Linux-2.4.27-1.3.1-432

   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

   Data Size:    708427 Bytes =3D 691.8 kB

   Load Address: 00000000

   Entry Point:  00000000

   Verifying Checksum ... OK

   Uncompressing Kernel Image ... OK

=0D

=0D

=0D

=0D

=3D> tftp 100000 uImage

Using FCC1 ETHERNET device

TFTP from server 10.0.0.1; our IP address is 10.0.0.2

Filename 'uImage'.

Load address: 0x100000

Loading:
#################################################################

=0D
#################################################################

         ##########################

done

Bytes transferred =3D 798431 (c2edf hex)

=3D> bootm 0x100000

## Booting image at 00100000 ...

   Image Name:

   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

   Data Size:    798367 Bytes =3D 779.7 kB

   Load Address: 00100000

   Entry Point:  00100000

   Verifying Checksum ... OK

   Uncompressing Kernel Image ... OK

NIP: 00100000 XER: 00000000 LR: 03FD14F0 REGS: 03b84bd8 TRAP: 0700 DAR:
03FD7B38MSR: 00083002 EE: 0 PR: 0 FP: 1 ME: 1 IR/DR: 00

=0D


GPR00: 00000002 03B84CC8 C02EA000 007FFEB0 00000000 00000000 007FFF00
007FFF13

GPR08: 17D78400 03B8500C 03FF8B30 F0000088 00000000 FFFBFFFF 03FFE000
00000001

GPR16: FFFFFFFF 00100000 00000000 03FF8F7C 03BC5270 00000002 007FFF00
03FFF3AC

GPR24: 00000000 00000000 00000000 00800000 00000000 03B84F6C 03FFE600
007FFEB0

Call backtrace:

Program Check Exception

=0D

=0D

Best Regards

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
------_=_NextPart_001_01C5E4E5.08A7F11D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=
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
span.EmailStyle17
	{mso-style-type:personal;
	color:black;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:black;}
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

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=
=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'>&nbsp;&nbsp;I am right now working=
 on MPC
8272 Ads board&nbsp; to bring up the u-boot and the linux kernel on it . As=
 I
am success full in bringing up the u-boot . but I am finding it difficult=
 in
getting the linux up . As I downloaded the vmlinux image from montavista=
 linux
site for 8272Ads board and they&nbsp; tried to tftp to 100000 at u-boot=
 prompt
I am not able to compress the linus kernel image and go further I end up in
getting the following errors&#8230;I tried with two images &#8230;=
 VMLINUX.UBOOT
is a different board image but tried it &#8230; but not able to go=
 further..
later I used the Uimage (got it from vmlinux&nbsp; using mkimage tool in=
 linux
) montavista image for mpc8272 &#8230; it ended up giving me the&nbsp;=
 program
check exception &#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>=3D&gt; tftp 100000=
 VMLINUX.UBOOT<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>Using FCC1 ETHERNET=
 device<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>TFTP from server 10.0.0.1; our IP
address is 10.0.0.2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>Filename=
 'VMLINUX.UBOOT'.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>Load address:=
 0x100000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>Loading:
#################################################################<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=
=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
#################################################################<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=
=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
#########<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>done<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>Bytes transferred =3D 708491=
 (acf8b hex)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>=3D&gt; bootm=
 0x100000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>## Booting image at 00100000=
 ...<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp; Image=
 Name:&nbsp;&nbsp;
Linux-2.4.27-1.3.1-432<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp; Image=
 Type:&nbsp;&nbsp;
PowerPC Linux Kernel Image (gzip compressed)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp; Data
Size:&nbsp;&nbsp;&nbsp; 708427 Bytes =3D 691.8=
 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp; Load Address:=
 00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp; Entry Point:&nbsp;=
 00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp; Verifying Checksum=
 ... OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp; Uncompressing Kernel=
 Image
... OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=
=3D'font-size:12.0pt;color:#993300'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=
=3D'font-size:12.0pt;color:#993300'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=
=3D'font-size:12.0pt;color:#993300'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=
=3D'font-size:12.0pt;color:#993300'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>=3D&gt; tftp 100000=
 uImage<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>Using FCC1 ETHERNET=
 device<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>TFTP from server 10.0.0.1; our IP=
 address
is 10.0.0.2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>Filename=
 'uImage'.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>Load address:=
 0x100000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>Loading:
#################################################################<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=
=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
#################################################################<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=
=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
##########################<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>done<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>Bytes transferred =3D 798431=
 (c2edf hex)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>=3D&gt; bootm=
 0x100000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>## Booting image at 00100000=
 ...<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp; Image=
 Name:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp; Image=
 Type:&nbsp;&nbsp;
PowerPC Linux Kernel Image (gzip compressed)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp; Data
Size:&nbsp;&nbsp;&nbsp; 798367 Bytes =3D 779.7=
 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp; Load Address:=
 00100000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp; Entry Point:&nbsp;=
 00100000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp; Verifying Checksum=
 ... OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp; Uncompressing Kernel=
 Image
... </span></font><font color=3D"#993300"><span lang=3DES style=
=3D'color:#993300'>OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
lang=3DES style=3D'font-size:12.0pt;color:#993300'>NIP: 00100000 XER:=
 00000000 LR:
03FD14F0 REGS: 03b84bd8 TRAP: 0700 DAR: 03FD7B38MSR: 00083002 EE: 0 PR: 0=
 FP: 1
ME: 1 IR/DR: 00<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
lang=3DES style=
=3D'font-size:12.0pt;color:#993300'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>GPR00: 00000002 03B84CC8 C02EA000
007FFEB0 00000000 00000000 007FFF00 007FFF13<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>GPR08: 17D78400 03B8500C 03FF8B30
F0000088 00000000 FFFBFFFF 03FFE000 00000001<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>GPR16: FFFFFFFF 00100000 00000000
03FF8F7C 03BC5270 00000002 007FFF00 03FFF3AC<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>GPR24: 00000000 00000000 00000000
00800000 00000000 03B84F6C 03FFE600 007FFEB0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>Call=
 backtrace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>Program Check=
 Exception<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=
=3D'font-size:12.0pt;color:#993300'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=
=3D'font-size:12.0pt;color:#993300'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:#993300'>Best=
 Regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3D"#993300" face=3D"Times New=
 Roman"><span
style=
=3D'font-size:12.0pt;color:#993300'>Srideep<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Times New=
 Roman"><span
style=3D'font-size:12.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><br>
<br>
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
------_=_NextPart_001_01C5E4E5.08A7F11D--
