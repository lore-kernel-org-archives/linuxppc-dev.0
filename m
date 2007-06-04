Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 8A28BDDED9
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jun 2007 06:37:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7A6E8.32F8AE4D"
Subject: Linux interrupt managing on 8xx
Date: Mon, 4 Jun 2007 22:37:42 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E264992@aquib01a>
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

------_=_NextPart_001_01C7A6E8.32F8AE4D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have a component named pca9555 (on the i2c bus) that is an I/O =
expander. It can generate an interrupt to the MPC8xx processor (SIU_IRQ1 =
pin). This pin will be active till I read registers of pca9555. Because =
I cannot access the i2c bus in the interrupt handler I queue a work on a =
work queue. Just at the end of the interrupt handler  should I disable =
the interrupt on the mpc8xx? I think that otherwise the interrupt will =
pop up again till I execute the work in the work queue finally reading =
the pca9555 and shutting off the source of the interrupt.

Bye,
Antonio.

------_=_NextPart_001_01C7A6E8.32F8AE4D
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7235.2">
<TITLE>Linux interrupt managing on 8xx</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>I have a component named pca9555 (on the i2c bus) that =
is an I/O expander. It can generate an interrupt to the MPC8xx processor =
(SIU_IRQ1 pin). This pin will be active till I read registers of =
pca9555. Because I cannot access the i2c bus in the interrupt handler I =
queue a work on a work queue. Just at the end of the interrupt =
handler&nbsp; should I disable the interrupt on the mpc8xx? I think that =
otherwise the interrupt will pop up again till I execute the work in the =
work queue finally reading the pca9555 and shutting off the source of =
the interrupt.<BR>
<BR>
Bye,<BR>
Antonio.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7A6E8.32F8AE4D--
