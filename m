Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 15/16] powerpc/mm: Rework usage of
	_PAGE_COHERENT/NO_CACHE/GUARDED
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <8F38D1CB-D389-4065-A309-3126B6D482DB@freescale.com>
References: <20081215054611.3C3C1474E1@ozlabs.org>
	<8F38D1CB-D389-4065-A309-3126B6D482DB@freescale.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ijlwLBNZum8dquhvnRN6"
Date: Tue, 16 Dec 2008 08:03:18 +1100
Message-Id: <1229374998.8332.20.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ijlwLBNZum8dquhvnRN6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-12-15 at 14:54 -0600, Kumar Gala wrote:
> >
> > #ifndef __ASSEMBLY__
> > +
> > +/*
> > + * Macro to mark a page protection value as "uncacheable".
> > + */
> > +
> > +#define _PAGE_CACHE_CTL	(_PAGE_COHERENT | _PAGE_COHERENT | _PAGE_COHER=
ENT | \
> > + 			 _PAGE_WRITETHRU)
>=20
> we like coherent so much we set it thrice?

That makes it really-really-really coherent.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ijlwLBNZum8dquhvnRN6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklGxhYACgkQdSjSd0sB4dJPFACgm+Baus4TeFC4VORTY4Gvnlml
g0AAn2y2a1IS43Zg71OvQgyTk5hwqfac
=zFCN
-----END PGP SIGNATURE-----

--=-ijlwLBNZum8dquhvnRN6--
