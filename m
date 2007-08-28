Return-Path: <michael@ellerman.id.au>
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id CB9B1DDE28
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 18:50:42 +1000 (EST)
Subject: Re: [PATCH 1/5] Add an optional device_node pointer to the irq_host
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <460e86e8b5a08c23dcbedb5d4bd484a519246dd3.1188290811.git.michael@ellerman.id.au>
References: <460e86e8b5a08c23dcbedb5d4bd484a519246dd3.1188290811.git.michael@ellerman.id.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-lWtIXoBPNKMHYFx4+cSA"
Date: Tue, 28 Aug 2007 18:50:41 +1000
Message-Id: <1188291041.10161.7.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-lWtIXoBPNKMHYFx4+cSA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-08-28 at 18:47 +1000, Michael Ellerman wrote:
> The majority of irq_host implementations (3 out of 4) are associated
> with a device_node, and need to stash it somewhere. Rather than having
> it somewhere different for each host, add an optional device_node pointer
> to the irq_host structure.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

This series is basically unchanged since I last sent it, but applies
cleanly now onto the powerpc-for-2.6.24 branch.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-lWtIXoBPNKMHYFx4+cSA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG0+HhdSjSd0sB4dIRArQ9AKCj9YsiKrUFt30COrKylaIB5BqsBwCgr1hU
sefztok2d9AqT1z/EEzLuhw=
=5421
-----END PGP SIGNATURE-----

--=-lWtIXoBPNKMHYFx4+cSA--
