Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id B9E7EDDDFC
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 03:17:41 +1000 (EST)
Date: Thu, 28 May 2009 19:17:26 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused
	by read i2c_msg
Message-ID: <20090528171726.GE3112@pengutronix.de>
References: <4A124202.4010201@doredevelopment.dk>
	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
	<20090526213351.GG23114@fluff.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
In-Reply-To: <20090526213351.GG23114@fluff.org.uk>
Cc: linuxppc-dev@ozlabs.org, Esben Haabendal <eha@doredevelopment.dk>,
	linux-i2c@vger.kernel.org, Esben Haabendal <esbenhaabendal@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Any blockers to get this accepted?
>=20
> It would be nice to get an ack from someone who can actually test
> the driver before getting this merged.

I wanted to test it, but it does not apply due to line breaks (check
@@-line). Also, I don't really have the time to dig into the topic, so I
would only test it and give a tested-by-tag if it doesn't break anything
here. I think Joakim would be a good candidate for an acked-by .

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoexyYACgkQD27XaX1/VRu+mACdFGtX1DCt/RqzCoYSloa0zGw3
f0IAoKyRUlePitsTyVsWjV42yZ/Iob4I
=oC0v
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
