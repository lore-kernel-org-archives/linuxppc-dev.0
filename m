Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F31B2C01C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 19:41:48 +1100 (EST)
Date: Fri, 11 Jan 2013 10:41:29 +0200
From: Felipe Balbi <balbi@ti.com>
To: Chen Peter-B29397 <B29397@freescale.com>
Subject: Re: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on current
 v3.8-rc3
Message-ID: <20130111084129.GB11085@arwen.pp.htv.fi>
References: <20130110100835.GB28920@arwen.pp.htv.fi>
 <20130110143006.GC15787@kroah.com>
 <94F013E7935FF44C83EBE7784D62AD3F09526763@039-SN2MPN1-023.039d.mgd.msft.net>
 <F281D0F91ED19E4D8E63A7504E8A649803D63ACE@039-SN2MPN1-022.039d.mgd.msft.net>
 <20130111082731.GA11085@arwen.pp.htv.fi>
 <F281D0F91ED19E4D8E63A7504E8A649803D63DA7@039-SN2MPN1-022.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803D63DA7@039-SN2MPN1-022.039d.mgd.msft.net>
Cc: Li Yang-R58472 <r58472@freescale.com>, Greg KH <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "balbi@ti.com" <balbi@ti.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 11, 2013 at 08:35:29AM +0000, Chen Peter-B29397 wrote:
> > > I am working on it, but there are two versions, this one and chipidea=
's.
> > >
> > > Anyway, I will send a patch to fix this problem.
> >=20
> > if you're already using chipidea, then send me a patch removing this
> > driver and focus your effort on chipidea.
> >=20
> Added Sascha
>=20
> Now, not all of FSL i.mx USB can move to use chipidea due to some platfor=
m and USB
> PHY problem.

then we need to target fixing those problems and moving to chipidea
completely at some point. There's no reason to duplicate efforts if we
already have a re-usable driver in tree, right ?

Let's fix this build break and focus on making sure all i.MX platforms
can use chipidea so we can drop fsl udc on next merge window. That would
be a great patchset to see.

--=20
balbi

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ79A5AAoJEIaOsuA1yqREyVEP/izYMihRAcY7HDls0dCQ1Y8+
HBkD/XuPytzzJI66pMQTZ1gxj7vGLwvsY4jJQ+0IuHcEXm2TFag0pVpSD2zX4/vt
Nvo6OcXWCeAP5wgM42KJb4h9O14YAM8AG61Xv74WsJt/x1pkLOXzkyeALdbPpk84
bdHZLTcbsZDo5SVxOuhaGw0U26swc+lyMV4PWR5UBSDPqPLbbcv7hVuJXLCnK2zn
ZEGx1H1x5F/hxE48IuzEUmqiyMFliyZDuOMg9t9xaPHhhqJktqJQizbhkKJZjPHq
9LD8MngN7h/CRN1TMeztqnb4wkiYG8XIY67yk6vRjGP6CvD8rVrrv+5+dO4k+dED
laROAdKkrv7hPOy2NzRnV+qyquP42pZ9i17Fn9kTn7Ub6NQFhwSYklvnvB7Nc1xX
GXXdGeXYe28BsMQPPPhdTFOoYEvV2pnXwgKvgdPcEsaUZ5r8yVw6HHxjGnAj1ung
fU0S2BCk3iEsnr6+sJOVAYFQP93VYR4eyFPqkrvTjVBY/Z1x4nIIi0vkyMdmfHdP
VIFAS5N/gDhvYyByw6yztoEvHV6gSsoVyyzqLzIcMkCLAoR56YNW8ua3kipep/du
AA+npLqbJ+1eiOdSHKQADmRYW2sdJSMzLizfzkOpZPnQXF/JrZUTcRPXEl5Yi96C
TAjuLV9A3cx94/6US6r6
=JI4M
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
