Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc: Track backing pages allocated by
	vmemmap_populate()
From: Michael Ellerman <michael@ellerman.id.au>
To: Mark Nelson <markn@au1.ibm.com>
In-Reply-To: <201004131416.23941.markn@au1.ibm.com>
References: <201003261812.34095.markn@au1.ibm.com>
	<201004131416.23941.markn@au1.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-hkRqKuV1Hk745mdA79UJ"
Date: Tue, 13 Apr 2010 15:24:17 +1000
Message-ID: <1271136257.13902.9.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-hkRqKuV1Hk745mdA79UJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-04-13 at 14:16 +1000, Mark Nelson wrote:
> We need to keep track of the backing pages that get allocated by
> vmemmap_populate() so that when we use kdump, the dump-capture kernel kno=
ws
> where these pages are.
>=20
> We use a linked list of structures that contain the physical address of t=
he
> backing page and corresponding virtual address to track the backing pages=
.
> We can use an hlist to save space, because we never remove nodes.

What if we remove_memory() ? Or does that not do what I think it does?

cheers




--=-hkRqKuV1Hk745mdA79UJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkvEAAEACgkQdSjSd0sB4dI+IACdF+6oRditt6iDCuZOQcyG0uNF
hx8An3qYn/1w4RZxUHbXC0Yn4irShQRL
=RqW+
-----END PGP SIGNATURE-----

--=-hkRqKuV1Hk745mdA79UJ--
