Return-Path: <praveen@spacomp.com>
Received: from fbr02.csee.onr.siteprotect.com (fbr02.csee.onr.siteprotect.com
	[64.26.60.146]) by ozlabs.org (Postfix) with ESMTP id 88487DE1DF
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 14:55:21 +1100 (EST)
Received: from smtpauth01.csee.onr.siteprotect.com
	(smtpauth01.csee.onr.siteprotect.com [64.26.60.145])
	by fbr02.csee.onr.siteprotect.com (Postfix) with ESMTP id 1002E327920
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 22:38:15 -0500 (CDT)
Received: from praveenvs (unknown [124.30.115.150])
	(Authenticated sender: praveen@spacomp.com)
	by smtpauth01.csee.onr.siteprotect.com (Postfix) with ESMTP id
	CF91F1C802D
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 22:38:12 -0500 (CDT)
Message-ID: <001901c9a2c4$165070b0$1301a8c0@spappm.com>
From: "Praveen VS" <praveen@spacomp.com>
To: <linuxppc-dev@ozlabs.org>
Subject: Interrupt mapping for MPC8323 board
Date: Thu, 12 Mar 2009 09:08:59 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0016_01C9A2F2.2E271B70"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0016_01C9A2F2.2E271B70
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

We have a board similar to the MPC8323 rdb. In the board we have
connected the IDSEL to AD18 & we have only one minipci connector for it. =
We
have interfaced a Wlan Card . When we do=20

# lspci -x  we get following

00:12.0 Network controller: RaLink RT2561/RT61 802.11g PCI
00: 14 18 01 03 07 00 10 04 00 00 80 02 08 80 00 00
10: 00 80 00 90 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 01 06 00 00 14 18 61 25
30: 00 00 00 00 40 00 00 00 00 00 00 00 13 01 00 00

In our circuit INTA is connected to IRQ4 . We are unable
to transmit thro this card. We are not getting any interrupts.We want to
make sure where to give the mapping of interrupts ?=20
how to give that for IDsel AD 18, INTA should be mapped to IRQ4 .

Is it that we need to change the dts file & create a new dtb? if so  =
where to get exact meaning of how to configure "interrupt mapping" in =
the dts file


Regards
Praveen 
------=_NextPart_000_0016_01C9A2F2.2E271B70
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.3492" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>We have a board similar to the MPC8323 rdb. In the board we=20
have<BR>connected the IDSEL to AD18 &amp; we have only&nbsp;one minipci=20
connector for it. We<BR>have interfaced a Wlan Card . When we do =
<BR><FONT=20
face=3DArial size=3D2></FONT></DIV>
<DIV><FONT face=3DArial size=3D2># lspci -x&nbsp; we get =
following</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>00:12.0 Network controller: RaLink RT2561/RT61 802.11g PCI<BR>00: =
14 18 01=20
03 07 00 10 04 00 00 80 02 08 80 00 00<BR>10: 00 80 00 90 00 00 00 00 00 =
00 00=20
00 00 00 00 00<BR>20: 00 00 00 00 00 00 00 00 01 06 00 00 14 18 61 =
25<BR>30: 00=20
00 00 00 40 00 00 00 00 00 00 00 13 01 00 00<BR><BR>In our circuit INTA =
is=20
connected to IRQ4 . We are unable<BR>to transmit thro this card. We are =
not=20
getting any interrupts.We want to<BR>make sure where to give the mapping =
of=20
interrupts ? </DIV>
<DIV>how to give that for IDsel AD 18, INTA should be mapped to IRQ4 =
.</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Is it that we need to change the dts =
file &amp;=20
create a new dtb? if so&nbsp; where to get exact meaning of how to=20
configure&nbsp;"interrupt mapping" in the dts file</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>Praveen</FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0016_01C9A2F2.2E271B70--
