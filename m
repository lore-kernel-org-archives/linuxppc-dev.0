Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 3/4] Use pseries_setup_i8259_cascade() in
	pseries_mpic_init_IRQ()
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1208492131.6958.390.camel@pasglop>
References: <6840627eab063b5246ec661968986a4ae2d7be61.1207032121.git.michael@ellerman.id.au>
	<87206bccf429273c3d7abba408ef606b69bae265.1207032121.git.michael@ellerman.id.au>
	<1208492131.6958.390.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Pm3VUVXt7YB4iO/L+Kr5"
Date: Fri, 18 Apr 2008 14:47:34 +1000
Message-Id: <1208494054.9319.6.camel@concordia.ozlabs.ibm.com>
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


--=-Pm3VUVXt7YB4iO/L+Kr5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-04-18 at 14:15 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2008-04-01 at 17:42 +1100, Michael Ellerman wrote:
> > pseries_mpic_init_IRQ() implements the same logic as the xics code did =
to
> > find the i8259 cascade irq. Now that we've pulled that logic out into
> > pseries_setup_i8259_cascade() we can use it in the mpic code.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> (provided you test it and it works :-)

Done. Booted on a Power something (5 or 6) partion and also booted fine
on bongohits, an old power 3 machine with an MPIC.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Pm3VUVXt7YB4iO/L+Kr5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBICCfmdSjSd0sB4dIRAgPEAJ4uahQlNPARvqACkLQmIKJSnhjhUQCdHZrP
utLCT6Tu7vRZKd2z4cEDwPA=
=y3EA
-----END PGP SIGNATURE-----

--=-Pm3VUVXt7YB4iO/L+Kr5--
