Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id B278BDDF11
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 06:02:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C74BB3.A20CE44F"
Subject: Receveing CD lost event in SCC3  even with PCSO reg bit cleared
Date: Thu, 8 Feb 2007 20:02:09 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E264921@aquib01a>
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

------_=_NextPart_001_01C74BB3.A20CE44F
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,
=20
I'm using SCC3 in HDLC synchronous mode on an MPC880 (only TXD3, RXD3 =
and clocks) with CD3 connected to ground programming relevant PCSO bit =
to 0.=20
Even if the CD is internally connected to GND, sometime I receive a CD =
lost event. How is it possible?
=20
Bye,
Antonio.
=20

------_=_NextPart_001_01C74BB3.A20CE44F
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML =
DIR=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1"></HEAD><BODY><DIV><FONT face=3D'Arial' =
color=3D#000000 size=3D2>Hi all,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>I'm using SCC3 in HDLC synchronous mode =
on an =0A=
MPC880 (only TXD3, RXD3 and clocks) with CD3 connected to ground =
programming =0A=
relevant PCSO bit to 0. </FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Even if the CD is internally connected =
to GND, =0A=
sometime I receive a CD lost event. How is it possible?</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Bye,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Antonio.</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>
------_=_NextPart_001_01C74BB3.A20CE44F--
