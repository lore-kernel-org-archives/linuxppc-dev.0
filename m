Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B42E3DDF14
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 17:37:40 +1000 (EST)
Date: Sat, 16 Jun 2007 17:37:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: arnd@arndb.de
Subject: Re: [patch 4/9] mpc82xx_ads build fix
Message-Id: <20070616173738.d5a7f707.sfr@canb.auug.org.au>
In-Reply-To: <20070616000618.576806652@arndb.de>
References: <20070616000511.712667424@arndb.de>
	<20070616000618.576806652@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__16_Jun_2007_17_37_38_+1000_TUQ=GVg38ZMnnd30"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__16_Jun_2007_17_37_38_+1000_TUQ=GVg38ZMnnd30
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 16 Jun 2007 02:05:15 +0200 arnd@arndb.de wrote:
>
> needed for 6xx allyesconfig
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> --- linux-2.6.orig/arch/powerpc/platforms/82xx/mpc82xx_ads.c
> +++ linux-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c
> @@ -49,7 +49,7 @@
>  #include <linux/fs_enet_pd.h>
> =20
>  #include <sysdev/fsl_soc.h>
> -#include <../sysdev/cpm2_pic.h>
> +#include <../../sysdev/cpm2_pic.h>

Does the include of <sysdev/fsl_soc.h> work?  If so, then you should use
<sysdev/cpm2_pic.h>. If not, then you have worse problems :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__16_Jun_2007_17_37_38_+1000_TUQ=GVg38ZMnnd30
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGc5NHFdBgD/zoJvwRAsyAAKCUTyI/kULBRBiOUy8pHnv25WIiNwCggId5
oUBP5k6msYoZUGWtasS5CxA=
=m18V
-----END PGP SIGNATURE-----

--Signature=_Sat__16_Jun_2007_17_37_38_+1000_TUQ=GVg38ZMnnd30--
