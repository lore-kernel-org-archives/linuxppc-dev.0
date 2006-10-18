Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id 9D42B67BE4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 03:53:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6F2DE.5B86BC79"
Subject: ELDK 4.0 / GDB with mpc85xx
Date: Wed, 18 Oct 2006 13:53:45 -0400
Message-ID: <3C02138692C13C4BB675FE7EA24095291F5CB9@bluefin.Soneticom.local>
From: "Clint Thomas" <cthomas@Soneticom.com>
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

------_=_NextPart_001_01C6F2DE.5B86BC79
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey guys,

I am trying to use GDB to debug U-boot 1.1.2 on a system based loosely
off the MPC8540ADS platform. Right now, both Linux (2.4.27) and U-boot
compile perfectly using our in-house cross-compilers
(gcc-3.3.2-glibc-2.3.2), where with the cross-compilers provided in the
ELDK they will not compile.=20
=20
My real question however is, will this effect the use of the crossGDB
provided with the ELDK? I want to use it with a BDI2000, and the
documentation on the Denx website shows it working, but I have also read
about issues related to the version of GDB, the BDI firmware, and the
e500 core not playing nicely together. Has anybody had good experience
getting this setup fully functional? I really need to be able to step
through the U-boot code and see where it is failing on our platform.
Thanks for the help!
=20
Clinton Thomas
=20

------_=_NextPart_001_01C6F2DE.5B86BC79
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D715174817-18102006><FONT face=3DArial size=3D2>Hey =
guys,<BR><BR>I=20
am trying to use GDB to debug U-boot 1.1.2 on a system based loosely off =
the=20
MPC8540ADS platform. Right now, both Linux (2.4.27) and U-boot compile =
perfectly=20
using our in-house cross-compilers (gcc-3.3.2-glibc-2.3.2), where with =
the=20
cross-compilers provided in the ELDK they will not compile. =
</FONT></SPAN></DIV>
<DIV><SPAN class=3D715174817-18102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D715174817-18102006><FONT face=3DArial size=3D2>My =
real question=20
however is, will this effect the use of the crossGDB provided with the =
ELDK? I=20
want to use it with a BDI2000, and the documentation on the Denx website =
shows=20
it working, but I have also read about issues related to the version of =
GDB, the=20
BDI firmware, and the e500 core not playing nicely together. Has anybody =
had=20
good experience getting this setup fully functional? I really need to be =
able to=20
step through the U-boot code and see where it is failing on our =
platform. Thanks=20
for the help!</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Clinton =
Thomas</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C6F2DE.5B86BC79--
