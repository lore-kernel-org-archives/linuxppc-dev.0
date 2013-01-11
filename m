Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 562002C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 19:27:50 +1100 (EST)
Date: Fri, 11 Jan 2013 10:27:31 +0200
From: Felipe Balbi <balbi@ti.com>
To: Chen Peter-B29397 <B29397@freescale.com>
Subject: Re: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on current
 v3.8-rc3
Message-ID: <20130111082731.GA11085@arwen.pp.htv.fi>
References: <20130110100835.GB28920@arwen.pp.htv.fi>
 <20130110143006.GC15787@kroah.com>
 <94F013E7935FF44C83EBE7784D62AD3F09526763@039-SN2MPN1-023.039d.mgd.msft.net>
 <F281D0F91ED19E4D8E63A7504E8A649803D63ACE@039-SN2MPN1-022.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803D63ACE@039-SN2MPN1-022.039d.mgd.msft.net>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, Felipe Balbi <balbi@ti.com>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2013 at 03:23:59AM +0000, Chen Peter-B29397 wrote:
> =20
> > > >
> > > > Some recent patch has caused fsl_mxc_udc.c driver to fail compilati=
on
> > > > because it can't find <mach/hardware.h> anymore.
> > > >
> > > > I would like this to be fixed still during this -rc cycle.
> > >
> > > Me too, who's sending a patch?  :)
> >=20
> > Hi Peter,
> >=20
> > Who is currently working on the i.mx USB?
> >=20
>=20
> I am working on it, but there are two versions, this one and chipidea's.
>=20
> Anyway, I will send a patch to fix this problem.

if you're already using chipidea, then send me a patch removing this
driver and focus your effort on chipidea.

--=20
balbi

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ78zzAAoJEIaOsuA1yqRElKUP/jxBed1NWzMqVJYNqJSLzyW6
Tih2lTFtnF/djOwOSr83oikWrHrT8kRtCKoKqsirgOFvPmbgXEGDmeGDuhLcPX2x
W4852+B+5qBNb41QvW2BDiEieMQ20VtZQFaVo0CjJbRVAbEG4//gDtrMYgxdEi7O
Mmnh9e0mKAf2/dV8ZND4l2yrZxIttFi7aWej/kN2wdBa6sn8bD5ohE21Mf6j4Re/
GpR4zChMw6H5FJqsO1/v6bZM/CyqyV1akWyX/f5GErdgdefQz1sUY7HmqGmtGEyd
lt+xGhOksWYM1Po0sZTjGYx6y5F4NKpCDM83hL5tYC1tTPanRXLdbyhxm60bHoVI
aIMcqlMmlH0XY0O0ZuuXLqPRG9lbNhaUDVH1mTZNyHER49yU0cCVIpvtFpK46uqY
NGKrGRl4U6TUL9nurbvGQ+fhvZKw8RLpl6Y/RJC+DpxPjRU9XjacWnSzN2I2VGSd
gTLnGje0GMmcsmSG7wiW0NOfNIwy3CsQxXrmti1DnFWyG/fTOvaVkKr4vP1SZRnZ
Umn3D3ExeoSqKzQenUHC5OIQKpjkBn63YxLbwhXXJXe28L6CBQsmZbFPCGSCMarH
Rhckvqb1VAln88i5YZJEDsiPT7DdxLp8cCI/JQaRLjiX0diuFQY+I0XEa91YRE/o
4cI84V0lZ6ntGXptbJA+
=0iVB
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
