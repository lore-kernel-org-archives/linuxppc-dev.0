Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix build of 4xx simple platforms without
	CONFIG_PCI
From: Michael Ellerman <michael@ellerman.id.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081210092508.66e566f8@zod.rchland.ibm.com>
References: <20081208045411.0CE03DDE0E@ozlabs.org>
	<1228714329.23242.52.camel@localhost>
	<1228714694.7101.27.camel@pasglop>
	<20081210092508.66e566f8@zod.rchland.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ow0MNiHFZxPafNaWs1j4"
Date: Thu, 11 Dec 2008 08:59:45 +1100
Message-Id: <1228946385.8245.0.camel@localhost>
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


--=-ow0MNiHFZxPafNaWs1j4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-12-10 at 09:25 -0500, Josh Boyer wrote:
> On Mon, 08 Dec 2008 16:38:14 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > > --- linux-work.orig/arch/powerpc/platforms/40x/ppc40x_simple.c	2008=
-12-08 15:51:49.000000000 +1100
> > > > +++ linux-work/arch/powerpc/platforms/40x/ppc40x_simple.c	2008-12-0=
8 15:51:52.000000000 +1100
> > > > @@ -61,7 +61,9 @@ static int __init ppc40x_probe(void)
> > > > =20
> > > >  	for (i =3D 0; i < ARRAY_SIZE(board); i++) {
> > > >  		if (of_flat_dt_is_compatible(root, board[i])) {
> > > > +#ifdef CONFIG_PCI
> > > >  			ppc_pci_flags =3D PPC_PCI_REASSIGN_ALL_RSRC;
> > > > +#endif
> > >=20
> > > No! #ifdefs! in C code!
> > >=20
> > > To the tune of you-know-what.
> > >=20
> > > Looks like we need an accessor we can replace with an empty version i=
n
> > > the !PCI case.
> >=20
> > If you have plenty of time on your hands :-) In the meantime, this is a
> > build fix.
>=20
> I have time.  I hate ifdefs.

You are awesome.

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ow0MNiHFZxPafNaWs1j4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklAO9AACgkQdSjSd0sB4dIzJQCgojxvNFHVbZ80NpMYEt3mHO+T
sU4AoMjhqpkyHNjo6WrZ4b917mSMWplw
=Bhj3
-----END PGP SIGNATURE-----

--=-ow0MNiHFZxPafNaWs1j4--
