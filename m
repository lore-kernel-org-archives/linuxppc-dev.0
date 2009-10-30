Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id A94BCB7C0F
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2009 22:41:59 +1100 (EST)
Date: Fri, 30 Oct 2009 12:36:44 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Mark Brown <broonie@sirena.org.uk>
Subject: Re: mpc512x/clock: fix clk_get logic
Message-ID: <20091030113644.GE12068@pengutronix.de>
References: <1256894234-11264-1-git-send-email-w.sang@pengutronix.de>
	<20091030105414.GD717@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
In-Reply-To: <20091030105414.GD717@sirena.org.uk>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2009 at 10:54:14AM +0000, Mark Brown wrote:
> On Fri, Oct 30, 2009 at 10:17:14AM +0100, Wolfram Sang wrote:
> > The matching logic returns a clock even if only the dev-part matches. T=
his is
> > wrong as devices may utilize more than one clock, so the wrong clock ma=
y be
> > returned due to dev being not unique (noticed while working on the CAN =
driver).
> > The proposed new method will:
>=20
> > - require the id field (as _this_ is the unique identifier)
>=20
> NULL id fields are supposed to be supported in the cannonical clkdev
> API, unfortunately.

Hmm, ok, thanks for the hint. Where is this documented, I can't find it?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrqz8wACgkQD27XaX1/VRsfjACfbub2rpEaOov2V4NO7F8ksSVe
3fEAnR2pA53Sjx2KiFaC0z2pg1qH9apM
=Srfz
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--
