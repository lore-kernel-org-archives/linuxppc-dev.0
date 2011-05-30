Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B0DAB6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 May 2011 00:50:50 +1000 (EST)
Date: Mon, 30 May 2011 16:50:34 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: [PATCH] Add support for pt7c4338 (rtc device)
	in rtc-ds1307 driver
Message-ID: <20110530145034.GE3409@pengutronix.de>
References: <1306393409-16153-1-git-send-email-Priyanka.Jain@freescale.com>
	<20110526091020.GA2201@pengutronix.de>
	<470DB7CE2CD0944E9436E7ADEFC02FE316DCB8@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110530082429.GA3409@pengutronix.de>
	<BANLkTi=H2rHSjTvRK5+SPhW26qCNUBMxbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
In-Reply-To: <BANLkTi=H2rHSjTvRK5+SPhW26qCNUBMxbA@mail.gmail.com>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
	Jain Priyanka-B32167 <B32167@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > IIRC I asked you explicitly for the differences between the chips. If
> > there are none, you can use the driver directly, right? :)
>=20
> Yes.  The device tree node for the PT7C4338 device should just say
>=20
>    /* The board has a PT7C4338, which is compatible with the DS1307 */
>    compatible =3D "dallas,ds1307";
>=20
> And that's it.

I'd also suggest to add a comment to the id_table in rtc-ds1307.c, so
the chip name can be grepped for.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3jrroACgkQD27XaX1/VRuhmgCgsBMdJa60pL6zT7rvbE6a1QuA
Kj4AoLre4e7j1PYfiAVSU19OPYJkSR66
=HfZv
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
