Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03C53DDF08
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 16:43:05 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5S6gx70017321
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 23:43:00 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l5S6gwW1021723
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 01:42:59 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 3/5 v2] Add the platform device support with RapidIO to
	MPC8641HPCN platform.
Date: Thu, 28 Jun 2007 14:42:39 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C6F31B2@zch01exm26.fsl.freescale.net>
In-Reply-To: <200706272256.16418.arnd@arndb.de>
References: <11829333481420-git-send-email-wei.zhang@freescale.com>
	<11829333481375-git-send-email-wei.zhang@freescale.com>
	<1182933348216-git-send-email-wei.zhang@freescale.com>
	<200706272256.16418.arnd@arndb.de>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Arnd Bergmann" <arnd@arndb.de>, <linuxppc-dev@ozlabs.org>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Arnd,


>=20
> On Wednesday 27 June 2007, Zhang Wei wrote:
> > +static struct of_device_id mpc86xx_of_ids[] =3D {
> > +=A0=A0=A0=A0=A0=A0=A0{ .type =3D "soc", },
> > +=A0=A0=A0=A0=A0=A0=A0{ .compatible =3D "fsl,rapidio-delta", },
> > +=A0=A0=A0=A0=A0=A0=A0{},
> > +};
> > +
> > +static __init int mpc86xx_of_device_init(void)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0return of_platform_bus_probe(NULL, =
mpc86xx_of_ids, NULL);
> > +}
>=20
> This will add any devices below the "fsl,rapidio-delta" device
> as an of_device. Is that what you actually want? I would guess that
> you want to add the bridge itself, not the devices below it.
>=20
> Is the rapidio device at the root of the device tree, and if so, why
> not under the soc bus?
>=20

RapidIO is rather a bus that a device although these is no other nodes =
defined in its sector now.

Thanks!
Wei.
