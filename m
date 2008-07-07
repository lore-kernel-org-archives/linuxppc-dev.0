Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [patch 11/11] powerpc/cell: Add
	DMA_ATTR_STRONG_ORDERING dma attribute and use in IOMMU code
From: Michael Ellerman <michael@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200807052351.39945.arnd@arndb.de>
References: <20080704190535.316377278@arndb.de>
	<1215236584.7424.2.camel@localhost> <1215239339.8970.10.camel@pasglop>
	<200807052351.39945.arnd@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HXvEnvS3kx4K+ZTK1fC5"
Date: Mon, 07 Jul 2008 10:00:51 +1000
Message-Id: <1215388851.19157.0.camel@localhost>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-HXvEnvS3kx4K+ZTK1fC5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-07-05 at 23:51 +0200, Arnd Bergmann wrote:
> On Saturday 05 July 2008, Benjamin Herrenschmidt wrote:
> > On Sat, 2008-07-05 at 15:43 +1000, Michael Ellerman wrote:
> > > > The current Cell IOMMU implementation sets the IOPTE_SO_RW bits in =
all IOTPEs
> > > > (for both the dynamic and fixed mappings) which enforces strong ord=
ering of
> > > > both reads and writes. This patch makes the default behaviour weak =
ordering
> > > > (the IOPTE_SO_RW bits not set) and to request a strongly ordered ma=
pping the
> > > > new DMA_ATTR_STRONG_ORDERING needs to be used.
> > >=20
> > > We're sure that's safe?
> >=20
> > I'd say it's not...
>=20
> It turned out that the firmware sets up the south bridge to never set the=
 'S'
> bit on incoming transactions, which overrides the IOPTE_SO_RW bits, on al=
l
> existing cell hardware.

It seems strange to me that the southbridge is allowed to override the
setting in the IOMMU page table, but if that's what the doc says ..

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-HXvEnvS3kx4K+ZTK1fC5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIcVyzdSjSd0sB4dIRAgbpAJ9YW8tckK8yuXsm7O+vNJBA6u58RgCgoS/1
CzGfOtr7XrHWXaUeggbiCw0=
=oYgw
-----END PGP SIGNATURE-----

--=-HXvEnvS3kx4K+ZTK1fC5--
