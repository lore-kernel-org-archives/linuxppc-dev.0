Return-Path: <brankok@dkts.co.yu>
Received: from dkts.co.yu (telis.dkts.co.yu [195.178.60.130])
	by ozlabs.org (Postfix) with ESMTP id 415482BDA5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Oct 2004 17:48:07 +1000 (EST)
Received: from BRANKO (branko.sraz.dkts.co.yu [192.168.200.36])
	by dkts.co.yu (8.10.2+Sun/8.10.2) with SMTP id i9J7ZRE02378
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Oct 2004 09:35:27 +0200 (MEST)
Message-ID: <007701c4b5ae$03bc8540$24c8a8c0@sraz.dkts.co.yu>
From: "Branko on dkts" <brankok@dkts.co.yu>
To: <linuxppc-embedded@ozlabs.org>
Date: Tue, 19 Oct 2004 09:34:06 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0074_01C4B5BE.C7265B90"
Subject: problem with pseudoterminals
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

------=_NextPart_000_0074_01C4B5BE.C7265B90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello group!

I would be most grateful for your help.

I am trying to port a working application built in a Linux environment =
from PC onto PPC. The ppc Linux distribution I am using is ELDK 3.0. The =
application I am trying to port is actually a client/server pair of =
programs based on pseudo-terminals. The state of the matter is this: All =
necessary infrastructure is created with no problems. However, the =
communication does not work, i.e. anything written to the master does =
not appear as input to the slave and vice verse. Let me point out that =
devpts filesystem is mounted at dev/pts and "Unix98 terminal support" is =
included. As I have already mentioned, everything is working fine on PC.

I would really appreciate it very much if anyone could provide me with =
some additional information or give me some advice I could follow.

Kindest regards,
Branko

------=_NextPart_000_0074_01C4B5BE.C7265B90
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Hello group!</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I would be most grateful for your=20
help.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am trying to port&nbsp;a working =
application=20
built in a Linux environment from PC onto PPC. The ppc Linux =
distribution I am=20
using is ELDK 3.0. The application I am trying to port is actually a=20
client/server pair of programs based on pseudo-terminals. The state of =
the=20
matter is this: All necessary infrastructure is created with no =
problems.=20
However, the communication does not work, i.e. anything written to the =
master=20
does not appear as input to the slave and vice verse.&nbsp;Let me point =
out that=20
devpts filesystem is mounted at dev/pts and "Unix98 terminal support" is =

included.&nbsp;As I have already mentioned, everything is working fine =
on=20
PC.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT><FONT face=3DArial =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I would really appreciate it very much =
if anyone=20
could provide me with some additional information or give me some advice =
I could=20
follow.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Kindest regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Branko</FONT></DIV></BODY></HTML>

------=_NextPart_000_0074_01C4B5BE.C7265B90--
