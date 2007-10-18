Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
From: Michael Ellerman <michael@ellerman.id.au>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20071017.042345.108116673.davem@davemloft.net>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
	<20071017.042229.95059231.davem@davemloft.net>
	<20071017.042345.108116673.davem@davemloft.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-leJjvchPFQ20mvu3NS+T"
Date: Thu, 18 Oct 2007 11:23:02 +1000
Message-Id: <1192670582.6681.4.camel@concordia>
Mime-Version: 1.0
Cc: sparclinux@vger.kernel.org, sfr@canb.auug.org.au, paulus@samba.org,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-leJjvchPFQ20mvu3NS+T
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-17 at 04:23 -0700, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Wed, 17 Oct 2007 04:22:29 -0700 (PDT)
>=20
> > From: Michael Ellerman <michael@ellerman.id.au>
> > Date: Wed, 17 Oct 2007 17:12:27 +1000 (EST)
> >=20
> > > Use of_get_pci_dev_node() in axon_msi.c. Switch to including <linux/o=
f.h>
> > > so we get the prototype.
> > >=20
> > > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> >=20
> > I find it ironic that you add of_get_pci_dev_node() as a function
> > which gets the node and grabs a reference to it, and then the very
> > first usage you make of it doesn't drop the reference at all.
>=20
> Ignore this poor attempt at humor, I misread your patch :)

Well it _would_ have been funny :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-leJjvchPFQ20mvu3NS+T
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHFrV2dSjSd0sB4dIRAgArAJ9dxVCUS29HMFxHOcNB1kvpL2BODwCfftBA
4fYb6jPYvw+LdFg8j7n9XK0=
=uHPQ
-----END PGP SIGNATURE-----

--=-leJjvchPFQ20mvu3NS+T--
