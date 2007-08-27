Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id DB0DDDE683
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 21:12:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7E89B.298A4B7E"
Subject: MDIO bus hotplug
Date: Mon, 27 Aug 2007 13:12:31 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8EA18371@aquib01a>
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

------_=_NextPart_001_01C7E89B.298A4B7E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I have an hot pluggable MDIO bus (connected to MDC, MDIO of an MPC880)
and thus I would like to rescan the bus on certain events (for example
fs_enet_open) to access the numerous PHYs I have on this bus. I saw that
it is "simply" a matter of calling mdiobus_register but I would like an
advice how to design the modification
=20
=20
MPC880 with linux-2.6.19.2
=20
Best regards,
Antonio.

------_=_NextPart_001_01C7E89B.298A4B7E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D408020311-27082007>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D408020311-27082007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D408020311-27082007>I have =
an hot=20
pluggable MDIO bus (connected to&nbsp;MDC, MDIO&nbsp;of&nbsp;an MPC880) =
and thus=20
I would like to rescan the bus on certain events (for example=20
fs_enet_open)&nbsp;to access the numerous PHYs I have on this bus. I saw =
that it=20
is "simply" a matter of calling mdiobus_register but I would like an =
advice how=20
to design the modification</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D408020311-27082007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D408020311-27082007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D408020311-27082007>MPC880 =
with=20
linux-2.6.19.2</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D408020311-27082007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D408020311-27082007>Best=20
regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D408020311-27082007>Antonio.</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C7E89B.298A4B7E--
