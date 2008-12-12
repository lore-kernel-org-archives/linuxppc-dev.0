Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 3C96DDE070
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 03:49:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C95C79.9D8278A1"
Subject: Trying to understand ppc4xx_configure_pciex_PIMs mapping to physical
	address 0
Date: Fri, 12 Dec 2008 10:49:36 -0600
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F8B7@tanisys-ex2.Tanisys.Local>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C95C79.9D8278A1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am using the ppc460ex as an endpoint and I see that the mentioned
function setups a 32Mb
window at address 0 in sdram.  what i want is some memory that the host
can read/write to.
But the 32Mb that are already mapped at the bottom of ram, so it would
not be good do writes
to those addresses.  Am I missing something?  My driver right now is not
touching the PIM=20
registers.
=20
So is the right way to do this to change the PIM registers after I get a
buffer in the kernel -- or
something else?
=20
How would I make sure that it was aligned on a 32Mb boundry per the 44x
requirements? =20
=20
thanks
ayman

------_=_NextPart_001_01C95C79.9D8278A1
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16735" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D678054316-12122008>I am =
using the=20
ppc460ex as an endpoint and I see that the mentioned function setups a=20
32Mb</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D678054316-12122008>window =
at address 0=20
in sdram.&nbsp; what i want is some memory that the host can read/write=20
to.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D678054316-12122008>But =
the 32Mb that=20
are already mapped at the bottom of ram, so it would not be =
</SPAN></FONT><FONT=20
face=3DArial size=3D2><SPAN class=3D678054316-12122008>good&nbsp;do=20
writes</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D678054316-12122008>to =
those=20
addresses.&nbsp; Am I missing something?</SPAN></FONT><FONT face=3DArial =

size=3D2><SPAN class=3D678054316-12122008>&nbsp; My driver right now is =
not touching=20
the PIM </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D678054316-12122008>registers.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D678054316-12122008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D678054316-12122008>So is =
the right way=20
to do this to change the PIM registers after I get a buffer in the =
kernel --=20
or</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D678054316-12122008>something=20
else?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D678054316-12122008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D678054316-12122008>How =
would I make=20
sure that it was aligned on a 32Mb boundry per the 44x =
requirements?&nbsp;=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D678054316-12122008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D678054316-12122008>thanks</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D678054316-12122008>ayman</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C95C79.9D8278A1--
