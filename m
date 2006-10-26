Return-Path: <matias.sundman@ericsson.com>
Received: from mailgw3.ericsson.se (mailgw3.ericsson.se [193.180.251.60])
	by ozlabs.org (Postfix) with ESMTP id 0C70867E07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Oct 2006 17:47:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6F8CF.C7210EB9"
Subject: RE: Using WindRiver Probe JTAG
Date: Thu, 26 Oct 2006 09:24:30 +0200
Message-ID: <24521B9781EAC745A4BE65966F69C9BE044FF03F@esealmw115.eemea.ericsson.se>
In-Reply-To: <1ea6be8e0610250554l5f9a431cr26f03a99574f68d9@mail.gmail.com>
From: "Matias Sundman \(AS/EAB\)" <matias.sundman@ericsson.com>
To: "Michael Zagalsky" <michaelzwrk@gmail.com>, <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6F8CF.C7210EB9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,
My name is Matias and I am working @ Ericsson in Stockholm.
We are using both BDI2000 and the WR ICE / probe.
I must say that if you have anyway invested in Workbench go with the WR
solutions. It is very convenient to debug U-boot , the Linux kernel or
insmod:ing of kernel modules with WB once you have things set-up. In
order to see the symbols you do not need to compile your kernel under
WB.
=20
Why do we have both BDI2000 and WR tools? We started with the open
source tools suite a few years back but have now made a transition
towards
the Eclipse based WB environment in order to get a uniform and easy to
use/deploy development environment.
=20
Note that I think that the Opensource tools and BDI2000 is a very good
alternative if you are a smaller organization or if you do not want to
or have
the $$$ to invest in WB.
=20
Cheers // Matias

________________________________

From: linuxppc-embedded-bounces+matias.sundman=3Dericsson.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+matias.sundman=3Dericsson.com@ozlabs.or=
g
] On Behalf Of Michael Zagalsky
Sent: den 25 oktober 2006 14:54
To: linuxppc-embedded@ozlabs.org
Subject: Using WindRiver Probe JTAG


Hi guys.
I'd like to know if anybody had an experience using Wind River Probe
JTAG with PowerPC architecture in general, and with PowerQuicc iii
family in particular.
We're using WR workbench, but I am not sure whether to use their JTAG or
the popular BDI2000.
Does anybody know if WR Probe uses GDB, or something proprietary to WR?
Can it be attached to gdb/ddd/eclipse, or only to WR workbench IDE?
For kernel debugging with symbolic information - can it use any binary
compiled with -g, or it has to be compiled under WR workbench
environment that has some add-ons (I know, it sounds strange - but I
actually heard some vague saying of this kind from WR representative).=20
=20
I know those are questions that should be addressed to Wind River ,
which I did, but I didn't get clear enough answers - so your (good/bad)
field experience could be very helpful.
=20
Thanks a lot,=20
Michael

------_=_NextPart_001_01C6F8CF.C7210EB9
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1561" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D483301707-26102006><FONT face=3DArial color=3D#0000ff =

size=3D2>Hello,</FONT></SPAN></DIV>
<DIV><SPAN class=3D483301707-26102006><FONT face=3DArial color=3D#0000ff =
size=3D2>My=20
name is Matias and I am working @ Ericsson in =
Stockholm.</FONT></SPAN></DIV>
<DIV><SPAN class=3D483301707-26102006><FONT face=3DArial color=3D#0000ff =
size=3D2>We are=20
using both BDI2000 and the WR ICE / probe.</FONT></SPAN></DIV>
<DIV><SPAN class=3D483301707-26102006><FONT face=3DArial color=3D#0000ff =
size=3D2>I must=20
say that if you have anyway invested in Workbench go with the WR =
solutions. It=20
is very convenient to debug U-boot , the Linux kernel =
or</FONT></SPAN></DIV>
<DIV><SPAN class=3D483301707-26102006><FONT face=3DArial color=3D#0000ff =

size=3D2>insmod:ing of kernel modules with WB once you have things =
set-up. In=20
order to see the symbols you do not need to compile your kernel under=20
WB.</FONT></SPAN></DIV>
<DIV><SPAN class=3D483301707-26102006><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D483301707-26102006><FONT face=3DArial color=3D#0000ff =
size=3D2>Why do=20
we have both BDI2000 and WR tools? We started with the open source tools =
suite a=20
few years back but have now made a transition =
towards</FONT></SPAN></DIV>
<DIV><SPAN class=3D483301707-26102006><FONT face=3DArial color=3D#0000ff =
size=3D2>the=20
Eclipse based WB environment in order to get a uniform and easy to =
use/deploy=20
development environment.</FONT></SPAN></DIV>
<DIV><SPAN class=3D483301707-26102006><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D483301707-26102006><FONT face=3DArial color=3D#0000ff =
size=3D2>Note=20
that I think that the Opensource tools and BDI2000 is a very good =
alternative if=20
you are a smaller organization or if you do not want to or=20
have</FONT></SPAN></DIV>
<DIV><SPAN class=3D483301707-26102006><FONT face=3DArial color=3D#0000ff =
size=3D2>the=20
$$$ to invest in WB.</FONT></SPAN></DIV>
<DIV><SPAN class=3D483301707-26102006><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D483301707-26102006><FONT face=3DArial color=3D#0000ff =
size=3D2>Cheers=20
// Matias</FONT></SPAN></DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B>=20
linuxppc-embedded-bounces+matias.sundman=3Dericsson.com@ozlabs.org=20
[mailto:linuxppc-embedded-bounces+matias.sundman=3Dericsson.com@ozlabs.or=
g] <B>On=20
Behalf Of </B>Michael Zagalsky<BR><B>Sent:</B> den 25 oktober 2006=20
14:54<BR><B>To:</B> linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> =
Using=20
WindRiver Probe JTAG<BR></FONT><BR></DIV>
<DIV></DIV>
<DIV>Hi guys.</DIV>
<DIV>I'd like to know if anybody had an experience&nbsp;using Wind River =
Probe=20
JTAG with PowerPC architecture in general, and with PowerQuicc iii =
family in=20
particular.</DIV>
<DIV>We're using WR workbench, but I am not sure whether to use their =
JTAG or=20
the popular BDI2000.</DIV>
<DIV>Does anybody know if WR Probe uses GDB, or something proprietary to =

WR?</DIV>
<DIV>Can it be attached to gdb/ddd/eclipse, or only to WR workbench =
IDE?</DIV>
<DIV>For kernel debugging with symbolic information - can it use any =
binary=20
compiled with -g, or it has to be compiled under WR workbench =
environment that=20
has some add-ons (I know, it sounds strange - but I actually heard some =
vague=20
saying of this kind from WR representative). </DIV>
<DIV>&nbsp;</DIV>
<DIV>I know those are questions that should be addressed to Wind River , =
which I=20
did, but I didn't get clear enough answers - so your (good/bad) field =
experience=20
could be very helpful.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks a lot, </DIV>
<DIV>Michael</DIV></BODY></HTML>

------_=_NextPart_001_01C6F8CF.C7210EB9--
