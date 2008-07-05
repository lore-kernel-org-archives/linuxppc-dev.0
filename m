Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [patch 11/11] powerpc/cell: Add
	DMA_ATTR_STRONG_ORDERING dma attribute and use in IOMMU code
From: Michael Ellerman <michael@ellerman.id.au>
To: arnd@arndb.de
In-Reply-To: <20080704190806.964824190@arndb.de>
References: <20080704190535.316377278@arndb.de>
	<20080704190806.964824190@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-fHzaPPedJRJzdagYu5Wz"
Date: Sat, 05 Jul 2008 15:43:04 +1000
Message-Id: <1215236584.7424.2.camel@localhost>
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


--=-fHzaPPedJRJzdagYu5Wz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-07-04 at 21:05 +0200, arnd@arndb.de wrote:

> Introduce a new dma attriblue DMA_ATTR_STRONG_ORDERING to use strong orde=
ring
> on DMA mappings in the Cell processor. Add the code to the Cell's IOMMU
> implementation to use this.
>=20
> The current Cell IOMMU implementation sets the IOPTE_SO_RW bits in all IO=
TPEs
> (for both the dynamic and fixed mappings) which enforces strong ordering =
of
> both reads and writes. This patch makes the default behaviour weak orderi=
ng
> (the IOPTE_SO_RW bits not set) and to request a strongly ordered mapping =
the
> new DMA_ATTR_STRONG_ORDERING needs to be used.

We're sure that's safe?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-fHzaPPedJRJzdagYu5Wz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIbwnodSjSd0sB4dIRAr2tAKCEjlkiElxq1q+DE5zJN9bo46dnrACgzNIb
ZFzW9/ckW7Ol0WplrShaywg=
=8qzd
-----END PGP SIGNATURE-----

--=-fHzaPPedJRJzdagYu5Wz--
