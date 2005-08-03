Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id 29ED767E3F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 01:14:32 +1000 (EST)
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com
	[171.70.151.144])
	by sj-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id j73F4bIs003075
	for <linuxppc-embedded@ozlabs.org>; Wed, 3 Aug 2005 08:04:37 -0700 (PDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5983C.AB7247EB"
Date: Wed, 3 Aug 2005 08:04:39 -0700
Message-ID: <F795765B112E7344AF36AA91127964158494B1@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC8541E DMA transfer
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

------_=_NextPart_001_01C5983C.AB7247EB
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
Hi all,
I am developing a linux driver (2.6.10) for Freescale MPC8541E
(customized board) to read and write 8 buffers (each buffer is 960 bytes
long) every 10 ms to/from a custom made PCI card with on board DSP Chip.
The chip's internal and external memories are memory mapped to the CPU
address space.=20
For reason that is beyond the discussion here, the DMA request line on
the PCI card is not connected although the PCI card has DMA
capabilities.=20
So what are my options?=20
Could I still do DMA transfer from the Host to the device?
=20
Many thanks in advance,
Bizhan

------_=_NextPart_001_01C5983C.AB7247EB
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT>&nbsp;</DIV>
<DIV></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D080062814-03082005>Hi=20
all,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D080062814-03082005>I am =
developing a=20
linux driver (2.6.10)&nbsp;for Freescale MPC8541E (customized board) to =
read and=20
write&nbsp;8 buffers (each buffer is 960 bytes long) every 10 ms to/from =
a=20
custom made PCI card with on board DSP Chip. The chip's&nbsp;internal =
and=20
external memories&nbsp;are memory mapped to the CPU address=20
space.&nbsp;</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D080062814-03082005>For =
reason that is=20
beyond the discussion here, the DMA request line on the PCI card is not=20
connected although the PCI card has DMA capabilities. =
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D080062814-03082005>So =
what are my=20
options? </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D080062814-03082005>Could =
I still do DMA=20
transfer from the Host to the device?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D080062814-03082005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D080062814-03082005>Many =
thanks in=20
advance,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D080062814-03082005>Bizhan</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C5983C.AB7247EB--
