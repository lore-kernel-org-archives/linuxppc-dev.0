Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4E570B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2009 23:12:46 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id BA84DDDDA0
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Aug 2009 23:12:44 +1000 (EST)
Date: Mon, 3 Aug 2009 15:12:31 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Read buffer overflow
Message-ID: <20090803131231.GG3154@pengutronix.de>
References: <4A76DB06.7090405@gmail.com>
	<19062.57005.981901.24666@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0qt3EE9wi45a2ZFX"
In-Reply-To: <19062.57005.981901.24666@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Roel Kluin <roel.kluin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2009 at 10:57:17PM +1000, Paul Mackerras wrote:
> Roel Kluin writes:
>=20
> > Check whether index is within bounds before grabbing the element.
>=20
> The change seems unnecessary since we only compute the address of the
> element before the bounds check, we don't actually access the
> element.  I believe that is legal in C.

I've got this strange feeling of deja vu :)

http://thread.gmane.org/gmane.linux.ports.arm.kernel/63507

(I'd vote for applying it but won't mind if not)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkp24j8ACgkQD27XaX1/VRt/sACfakqxip2Bm/homfVJ6jzaoxTq
OXEAnRM7tzUxfawJtgB2MyFeFCJub6C9
=iHHX
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--
