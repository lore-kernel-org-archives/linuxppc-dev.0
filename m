Return-Path: <vasbridge@sanblaze.com>
Received: from mail.gazungle.com (mail.gazungle.com [207.210.240.68])
	by ozlabs.org (Postfix) with ESMTP id 56659DDF68
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Aug 2008 07:14:35 +1000 (EST)
From: "Vince Asbridge" <vasbridge@sanblaze.com>
To: "'linuxppc-embedded'" <linuxppc-embedded@ozlabs.org>
Subject: Some memory (DDR2 ECC Dual Rank) just doesn't work! Can anyone point
	me to how to debug this hang?
Date: Wed, 13 Aug 2008 17:21:35 -0400
Message-ID: <04c601c8fd8a$91022450$4b01a8c0@sanblaze.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_04C7_01C8FD69.09F08450"
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

------=_NextPart_000_04C7_01C8FD69.09F08450
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

All,

We have an 8548 design, which implements a DDR2 on a SODIMM

We have an issue with dual rank memory (specific part number Viking
VR5DR287218EBSS1), which is a 1G ECC Registered SODIMM part, with two ranks.

Our platform wires CS0 and CS1 to the SODIMM slot.

At uBoot, all is well.  Memory is discovered as ECC 533, 1G DDR2 64Bit 4
beat bursts, and mtest can read and write all 1G of the SODIMM.

Here's where things get bad.

If I boot linux (2.6.11 or 2.6.23 kernel), after the kernel image
decompresses, the machine simply HANGS.

 The IP address of the board is currently set to 192.168.200.90
The MAC address is 00:11:0d:1d:a2:23
If they don't match your network environment, please change them in U-Boot
and kernel manually.
Hit any key to stop autoboot:  0
## Booting image at fc580000 ...
   Image Name:   Linux-2.6.11
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1706305 Bytes =  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image .   (HANG)

Other DDR2s (identical except for vendor and # of ranks), work perfectly!

Anyone got a clue what I could look at to try to figure this out?

We've tried enable / disable ECC at uboot
We've tried enable / disable Interleaving at uboot

uboot always works (and can read/write entire DDR), Linux always hangs on
boot!

Please help,
Vince










------=_NextPart_000_04C7_01C8FD69.09F08450
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7036.0">
<TITLE>Some memory (DDR2 ECC Dual Rank) just doesn't work!  Can anyone =
point me to how to debug this hang?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">All,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We have an 8548 design, which =
implements a DDR2 on a SODIMM</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We have an issue with dual rank memory =
(specific part number Viking VR5DR287218EBSS1), which is a 1G ECC =
Registered SODIMM part, with two ranks.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Our platform wires CS0 and CS1 to the =
SODIMM slot.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">At uBoot, all is well.&nbsp; Memory is =
discovered as ECC 533, 1G DDR2 64Bit 4 beat bursts, and mtest can read =
and write all 1G of the SODIMM.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Here's where things get bad.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">If I boot linux (2.6.11 or 2.6.23 =
kernel), after the kernel image decompresses, the machine simply =
HANGS.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;The IP address of the board is =
currently set to 192.168.200.90</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">The MAC address is =
00:11:0d:1d:a2:23</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">If they don't match your network =
environment, please change them in U-Boot and kernel manually.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Hit any key to stop autoboot:&nbsp; =
0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">## Booting image at fc580000 =
...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-2.6.11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Image Type:&nbsp;&nbsp; =
PowerPC Linux Kernel Image (gzip compressed)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Data =
Size:&nbsp;&nbsp;&nbsp; 1706305 Bytes =3D&nbsp; 1.6 MB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Load Address: =
00000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Entry Point:&nbsp; =
00000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Verifying Checksum ... =
OK</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Uncompressing Kernel =
Image &#8230;&nbsp;&nbsp; (HANG)</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Other DDR2s (identical except for =
vendor and # of ranks), work perfectly!</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Anyone got a clue what I could look at =
to try to figure this out?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We've tried enable / disable ECC at =
uboot</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">We've tried enable / disable =
Interleaving at uboot</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">uboot always works (and can read/write =
entire DDR), Linux always hangs on boot!</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Please help,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Vince</FONT>
</P>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>

</BODY>
</HTML>
------=_NextPart_000_04C7_01C8FD69.09F08450--
