Return-Path: <B05799@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 189B5B7BE5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Dec 2009 01:12:06 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nBNEBnlG001076 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Dec 2009 07:11:49 -0700 (MST)
Received: from zin33exm22.fsl.freescale.net (zin33exm22.ap.freescale.net
	[10.232.192.20])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nBNEGNrn016503
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Dec 2009 08:16:24 -0600 (CST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA83D9.DCFED66B"
Subject: [HELP] BAD interrupts
Date: Wed, 23 Dec 2009 19:41:46 +0530
Message-ID: <9F4C7D19E8361D4C94921B95BE08B81BA09038@zin33exm22.fsl.freescale.net>
From: "Kumar Gopalpet-B05799" <B05799@freescale.com>
To: <netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA83D9.DCFED66B
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi all,
=20
I am trying linux 2.6.32-rc3 in SMP mode. I am seeing a lot of BAD
interrupts when I do a "cat  /proc/interrupts".
=20
I am running a forwarding application b/w two ethernet ports (ethernet
uses gianfar driver).
=20
Has any one observed these BAD interrupts ? If so, can someone help me
in understanding why these interrupts come and how to resolve it ?
=20
=20
--
=20
Thanks
Sandeep=20

------_=_NextPart_001_01CA83D9.DCFED66B
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3627" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245170414-23122009>Hi=20
all,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245170414-23122009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245170414-23122009>I am =
trying linux=20
2.6.32-rc3 in SMP mode. I am seeing a lot of BAD interrupts when I do a=20
"cat&nbsp; /proc/interrupts".</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245170414-23122009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245170414-23122009>I am =
running a=20
forwarding application b/w two ethernet ports (ethernet uses gianfar=20
driver).</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245170414-23122009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245170414-23122009>Has =
any one observed=20
these BAD interrupts ? If so, can someone help me in understanding why =
these=20
interrupts come and how to resolve it ?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245170414-23122009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245170414-23122009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245170414-23122009>--</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245170414-23122009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245170414-23122009>Thanks</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D245170414-23122009>Sandeep=20
</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01CA83D9.DCFED66B--
