Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79CB1B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 14:51:43 +1000 (EST)
Date: Thu, 7 Apr 2011 06:51:37 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Carlos Roberto Moratelli <carlos.moratelli@digitel.com.br>
Subject: Re: sdhc/mpc8536 - SDCard always detected like read-only - SOLVED.
Message-ID: <20110407045137.GA11417@pengutronix.de>
References: <1302028796.10112.59.camel@moratelli-host.digitel.com.br>
	<20110405190204.GB12723@pengutronix.de>
	<1302031171.10112.66.camel@moratelli-host.digitel.com.br>
	<20110405234824.GB5611@pengutronix.de>
	<1302110338.2647.21.camel@moratelli-host.digitel.com.br>
	<1302127065.2647.60.camel@moratelli-host.digitel.com.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
In-Reply-To: <1302127065.2647.60.camel@moratelli-host.digitel.com.br>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Reading the MPC8536E Chip Errata I saw the SDHC_WP signal polarity is=20
> reversed to the silicon revision 1.0.
>=20
> Unfortunately my prototype board  is using revision 1.0. So, I asked to
> my hardware team workaround putting an extra inverter for the SDHC_WP
> signal.
>=20
> Now its working fine!

OK, nice. I fail to see from a glimpse how all this is related to the
timeout-errors you were seeing (-110), but if it works now, all is fine, I
guess.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2dQtgACgkQD27XaX1/VRv6vACeN/frfcK6YrvW48/1KlC6Blgk
W/AAn0QP0rfLEdfkVulNqrXjlp2tSZd5
=kLlL
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
