Return-Path: <michael@ellerman.id.au>
Subject: RE: [PATCH 2/2] powerpc: Add IPIC MSI support
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Yang <LeoLi@freescale.com>
In-Reply-To: <989B956029373F45A0B8AF029708189001B4D395@zch01exm26.fsl.freescale.net>
References: <1196764760.2573.10.camel@Guyver>
	<989B956029373F45A0B8AF029708189001B4D395@zch01exm26.fsl.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-7p6sTBs2PEkvldmAD3O0"
Date: Tue, 04 Dec 2007 22:59:51 +1100
Message-Id: <1196769591.32524.6.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Gala Kumar <kumar.gala@freescale.com>,
	Phillips Kim <Kim.Phillips@freescale.com>, Li Tony <Tony.Li@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-7p6sTBs2PEkvldmAD3O0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-12-04 at 18:57 +0800, Li Yang wrote:
> > -----Original Message-----
> > From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> > [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> > On Behalf Of Li Tony
> > Sent: Tuesday, December 04, 2007 6:39 PM
> > To: Gala Kumar; Phillips Kim; michael@ellerman.id.au; linuxppc-dev
> > Subject: [PATCH 2/2] powerpc: Add IPIC MSI support
> >=20
> > Modified based on discussion on list.
> >=20
> > 1. Adopt virq_to_hw routine
> > 2. Correct a legacy bug
>=20
> The above lines should probably be placed after the "---" below.
>=20
> >=20
> > Implements the IPIC MSI as two level interrupt controller.
> >=20
> > Signed-off-by: Tony Li <tony.li@freescale.com>

The change log is a bit short in general for my liking.

Still, MSI bits ..

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-7p6sTBs2PEkvldmAD3O0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHVUE3dSjSd0sB4dIRAk67AKCHKB++ixrONhRBP5cT/xbomX1g0wCgxDE+
diqXqEYZUq2GdXoxhk9LVlo=
=rFyx
-----END PGP SIGNATURE-----

--=-7p6sTBs2PEkvldmAD3O0--
