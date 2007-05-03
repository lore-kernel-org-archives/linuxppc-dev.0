Return-Path: <a.llano@usyscom.com>
Received: from correo.ziv.es (eu31-237.clientes.euskaltel.es [212.55.31.237])
	by ozlabs.org (Postfix) with ESMTP id AA129DDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 20:21:32 +1000 (EST)
Subject: Re: mpc5200 and spi bus
From: "Asier Llano Palacios" <a.llano@usyscom.com>
To: "John Rigby" <jcrigby@gmail.com>
In-Reply-To: <4b73d43f0705021319y116aa62axe0d1ce868d4d7ad1@mail.gmail.com>
References: <1177595421.9950.4.camel@a.llano.llano> <4630BBF9.7000305@aotek.es>
	<1177670193.9950.9.camel@a.llano.llano> <4631EF88.3060808@aotek.es>
	<1178092964.25579.7.camel@a.llano.llano>
	<20070502173629.GA5797@pengutronix.de>
	<4b73d43f0705021319y116aa62axe0d1ce868d4d7ad1@mail.gmail.com>
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 03 May 2007 12:22:57 +0200
Message-ID: <1178187777.25579.23.camel@a.llano.llano>
MIME-Version: 1.0
Cc: Txema Lopez <tlopez@aotek.es>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thank you very much for the patch. I will tell you how it worked.
Currently I need the SPI mode PSC driver (this one), but the other one
may be quite interesting also.

Thank you,
Asier

El mi=E9, 02-05-2007 a las 14:19 -0600, John Rigby escribi=F3:
> This will take you to a page where the download attachment link will
> actually work:
>=20
> =
http://sourceforge.net/mailarchive/attachment.php?list_name=3Dspi-devel-g=
eneral&message_id=3D45DEDC70.7010301@toptica.com&counter=3D1
>=20
> On 5/2/07, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Hi,
> >
> > On Wed, May 02, 2007 at 10:02:44AM +0200, Asier Llano Palacios =
wrote:
> > > >
> > >
> > > I'll have a look. If don't see anything the code from 2.4.x is =
good
> > > starting point to port it.
> >
> > There was a patch for the PSC in SPI mode for 2.6 posted here:
> >
> > =
http://sourceforge.net/mailarchive/forum.php?thread_name=3D45DD9ABF.90100=
09%40toptica.com&forum_name=3Dspi-devel-general
> >
> > I can forward you the patch if you like, because the sourceforge =
server
> > only replies with "Insufficient parameters" when I click on the =
patch
> > link :(
> >
> > I myself wrote a driver for the dedicated SPI port which I can post =
on
> > spi-devel-general tomorrow (after I looked over it again).
> >
> > Best regards,
> >   Sascha
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >=20
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
