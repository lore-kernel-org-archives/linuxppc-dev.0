Return-Path: <jonandia@aotek.es>
Received: from smtp1.sarenet.es (smtp1.sarenet.es [194.30.0.4])
	by ozlabs.org (Postfix) with ESMTP id C4330DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 21:34:15 +1100 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by smtp1.sarenet.es (Postfix) with ESMTP id 3E1B314097
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 11:09:40 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Subject: Video controller for 5200 (was RE: ELDK 3.1.1: PCI Video Cards on
	Lite5200B)
Date: Thu, 11 Jan 2007 11:09:38 +0100
Message-ID: <918EB199DDDFFA42BEA2EB3A1C6021F387490B@CORREO>
From: "Josu Onandia" <jonandia@aotek.es>
To: "Roman Fietze" <roman.fietze@telemotive.de>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Roman,

I'm using a Lite5200B + Coral-P, to advance the development of software. =
Soon we will design our custom board with a MPC5200 and a graphics chip =
on-board. The application is not complex, but it is cost sensitive, so =
the Coral-P doesn't seem a good choice.

Our main need is only to have a frame buffer to draw on, but sure it =
would be interesting to support X11 too.

You comment about a Coral-P 'successor' more adapted to big endian =
processors. Witch is the name of this chip? I would like to read more =
about it.

Any other info or links you can add would be greatly appreciated,

Thanks

Josu

-----Mensaje original-----
De: linuxppc-embedded-bounces+jonandia=3Daotek.es@ozlabs.org
[mailto:linuxppc-embedded-bounces+jonandia=3Daotek.es@ozlabs.org]En =
nombre
de Roman Fietze
Enviado el: jueves, 11 de enero de 2007 8:49
Para: linuxppc-embedded@ozlabs.org
Asunto: Re: ELDK 3.1.1: PCI Video Cards on Lite5200B


Hallo Michael,

On Wednesday 10 January 2007 01:09, Michael Carey wrote:

> Has anyone gotten a pci video card to work on a Lite5200B board?

Yes, but only the Coral-P, and X11 only correctly using a modified X
server (xfree86 and xorg).

The problem is the endianess. The Coral-P does not contain a byte
swapper for the video memory, so it cannot be easily be used with a
big endian CPU like many other grafik chips. Even the successor of the
Coral-P has such a byte swapper.

Our modifications to support Z-images are done in the non-accelerated
driver in the shadow frame buffer extension.

The Coral-P accelerated driver wasn't very stable when we tested it a
while ago, I assume this very much depends on the functions you use.


Roman

--=20
Roman Fietze Telemotive AG B=FCro M=FChlhausen
