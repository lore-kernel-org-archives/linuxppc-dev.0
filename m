Return-Path: <nhickman@dtechlabs.com>
Received: from mail.dtechlabs.com
	(ip66-104-11-166.z11-104-66.customer.algx.net [66.104.11.166])
	by ozlabs.org (Postfix) with SMTP id D1182DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Sep 2007 05:26:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7F705.246A69C8"
Subject: SPI INT line
Date: Fri, 14 Sep 2007 15:26:22 -0400
Message-ID: <8140AAF341CC904BA92C3D6A5A1909782F0E9D@ditech-1.ditechllc.com>
From: "Nicholas Hickman" <nhickman@dtechlabs.com>
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

------_=_NextPart_001_01C7F705.246A69C8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We are developing a system around the mpc8270.  On this system we are
using an ISDN controller connected to the SPI interface of the 8270.
For the INT line coming from the controller, should this be connected to
one of the IRQ lines that we typically use for PCI bus, or should we
connect it to one of the GPIO Group C pins?  Currently we have it to
IRQ4, but I am worried that this is incorrect.
=20
=20
Thanks in advance.


Nicholas Hickman


=20

------_=_NextPart_001_01C7F705.246A69C8
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3157" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D908522319-14092007>We are=20
developing a system around the mpc8270.&nbsp; </SPAN>On this system we =
are using=20
an ISDN controller connected to the SPI interface of the 8270.&nbsp; For =
the INT=20
line coming from the controller, should this be connected to one of the =
IRQ=20
lines that we typically use for PCI bus, or should we connect it to =
one&nbsp;of=20
the&nbsp;<SPAN class=3D908522319-14092007>GPIO Group =
C</SPAN>&nbsp;pins?&nbsp;=20
Currently we have it to IRQ4, but I am worried that this is=20
incorrect.</FONT></FONT></DIV>
<DIV><SPAN class=3D908522319-14092007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D908522319-14092007><FONT face=3DArial size=3D2>Thanks =
in=20
advance.</FONT></SPAN></DIV>
<DIV align=3Dleft>
<P class=3DMsoNormal><STRONG><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
'Calibri','sans-serif'"><BR>Nicholas=20
Hickman<BR></SPAN></STRONG></P></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C7F705.246A69C8--
