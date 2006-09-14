Return-Path: <michael@ellerman.id.au>
Subject: Re: 'make ARCH=ppc defconfig' failing for cross-compile
From: Michael Ellerman <michael@ellerman.id.au>
To: Judith Lebzelter <judith@osdl.org>
In-Reply-To: <20060912174814.GA29226@shell0.pdx.osdl.net>
References: <20060909000512.GF9335@shell0.pdx.osdl.net>
	<Pine.LNX.4.64.0609100652160.16347@sheep.housecafe.de>
	<20060912174814.GA29226@shell0.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Rr29u0llyPRJQJvo0ruZ"
Date: Thu, 14 Sep 2006 13:12:01 +1000
Message-Id: <1158203522.7305.14.camel@localhost.localdomain>
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


--=-Rr29u0llyPRJQJvo0ruZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-09-12 at 10:48 -0700, Judith Lebzelter wrote:
> On Tue, Sep 12, 2006 at 10:21:46AM -0700, Christian wrote:
> > On Fri, 8 Sep 2006, Judith Lebzelter wrote:
> > > I have been doing cross-compiles for ppc and powerpc on my i686 syste=
m.
> > > In order to do this I generate the .config file like this:
> > >
> > > make ARCH=3Dppc defconfig
> > > (or make ARCH=3Dpowerpc defconfig)
> >=20
> > Seems like defconfig has been removed, because there are so many=20
> > sub-platforms for ppc:
>=20
> I build these in OSDL's cross compile build farm (PLM) as a code check.
> Our scripts are generalized to work for various architectures, so it is
> disappointing that 'defconfig' no longer works for ppc the way it does=20
> in other achitectures.  Are there plans to make plain 'defconfig' work=20
> again, at least in the new 'powerpc' directory?  (The 'ppc64_defconfig'=20
> target looks good to me.:)

Perhaps you need to rework the scripts to cope for the fact that there
are different platforms under the architecture? There will never be a
defconfig for powerpc that builds all the code for all platforms, so to
get full test coverage you'll need to build more than one config anyway.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Rr29u0llyPRJQJvo0ruZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFCMiBdSjSd0sB4dIRApHwAKCvxe/k6RDZ8caA4TLG3xoM18pMzACgtabO
1QMuq8q5XjDr0CdiHJqH1XM=
=EbPj
-----END PGP SIGNATURE-----

--=-Rr29u0llyPRJQJvo0ruZ--
