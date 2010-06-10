Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3348B7D48
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 18:59:28 +1000 (EST)
Date: Thu, 10 Jun 2010 10:59:23 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: CAN Subsystem and MPC52xx onboard controller
Message-ID: <20100610085923.GE5333@pengutronix.de>
References: <201006101041.27926.roman.fietze@telemotive.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
In-Reply-To: <201006101041.27926.roman.fietze@telemotive.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> And which one is "good" or "better" for CAN+MPC52xx if that's
> different?

The mainline kernel works fine here with Phytec based MPC5xxx-boards. Some
custom boards, too. You probably already know that it is always best to
stay as close to mainline as possible ;) Maybe just the lite-support is
slightly bit-rotten? What kind of build-errors do you get with the
mainline-kernel?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwQqWsACgkQD27XaX1/VRtHKwCeKjsWbF3Yyucj/umFoKmq/6NE
c3QAoKvHXt881ybV5J+2Hz/nUtDw/vZO
=2c9R
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--
