Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 15 Jan 2008 10:21:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/4] powerpc: mv64x60 - Use early_* PCI accessors for
	hotswap reg
Message-Id: <20080115102129.a4666143.sfr@canb.auug.org.au>
In-Reply-To: <20080114225150.GB21940@mag.az.mvista.com>
References: <20080114225150.GB21940@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_Jan_2008_10_21_29_+1100__Hv3yqt+fNmwZY6u"
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_Jan_2008_10_21_29_+1100__Hv3yqt+fNmwZY6u
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, 14 Jan 2008 15:51:50 -0700 "Mark A. Greer" <mgreer@mvista.com> wrot=
e:
>
> +++ b/arch/powerpc/sysdev/mv64x60.h
> @@ -3,10 +3,32 @@
> =20
>  #include <linux/init.h>
> =20
> +#include <asm/prom.h>

You probably meant to include linux/of.h here

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_Jan_2008_10_21_29_+1100__Hv3yqt+fNmwZY6u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHi+58TgG2atn1QN8RAuNjAJ0VlFB02FtD9ovjgqJa+Xg89MSq8gCfSEFT
FGd7uDFqIWKC+WsbuRDH6Z0=
=jNib
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Jan_2008_10_21_29_+1100__Hv3yqt+fNmwZY6u--
