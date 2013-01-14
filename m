Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F38F72C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 04:57:40 +1100 (EST)
Date: Mon, 14 Jan 2013 19:57:24 +0200
From: Felipe Balbi <balbi@ti.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Message-ID: <20130114175724.GD12611@arwen.pp.htv.fi>
References: <20130114102444.GD10874@arwen.pp.htv.fi>
 <50F3DF1D.3040706@pengutronix.de>
 <20130114103952.GF10874@arwen.pp.htv.fi>
 <50F3E301.7040509@pengutronix.de>
 <20130114105357.GH10874@arwen.pp.htv.fi>
 <50F3E5E8.2000905@pengutronix.de>
 <20130114110600.GI10874@arwen.pp.htv.fi>
 <20130114125632.GA30157@nchen-desktop>
 <20130114174054.GB12611@arwen.pp.htv.fi>
 <50F4464E.7000605@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
In-Reply-To: <50F4464E.7000605@pengutronix.de>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 balbi@ti.com, Peter Chen <peter.chen@freescale.com>, kernel@pengutronix.de,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2013 at 06:54:22PM +0100, Marc Kleine-Budde wrote:
> On 01/14/2013 06:40 PM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Mon, Jan 14, 2013 at 08:56:33PM +0800, Peter Chen wrote:
> >=20
> > <snip>
> >=20
> >>>> Usually there isn't any Changelog between IP cores used in the diffe=
rent
> >>>> fsl processors (at least available outside of fsl), that makes it qu=
ite
> >>>> difficult to say if something found on one imx is really the same as=
 on
> >>>> the other one. And they (usually) don't provide any versioning
> >>>> information in a register or the documentation.
> >>>>
> >>>> just my 2=A2
> >>>
> >>> $SUBJECT is trying to differentiate a single feature (or maybe two) to
> >>> replace cpu_is_xxx(), then expose that on driver_data without creating
> >>> one enum value for each release from fsl.
> >>
> >> Felipe, every one or two SoCs may have their special operations for
> >> integrate PHY interface, clk operation, or workaround for IC
> >> limitation.
> >=20
> > the particular PHY and clk used should be hidden by phy layer and clk
> > API respectively. Workarounds, fair enough, we need to handle them; but
> > ideally those should be based on runtime revision detection, not some
> > hackery using driver_data.
>=20
> If this is actually possible, I'd love to do this. But IP vendor don't
> include a version register in their cores. :(

then fair enough, driver_data or platform_data is the way to go, still
my point (a) below is valid.

--=20
balbi

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ9EcEAAoJEIaOsuA1yqREX5YP/3Ml3NhWU7FAz4/tmb3wnHmp
sA1xu/aP04C3jor3iWzyoKJVhTWXUAIFrCUdUIFbfLyHY3dP8uJMJewED6RCFlG6
531rwx1oB9wk3O7R6oQG0+BuTi2Xtdx9TRTbhflSeb4ocgTamJE0bF7z9Zq2AWoR
U5AcEYR/7kxZ4JCAGcXB7G70p1nuR+Un2kY5KAOGwzFuf4fNpiFdezVd7gHUgxc5
VDHa3DzrsfN3VzTgVLqEW+NLUtOC6yhgErJV5RwluyWZb5ZK5pINHx7WK3pldIj4
8oiJk16UwiEl5oMOKrgz1WqYgF7gUixJh8E+gCEJNQm0KRvM+gDetalHHZgA0uuU
4VEbM1pHXvrsa1niaMeQ39ag3PUMPI4/x+2gGynzOZQh2tkaf17rb31kj1fE3o+y
V8G67zWVTrn2NtNewTc9ucMOQRZMWbPf9UPdqvTZqR3DiA921XtCiWXyip3ghHOg
lc7pROTFKOYrub9YV5mlN1sd36kXc8zjSd5zBRpW+aTO+qSixIGs984mvi7WY84m
EKYRe9sFlssafrFY48dThOfvMmQ9lO0KRbyGdyHaUvKJP0WHqOiQO0YspdnQBZdh
odByPo7G8xVJ6uioVMN2LmliN8a+x1M7hxEVZZuvns6pxwNWckZrBrnJXDaA7GFS
V8Ht4oO1Qs28//ZZbLkx
=kKMk
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
