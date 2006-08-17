Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Make RTAS console init generic
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20060816194225.C9F1F67B32@ozlabs.org>
References: <20060816194225.C9F1F67B32@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-dBI0YqupxyQaX5F8+Sqi"
Date: Thu, 17 Aug 2006 12:04:27 +1000
Message-Id: <1155780267.6910.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-dBI0YqupxyQaX5F8+Sqi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-16 at 14:42 -0500, Michael Neuling wrote:
> The rtas console doesn't have to be Cell specific.  If we get both
> rtas tokens, we should just enabled the console then and there.
>=20

Seems to work fine on Cell.

> Updated Kconfig so we can enable it. =20

I enable it via the early debugging menu (under kernel hacking), is that
not good enough?

>  arch/powerpc/Kconfig                |    2 +-
>  arch/powerpc/kernel/rtas.c          |    5 +++++
>  arch/powerpc/platforms/cell/setup.c |    4 ----
>  3 files changed, 6 insertions(+), 5 deletions(-)
>=20
> Index: linux-2.6-ozlabs/arch/powerpc/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-ozlabs.orig/arch/powerpc/Kconfig
> +++ linux-2.6-ozlabs/arch/powerpc/Kconfig
> @@ -426,7 +426,7 @@ config PPC_IBM_CELL_BLADE
>  	select UDBG_RTAS_CONSOLE
> =20
>  config UDBG_RTAS_CONSOLE
> -	bool
> +	bool "RTAS based debug console"
>  	default n

This should probably depend on RTAS?

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-dBI0YqupxyQaX5F8+Sqi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE486qdSjSd0sB4dIRAog+AJwIw56I0eQEuVUmdo68Axwcj6IC7ACgzASy
MUiX9ImSwNkQCncvizRbG7A=
=J+sN
-----END PGP SIGNATURE-----

--=-dBI0YqupxyQaX5F8+Sqi--
