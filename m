Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc: setup_64 comment cleanup.
From: Michael Ellerman <michael@ellerman.id.au>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070906174729.GC21800@austin.ibm.com>
References: <20070906174416.GW4584@austin.ibm.com>
	<20070906174521.GA21800@austin.ibm.com>
	<20070906174615.GB21800@austin.ibm.com>
	<20070906174729.GC21800@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pSLFax1i0nqDSw1BsDFA"
Date: Fri, 07 Sep 2007 09:54:18 +1000
Message-Id: <1189122858.12962.10.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-pSLFax1i0nqDSw1BsDFA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-09-06 at 12:47 -0500, Linas Vepstas wrote:
> Gramatical corrections to comments.
>=20
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
>=20
> ----
>=20
>  arch/powerpc/kernel/prom.c     |    8 +++++---
>  arch/powerpc/kernel/setup_64.c |    6 +++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> Index: linux-2.6.22-git2/arch/powerpc/kernel/setup_64.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22-git2.orig/arch/powerpc/kernel/setup_64.c	2007-09-04 17:2=
9:36.000000000 -0500
> +++ linux-2.6.22-git2/arch/powerpc/kernel/setup_64.c	2007-09-05 14:12:23.=
000000000 -0500
> @@ -181,9 +181,9 @@ void __init early_setup(unsigned long dt
>   	DBG(" -> early_setup(), dt_ptr: 0x%lx\n", dt_ptr);
> =20
>  	/*
> -	 * Do early initializations using the flattened device
> -	 * tree, like retreiving the physical memory map or
> -	 * calculating/retreiving the hash table size
> +	 * Do early initialization using the flattened device
> +	 * tree, such as retrieving the physical memory map or
> +	 * calculating/retrieving the hash table size.
>  	 */
>  	early_init_devtree(__va(dt_ptr));

That's a little pedantic ..

> Index: linux-2.6.22-git2/arch/powerpc/kernel/prom.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22-git2.orig/arch/powerpc/kernel/prom.c	2007-09-05 14:23:06=
.000000000 -0500
> +++ linux-2.6.22-git2/arch/powerpc/kernel/prom.c	2007-09-05 14:24:49.0000=
00000 -0500
> @@ -433,9 +433,11 @@ static int __init early_parse_mem(char *
>  }
>  early_param("mem", early_parse_mem);
> =20
> -/*
> - * The device tree may be allocated below our memory limit, or inside th=
e
> - * crash kernel region for kdump. If so, move it out now.
> +/**
> + * move_device_tree - move tree to an unused area, if needed.
> + *
> + * The device tree may be allocated beyond our memory limit, or inside t=
he
> + * crash kernel region for kdump. If so, move it out of the way.
>   */
>  static void move_device_tree(void)

.. but that looks good. Although it's a semantic change, not just
grammatical as your changelog says.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-pSLFax1i0nqDSw1BsDFA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4JMqdSjSd0sB4dIRAlGdAJ0ZXjwsyWW3i+zHfYdCumzzYfF9vwCgqD0b
fZJyDlnue5b9wVT9cni+umI=
=V+iD
-----END PGP SIGNATURE-----

--=-pSLFax1i0nqDSw1BsDFA--
