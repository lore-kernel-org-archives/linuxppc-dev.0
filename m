Return-Path: <wsa@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7A137B715B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 03:07:37 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id DCE0CDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 03:07:36 +1000 (EST)
Date: Thu, 11 Jun 2009 19:07:30 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Albrecht =?iso-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] powerpc: tiny memcpy_(to|from)io optimisation
Message-ID: <20090611170730.GC28028@pengutronix.de>
References: <1243454441.3489.1@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
In-Reply-To: <1243454441.3489.1@antares>
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2009 at 10:00:41PM +0200, Albrecht Dre=DF wrote:
> This trivial patch changes memcpy_(to|from)io as to transfer as many =20
> 32-bit words as possible in 32-bit accesses (in the current solution, =20
> the last 32-bit word was transferred as 4 byte accesses).
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>

Besides the discussion about optimizing the loop, what about the patch itse=
lf?
Looks plausible to me...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoxOdEACgkQD27XaX1/VRt8IQCdHTX2zugrASaUnyCPpXeUtjht
EJ4AoIM0Ha9Wx9iBaq4VRJ5iA1vPv3/J
=/rxs
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
