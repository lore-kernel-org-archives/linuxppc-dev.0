Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id F319CDDF53
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 07:39:22 +1100 (EST)
Date: Thu, 16 Oct 2008 22:39:14 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] i2c-cpm: Suppress autoprobing for devices
Message-ID: <20081016203914.GC13629@pengutronix.de>
References: <20081016111300.GC3432@pengutronix.de>
	<FC91562A-D6B4-4E62-A5EA-43171A80B766@kernel.crashing.org>
	<20081016.122325.188129775.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
In-Reply-To: <20081016.122325.188129775.davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2008 at 12:23:25PM -0700, David Miller wrote:

> Don't bother, he'll just argue with you about the fact that class
> based probing should be maintained.
>=20
> He's doing exactly that with me right now.

I think the two of you talked at cross purposes. Just observing, I can
follow his point, that you can easily switch probing off in the driver
(like Wolfgang Grandegger's and my patch does), so there is no need to
sacrifice some functionality of a whole algorithm. Just clear the
=2Eclass-entry in your driver and there should be peace ;)

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj3pnIACgkQD27XaX1/VRvV1ACgg8Q6OPaWFIBgNm9HzVW4gY2a
9fwAoJOo54T2+HctYWonDa63G3f4obOd
=XfkI
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
