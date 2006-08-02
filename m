Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] fix PMU initialization on pseries lpar
From: Michael Ellerman <michael@ellerman.id.au>
To: Sonny Rao <sonny@burdell.org>
In-Reply-To: <20060802042009.GA15567@kevlar.burdell.org>
References: <20060802042009.GA15567@kevlar.burdell.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-N+/bsCygWfcS6qz2XPSV"
Date: Wed, 02 Aug 2006 14:29:33 +1000
Message-Id: <1154492973.14858.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-N+/bsCygWfcS6qz2XPSV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-02 at 00:20 -0400, Sonny Rao wrote:
> We should not be calling power4_enable_pmcs() in
> pseries_lpar_enable_pmcs(); just doing the hypercall is sufficient.=20
> Prior to 2.6.15 we did not call power4_enable_pmcs() for an lpar.
>=20
> power4_enable_pmcs() tries to read the hid0 register which is no
> longer legal for an lpar in newer Power processors.

Argh, how did I miss that. Mea culpa.=20

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-N+/bsCygWfcS6qz2XPSV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE0CotdSjSd0sB4dIRAtqkAKCPEM10I4f128VSlfDi/ok7F6uh3ACeNGIv
FLXUpvY1o9mszPGCH8SCBi0=
=rIfV
-----END PGP SIGNATURE-----

--=-N+/bsCygWfcS6qz2XPSV--
