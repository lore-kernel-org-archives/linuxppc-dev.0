Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Introduce MMU features v2
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20081209064732.D1904DDF15@ozlabs.org>
References: <20081209064732.D1904DDF15@ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-laTq2txV79DfXAsFon0a"
Date: Tue, 09 Dec 2008 17:54:56 +1100
Message-Id: <1228805696.17726.24.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-laTq2txV79DfXAsFon0a
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-12-09 at 17:46 +1100, Benjamin Herrenschmidt wrote:
> We're soon running out of CPU features and I need to add some new
> ones for various MMU related bits, so this patch separates the MMU
> features from the CPU features. I moved over the 32-bit MMU related
> ones, added base features for MMU type families, but didn't move
> over any 64-bit only feature yet.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>=20
> Remove a spurrious character that broke 64-bit build
>=20
>  arch/powerpc/include/asm/cputable.h       |   85 +++++++++-------------
>  arch/powerpc/include/asm/feature-fixups.h |   30 +++++++

You forgot to add tests of the feature fixup macros :)

See the bottom of arch/powerpc/lib/feature-fixup-test.S, it should only
require two lines.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-laTq2txV79DfXAsFon0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk+FkAACgkQdSjSd0sB4dK8RQCfcwVCT/sfyFt2aZf9JTO16PPH
+7gAn2ni6NCp+nrq9+d0AmAv4wganV+y
=Jo2n
-----END PGP SIGNATURE-----

--=-laTq2txV79DfXAsFon0a--
