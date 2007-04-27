Return-Path: <a.llano@usyscom.com>
Received: from correo.ziv.es (eu31-237.clientes.euskaltel.es [212.55.31.237])
	by ozlabs.org (Postfix) with ESMTP id 73E77DDF05
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 20:35:08 +1000 (EST)
Subject: Re: mpc5200 and spi bus
From: "Asier Llano Palacios" <a.llano@usyscom.com>
To: "Txema Lopez" <tlopez@aotek.es>
In-Reply-To: <4630BBF9.7000305@aotek.es>
References: <1177595421.9950.4.camel@a.llano.llano> <4630BBF9.7000305@aotek.es>
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 27 Apr 2007 12:36:33 +0200
Message-ID: <1177670193.9950.9.camel@a.llano.llano>
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

I'm working with the a linux 2.6.20.9 with patches from Sylvain's tree.
I've been looking the Den'x 2.5.xx SPI support and it seems that it is
done through GPIOs. I'd like a native SPI implementation, using the
hardware of the MPC5200, because of the performance issue of using a
GPIO, because I'd like to use it at full speed.

Is it done really with GPIOs? If so, is there any other implementation?
If it is possible I'd like it to be for 2.6.x.

Thank you,
Asier

El jue, 26-04-2007 a las 16:49 +0200, Txema Lopez escribi=F3:
> Asier Llano Palacios wrote:
>=20
> >I've seen some comments about drivers for SPI of the MPC5200. I'm not
> >sure about it, but is there anything functional about it?. I want to
> >know if there is anything already done, in order to use it or improve
> >it. I need a driver of the SPI bus, so if it is not implemented at =
all
> >we should contribute it.
> >
> > =20
> >
> The Denx's 2.4.xx top of tree kernel has MPC5200 SPI support. We are=20
> using the SPI dev interface from a user aplication and it works fine.
>=20
>=20
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
