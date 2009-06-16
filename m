Return-Path: <wsa@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6D1CCB7138
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 23:20:20 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id D4FBBDDF86
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 23:20:19 +1000 (EST)
Date: Tue, 16 Jun 2009 15:20:05 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V2 2/2] mtd/maps/mtd-ram: add an of-platform driver
Message-ID: <20090616132005.GD21321@pengutronix.de>
References: <1244203514-12516-3-git-send-email-w.sang@pengutronix.de>
	<1245087807.3185.0@antares> <20090616091801.GC21321@pengutronix.de>
	<fa686aa40906160553m2f0e7cc4n644c3893573845f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
In-Reply-To: <fa686aa40906160553m2f0e7cc4n644c3893573845f@mail.gmail.com>
Cc: devicetree-discuss@ozlabs.org,
	Albrecht =?iso-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Ben Dooks <ben-linux@fluff.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Grant wondered if we need a bankwidth. IMHO it is needed for now, but I=
 don't
> > know if this is a common agreement.
>=20
> I'm not happy about the use case though.  It probably shouldn't appear
> in this binding, or if it does it should be tagged as an optional
> property.  It is only in the 5200 localplus case that bank-width is
> needed to figure out how to apply the workaround.

Maybe there is a misunderstanding here. I am not talking about Albrecht's c=
ase.
What I replied to your concern is that bankwidth is used(!) in the underlyi=
ng
map-ram-driver in mapram_erase() at the moment. Whether this is really need=
ed
could be discussed perhaps, but is beyond the scope of this patch series IM=
HO.
I'd think this can be addressed in a later series, if needed, although this
could mean that the binding will change (bank-width becoming optional).

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko3nAUACgkQD27XaX1/VRtTkACfW0aUMJHrU3m4DCel0pm5fA6J
WaQAnjGo5fn6JvMHt3Ke/xFTGB1uYT6p
=V9t5
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
