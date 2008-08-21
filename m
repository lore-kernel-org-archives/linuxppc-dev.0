Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 419D4DE5EB
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 18:52:13 +1000 (EST)
Date: Thu, 21 Aug 2008 18:52:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Markus Brunner <super.firetwister@googlemail.com>
Subject: Re: [PATCH] add a simple 405EP based board
Message-Id: <20080821185202.24cb6810.sfr@canb.auug.org.au>
In-Reply-To: <200808211007.59965.super.firetwister@gmail.com>
References: <200808211007.59965.super.firetwister@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__21_Aug_2008_18_52_02_+1000_TkI3muAWrinLI6KG"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__21_Aug_2008_18_52_02_+1000_TkI3muAWrinLI6KG
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Markus,

One small nit:

On Thu, 21 Aug 2008 10:07:58 +0200 Markus Brunner <super.firetwister@google=
mail.com> wrote:
>
> +#include <linux/init.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/machdep.h>
> +#include <asm/ppc4xx.h>
> +#include <asm/time.h>
> +#include <asm/udbg.h>
> +#include <asm/uic.h>
> +
> +static int __init ppc405ep_probe(void)
> +{
> +	unsigned long root =3D of_get_flat_dt_root();
> +	if (!of_flat_dt_is_compatible(root, "company,ppc405ep"))

You need to include <asm/prom.h> to use the of_flat ... routines.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__21_Aug_2008_18_52_02_+1000_TkI3muAWrinLI6KG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkitLLIACgkQjjKRsyhoI8w/aQCfVeKVxbb8D5koBZXEC0N2YSyl
31IAn3Jdmhez0wSkgjkjrvfeyhgS9j6z
=glcZ
-----END PGP SIGNATURE-----

--Signature=_Thu__21_Aug_2008_18_52_02_+1000_TkI3muAWrinLI6KG--
