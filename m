Return-Path: <mchaffin@microsatsystems.com>
Received: from [63.150.173.66] (itnmail.itnes.com [63.150.173.66])
	by ozlabs.org (Postfix) with ESMTP id 778FE67CDC
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 04:18:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7028F.25D232CD"
Subject: Problem connecting a Ti TUSB2077a hub to Cypress SL811 host
Date: Tue, 7 Nov 2006 10:07:04 -0700
Message-ID: <B9D56A48380DF34CA0922A7C2450D4797B2E8C@itnmail1.itnes.com>
From: "Chaffin, Michael" <mchaffin@microsatsystems.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: "Mouw, Jamie" <jmouw@microsatsystems.com>, "Newman,
	David" <dnewman@microsatsystems.com>
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

------_=_NextPart_001_01C7028F.25D232CD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have a running 2.4.26 Linux kernel (penguinppc.org) on a commercial
built embedded PPC405 (Xilinx VirtexII Pro) attached to a Cypress SL811
shown to work, I am now trying to attach a Texas Instruments TUSB2077a
Hub chip. When I first attach the hub to the host on Data +/- (pins 7 &
8) the host recognizes the hub and then reports "USB device not
accepting new address (error=3D-110)

** SNIP **
		/dev # cd /mnt
		/mnt # insmod usbcore.o -f
		Warning: kernel-module version mismatch
			usbcore.o was compiled for kernel version
2.4.26-msi
			while this kernel is version 2.4.26-pre3
		Warning: loading usbcore.o will taint the kernel: forced
load
		  See http://www.tux.org/lkml/#export-tainted for
information about tainted modules
		Module usbcore loaded, with warnings
		/mnt # insmod -f sl__
		/mnt # insmod -f sl811.o _[J
		Warning: kernel-module version mismatch
			sl811.o was compiled for kernel version
2.4.26-msi
			while this kernel is version 2.4.26-pre3
		Warning: loading sl811.o will taint the kernel: no
license
		  See http://www.tux.org/lkml/#export-tainted for
information about tainted modules
		Warning: loading sl811.o will taint the kernel: forced
load
		Module sl811 loaded, with warnings
		/mnt #=20
		; MSC - External Hub is identified=20
		; MSC - And reports over-current on three of the four
available ports
		hub.c: port 2 over-current change
		hub.c: port 3 over-current change
		hub.c: port 4 over-current change
		; MSC - Host controller unable to set USB address on new
HUB
		; Hub is disconnected and un-reachable from this point
on
		hub.c: USB device not accepting new address (error=3D-110)
		hub.c: error resetting hub 2 - disconnecting
** SNIP **

At this point the hub is completely un-responsive, but re-plugging the
hub will return the same results. If I have a thumb drive attached to
the hub, before I plug the hub into the host controller, I see the thumb
drive properly but exit with the same error "USB device not accepting
new address (error=3D-110).

** SNIP **
		usb.c: USB device 2 (vend/prod 0x781/0x7104) is not
claimed by any active driver.

		; MSC - Thumb drive is enumberated
		  Length              =3D 18
		  DescriptorType      =3D 01
		  USB version         =3D 2.00
		  Vendor:Product      =3D 0781:7104
		  MaxPacketSize0      =3D 64
		  NumConfigurations   =3D 1
		  Device version      =3D 10.33
		  Device Class:SubClass:Protocol =3D 00:00:00
		    Per-interface classes

		Configuration:
		  bLength             =3D    9
		. . . . .=20
		  bInterval           =3D   00

		; MSC - Host controller unable to set USB address on new
HUB
		; Hub is disconnected and un-reachable from this point
on
		hub.c: USB device not accepting new address (error=3D-110)
		hub.c: error resetting hub 127 - disconnecting
** SNIP **

What am I doing wrong?

Michael S. Chaffin
Satellite Test Engineer
MicroSat Systems, Inc.
microsatsystems.com

------_=_NextPart_001_01C7028F.25D232CD
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE>Problem connecting a Ti TUSB2077a hub to Cypress SL811 =
host</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">I have a running 2.4.26 Linux kernel =
(penguinppc.org) on a commercial built embedded PPC405 (Xilinx VirtexII =
Pro) attached to a Cypress SL811 shown to work, I am now trying to =
attach a Texas Instruments TUSB2077a Hub chip. When I first attach the =
hub to the host on Data +/- (pins 7 &amp; 8) the host recognizes the hub =
and then reports &quot;USB device not accepting new address =
(error=3D-110)</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">** SNIP **</FONT>
<UL><UL>
<P><I><FONT SIZE=3D2 FACE=3D"Courier New">/dev # cd /mnt</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">/mnt # insmod usbcore.o =
-f</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">Warning: kernel-module =
version mismatch</FONT></I>

<BR><I>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Courier New">usbcore.o was compiled for kernel version =
2.4.26-msi</FONT></I>

<BR><I>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Courier New">while this kernel is version 2.4.26-pre3</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">Warning: loading usbcore.o =
will taint the kernel: forced load</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; See </FONT></I><A =
HREF=3D"http://www.tux.org/lkml/#export-tainted"><I><U><FONT =
COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Courier =
New">http://www.tux.org/lkml/#export-tainted</FONT></U></I></A><I><FONT =
SIZE=3D2 FACE=3D"Courier New"> for information about tainted =
modules</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">Module usbcore loaded, with =
warnings</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">/mnt # insmod -f =
sl__</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">/mnt # insmod -f sl811.o =
_[J</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">Warning: kernel-module =
version mismatch</FONT></I>

<BR><I>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Courier New">sl811.o was compiled for kernel version =
2.4.26-msi</FONT></I>

<BR><I>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Courier New">while this kernel is version 2.4.26-pre3</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">Warning: loading sl811.o will =
taint the kernel: no license</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; See </FONT></I><A =
HREF=3D"http://www.tux.org/lkml/#export-tainted"><I><U><FONT =
COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Courier =
New">http://www.tux.org/lkml/#export-tainted</FONT></U></I></A><I><FONT =
SIZE=3D2 FACE=3D"Courier New"> for information about tainted =
modules</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">Warning: loading sl811.o will =
taint the kernel: forced load</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">Module sl811 loaded, with =
warnings</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">/mnt # </FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">; MSC - External Hub is =
identified </FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">; MSC - And reports =
over-current on three of the four available ports</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">hub.c: port 2 over-current =
change</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">hub.c: port 3 over-current =
change</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">hub.c: port 4 over-current =
change</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">; MSC &#8211; Host controller =
unable to set USB address on new HUB</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">; Hub is disconnected and =
un-reachable from this point on</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">hub.c: USB device not =
accepting new address (error=3D-110)</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">hub.c: error resetting hub 2 =
- disconnecting</FONT></I>
</UL></UL>
<P><FONT SIZE=3D2 FACE=3D"Arial">** SNIP **</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">At this point the hub is completely =
un-responsive, but re-plugging the hub will return the same results. If =
I have a thumb drive attached to the hub, before I plug the hub into the =
host controller, I see the thumb drive properly but exit with the same =
error &quot;USB device not accepting new address =
(error=3D-110).</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">** SNIP **</FONT>
<UL><UL>
<P><I><FONT SIZE=3D2 FACE=3D"Courier New">usb.c: USB device 2 (vend/prod =
0x781/0x7104) is not claimed by any active driver.</FONT></I>
</P>

<P><I><FONT SIZE=3D2 FACE=3D"Courier New">; MSC &#8211; Thumb drive is =
enumberated</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
Length&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =3D 18</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
DescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 01</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; USB =
version&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
2.00</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
Vendor:Product&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0781:7104</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
MaxPacketSize0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 64</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
NumConfigurations&nbsp;&nbsp; =3D 1</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; Device =
version&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 10.33</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; Device =
Class:SubClass:Protocol =3D 00:00:00</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; =
Per-interface classes</FONT></I>
</P>

<P><I><FONT SIZE=3D2 FACE=3D"Courier New">Configuration:</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; =3D&nbsp;&nbsp;&nbsp; 9</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">. . . . . </FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; =
bInterval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D&nbsp;&nbsp; 00</FONT></I>
</P>

<P><I><FONT SIZE=3D2 FACE=3D"Courier New">; MSC &#8211; Host controller =
unable to set USB address on new HUB</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">; Hub is disconnected and =
un-reachable from this point on</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">hub.c: USB device not =
accepting new address (error=3D-110)</FONT></I>

<BR><I><FONT SIZE=3D2 FACE=3D"Courier New">hub.c: error resetting hub =
127 - disconnecting</FONT></I>
</UL></UL>
<P><FONT SIZE=3D2 FACE=3D"Arial">** SNIP **</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">What am I doing wrong?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Michael S. Chaffin</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Satellite Test Engineer</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">MicroSat Systems, Inc.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">microsatsystems.com</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7028F.25D232CD--
