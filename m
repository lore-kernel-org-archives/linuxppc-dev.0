Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Fix legacy serial search for opb bus ports
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <20080205145008.GA5306@windriver.com>
References: <9efb8c0e313840ccb1bdf918406cdc812ec5de94.1202212897.git.michael@ellerman.id.au>
	<20080205145008.GA5306@windriver.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-MUOXsRRaoXFaDvEyVyek"
Date: Wed, 06 Feb 2008 10:50:09 +1100
Message-Id: <1202255409.11152.8.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-MUOXsRRaoXFaDvEyVyek
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-02-05 at 09:50 -0500, Paul Gortmaker wrote:
> In message: [PATCH] Fix legacy serial search for opb bus ports
> on 05/02/2008 Michael Ellerman wrote:
>=20
> > The patch to legacy_serial.c (1a7507c7da2df6856e085e0fbb0c9ea8c12ac4e,
> > Reduce code duplication in legacy_serial, add UART parent types) change=
d
> > the semantics for opb ports from type =3D "opb" || compatible =3D "ibm,=
opb"
> > to type =3D "opb" && compatible =3D "ibm,opb".
>=20
> Ah.  I'd originally coded it as an ||   -- but then Arnd suggested I
> condense it further by using of_match_node() -- which was a good idea,
> but that is where it accidentally changed to && without me catching it.
> Thanks for finding this, and sorry for the debug adventure (I know
> vanishing uarts isn't fun).

Yeah it's easy to confuse, I had to look at of_match_node() fairly
closely before I was convinced it was equivalent to &&. The bisect was
fairly painless actually, so no dramas.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-MUOXsRRaoXFaDvEyVyek
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHqPYxdSjSd0sB4dIRAqE7AKC76UrhGIrwBG3IjxKoDVBxjK8a1gCdE06V
/BTMXPP/0vtWCB3p5ghSejk=
=Tdjb
-----END PGP SIGNATURE-----

--=-MUOXsRRaoXFaDvEyVyek--
