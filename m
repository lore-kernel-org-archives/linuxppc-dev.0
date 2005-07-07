Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id C098567B92
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Jul 2005 08:08:11 +1000 (EST)
Received: from xbh-sjc-231.amer.cisco.com (xbh-sjc-231.cisco.com
	[128.107.191.100])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id j67Lw9op010250
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Jul 2005 14:58:10 -0700 (PDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5833E.F659874E"
Date: Thu, 7 Jul 2005 14:58:09 -0700
Message-ID: <F795765B112E7344AF36AA91127964151EC368@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: remap_page_range not resolved
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

------_=_NextPart_001_01C5833E.F659874E
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi All,
I am porting a Linux PCI driver originally developed for X86 platform to
MPC8540ADS reference  board by Freescale running 2.6 Linux.=20
The "insmod" command fails when I am trying to load the module. The
failure is because the reference to a function name can not be resolved:
"remap_page_range"
Could someone help me please to find out what I am missing from my
kernel image?
=20
Regards,
Bizhan

------_=_NextPart_001_01C5833E.F659874E
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D633064321-07072005>Hi=20
All,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D633064321-07072005>I am =
porting a Linux=20
PCI driver originally developed for X86 platform to&nbsp; MPC8540ADS=20
reference&nbsp; board by Freescale running 2.6 Linux. =
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D633064321-07072005>The =
"insmod" command=20
fails when I am trying to load the module. The failure is&nbsp;because =
the=20
reference to a function name&nbsp;can not be resolved:=20
"remap_page_range"</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D633064321-07072005>Could =
someone help=20
me please to find out what I am missing from my kernel=20
image?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D633064321-07072005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D633064321-07072005>Regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D633064321-07072005>Bizhan</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C5833E.F659874E--
