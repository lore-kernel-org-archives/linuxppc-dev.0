Return-Path: <ma.alvarez@usyscom.com>
Received: from correo.ziv.es (correo.ziv.es [212.55.31.237])
	by ozlabs.org (Postfix) with ESMTP id 7F013DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Dec 2007 02:17:50 +1100 (EST)
Message-ID: <4773C21B.5000206@ziv.es>
Date: Thu, 27 Dec 2007 16:17:47 +0100
From: "Miguel Angel Alvarez" <ma.alvarez@ziv.es>
MIME-Version: 1.0
To: "Miguel Angel Alvarez" <ma.alvarez@ziv.es>
Subject: Re: Using SPI in lite5200
References: <477385A4.8020808@ziv.es>
In-Reply-To: <477385A4.8020808@ziv.es>
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1"
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

Hi

It seems the problem is much harder that I thought. I was trying to use=20
SPI_MOSI, SPI_MISO, SPI_SS and SPI_CLK lines in the PSC3 of my MPC5200,=20
and this made me thought that I could use the "mpc52xx-psc-spi" driver.

Reading better the user guide, I have found that the "mpc52xx-psc-spi"=20
driver is related to the "codec" spi of the PSC3 and not to the SPI=20
subsystem. Am I right?

In this case... Which code should I use as "master driver"?=20
mpc52xx-devices.c talks about a "mpc52xx-spi" driver, but I cannot find=20
it. Does it exist?

All suggestions will be appreciated.

Thanks

Miguel =C1ngel=20
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
