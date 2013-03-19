Return-Path: <dgibson@ozlabs.org>
Date: Tue, 19 Mar 2013 17:31:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: akpm@linux-foundation.org
Subject: Re: [patch 2/2] mm: use vm_unmapped_area() on powerpc architecture
Message-ID: <20130319063155.GW9402@truffula.fritz.box>
References: <20130221230558.C201931C1B7@corp2gmr1-1.hot.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zGa1rFMfQatMxgJk"
In-Reply-To: <20130221230558.C201931C1B7@corp2gmr1-1.hot.corp.google.com>
Cc: walken@google.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--zGa1rFMfQatMxgJk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2013 at 03:05:58PM -0800, akpm@linux-foundation.org wrote:
> From: Michel Lespinasse <walken@google.com>
> Subject: mm: use vm_unmapped_area() on powerpc architecture
>=20
> Update the powerpc slice_get_unmapped_area function to make use of
> vm_unmapped_area() instead of implementing a brute force search.
>=20
> Signed-off-by: Michel Lespinasse <walken@google.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

A little unnecessarily cryptic in places, but the logic looks sound.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zGa1rFMfQatMxgJk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlFIBlsACgkQaILKxv3ab8aGyACgkl786nn4d64eLL0PA1RLuf6v
bzIAn01e7Jj5GEymVRb7wZ+gvTd+Yyp/
=A33D
-----END PGP SIGNATURE-----

--zGa1rFMfQatMxgJk--
