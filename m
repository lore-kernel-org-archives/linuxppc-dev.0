Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 9D0BADDDD8
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 17:11:31 +1000 (EST)
Date: Fri, 26 Sep 2008 09:11:21 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: mpc52xx_uart and rs485
Message-ID: <20080926071121.GA4215@pengutronix.de>
References: <WorldClient-F200808141123.AA23490073@abs-cs.com>
	<20080924142015.GA12119@secretlab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
In-Reply-To: <20080924142015.GA12119@secretlab.ca>
Cc: Sinisa Denic <sinisa.denic@abs-cs.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Sep 24, 2008 at 08:20:16AM -0600, Grant Likely wrote:

> > Hi Wolfgang and others,=20
> > below is patch for mpc52xx_usrt.c which add software rs485 support to=
=20
> > this driver.
> > It has worked for me and if you think it is good enough it might be=20
> > useful for someone else.
>=20
> Thanks for the patch.  I've made a number of comments below and it
> appears that your mail client has damaged the patch.  Can you please
> respin after addressing the comments.  When you repost, please include a
> technical description of what you have done and why.

And please add linux-serial as cc then. I recently read some criticism
about software RS485 (http://article.gmane.org/gmane.linux.serial/2573).
I don't know if these apply to this patch, but it would be nice to have
it sorted out IMHO.

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFI3IsZD27XaX1/VRsRAhAEAKCvoo/oTFgjvESqpoKOkA1VRfEK/wCfR3W0
Pl38VksUGhgsLzRiddIEOuc=
=4ePr
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
