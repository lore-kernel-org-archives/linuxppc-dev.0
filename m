Return-Path: <Jens-Peter.Oswald@kayser-threde.de>
Received: from ktweb02.kayser-threde.de (ktweb02.kayser-threde.de
	[62.245.158.227]) by ozlabs.org (Postfix) with SMTP id EB1702BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 23:52:38 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-0b39bc26-0097-4136-b5dc-22220ac00e09"
Date: Thu, 13 Jan 2005 13:37:12 +0100
Message-ID: <1D40077EC04042479FDA552D718E051B010D7528@ktms3.net.local>
From: <Jens-Peter.Oswald@kayser-threde.de>
To: <linuxppc-embedded@ozlabs.org>
Subject: TQM860L hangs after soft reboot
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

------=_NextPartTM-000-0b39bc26-0097-4136-b5dc-22220ac00e09
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4F96C.9AEAA5E4"

------_=_NextPart_001_01C4F96C.9AEAA5E4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

We've designed a custom board for an TQM860L module from TQ-Components.
Now the following behaviour occurs:

After a soft reset (from linux or bootloader u-boot) the board hangs.=20
Only a hard reset (power cycle or RESIN# pin low of TQ-Modul) wakes it
up.=20
In the evaluation board STK8xxL from TQ the modul boots normally after a
soft reset.

I assume it might be a forgotten pullup- or pull down in our custom
board.

Any hints which pins I must check?

By the way, how does linux handle a soft reset?

--
Dipl.-Ing. Jens-Peter Oswald         =20


------_=_NextPart_001_01C4F96C.9AEAA5E4
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6556.0">
<TITLE>TQM860L hangs after soft reboot</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi all,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We've designed a custom board for an =
TQM860L module from TQ-Components.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Now the following behaviour =
occurs:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">After a soft reset (from linux or =
bootloader u-boot) the board hangs. </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Only a hard reset (power cycle or =
RESIN# pin low of TQ-Modul) wakes it up. </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">In the evaluation board STK8xxL from =
TQ the modul boots normally after a soft reset.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I assume it might be a forgotten =
pullup- or pull down in our custom board.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Any hints which pins I must =
check?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">By the way, how does linux handle a =
soft reset?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">--</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Dipl.-Ing. Jens-Peter =
Oswald&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C4F96C.9AEAA5E4--

------=_NextPartTM-000-0b39bc26-0097-4136-b5dc-22220ac00e09--
