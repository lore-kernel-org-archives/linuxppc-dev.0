Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it
	(host20-155-static.82-213-b.business.telecomitalia.it
	[213.82.155.20]) by ozlabs.org (Postfix) with ESMTP id 704C2DDE39
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 00:15:07 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C859D4.22D22F3E"
Subject: A file of 5 MB on tmpfs file system uses 5 MB of RAM or more?
Date: Fri, 18 Jan 2008 14:15:02 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8EC8BBD1@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
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

------_=_NextPart_001_01C859D4.22D22F3E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have a linux-2.6.19.2 board with an MPC880 with 16MB ram and 16 MB
flash.=20
Normally I have 9-10 MB of free RAM.
=20
If I allocate 5 MB of ram memory, the system continues to work normally,
but if, instead of allocating 5 MB directly, I fill the /tmp directory
(that has a tmpfs file system) with a 5MB file the system becomes slow
and after some minutes the oom_killer is invoked. Before it dies I had
the time to see that mtdblockd is taking a lot of CPU (20%), what could
be the problem?
=20
Any hint will be appreciate,
Bye,
Antonio.

------_=_NextPart_001_01C859D4.22D22F3E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D554500913-18012008>I have =
a=20
linux-2.6.19.2 board with an MPC880 with 16MB ram and 16 MB flash.=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D554500913-18012008>Normally I have 9-10=20
MB of free RAM.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D554500913-18012008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D554500913-18012008>If I =
allocate 5 MB=20
of ram memory, the system continues to work normally, but if, instead of =

allocating 5 MB directly,&nbsp;I fill the /tmp directory (that has a =
tmpfs file=20
system) with a 5MB file the system becomes slow and after some minutes =
the=20
oom_killer is invoked. Before it dies I had the time to see that =
mtdblockd is=20
taking a lot of CPU (20%), what could be the =
problem?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D554500913-18012008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D554500913-18012008>Any =
hint will be=20
appreciate,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D554500913-18012008>Bye,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D554500913-18012008>Antonio.</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C859D4.22D22F3E--
