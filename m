Return-Path: <sinan.awad@med.ge.com>
Received: from ext-ch1gw-3.online-age.net (ext-ch1gw-3.online-age.net
	[216.34.191.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-ch1gw.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5A41867BEC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 22:54:19 +1100 (EST)
Received: from int-ch1gw-3.online-age.net (int-ch1gw-3 [3.159.232.67])
	by ext-ch1gw-3.online-age.net (8.13.6/8.13.6/20051111-SVVS-TLS-DNSBL)
	with ESMTP id kBEBjdSp015402 for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 06:45:39 -0500 (EST)
Received: from cinmlef01.e2k.ad.ge.com (int-ch1gw-3 [3.159.232.67])
	by int-ch1gw-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id kBEBlSBg020908 for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 06:47:28 -0500 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C71F75.B227FAF6"
Subject: Linux on PowerQUICC 8349E
Date: Thu, 14 Dec 2006 12:50:32 +0100
Message-ID: <22A704B880BBD94A9E52BD6FA90C63D787241F@BUDMLVEM08.e2k.ad.ge.com>
From: "Awad, Sinan \(GE Healthcare\)" <sinan.awad@med.ge.com>
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

------_=_NextPart_001_01C71F75.B227FAF6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all
=20
I'm new to this list, so please be gentle ;)
I've been working on vxWorks (5-6) for a few years on powerquicc CPUs.
=20
I wanted to check the option of moving to linux, I have a windriver
sbc8349 evb, which I would like to boot linux on.
- I downloaded crosstool, and am building the ppc603 toolchain (is that
OK ? or is there some better toolchain ?)
- Where do I go now ? I downloaded the latest kernel from kernel.orgmn
and...
=20
I am quite ok on linux, yet never cross-compiled or brought-up a board
based on some flavor of linux..
=20
I have searched the web for information, but the sources of knowledge
are quite sparse and not helpfull..
=20
Can someone please point me to a starting point, so that I can at least
flash a bootloader to the board, with some sort of BSP, so that I can
see at least some linux prompt on the serial port ? ;)
=20
Thanks in advance.
Sinan..
=20
=20
=20
=20
Notice: This e-mail and accompanying files contain confidential
information, belonging to the sender that is legally privileged. This
information is intended only for use by the individual or entity
designated. The authorized recipient of this information is prohibited
from disclosing the information to any other party and is required to
destroy the information after its stated need has been fulfilled. If you
are not the intended recipient, you are hereby notified that any
disclosure, copying, distribution, or action taken in reliance on the
contents of these documents is strictly prohibited. If you have received
this copy in error, please notify the sender immediately and destroy all
copies of this information, including any attachments, without reading
or disclosing them. Thank You
=20

------_=_NextPart_001_01C71F75.B227FAF6
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1578" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D093264511-14122006>Hello=20
all</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D093264511-14122006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D093264511-14122006>I'm =
new to this=20
list, so please be gentle ;)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D093264511-14122006>I've =
been working on=20
vxWorks (5-6) for a few years on powerquicc CPUs.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D093264511-14122006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D093264511-14122006>I =
wanted to check=20
the option of moving to linux, I have a windriver sbc8349 evb, which I =
would=20
like to boot linux on.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D093264511-14122006>- I =
downloaded=20
crosstool, and am building the ppc603 toolchain (is that OK ? or is =
there some=20
better toolchain ?)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D093264511-14122006>- =
Where do I go now=20
? I downloaded the latest kernel from kernel.orgmn =
and...</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D093264511-14122006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D093264511-14122006>I am =
quite ok on=20
linux, yet never cross-compiled or brought-up a board based on some =
flavor of=20
linux..</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D093264511-14122006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D093264511-14122006>I have =
searched the=20
web for information, but the sources of knowledge are quite sparse and =
not=20
helpfull..</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D093264511-14122006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D093264511-14122006>Can =
someone please=20
point me to a starting point, so that I can at least flash a bootloader =
to the=20
board, with some sort of BSP, so that&nbsp;I can see at least some linux =
prompt=20
on the serial port ? ;)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D093264511-14122006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D093264511-14122006>Thanks =
in=20
advance.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D093264511-14122006>Sinan..</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D093264511-14122006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D093264511-14122006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><U><SPAN=20
style=3D"FONT-SIZE: 7.5pt; COLOR: black; FONT-FAMILY: 'Arial Narrow'; =
mso-bidi-font-family: 'Arial Narrow'">Notice</SPAN></U><SPAN=20
style=3D"FONT-SIZE: 7.5pt; COLOR: black; FONT-FAMILY: 'Arial Narrow'; =
mso-bidi-font-family: 'Arial Narrow'">:=20
This e-mail and accompanying files contain confidential information, =
belonging=20
to the sender that is legally privileged. This information is intended =
only for=20
use by the individual or entity designated. The authorized recipient of =
this=20
information is prohibited from disclosing the information to any other =
party and=20
is required to destroy the information after its stated need has been =
fulfilled.=20
If you are not the intended recipient, you are hereby notified that any=20
disclosure, copying, distribution, or action taken in reliance on the =
contents=20
of these documents is strictly prohibited. If you have received this =
copy in=20
error, please notify the sender immediately and destroy all copies of =
this=20
information, including any attachments, without reading or disclosing =
them.=20
Thank You</SPAN></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C71F75.B227FAF6--
