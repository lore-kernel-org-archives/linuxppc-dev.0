Return-Path: <miguel.valero@ericsson.com>
Received: from mailgw4.ericsson.se (mailgw4.ericsson.se [193.180.251.62])
	by ozlabs.org (Postfix) with ESMTP id E493967BAD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Oct 2006 00:24:40 +1000 (EST)
Received: from esealmw126.eemea.ericsson.se (unknown [153.88.254.123])
	by mailgw4.ericsson.se (Symantec Mail Security) with ESMTP id
	09FEC4F0002 for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Oct 2006 16:07:56 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6ED3E.A5B9C2C6"
Subject: How to connect a CF to a MPC82xx in trueIDE mode with DMA/UDMA
	capability?
Date: Wed, 11 Oct 2006 16:07:55 +0200
Message-ID: <A882E155DA2B6449842E839A0E1DB4E70307D35B@esealmw109.eemea.ericsson.se>
From: "Miguel Valero \(OS/EXA\)" <miguel.valero@ericsson.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6ED3E.A5B9C2C6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Does anybody know whether it is possible to have a CF card directly
connected to a MPC82xx and have it working in trueIDE mode with either
multiword DMA or, preferibly, UDMA capabilities on?
We know how to have it connected and working in trueIDE mode, but
without DMA capabilities.

Is the MPC82xx DMA controller at all able to assist the CF in doing
multiword DMA or UDMA? How does one connect the DMA related CF pins to
the MPC82xx? How does one configure the UPM that controls the CF? Is
there a linux driver for MPC82xx that exploits the DMA/UDMA capabilities
of the CF?


Regards
Miguel A. Valero
R&D engineer
Ericsson AXXESSIT AS



------_=_NextPart_001_01C6ED3E.A5B9C2C6
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7650.28">
<TITLE>How to connect a CF to a MPC82xx in trueIDE mode with DMA/UDMA =
capability?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Does anybody know whether it is =
possible to have a CF card directly connected to a MPC82xx and have it =
working in trueIDE mode with either multiword DMA or, preferibly, UDMA =
capabilities on?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We know how to have it connected and =
working in trueIDE mode, but without DMA capabilities.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Is the MPC82xx DMA controller at all =
able to assist the CF in doing multiword DMA or UDMA? How does one =
connect the DMA related CF pins to the MPC82xx? How does one configure =
the UPM that controls the CF? Is there a linux driver for MPC82xx that =
exploits the DMA/UDMA capabilities of the CF?</FONT></P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Regards</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Miguel A. Valero</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">R&amp;D engineer</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Ericsson AXXESSIT AS</FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C6ED3E.A5B9C2C6--
