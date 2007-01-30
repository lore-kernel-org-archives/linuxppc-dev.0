Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id DC059DDF8F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Jan 2007 19:43:01 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C74448.F26A2A03"
Subject: cpm_uart: WARNING: no UART devices found
Date: Tue, 30 Jan 2007 09:30:49 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E5F5EB8@aquib01a>
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

------_=_NextPart_001_01C74448.F26A2A03
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

My board has an MPC880 and it is named TL880 with a linux 2.6.19, I
copied kernel configurations from the very similar board mpc885ads.
I filled in platform data in file TL880_setup.c but I see that function
TL880_fixup_uart_pdata is never called and, as a consequence, I see the
message cpm_uart: WARNING: no UART devices found. Also I receive
message: IP-Config: No network devices available.=20
=20
=20
Bye,
Antonio.

------_=_NextPart_001_01C74448.F26A2A03
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D009462608-30012007>My =
board has an=20
MPC880 and it is named TL880 with a linux 2.6.19, I copied kernel =
configurations=20
from the very similar board mpc885ads.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D009462608-30012007>I =
filled in platform=20
data in file TL880_setup.c but I see that function =
TL880_fixup_uart_pdata is=20
never called and, as a consequence, I see the message cpm_uart: WARNING: =
no UART=20
devices found. Also I receive message: IP-Config: No network devices =
available.=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D009462608-30012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D009462608-30012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D009462608-30012007>Bye,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D009462608-30012007>Antonio.</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C74448.F26A2A03--
