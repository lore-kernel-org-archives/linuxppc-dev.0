Return-Path: <iluri@fagorautomation.es>
Received: from correo2.sarenet.es (correo2.sarenet.es [194.30.0.12])
	by ozlabs.org (Postfix) with ESMTP id 17827679E0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Mar 2006 19:18:59 +1100 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by correo2.sarenet.es (Postfix) with ESMTP id 9BF553689F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Mar 2006 09:18:56 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Subject: RE: mpc5xxx keyboard BUG found
Date: Mon, 20 Mar 2006 09:18:57 +0100
Message-ID: <918EB199DDDFFA42BEA2EB3A1C6021F3B9143D@correo.fagorautomation.net>
From: "IGOR LURI" <iluri@fagorautomation.es>
To: "Jarno Manninen" <jarno.manninen@tut.fi>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The problem is that from aplication can't handle 0xe0 scancode because =
mpc5xxx_translate function translates the scancode to a keycode, and to =
the aplication arrives for example 0x0a1b5b41 (up arrow) and inmediatly =
another 0x0a. For this efect I think mpc5xxx_translate function needs to =
evaluate 0xe0 scancode correctly.


-----Mensaje original-----
De: Jarno Manninen [mailto:jarno.manninen@tut.fi]
Enviado el: viernes, 17 de marzo de 2006 19:50
Para: linuxppc-embedded@ozlabs.org
CC: IGOR LURI
Asunto: Re: mpc5xxx keyboard BUG found


On Friday 17 March 2006 13:38, Igor Luri wrote:

> We have an MPC5200LiteB board with a Microsoft USB keyboard atached =
and
> we have realized that some keys don't work properly, like up, down, =
lef
> and right arrows, PageUp, PageDown etc.

Hi!

Actually that Microsoft keyboard is working fine. A rare exception. ,-)
For more information see chapter 1.3 from here:

http://www.win.tue.nl/~aeb/linux/kbd/scancodes.html

So basically you will have to handle those in the application level =
code.

- Jarno
