Return-Path: <Madhusudhan.J@kpitcummins.com>
Received: from kcinblrexb01.kpit.com (kcinblrexb01.kpit.com [203.145.158.132])
	by ozlabs.org (Postfix) with ESMTP id 1C442DDE11
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 15:35:54 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9A84A.7C5C4DBA"
Subject: Issue with UART driver on MPC5121e Platform
Date: Thu, 19 Mar 2009 09:53:07 +0530
Message-ID: <F7846B8F3C78C049B6A1DFF861F6C16F0353EB9A@kcinblrexb01.kpit.com>
From: "Madhusudhan J" <Madhusudhan.J@kpitcummins.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9A84A.7C5C4DBA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


=20
 Hi,=20
=20
this is Madhusudhan J from KPITCummins Bangalore India .=20
I have issue with uart driver   in linux kernel 2.6.24
(drivers\serial\Mpc52xx_uart.c)
I am using platform  mpc5121e to communicating to modem through serial
driver. i am not able to communicate with  UART
driver(drivers\serial\Mpc52xx_uart.c).
In this file i could not see 512x uart operations but UART opration are
there for 52xx. could you please let me know how to make it work with
uart driver on 5121e platform?.
=20
Appriciate your help in this regard.
=20
Regards,
Madhu

------_=_NextPart_001_01C9A84A.7C5C4DBA
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3492" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT><BR>&nbsp;</DIV>
<DIV></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D752114812-18032009><SPAN=20
class=3D016252004-19032009>&nbsp;Hi,&nbsp;</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D752114812-18032009></SPAN></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D752114812-18032009><FONT face=3DArial><FONT =
size=3D2>this is=20
Madhusudhan J from KPITCummins Bangalore India<SPAN=20
class=3D016252004-19032009><FONT=20
color=3D#0000ff>&nbsp;.&nbsp;</FONT></SPAN></FONT></FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D752114812-18032009>I have =
issue with=20
uart driver<SPAN class=3D016252004-19032009><FONT color=3D#0000ff>&nbsp; =

&nbsp;</FONT></SPAN>in linux kernel 2.6.24=20
(drivers\serial\Mpc52xx_uart.c)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D752114812-18032009></SPAN></FONT><FONT=20
face=3DArial size=3D2><SPAN class=3D752114812-18032009>I am&nbsp;using =
platform=20
&nbsp;mpc5121e to communicating to modem through serial driver. i am not =
able to=20
communicate&nbsp;with&nbsp;&nbsp;UART=20
driver(drivers\serial\Mpc52xx_uart.c).</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D752114812-18032009>In =
this file i could=20
not see 512x uart operations but UART opration are there for 52xx. could =
you=20
please let me know how to make it work with uart driver on 5121e=20
platform?.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D752114812-18032009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D752114812-18032009>Appriciate your help=20
in this regard.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D752114812-18032009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D752114812-18032009>Regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D752114812-18032009>Madhu</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C9A84A.7C5C4DBA--
