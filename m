Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id 818C0682A7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Sep 2005 04:35:14 +1000 (EST)
Received: from xbh-sjc-221.amer.cisco.com (xbh-sjc-221.cisco.com
	[128.107.191.63])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id j8DIYrKO014544
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Sep 2005 11:35:10 -0700 (PDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5B891.DE7719F6"
Date: Tue, 13 Sep 2005 11:35:09 -0700
Message-ID: <F795765B112E7344AF36AA9112796415849622@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Interrupt mapping for MPC8541
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

------_=_NextPart_001_01C5B891.DE7719F6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi ALL,
We are developing a custom board mother board based on
MPC8541 processor trying to run with Linux 2.6.11. The custom board has
hardwire the
interrupt lines for PCI peripherals with specific interrupt number for
each peripheral.=20
The MPC8541 has on Ethernet chip which during boot process the Linux
kernel assign=20
interrupt number 96 to it. Unfortunately one of our PCI peripheral that
is hardwire need that
interrupt number and this causes conflict.=20
Is there anyway we can avoid reserving this interrupt number so kernel
does not assign it unless it is asked specifically?
=20
Thanks,
Bizhan

------_=_NextPart_001_01C5B891.DE7719F6
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D284292418-13092005>Hi=20
ALL,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D284292418-13092005>We are =
developing a=20
custom board mother board based on</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D284292418-13092005>MPC8541 processor=20
trying to run with Linux 2.6.11. The custom board has hardwire=20
the</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D284292418-13092005>interrupt lines for=20
PCI peripherals with specific interrupt number for each peripheral.=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D284292418-13092005>The =
MPC8541 has on=20
Ethernet chip </SPAN></FONT><FONT face=3DArial size=3D2><SPAN=20
class=3D284292418-13092005>which during boot process the Linux kernel =
assign=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D284292418-13092005>interrupt number 96=20
</SPAN></FONT><FONT face=3DArial size=3D2><SPAN =
class=3D284292418-13092005>to it.=20
Unfortunately one of our PCI peripheral that is hardwire need=20
that</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D284292418-13092005>interrupt number and=20
this causes conflict. </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D284292418-13092005>Is =
there anyway we=20
can avoid reserving this interrupt number so kernel</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D284292418-13092005>does =
not assign it=20
unless it is asked specifically?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D284292418-13092005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D284292418-13092005>Thanks,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D284292418-13092005>Bizhan</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C5B891.DE7719F6--
