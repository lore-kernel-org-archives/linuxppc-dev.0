Return-Path: <a.llano@usyscom.com>
Received: from correo.ziv.es (eu31-237.clientes.euskaltel.es [212.55.31.237])
	by ozlabs.org (Postfix) with ESMTP id 22B27DDF11
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 18:01:17 +1000 (EST)
Subject: Re: mpc5200 and spi bus
From: "Asier Llano Palacios" <a.llano@usyscom.com>
To: "Txema Lopez" <tlopez@aotek.es>
In-Reply-To: <4631EF88.3060808@aotek.es>
References: <1177595421.9950.4.camel@a.llano.llano> <4630BBF9.7000305@aotek.es>
	<1177670193.9950.9.camel@a.llano.llano> <4631EF88.3060808@aotek.es>
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 02 May 2007 10:02:44 +0200
Message-ID: <1178092964.25579.7.camel@a.llano.llano>
MIME-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

El vie, 27-04-2007 a las 14:41 +0200, Txema Lopez escribi=F3:
> Asier Llano Palacios wrote:
>=20
> >I'm working with the a linux 2.6.20.9 with patches from Sylvain's =
tree.
> >I've been looking the Den'x 2.5.xx SPI support and it seems that it =
is
> >done through GPIOs.=20
> >
> =BF2.5.xx?. I talked about a 2.4.xx version.
>=20
Sorry this was a mistyping. I was pretending to say 2.4.xx.

> >I'd like a native SPI implementation, using the
> >hardware of the MPC5200, because of the performance issue of using a
> >GPIO, because I'd like to use it at full speed.
> >
> >Is it done really with GPIOs? If so, is there any other =
implementation?
> > =20
> >
> Yes, you can use the MPC5200's dedicated SPI (spi-algo-mpc5xxx.c) or =
use=20
> a PSC in SPI codec mode (spi-algo-mpc5xxx-psc.c).

Thank you very much. I don't know where I was looking. I've seen the
code and it seems interesting and easy to port.

> >If it is possible I'd like it to be for 2.6.x.
> > =20
> >
> I don't know nothing about the MPC5200 SPI implementation in the 2.6.x =

> kernel.
>=20

I'll have a look. If don't see anything the code from 2.4.x is good
starting point to port it.

> Best regards,

Thank you very much for the information.=20
=20
----------------------------------------- PLEASE NOTE =
-------------------------------------------
This message, along with any attachments, may be confidential or legally =
privileged.=20
It is intended only for the named person(s), who is/are the only =
authorized recipients.
If this message has reached you in error, kindly destroy it without =
review and notify the sender immediately.
Thank you for your help.
=B5SysCom uses virus scanning software but excludes any liability for =
viruses contained in any attachment.
=20
------------------------------------ ROGAMOS LEA ESTE TEXTO =
-------------------------------
Este mensaje y sus anexos pueden contener informaci=F3n confidencial y/o =
con derecho legal.=20
Est=E1 dirigido =FAnicamente a la/s persona/s o entidad/es rese=F1adas =
como =FAnico destinatario autorizado.
Si este mensaje le hubiera llegado por error, por favor elim=EDnelo sin =
revisarlo ni reenviarlo y notif=EDquelo inmediatamente al remitente. =
Gracias por su colaboraci=F3n. =20
=B5SysCom utiliza software antivirus, pero no se hace responsable de los =
virus contenidos en los ficheros anexos.
