Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17679.25131.721027.405431@cargo.ozlabs.ibm.com>
References: <17679.25131.721027.405431@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vwt+QNli0fJZaYFFdZKO"
Date: Tue, 19 Sep 2006 14:22:20 +1000
Message-Id: <1158639740.32015.114.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-vwt+QNli0fJZaYFFdZKO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-09-19 at 13:21 +1000, Paul Mackerras wrote:
> This is a reworked version of Mark's patches 1/6 and 2/6.  This boots
> on powermac (newworld) and pseries (power5 partition) at least.
>=20
> --- /dev/null	2006-09-18 11:33:23.687982711 +1000
> +++ arch/powerpc/boot/of.c	2006-09-18 17:35:59.000000000 +1000
> @@ -0,0 +1,283 @@
> +/*
> + * Copyright (C) Paul Mackerras 1997.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#include <stdarg.h>
> +#include <stddef.h>
> +#include "types.h"
> +#include "elf.h"
> +#include "string.h"
> +#include "stdio.h"
> +#include "page.h"
> +#include "ops.h"

Where do I get ops.h?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-vwt+QNli0fJZaYFFdZKO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFD3B7dSjSd0sB4dIRAnD2AKCzUJzBrqiXyM9/q8bhJgHG/K83cwCfcISu
+xbLOJb0ZtoNWIP4fyezzsM=
=tVA2
-----END PGP SIGNATURE-----

--=-vwt+QNli0fJZaYFFdZKO--
