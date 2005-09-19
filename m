Return-Path: <d.grab@hima.com>
Received: from hima.com (mail.hima.com [80.146.244.10])
	by ozlabs.org (Postfix) with SMTP id A850B68347
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 00:04:12 +1000 (EST)
Received: from SN7606 ([192.168.100.10])
	by hima.com (mail.hima.com [212.116.4.129]) (MDaemon.PRO.v8.1.2.R)
	with ESMTP id md50000146197.msg
	for <linuxppc-embedded@ozlabs.org>; Mon, 19 Sep 2005 15:59:15 +0200
From: "David Grab" <d.grab@hima.com>
To: "'Peter Fercher'" <peter.fercher@scs.ch>,
	<benh@kernel.crashing.org>
Date: Mon, 19 Sep 2005 15:59:11 +0200
Message-ID: <001b01c5bd22$5071a510$f201a8c0@SN7606>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001C_01C5BD33.13FA7510"
In-Reply-To: <004101c5bd1f$3d1b91e0$dbe5fed4@scsad.scs.ch>
Cc: 'linux-ppc-embedded' <linuxppc-embedded@ozlabs.org>
Subject: AW: emac driver broken in 2.6.12.2 ?
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

------=_NextPart_000_001C_01C5BD33.13FA7510
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Message>> emac: IBM EMAC Ethernet driver, version 2.0
>> Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> eth0: IBM ema c, MAC 00:00:00:00:00:00
>> eth0: Found Generic MII PHY (0x00)
>> eth1: IBM emac, MAC 00:00:00:00:00:00
>> eth1: Found Generic MII PHY (0x01)

Are you sure that you?ve configured your ethernet driver? There is no MAC
address defined. And the PHY address is really located at 0x0 or 0x1? If not
you have also to configure the offset from which address the PHY routine
start in your board specific files like for OCOTEA reference board in
linux-2.6.12/arch/ppc/platforms/4xx/ocotea.c

Best regards,

David

------=_NextPart_000_001C_01C5BD33.13FA7510
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2800.1276" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D593165013-19092005><FONT=20
color=3D#0000ff>&gt;&gt;&nbsp;</FONT></SPAN>emac: IBM EMAC Ethernet =
driver,=20
version=20
2.0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
<BR><SPAN class=3D593165013-19092005><FONT=20
color=3D#0000ff>&gt;&gt;&nbsp;</FONT></SPAN>Maintained by Benjamin =
Herrenschmidt=20
&lt;</FONT></FONT><A href=3D"mailto:benh@kernel.crashing.org"><FONT =
face=3DArial=20
size=3D2>benh@kernel.crashing.org</FONT></A><FONT size=3D2><FONT=20
face=3DArial>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR><SPAN class=3D593165013-19092005><FONT=20
color=3D#0000ff>&gt;&gt;&nbsp;</FONT></SPAN>eth0: IBM ema<SPAN=20
class=3D593165013-19092005><FONT color=3D#0000ff>&nbsp;</FONT></SPAN>c, =
MAC=20
00:00:00:00:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR><SPAN class=3D593165013-19092005><FONT=20
color=3D#0000ff>&gt;&gt;&nbsp;</FONT></SPAN>eth0: Found Generic MII PHY=20
(0x00)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR><SPAN class=3D593165013-19092005><FONT=20
color=3D#0000ff>&gt;&gt;&nbsp;</FONT></SPAN>eth1: IBM emac, MAC=20
00:00:00:00:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR><SPAN class=3D593165013-19092005><FONT=20
color=3D#0000ff>&gt;&gt;&nbsp;</FONT></SPAN>eth1: Found Generic MII PHY=20
(0x01)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR></FONT></FON=
T><FONT=20
size=3D2><FONT face=3DArial><SPAN=20
class=3D593165013-19092005></SPAN></FONT></FONT></DIV>
<DIV><FONT size=3D2><FONT face=3DArial><SPAN =
class=3D593165013-19092005><FONT=20
color=3D#0000ff>Are you&nbsp;sure that you&acute;ve configured your =
ethernet driver?=20
There is no MAC&nbsp;address defined.&nbsp;And the PHY address is really =
located=20
at 0x0 or 0x1? If not you have also to configure the offset from which =
address=20
the PHY routine start&nbsp;in your board specific files like =
for&nbsp;OCOTEA=20
reference&nbsp;board&nbsp;in=20
linux-2.6.12/arch/ppc/platforms/4xx/ocotea.c</FONT></SPAN></FONT></FONT><=
/DIV>
<DIV><FONT size=3D2><FONT face=3DArial color=3D#0000ff><SPAN=20
class=3D593165013-19092005></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2><FONT face=3DArial color=3D#0000ff><SPAN=20
class=3D593165013-19092005>Best regards,</SPAN></FONT></FONT></DIV>
<DIV><FONT size=3D2><FONT face=3DArial color=3D#0000ff><SPAN=20
class=3D593165013-19092005></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2><FONT face=3DArial color=3D#0000ff><SPAN=20
class=3D593165013-19092005>David</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff =
size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_001C_01C5BD33.13FA7510--
