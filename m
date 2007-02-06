Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id F2883DDE40
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Feb 2007 02:42:40 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C74A05.699A5A0E"
Subject: Conditions for mydriver_probe to be called
Date: Tue, 6 Feb 2007 16:42:30 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E6237D0@aquib01a>
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

------_=_NextPart_001_01C74A05.699A5A0E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm realizing a controller driver for the mpc8xx spi master device. My
driver has a mpc8xx_spi_probe method that I expected to be called. I'm
sure that platform_device_register is called for my spi platform_device
but nothing happens,  mpc8xx_spi_probe is not called.
=20
Bye,
Antonio.

------_=_NextPart_001_01C74A05.699A5A0E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D884593715-06022007>I'm =
realizing a=20
controller driver for the mpc8xx spi master device. My driver has a=20
mpc8xx_spi_probe method that I expected to be called.&nbsp;I'm sure that =

platform_device_register is called for my spi platform_device but=20
nothing&nbsp;happens,&nbsp;&nbsp;mpc8xx_spi_probe is not=20
called.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D884593715-06022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D884593715-06022007>Bye,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D884593715-06022007>Antonio.</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C74A05.699A5A0E--
