Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id DFDD8DDF37
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Mar 2007 01:00:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75FF7.D2B5CDE5"
Subject: Dereferencing phys addr IMMAP works even if it is not a virtual
	address. Strange?
Date: Tue, 6 Mar 2007 15:00:39 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E6C0B3A@aquib01a>
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

------_=_NextPart_001_01C75FF7.D2B5CDE5
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Now I'm doing a ioremap_nocache of IMMAP and using the virtual pointer
returned to access my 880 registers but also using the physical address
it works, I can access the registers.=20
=20
Bye,
Antonio.

------_=_NextPart_001_01C75FF7.D2B5CDE5
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D556295613-06032007>Now =
I'm doing a=20
ioremap_nocache of IMMAP and using the virtual pointer returned to =
access my 880=20
registers but also using the physical address it works, I can access the =

registers. </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D556295613-06032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D556295613-06032007>Bye,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D556295613-06032007>Antonio.</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C75FF7.D2B5CDE5--
