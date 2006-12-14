Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/9] MPIC MSI allocator
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1166058148.11914.255.camel@localhost.localdomain>
References: <1166006370.90082.476088563252.qpush@cradle>
	<20061213104007.4B8F967DA9@ozlabs.org> <20061213122353.7498a25e@pb15>
	<1166052344.11914.233.camel@localhost.localdomain>
	<20061213180921.487b1cea@pb15>
	<1166056373.11914.246.camel@localhost.localdomain>
	<1166057940.6838.25.camel@concordia.ozlabs.ibm.com>
	<1166058148.11914.255.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-XUlViIyXyi+E1Pzf1pWe"
Date: Thu, 14 Dec 2006 12:06:52 +1100
Message-Id: <1166058412.6838.30.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-XUlViIyXyi+E1Pzf1pWe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-12-14 at 12:02 +1100, Benjamin Herrenschmidt wrote:
> > if get_property("msi_available")
> > 	mpic_msi_reserve_dt_irqs()
>=20
> available-msi is a better name now that I think of it, or better even:
> "msi-ranges"

"msi-ranges" is ambiguous, are the ranges available or reserved?

How about "msi-available-ranges" :D

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-XUlViIyXyi+E1Pzf1pWe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFgKOsdSjSd0sB4dIRApHDAKC8uqRS+lGL4oGPg812IrBQOill9wCgtDc3
6eusv9vWyshlD/clgOoU3/I=
=NQu1
-----END PGP SIGNATURE-----

--=-XUlViIyXyi+E1Pzf1pWe--
