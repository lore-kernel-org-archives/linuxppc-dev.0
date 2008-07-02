Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] powerpc: Fix building of feature-fixup tests on
	ppc32
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0807011015390.20129@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0807011015390.20129@blarg.am.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-5NsTJ3ybYrCNQqZR80Iy"
Date: Wed, 02 Jul 2008 19:35:02 +1000
Message-Id: <1214991302.7436.7.camel@localhost>
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


--=-5NsTJ3ybYrCNQqZR80Iy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-07-01 at 10:16 -0500, Kumar Gala wrote:
> We need to use PPC_LCMPI otherwise we get compile errors like:
>=20
> arch/powerpc/lib/feature-fixups-test.S: Assembler messages:
> arch/powerpc/lib/feature-fixups-test.S:142: Error: Unrecognized opcode: `=
cmpdi'
> arch/powerpc/lib/feature-fixups-test.S:149: Error: Unrecognized opcode: `=
cmpdi'
> arch/powerpc/lib/feature-fixups-test.S:164: Error: Unrecognized opcode: `=
cmpdi'

Sorry, I definitely built (and booted) a 32-bit config, so I'm not sure
how I missed that. What toolchain are you using?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-5NsTJ3ybYrCNQqZR80Iy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIa0vGdSjSd0sB4dIRAkE6AJwL1OEF+S1d2jJ6kusDcYQgeMyRrACeNdND
getH5++O+n8NGJtMWcKymCE=
=yGVu
-----END PGP SIGNATURE-----

--=-5NsTJ3ybYrCNQqZR80Iy--
