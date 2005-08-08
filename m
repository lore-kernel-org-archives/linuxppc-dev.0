Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id 4A19567E2E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Aug 2005 04:12:31 +1000 (EST)
Received: from xbh-sjc-221.amer.cisco.com (xbh-sjc-221.cisco.com
	[128.107.191.63])
	by sj-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id j78IC40Z025765
	for <linuxppc-embedded@ozlabs.org>; Mon, 8 Aug 2005 11:12:26 -0700 (PDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C59C44.BA298212"
Date: Mon, 8 Aug 2005 11:12:24 -0700
Message-ID: <F795765B112E7344AF36AA91127964158494EB@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: pci_enable_device fails on MPC8541
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

------_=_NextPart_001_01C59C44.BA298212
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,
I am using two evaluation board from freescale, 8540ADS and MPC8541. The
same PCI driver is being compiled and loaded on both platforms. The same
PCI driver (developed by me) for DSP board compiled and loaded on both
platforms.=20
=20
When I type: "insmod C6415.ko" on 8541 board, I get the following error:
"PCI: Device 0000:02:01.0 not available because of resource collisions"
This messages is because of the execution of the generic PCI Linux
command:
"pci_enable_device(pdev)"
The same API has no problem on 8540ADS.
=20
>From UBOOT I can see my device is on bus 3:
=3D> pci 3
Scanning PCI devices on bus 3
BusDev FUN    VendorID    DeviceID    Device Class    Sub-Class
------------------------------------------------------------------------
--------------------
03.01.00            0x104c    0xa106        .........
=20
Any idea why the insmod fails on one board and not on the other one?
=20
Many thanks in advance,
Bizhan

------_=_NextPart_001_01C59C44.BA298212
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D906172017-08082005><SPAN=20
class=3D548390318-08082005>Hi All,</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D906172017-08082005>I&nbsp;<SPAN=20
class=3D548390318-08082005>am using two evaluation board from freescale, =
8540ADS=20
and MPC8541. The same&nbsp;PCI driver is being compiled and loaded on =
both=20
platforms.&nbsp;</SPAN>The same PCI driver<SPAN =
class=3D548390318-08082005>=20
(developed&nbsp;by me) for&nbsp;DSP board compiled and loaded on both=20
platforms.</SPAN>&nbsp;</SPAN></FONT><FONT face=3DArial size=3D2><SPAN=20
class=3D906172017-08082005></SPAN></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D906172017-08082005></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT><FONT><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D906172017-08082005>When I type: </SPAN><SPAN=20
class=3D906172017-08082005>"insmod C6415.ko"<SPAN =
class=3D548390318-08082005> on=20
8541 board, </SPAN></SPAN></FONT></FONT></FONT></FONT><FONT face=3DArial =

size=3D2><SPAN class=3D906172017-08082005>I get the following=20
error:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D906172017-08082005>"PCI: =
Device=20
0000:02:01.0 not available because of resource =
collisions"</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D906172017-08082005>This=20
messages&nbsp;<SPAN class=3D548390318-08082005>is because of=20
the</SPAN>&nbsp;execution of the generic PCI Linux =
command:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D906172017-08082005>"pci_enable_device(pdev)"</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D906172017-08082005>The =
same API has no=20
problem on 8540ADS.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D906172017-08082005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D906172017-08082005>From =
UBOOT I can see=20
my device is on bus 3:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D906172017-08082005>=3D&gt; pci=20
3</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D906172017-08082005>Scanning PCI devices=20
on bus 3</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D906172017-08082005>BusDev =

FUN&nbsp;&nbsp;&nbsp; VendorID&nbsp;&nbsp;&nbsp; =
DeviceID&nbsp;&nbsp;&nbsp;=20
Device Class&nbsp;&nbsp;&nbsp; Sub-Class</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D906172017-08082005>----------------------------------------------=
----------------------------------------------</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D906172017-08082005>03.01.00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0x104c&nbsp;&nbsp;&nbsp; =
0xa106&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
.........</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D906172017-08082005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D906172017-08082005><SPAN=20
class=3D548390318-08082005>Any idea why the insmod fails on one board =
and not on=20
the other one?</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D906172017-08082005><SPAN=20
class=3D548390318-08082005></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D906172017-08082005><SPAN=20
class=3D548390318-08082005>Many thanks in =
advance,</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D906172017-08082005><SPAN=20
class=3D548390318-08082005>Bizhan</SPAN></SPAN></FONT></DIV></DIV></BODY>=
</HTML>

------_=_NextPart_001_01C59C44.BA298212--
