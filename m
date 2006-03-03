Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id E9E37679E9
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Mar 2006 06:37:27 +1100 (EST)
Received: from xbh-sjc-231.amer.cisco.com (xbh-sjc-231.cisco.com
	[128.107.191.100])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id k23JRYGv029358
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Mar 2006 11:27:34 -0800 (PST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C63EF8.85B39681"
Subject: VLAN support on TSEC
Date: Fri, 3 Mar 2006 11:27:34 -0800
Message-ID: <F795765B112E7344AF36AA9112796415019ECDC0@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
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

------_=_NextPart_001_01C63EF8.85B39681
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,
We are using custom board 8541 based processor, running Linux version
2.6.11.=20
In our board, the TSEC interface is connected to a BCM switch chip. We
need to configure the interface to support VLAN . The TSEC hardware has
no VLAN support and the current driver, gianfar.c, has no support for
VLAN either. Are there any implementation of gianfar.c  which supports
VLAN?
=20
Many thanks in advance,
Bizhan  =20

------_=_NextPart_001_01C63EF8.85B39681
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D644572019-03032006>Hi=20
All,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D644572019-03032006>We are =
using custom=20
board 8541 based processor, running Linux version 2.6.11. =
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D644572019-03032006>In our =
board, the=20
TSEC interface is connected to a BCM switch chip. We need to configure =
the=20
interface&nbsp;to support&nbsp;VLAN .&nbsp;The TSEC&nbsp;hardware has=20
no&nbsp;VLAN support&nbsp;and the&nbsp;current driver, gianfar.c, has no =
support=20
for VLAN either. Are there any implementation of gianfar.c&nbsp; which =
supports=20
VLAN?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D644572019-03032006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D644572019-03032006>Many =
thanks in=20
advance,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D644572019-03032006>Bizhan&nbsp;&nbsp;&nbsp;</SPAN></FONT></DIV></=
BODY></HTML>

------_=_NextPart_001_01C63EF8.85B39681--
