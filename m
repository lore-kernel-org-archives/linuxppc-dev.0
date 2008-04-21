Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2.6.26?] Raise the upper limit of NR_CPUS.
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1208743427.10486.2.camel@pasglop>
References: <20080418053349.GE20457@bakeyournoodle.com>
	<1208743427.10486.2.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-zZ8bJm9b+QEA+dOAUnHo"
Date: Mon, 21 Apr 2008 19:05:06 +1000
Message-Id: <1208768706.9955.9.camel@concordia>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-zZ8bJm9b+QEA+dOAUnHo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-04-21 at 12:03 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2008-04-18 at 15:33 +1000, Tony Breeds wrote:
> > As the pacas are statically initialised increasing NR_CPUS beyond 128,
> > means that any additional pacas will be empty  ... which is bad.
> >=20
> > This patch adds the required functionality to fill in any excess pacas
> > at runtime.
> >=20
> > Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> > ---
> > I know it's late, but can this be considered for 2.6.26?
>=20
> NAK.

Tony, you should NAK Ben tomorrow after lunch if you know what I mean :)

> You must NEVER manipulate kernel globals from prom_init.c. The fact that
> prom_init is linked with the kernel is an "accident" which may change.

A very long running accident, we should really look at fixing it some
time.

> Your scheme would break among others with kexec or non-OF bootloaders

I talked to Tony about it this morning and we came up with a scheme that
should work for all cases.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-zZ8bJm9b+QEA+dOAUnHo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIDFjCdSjSd0sB4dIRAgGUAJ9jS/e2QLLNpPnHxWhhKzzJwpiOIwCcC1qk
FBYlhO76JOWmTKuG9NIphi4=
=v55b
-----END PGP SIGNATURE-----

--=-zZ8bJm9b+QEA+dOAUnHo--
