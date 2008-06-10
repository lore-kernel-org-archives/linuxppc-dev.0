Return-Path: <michael@ellerman.id.au>
Subject: Re: [patch 1/5] powerpc: fix for OProfile callgraph for Power 64
	bit user apps
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1213054877.25745.11.camel@pasglop>
References: <200806092326.m59NQ7rM014218@imap1.linux-foundation.org>
	<1213054877.25745.11.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0mmcic4tAoEwBJsxhtx9"
Date: Tue, 10 Jun 2008 10:30:02 +1000
Message-Id: <1213057802.25500.1.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, cel@us.ibm.com,
	paulus@samba.org, carll@us.ibm.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-0mmcic4tAoEwBJsxhtx9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-06-10 at 09:41 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2008-06-09 at 16:26 -0700, akpm@linux-foundation.org wrote:
> > From: Carl Love <cel@us.ibm.com>
> >=20
> > Fix the 64 bit user code backtrace which currently may hang the system.
> >=20
> > Signed-off-by: Carl Love <carll@us.ibm.com>
> > Cc: Maynard Johnson <maynardj@us.ibm.com>
>=20
> That looks weird. I doubt it's the right fix for the problem. Paul,
> I remember this was discussed earlier, did we come up with a proper fix
> already ?

We decided there probably wasn't a bug there at all:

http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056449.html

Haven't heard from Carl if he reproduced the hang and traced it to
something else.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-0mmcic4tAoEwBJsxhtx9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQBITcsKdSjSd0sB4dIRAlXWAJiBVaXz7ibrNWJ6qA4XGjCLDpXaAKDEL0Cc
xJ5uvT8IMot3y8qTYTvuOA==
=8QSD
-----END PGP SIGNATURE-----

--=-0mmcic4tAoEwBJsxhtx9--
