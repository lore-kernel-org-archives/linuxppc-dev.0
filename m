Return-Path: <Rajan.Rai@ingenient.com>
Received: from mail.ingenient.com (unknown [63.87.52.245])
	by ozlabs.org (Postfix) with ESMTP id 97E0567B73
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 11:04:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6BCE0.0E463295"
Subject: PCI driver on EB8347
Date: Thu, 10 Aug 2006 19:49:52 -0500
Message-ID: <4DA89577C33E194ABEBC978921E858541B8E38@exchange.ingenient.net>
From: "rajan rai" <Rajan.Rai@ingenient.com>
To: <kumar.gala@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C6BCE0.0E463295
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



        I have written PCI driver which works fine along with MPC8347 =
and two PCI card connected in a single PCI bus. When I try to =
communicate same PCI card using PCI bridge ( PCI2050B ), Linux does =
detect PCI card on Secondary bus but same driver doesn't work !!!!
      =20
                 Do I need to enable support for second PCI host =
controller at kernel level to make it work? Or I need to do something =
else ? I tried compiling PPC-linux kernel after enabling =
CONFIG_85xx_PCI2 kernel doesn't compile it gives me error while =
compiling "arch/ppc/syslib/ppc83xx_setup.c" Kernel version I'm using is =
2.6.13.


****** Board along with which PCI card works ************
lspci -v
/demo # lspci -v
00:1b.0 Non-VGA unclassified device: Texas Instruments: Unknown device =
9065 (rev 01)
        Flags: bus master, medium devsel, latency 128, IRQ 21
        Memory at 9fc00000 (32-bit, prefetchable) [size=3D4M]
        Memory at 9f000000 (32-bit, non-prefetchable) [size=3D8M]
        I/O ports at 3ffffff0 [size=3D16]
        Capabilities: [40] Power Management version 2

00:1c.0 Non-VGA unclassified device: Texas Instruments: Unknown device =
9065 (rev 01)
        Flags: bus master, medium devsel, latency 128, IRQ 18
        Memory at 9ec00000 (32-bit, prefetchable) [size=3D4M]
        Memory at 9e000000 (32-bit, non-prefetchable) [size=3D8M]
        I/O ports at 3fffffe0 [size=3D16]
        Capabilities: [40] Power Management version 2


****** Board along with which PCI card doesn't work ************
lspci -v
PCI devices found:
  Bus  0, device  17, function  0:
    Class 0604: PCI device 104c:ac28 (rev 2).
  Bus  1, device   1, function  0:
    Class 0000: PCI device 104c:9065 (rev 1).
      Master Capable.  Latency=3D128.
      Prefetchable 32 bit memory at 0x9fc00000 [0x9fffffff].
      Non-prefetchable 32 bit memory at 0x9f000000 [0x9f7fffff].
      I/O at 0xfff0 [0xffff].
  Bus  1, device   2, function  0:
    Class 0000: PCI device 104c:9065 (rev 1).
      Master Capable.  Latency=3D128.
      Prefetchable 32 bit memory at 0x9ec00000 [0x9effffff].
      Non-prefetchable 32 bit memory at 0x9e000000 [0x9e7fffff].
      I/O at 0xffe0 [0xffef].

                     Any help would be appreciated I'm running out of =
ideas what to do next !!!!!!!!

Regards,
-Rajan Rai

------_=_NextPart_001_01C6BCE0.0E463295
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>PCI driver on EB8347</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>
<BR>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I have =
written PCI driver which works fine along with MPC8347 and two PCI card =
connected in a single PCI bus. When I try to communicate same PCI card =
using PCI bridge ( PCI2050B ), Linux does detect PCI card on Secondary =
bus but same driver doesn't work !!!!<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; Do I need to enable support for second PCI host =
controller at kernel level to make it work? Or I need to do something =
else ? I tried compiling PPC-linux kernel after enabling =
CONFIG_85xx_PCI2 kernel doesn't compile it gives me error while =
compiling &quot;arch/ppc/syslib/ppc83xx_setup.c&quot; Kernel version I'm =
using is 2.6.13.<BR>
<BR>
<BR>
****** Board along with which PCI card works ************<BR>
lspci -v<BR>
/demo # lspci -v<BR>
00:1b.0 Non-VGA unclassified device: Texas Instruments: Unknown device =
9065 (rev 01)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, medium =
devsel, latency 128, IRQ 21<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 9fc00000 (32-bit, =
prefetchable) [size=3D4M]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 9f000000 (32-bit, =
non-prefetchable) [size=3D8M]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at 3ffffff0 =
[size=3D16]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [40] Power =
Management version 2<BR>
<BR>
00:1c.0 Non-VGA unclassified device: Texas Instruments: Unknown device =
9065 (rev 01)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, medium =
devsel, latency 128, IRQ 18<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 9ec00000 (32-bit, =
prefetchable) [size=3D4M]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 9e000000 (32-bit, =
non-prefetchable) [size=3D8M]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at 3fffffe0 =
[size=3D16]<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [40] Power =
Management version 2<BR>
<BR>
<BR>
****** Board along with which PCI card doesn't work ************<BR>
lspci -v<BR>
PCI devices found:<BR>
&nbsp; Bus&nbsp; 0, device&nbsp; 17, function&nbsp; 0:<BR>
&nbsp;&nbsp;&nbsp; Class 0604: PCI device 104c:ac28 (rev 2).<BR>
&nbsp; Bus&nbsp; 1, device&nbsp;&nbsp; 1, function&nbsp; 0:<BR>
&nbsp;&nbsp;&nbsp; Class 0000: PCI device 104c:9065 (rev 1).<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Master Capable.&nbsp; Latency=3D128.<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Prefetchable 32 bit memory at 0x9fc00000 =
[0x9fffffff].<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Non-prefetchable 32 bit memory at =
0x9f000000 [0x9f7fffff].<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O at 0xfff0 [0xffff].<BR>
&nbsp; Bus&nbsp; 1, device&nbsp;&nbsp; 2, function&nbsp; 0:<BR>
&nbsp;&nbsp;&nbsp; Class 0000: PCI device 104c:9065 (rev 1).<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Master Capable.&nbsp; Latency=3D128.<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Prefetchable 32 bit memory at 0x9ec00000 =
[0x9effffff].<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Non-prefetchable 32 bit memory at =
0x9e000000 [0x9e7fffff].<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O at 0xffe0 [0xffef].<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Any help would be =
appreciated I'm running out of ideas what to do next !!!!!!!!<BR>
<BR>
Regards,<BR>
-Rajan Rai</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6BCE0.0E463295--
