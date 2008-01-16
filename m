Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id D3F00DDDF4
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 03:50:55 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8585F.F53552E7"
Subject: Fixed phy
Date: Wed, 16 Jan 2008 10:50:53 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D3@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8585F.F53552E7
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi
We're doing a port to 2.6.24-rc7, and we need to set up two ethernets =
with fixed phy's as they have phyless interfaces to a switch.
WE cannot find any good examples on how to do this. We've found the =
fixed speed PHY emulation in the configuration, but are unsure on how to =
set the PHY's up in the device tree.

This is using a 8280 cpu and ethernet on the FCC's

------_=_NextPart_001_01C8585F.F53552E7
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>Fixed phy</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Hi<BR>
We're doing a port to 2.6.24-rc7, and we need to set up two ethernets =
with fixed phy's as they have phyless interfaces to a switch.<BR>
WE cannot find any good examples on how to do this. We've found the =
fixed speed PHY emulation in the configuration, but are unsure on how to =
set the PHY's up in the device tree.<BR>
<BR>
This is using a 8280 cpu and ethernet on the FCC's<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8585F.F53552E7--
