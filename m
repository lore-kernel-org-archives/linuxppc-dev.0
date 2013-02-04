Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 194002C02C4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2013 06:53:50 +1100 (EST)
Date: Mon, 4 Feb 2013 21:53:15 +0200
From: Felipe Balbi <balbi@ti.com>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RFC/PATCH 29/32] usb: gadget: pxa27x_udc: let udc-core manage
 gadget->dev
Message-ID: <20130204195315.GA29628@arwen.pp.htv.fi>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
 <1359042370-4358-30-git-send-email-balbi@ti.com>
 <87txq1m57u.fsf@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
In-Reply-To: <87txq1m57u.fsf@free.fr>
Cc: kgene.kim@samsung.com, eric.y.miao@gmail.com,
 kuninori.morimoto.gx@renesas.com, alexander.shishkin@linux.intel.com,
 gregkh@linuxfoundation.org, yoshihiro.shimoda.uh@renesas.com,
 Linux USB Mailing List <linux-usb@vger.kernel.org>, nicolas.ferre@atmel.com,
 linux-geode@lists.infradead.org, Felipe Balbi <balbi@ti.com>,
 linux-samsung-soc@vger.kernel.org, haojian.zhuang@gmail.com,
 ben-linux@fluff.org, dahlmann.thomas@arcor.de, linux@arm.linux.org.uk,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2013 at 09:18:29PM +0100, Robert Jarzmik wrote:
> Felipe Balbi <balbi@ti.com> writes:
>=20
> > By simply setting a flag, we can drop some
> > boilerplate code.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/usb/gadget/pxa27x_udc.c | 9 +--------
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>=20
> And I tested also your patch and it works in my environment. For next pat=
ches
> I'd like to be CCed for pxa27x_udc stuff as I'm maintaining that one sinc=
e its
> beginning (and yes, I know, I didn't put that in MAINTAINERS ...).

you should add yourself to MAINTAINERS. Please send a patch to Greg when
you have time.

No need to prepare a tree, though. I just need you to give your Acked-by
and I'll queue the patches myself.

cheers

--=20
balbi

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJREBGrAAoJEIaOsuA1yqRE0vUQAKyazTVwVicGXO+vGMA3PsuF
eOWtYr8dSlvXy/cjOo5ltIlFBbjc8tZVWsOqurALqO+qzu0pfON9AAQShpyHq2YV
+J6iAGFYaQ6x5QrPuFDeDWG9SEWwcAJtSxa99x8pPrVyzt/an06JwEwSztezLHUj
flhRU0iHLuBPgZVwUPK5Zx9PRu7XeHUoyVLB2pSzsffxM+2cR4P6cglNSrU7uqJY
vNtoZpwpAMDDjtgzRNLAj3LTiSlmpG6/Jxaq3vqt5xUR34f6OywafM/rjW64CmbT
u+NGIPnWxXXawThlBkIhotZzMQgS3hD0cZtnw3v9RTdAgSH3KE1sWum/QXkOAMwI
Jg/6fwcNto4E7npl6cGQqREXYcOg4lH0d4eZ8va1sZQUwSinJKMWZj2Dkd1esGdr
VDa/3hw6tncruTbaSXcgyr9bWCcSjmZYNdF8hd9B+fEPgMeRBcLH0PF+w2bRcG4Q
xiPgGG2y3s3SWsUXvyXRE2vtSp1f+aPEYLmWZdGDIum+Ev5v7yRK1s3d2s3kLM/Q
1Kb3kQMyfachlwYd0Ev54L8X1vyjHe5SQylhdzIbW7RpXY3vn3KIxbT9WjLM385t
ok43ibbIzXBtS7z17PqMNLQoIrNtJk+vJEaMJsmY7hBBCgfmnFpRqJiRQaTi65xr
uexTC1K/SknBAg/8+Z8h
=qf2p
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
