Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB25D2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 21:24:54 +1100 (EST)
Date: Mon, 14 Jan 2013 12:24:44 +0200
From: Felipe Balbi <balbi@ti.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Message-ID: <20130114102444.GD10874@arwen.pp.htv.fi>
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
 <1358158361-25550-2-git-send-email-peter.chen@freescale.com>
 <20130114101642.GB10874@arwen.pp.htv.fi>
 <50F3DB8D.6050104@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
In-Reply-To: <50F3DB8D.6050104@pengutronix.de>
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

--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2013 at 11:18:53AM +0100, Marc Kleine-Budde wrote:
> On 01/14/2013 11:16 AM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Mon, Jan 14, 2013 at 06:12:39PM +0800, Peter Chen wrote:
> >> @@ -2756,22 +2753,41 @@ static int fsl_udc_otg_resume(struct device *d=
ev)
> >> =20
> >>  	return fsl_udc_resume(NULL);
> >>  }
> >> -
> >>  /*-------------------------------------------------------------------=
------
> >>  	Register entry point for the peripheral controller driver
> >>  ---------------------------------------------------------------------=
-----*/
> >> -
> >> +static const struct platform_device_id fsl_udc_devtype[] =3D {
> >> +	{
> >> +		.name =3D "imx-udc-mx25",
> >> +		.driver_data =3D IMX25_UDC,
> >> +	}, {
> >> +		.name =3D "imx-udc-mx27",
> >> +		.driver_data =3D IMX27_UDC,
> >> +	}, {
> >> +		.name =3D "imx-udc-mx31",
> >> +		.driver_data =3D IMX31_UDC,
> >> +	}, {
> >> +		.name =3D "imx-udc-mx35",
> >> +		.driver_data =3D IMX35_UDC,
> >> +	}, {
> >> +		.name =3D "imx-udc-mx51",
> >> +		.driver_data =3D IMX51_UDC,
> >> +	}
> >> +};
> >=20
> > I wonder if your driver-data is actually needed since you can use string
> > comparisson to achieve the exact same outcome.
>=20
> Why use a string compare, if the kernel infrastructure already does this
> for you?

what do you mean ? What kernel infrastructure is doing waht for me ?

--=20
balbi

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ89zsAAoJEIaOsuA1yqREeA4P/2YIMIow0vwZq7IcV0L8KiMV
i/CAum5WdpPxFbUTXXP7MC1ChkwukOV6ZO9CF/daGKU+Z13nzuNrlbFeIlhVAHJi
5XO8Fs5klqSVgVffGsulHaDZ7cay/eghJ8T1Pdi38bOuQG1rhxVQxID0Kx7EPVzE
O4onHs1tdIW2qmvW8/xtEDx8jNU6/BO5N3ePUCT/6bx1q0s7JRxiTL5eNRQch6jn
AO3f6gL9Gk6Qmm4Qz6mA1pbaZRQEThfw22YlJehUTyvnEexcKGn7MmHD9iepeTKx
LzpfP/HjBlnj6vu+E8oPCl1MtS5zpVXhYdBBUjtIth7ksbCTQMWUsaVgiXuVGuAp
1ecYrTsZczzEmSuHyZJdsmW4dj/kqQgkf0CoWW6p3Y2H+FheOT8K6gQrporUOtkP
xrvu9fs8nGXmJJ76jVxZ/lzNhf0GXyyMRZvMT7cOOwjGV519lcIAi1pUyMrr3px8
raV6FPNxKZnsGDw3/yHVsXZRplgsNxP/mt4keT51053n3DCliBVUGOMi6ow99EB4
khLMOLJS9LUT0Fptt6KC4gBM+ThcOvWSJ+fNtGFus10TwhWsIWdRgqvw+92tnT/T
7ZGekY0ALS5ediZrI2sFbhYBna+Tn5NMUVWIYsjL2IARICYVdxSu4VIB6fZjITue
dET7/Ee94Kgx5aiEbA+O
=ayVw
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
