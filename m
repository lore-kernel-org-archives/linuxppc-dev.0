Return-Path: <bsilverman@iveia.com>
Received: from wisrv001.westonlan.com (mail1.westonlan.com [75.148.20.91])
	by ozlabs.org (Postfix) with ESMTP id 5EB57DE33B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Apr 2008 00:45:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A618.17197C52"
Subject: EABI
Date: Thu, 24 Apr 2008 10:32:57 -0400
Message-ID: <D3DA1D029B6D214DAA13E79CD073026F0A8DD2@wisrv001.westonlan.com>
From: "Brian Silverman" <bsilverman@iveia.com>
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

------_=_NextPart_001_01C8A618.17197C52
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Is it possible to compile a Linux application using an EABI compiler
(specfically, Xilinx's EDK powerpc-eabi-gcc.exe)?
=20
The issue at hand is that we'd like for our customers to be able to use
the Xilinx EDK toolchain (which we know they will have) to compile Linx
apps without having to install another toolchain (crosstool, ELDK, etc).
=20
So, what I'm hoping is that the EDK toolchain can be configured to be
Linux compatible binaries, or that there is some kind of wrapper that
will handle the incompatible interfaces.  Searching around, I've seen
some mention of Linux EABI compatibility (for Debian ARM releases), but
I haven't found any clear concensus...
=20
----
Brian Silverman
Principal Engineer
iVeia
=20

------_=_NextPart_001_01C8A618.17197C52
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3314" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D768110114-24042008><FONT face=3DArial size=3D2>Is it =
possible to=20
compile a Linux application using an EABI compiler (specfically, =
Xilinx's EDK=20
powerpc-eabi-gcc.exe)?</FONT></SPAN></DIV>
<DIV><SPAN class=3D768110114-24042008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D768110114-24042008><FONT face=3DArial size=3D2>The =
issue at hand is=20
that&nbsp;we'd like for our customers to be able to use the Xilinx EDK =
toolchain=20
(which we know they will have) to compile Linx apps without having to =
install=20
another toolchain (crosstool, ELDK, etc).</FONT></SPAN></DIV>
<DIV><SPAN class=3D768110114-24042008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D768110114-24042008><FONT face=3DArial size=3D2>So, =
what I'm hoping=20
is that the EDK toolchain can be configured to be Linux compatible =
binaries, or=20
that there is some kind of wrapper that will handle the incompatible=20
interfaces.&nbsp; Searching around, I've seen some mention of Linux EABI =

compatibility (for Debian ARM releases), but I haven't found any clear=20
concensus...</FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV align=3Dleft>
<DIV align=3Dleft><FONT face=3DArial size=3D2><SPAN =
class=3D179563815-09112007>
<DIV><FONT face=3DArial><FONT face=3DVerdana =
size=3D2>----</FONT></FONT></DIV>
<DIV><FONT face=3DArial color=3D#000000 size=3D2><STRONG><FONT =
face=3DVerdana=20
color=3D#0000ff size=3D3>Brian Silverman<BR></FONT></STRONG><SPAN=20
style=3D"FONT-SIZE: 12px"><STRONG><FONT color=3D#808080><FONT =
face=3DVerdana>Principal=20
Engineer<BR></FONT></STRONG></SPAN></FONT><SPAN><FONT =
face=3DVerdana><FONT=20
color=3D#0000ff><STRONG>iVeia</STRONG></FONT></FONT></SPAN></FONT></DIV><=
/SPAN></FONT></DIV></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C8A618.17197C52--
