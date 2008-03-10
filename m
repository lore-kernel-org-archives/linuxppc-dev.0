Return-Path: <carcadiz@hotmail.com>
Received: from blu139-omc3-s27.blu139.hotmail.com
	(blu139-omc3-s27.blu139.hotmail.com [65.55.175.227])
	by ozlabs.org (Postfix) with ESMTP id 1A739DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Mar 2008 19:38:35 +1100 (EST)
Message-ID: <BLU106-W2741C72B55848FCACEA0AACA0E0@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: TQM5200 2.6-denx SM501 voyager enabling problem.
Date: Mon, 10 Mar 2008 09:38:34 +0100
In-Reply-To: <20080308012738.0C3D9247AF@gemini.denx.de>
References: Your message of  <20080308012738.0C3D9247AF@gemini.denx.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Wolfgang wrote:

>>=20
>> I thought about this possible solution (adding resource description to=20
>> device tree), but as far as I understood, the device tree was intended t=
o=20
>> describe the microcontroller peripherals and tqm5200, based on the mpc52=
00=20
>> is sold out also without sm501, so that's why I discarded this option.
>
>=20
> The device tree describes the hardware, and the TQM5200 (with  SM501)
> and  the  TQM5200S  (without  the SM501) are two different boards and
> need different device trees.
>=20

So I got it wrong... Good to know. Once I had something working I can give =
it=20
a try and make a different device tree for TQM5200 and TQM5200S and try
to initialize the SM501 using of_platform api.

>=20
> And, Pedro - could you please restrict your line length to some 70+
> characters or so? Thanks.

Ups, sorry. I'll do it since now.

> Best regards,
>=20
> Wolfgang Denk
>

Best regards,

Pedro L. Dominguez.
=20
> --=20
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> "The greatest warriors are the ones who fight for peace."
> - Holly Near

_________________________________________________________________
Tecnolog=EDa, moda, motor, viajes,=85suscr=EDbete a nuestros boletines para=
 estar siempre a la =FAltima
Guapos y guapas, clips musicales y estrenos de cine. =
