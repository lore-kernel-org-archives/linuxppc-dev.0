Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Add CONFIG_POWERPC
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17634.40549.377775.121184@cargo.ozlabs.ibm.com>
References: <20060816041617.690EB67A3F@ozlabs.org>
	<17634.40549.377775.121184@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0l8QMuez7+JRisJHNkJw"
Date: Wed, 16 Aug 2006 15:18:12 +1000
Message-Id: <1155705492.12715.2.camel@localhost.localdomain>
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


--=-0l8QMuez7+JRisJHNkJw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-16 at 14:26 +1000, Paul Mackerras wrote:
> Michael Ellerman writes:
>=20
> > We don't seem to have a top-level config symbol like other archs do. We=
 have
> > PPC64 and PPC, but I think it'd be cleaner to have just one for cases w=
here
> > we really mean PPC64 and/or PPC.
>=20
> CONFIG_PPC already means either 32-bit or 64-bit PowerPC (always has
> done, even before the merge).

Hmm, but won't that also match arch/ppc ?

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-0l8QMuez7+JRisJHNkJw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE4qqTdSjSd0sB4dIRAtyRAJ9dC2iheVeId18dAZBLx5XGdyl7/QCfXY7a
zemPteJJQpj6qsRND4DJ2mk=
=eiSK
-----END PGP SIGNATURE-----

--=-0l8QMuez7+JRisJHNkJw--
