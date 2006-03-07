Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id 40CD3679F0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 08:19:39 +1100 (EST)
Received: from xbh-sjc-221.amer.cisco.com (xbh-sjc-221.cisco.com
	[128.107.191.63])
	by sj-core-4.cisco.com (8.12.10/8.12.6) with ESMTP id k27LJcYi001596
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Mar 2006 13:19:38 -0800 (PST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6422C.D6AF2F52"
Subject: Hints on hard hang
Date: Tue, 7 Mar 2006 13:19:37 -0800
Message-ID: <F795765B112E7344AF36AA9112796415019ECDF5@xmb-sjc-212.amer.cisco.com>
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

------_=_NextPart_001_01C6422C.D6AF2F52
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

Our custom board based on 8541 processor running Linux 2.6.11 gets hard
hang during run time. We can't soft reset (SRESET, Pin#AF20) and get a
machine check interrupt when the hang happens, and JTAG can not
communicate with the processor. We do not know how to go to debug this
issue. If you have any idea or hints, we greatly appreciate.

Many thanks in advance,

Bizhan


------_=_NextPart_001_01C6422C.D6AF2F52
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<P><FONT face=3DArial size=3D2>Hi All,</FONT></P>
<P><FONT face=3DArial><FONT size=3D2>Our custom board&nbsp;<SPAN=20
class=3D955461421-07032006>based on </SPAN>854<SPAN =
class=3D955461421-07032006>1=20
</SPAN>processor running Linux 2.<SPAN=20
class=3D955461421-07032006>6</SPAN>.11&nbsp;<SPAN =
class=3D955461421-07032006>gets=20
</SPAN><SPAN class=3D955461421-07032006>hard </SPAN>hang =
during&nbsp;<SPAN=20
class=3D955461421-07032006>run time</SPAN>.&nbsp;<SPAN=20
class=3D955461421-07032006><SPAN class=3D376592603-07032006>We can't =
soft reset=20
(SRESET, Pin#AF20) and get a machine check interrupt&nbsp;when the hang =
happens,=20
and JTAG can not communicate with the processor. We do not know how to =
go to=20
debug this issue. If you have any idea or hints, we greatly=20
appreciate.</SPAN></SPAN></FONT></FONT></P>
<P><FONT size=3D2><SPAN class=3D955461421-07032006><SPAN=20
class=3D376592603-07032006>Many thanks in =
advance,</SPAN></SPAN></FONT></P>
<P><FONT size=3D2><SPAN class=3D955461421-07032006><SPAN=20
class=3D376592603-07032006>Bizhan</SPAN></SPAN></FONT></P></DIV></BODY></=
HTML>

------_=_NextPart_001_01C6422C.D6AF2F52--
