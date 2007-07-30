Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 11A85DDE06
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 18:26:42 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6U8Qatw009665
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 01:26:37 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6U8QX9f003391
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 03:26:34 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 3/5 v3] Add the platform device support with RapidIO to
	MPC8641HPCN platform.
Date: Mon, 30 Jul 2007 16:26:32 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C74D27B@zch01exm26.fsl.freescale.net>
In-Reply-To: <200707291556.35632.arnd@arndb.de>
References: <11854393721520-git-send-email-wei.zhang@freescale.com>
	<11854393741899-git-send-email-wei.zhang@freescale.com>
	<11854393753986-git-send-email-wei.zhang@freescale.com>
	<200707291556.35632.arnd@arndb.de>
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

I can change it as you metioned now.

Thanks!
-zw

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org=20
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Arnd Bergmann
> Sent: Sunday, July 29, 2007 9:57 PM
> To: linuxppc-dev@ozlabs.org
> Cc: Zhang Wei-r63237; galak@kernel.crashing.org;=20
> mporter@kernel.crashing.org; paulus@samba.org;=20
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/5 v3] Add the platform device support=20
> with RapidIO to MPC8641HPCN platform.
>=20
> On Thursday 26 July 2007, Zhang Wei wrote:
> > +
> > +static struct of_device_id mpc86xx_of_ids[] =3D {
> > +=A0=A0=A0=A0=A0=A0=A0{ .type =3D "soc", },
> > +=A0=A0=A0=A0=A0=A0=A0{ .compatible =3D "fsl,rapidio-delta", },
> > +=A0=A0=A0=A0=A0=A0=A0{},
> > +};
>=20
> With the device tree source you have posted in 2/5, the=20
> rapidio node is
> a child of the soc bus, and it doesn't have any children of its own.
> Therefore it is completely equivalent to _only_ add the soc type
> to mpc86xx_of_ids[], as in=20
>=20
> static struct of_device_id mpc86xx_of_ids[] =3D {
>        { .type =3D "soc", },
>        {},
> };
>=20
> Even if you intend to add children to the rapidio node in the future,
> I'd think it would be more appropriate to have those scanned by
> the rapidio bus driver, not by of_platform.
>=20
> 	Arnd <><
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
