Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 13EA42C009A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 20:48:13 +1100 (EST)
Date: Fri, 11 Jan 2013 11:47:54 +0200
From: Felipe Balbi <balbi@ti.com>
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on current
 v3.8-rc3
Message-ID: <20130111094618.GD11085@arwen.pp.htv.fi>
References: <20130110100835.GB28920@arwen.pp.htv.fi>
 <20130110143006.GC15787@kroah.com>
 <94F013E7935FF44C83EBE7784D62AD3F09526763@039-SN2MPN1-023.039d.mgd.msft.net>
 <F281D0F91ED19E4D8E63A7504E8A649803D63ACE@039-SN2MPN1-022.039d.mgd.msft.net>
 <20130111082731.GA11085@arwen.pp.htv.fi>
 <F281D0F91ED19E4D8E63A7504E8A649803D63DA7@039-SN2MPN1-022.039d.mgd.msft.net>
 <20130111084129.GB11085@arwen.pp.htv.fi>
 <94F013E7935FF44C83EBE7784D62AD3F09526C23@039-SN2MPN1-023.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F09526C23@039-SN2MPN1-023.039d.mgd.msft.net>
Cc: Mehresh Ramneek-B31383 <B31383@freescale.com>,
 Chen Peter-B29397 <B29397@freescale.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "balbi@ti.com" <balbi@ti.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Greg KH <gregkh@linuxfoundation.org>,
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

--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 11, 2013 at 09:24:16AM +0000, Li Yang-R58472 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Felipe Balbi [mailto:balbi@ti.com]
> > Sent: Friday, January 11, 2013 4:41 PM
> > To: Chen Peter-B29397
> > Cc: balbi@ti.com; kernel@pengutronix.de; Li Yang-R58472; Greg KH; linux-
> > usb@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on
> > current v3.8-rc3
> >=20
> > Hi,
> >=20
> > On Fri, Jan 11, 2013 at 08:35:29AM +0000, Chen Peter-B29397 wrote:
> > > > > I am working on it, but there are two versions, this one and
> > chipidea's.
> > > > >
> > > > > Anyway, I will send a patch to fix this problem.
> > > >
> > > > if you're already using chipidea, then send me a patch removing this
> > > > driver and focus your effort on chipidea.
> > > >
> > > Added Sascha
> > >
> > > Now, not all of FSL i.mx USB can move to use chipidea due to some
> > > platform and USB PHY problem.
> >=20
> > then we need to target fixing those problems and moving to chipidea
> > completely at some point. There's no reason to duplicate efforts if we
> > already have a re-usable driver in tree, right ?
> >=20
> > Let's fix this build break and focus on making sure all i.MX platforms
> > can use chipidea so we can drop fsl udc on next merge window. That would
> > be a great patchset to see.
>=20
> I do agree that we need move to use the chipidea driver and eventually
> remove the fsl udc driver, but there were many users of the current
> driver such as PowerPC and Coldfire platforms besides the i.MX
> platforms.  The support for them with chipidea driver could also be
> broken for now.  I would suggest to have a transitional period that
> both drivers are kept while new development be based on the new
> driver.

right, right. That can be done as long as 'transitional period' isn't 20
years. At least make a plan to remove fsl udc, if it doesn't happen in
the next 4 merge windows, I will remove it myself to force people to
reuse other drivers. There is no reason to keep both drivers around.

> Added Ramneek.  What do you think of the current status for chipidea
> driver on PowerPC platforms?

that would be great to know, indeed.

--=20
balbi

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ79/KAAoJEIaOsuA1yqRErsoP/RhkGvU4mFeAa0uRqS1DXzgU
qI+veGZaDrt1kr5yBtAl8mJ3oTUXbvzrq/EJUHqHbgYFIWzhEfEAtvWShq0aINdk
daIXGQkQAA0k6GD2T6ZUYL+eNRabzkapVr4bY4B2ZukehzlmsqqZmWA8wGpIwRc3
Dhq2PobxRg+Sl67+E13ylV5k+oZ8Z3Yr5GXF27whVa1djjm3zo9em3VhZun8kwRj
EkJdmQ62PUU7Gw4NiZHA1+MkCiO/zMuZYz9emqZBpPBP5MAp/CbyeMHMjWAaI/yt
ZpgaG2Xm9KLPVcnP3+NzxKDH+5Ywo4Eth5zxC7x+y8BkmYxrHAzfx8v/JzbUUOcS
MzGhrW9d86sIkWPzL1knPB9USIWXtkQC2o+//zCxwxLg/CGWQHsloA8TyBy9nkMC
wYEywmBjRC+xN1TQzcep/5w01PRMZS4bgMSHTwwWyR8j57PmfVX5mZg9VT7GlQiJ
RFDxmH7Uu0iAzyGAge5CLHSHVdkvIxTe5w4EoTzr+Ph0kEjBaqzpi5Cpi6FIn3H5
wzrOtsg1i+ZCKkMvvyNBaoLNgLZL7+bMv4ToXRBPnNlVud2UIQPqwFinnYorfUNV
S6Fj8xAuIFDx0HRl/ioXTVW0WpsS2s9xSpFqHAdPOVTFkS9NdCL/x69xt93mUuNq
c5kfe00bRbpS7uwOHBIh
=I9RL
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
