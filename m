Return-Path: <bgholikh@cisco.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C62144.5D4046C5"
Subject: Help: FCC driver does not handle IPV6 multicast packet
Date: Tue, 24 Jan 2006 16:14:53 -0800
Message-ID: <F795765B112E7344AF36AA911279641584984E@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: <linuxppc-embedded@ozlabs.org>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C62144.5D4046C5
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

HI All,
Our custom board is based on PPC 8541 running Linux 2.6.11.
We have NO issue if FCC is operating in 100 Mbs. However, if we
configure the interface  in 10 Mbs we see the following behavior:
If IPV6 is enabled, as soon as the FCC network interface is plumbed
through "ifconfig" system call, we observe the CPU load increases to 90
percent=20
and most of the load is related to softirq process. A traceroute command
on the interface displays an IPV6 multicast packet continuously getting
transmitted.
If we bring the interface down through the ifconfig, we do not observe
the problem
no longer. The strange thing is we do not observe this behavior if the
interface
is plumbed 100 Mbs.
We need to root cause this and have no idea what to look for, any idea
greatly
appreciated.
=20
Many thanks in advance,
Bizhan

------_=_NextPart_001_01C62144.5D4046C5
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D263335823-24012006>HI=20
All,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D263335823-24012006>Our =
custom board is=20
based on PPC 8541 running Linux 2.6.11.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D263335823-24012006>We =
have&nbsp;NO=20
issue if FCC is operating in 100 Mbs. However, if we</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D263335823-24012006>configure the=20
interface &nbsp;in 10 Mbs we see the following =
behavior:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D263335823-24012006><FONT =
size=3D2>If IPV6=20
is enabled, as soon as the FCC network interface is=20
plumbed</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D263335823-24012006><FONT =
size=3D2>through=20
"ifconfig" system call, </FONT></SPAN></FONT><FONT face=3DArial =
size=3D2><SPAN=20
class=3D263335823-24012006><FONT size=3D2>we&nbsp;observe the CPU load =
increases to=20
90 percent </FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D263335823-24012006><FONT =
size=3D2>and=20
most of the load is&nbsp;related to&nbsp;softirq process. A traceroute=20
command</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D263335823-24012006><FONT =
size=3D2>on the=20
interface displays an IPV6 multicast packet continuously getting=20
transmitted.</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D263335823-24012006>If we =
bring the=20
interface down through the ifconfig, we do not observe the=20
problem</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D263335823-24012006>no =
longer. The=20
strange thing is we do not observe this behavior if the=20
interface</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D263335823-24012006>is =
plumbed 100=20
Mbs.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D263335823-24012006></SPAN></FONT><FONT=20
face=3DArial size=3D2><SPAN class=3D263335823-24012006><FONT size=3D2>We =
need to root=20
cause this and have no idea what to look for, any idea=20
greatly</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D263335823-24012006><FONT=20
size=3D2>appreciated.</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D263335823-24012006><FONT=20
size=3D2></FONT></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D263335823-24012006><FONT =
size=3D2>Many=20
thanks in advance,</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D263335823-24012006><FONT=20
size=3D2>Bizhan</DIV></FONT></SPAN></FONT></BODY></HTML>

------_=_NextPart_001_01C62144.5D4046C5--
