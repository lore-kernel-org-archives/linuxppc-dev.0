Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 87EF5DDEDC
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 14:11:15 +1000 (EST)
Date: Tue, 12 Jun 2007 14:11:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: arnd@arndb.de
Subject: Re: [patch 04/10] powerpc: rename add_bridge to avoid namespace
	clashes
Message-Id: <20070612141108.7d0277ca.sfr@canb.auug.org.au>
In-Reply-To: <20070611233354.006513064@arndb.de>
References: <20070611232824.489103547@arndb.de>
	<20070611233354.006513064@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_Jun_2007_14_11_08_+1000_8+/yEFX+x4sRE=kb"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__12_Jun_2007_14_11_08_+1000_8+/yEFX+x4sRE=kb
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Jun 2007 01:28:28 +0200 arnd@arndb.de wrote:
>
> Many platforms currently define their own add_bridge function, some
> of them globally. This breaks some multiplatform configurations.
> Prefixing each of these functions with the platform name avoids
> this problem.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Index: linux-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/platforms/82xx/mpc82xx_ads.c
> +++ linux-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c
> @@ -49,7 +49,7 @@
>  #include <linux/fs_enet_pd.h>
> =20
>  #include <sysdev/fsl_soc.h>
> -#include <../sysdev/cpm2_pic.h>
> +#include <../../sysdev/cpm2_pic.h>

This is a separate fix and so should be a separate patch.  You might also
consider putting that include file in include/asm-powerpc...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_Jun_2007_14_11_08_+1000_8+/yEFX+x4sRE=kb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGbhzgFdBgD/zoJvwRAjnZAJ9uQQ/4K0PrejU+Ph1K1A0ib89Z3wCgiQuD
wga5h5TwTTqFLE5S1mPWTQQ=
=atou
-----END PGP SIGNATURE-----

--Signature=_Tue__12_Jun_2007_14_11_08_+1000_8+/yEFX+x4sRE=kb--
