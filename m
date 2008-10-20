Return-Path: <peter.scott@ericsson.com>
Received: from mailgw3.ericsson.se (mailgw3.ericsson.se [193.180.251.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB2E5DDDE1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Oct 2008 07:07:48 +1100 (EST)
Received: from mailgw3.ericsson.se (unknown [127.0.0.1])
	by mailgw3.ericsson.se (Symantec Mail Security) with ESMTP id
	256FB204A8 for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Oct 2008 21:42:47 +0200 (CEST)
Received: from esealmw127.eemea.ericsson.se (unknown [153.88.254.122])
	by mailgw3.ericsson.se (Symantec Mail Security) with ESMTP id
	F2BAA2001A for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Oct 2008 21:42:46 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C932EC.05024350"
Subject: Xilininx GPIO
Date: Mon, 20 Oct 2008 21:42:41 +0200
Message-ID: <425A3BC99494A4409BEF99524478ED52092E7F36@esealmw103.eemea.ericsson.se>
From: "Peter Scott" <peter.scott@ericsson.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C932EC.05024350
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello there,

I am having difficulties with some xilinx gpios and the xilinx-2.6-xlnx
kernel. As far as I can tell the kernel is configured correctly for
gpio.
=20
I can see that the module_init function "xgpio_init" is called, and that
bus_add_driver and driver_add_groups returns without error. But I cannot
see that the probe function is called.  /proc/misc doesnt list a driver
for the gpios. I am not sure where to go next as there is no error
printouts.

I have seen other peoples consoles stating that the gpio is mapped to xx
but this doesn't happen for me.

I am using the default bit file for the ml507 board, and have created
device files=20
/dev/xgpio0=20
/dev/xgpio1 etc with major 10 and minor 185=20

However if I try to open these devices the open fails.=20

I would rally appreciate it if someone could give me some pointers as to
what to look for, or how a to go about debugging this.

Many thanks
Peter Scott

------_=_NextPart_001_01C932EC.05024350
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.38">
<TITLE>Xilininx GPIO</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello there,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am having difficulties with some =
xilinx gpios and the xilinx-2.6-xlnx kernel. As far as I can tell the =
kernel is configured correctly for gpio.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">I can see that the module_init =
function &quot;xgpio_init&quot; is called, and that bus_add_driver and =
driver_add_groups returns without error. But I cannot see that the probe =
function is called.&nbsp; /proc/misc doesnt list a driver for the gpios. =
I am not sure where to go next as there is no error =
printouts.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have seen other peoples consoles =
stating that the gpio is mapped to xx but this doesn't happen for =
me.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am using the default bit file for the =
ml507 board, and have created device files </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/xgpio0 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/xgpio1 etc with major 10 and =
minor 185 </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">However if I try to open these devices =
the open fails. </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I would rally appreciate it if someone =
could give me some pointers as to what to look for, or how a to go about =
debugging this.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Many thanks</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Peter Scott</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C932EC.05024350--
