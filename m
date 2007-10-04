Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C1B7ADDDFC
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 13:41:35 +1000 (EST)
Date: Thu, 4 Oct 2007 13:41:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jon Loeliger <jdl@freescale.com>, Xianghua Xiao <x.xiao@freescale.com>
Subject: Re: [PATCH 2/5] Add initial MPC8610 HPCD Platform files.
Message-Id: <20071004134115.cc099dd1.sfr@canb.auug.org.au>
In-Reply-To: <1191442173.21463.77.camel@ld0161-tx32>
References: <1191442173.21463.77.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__4_Oct_2007_13_41_15_+1000_4gD.RAZUTqaDp6k6"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__4_Oct_2007_13_41_15_+1000_4gD.RAZUTqaDp6k6
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 03 Oct 2007 15:09:33 -0500 Jon Loeliger <jdl@freescale.com> wrote:
>
> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/kdev_t.h>
> +#include <linux/delay.h>
> +#include <linux/seq_file.h>
> +
> +#include <asm/system.h>
> +#include <asm/time.h>
> +#include <asm/machdep.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/mpc86xx.h>
> +#include <asm/prom.h>

You should include linux/of.h as well to use the of_ accessor functions.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__4_Oct_2007_13_41_15_+1000_4gD.RAZUTqaDp6k6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHBGDgTgG2atn1QN8RAgwFAJ0RiNI6zR2wyO/zmAw7irXONHVmuwCfYWsL
yVL6S39mWoRVsi1Cay3FyG4=
=XRpz
-----END PGP SIGNATURE-----

--Signature=_Thu__4_Oct_2007_13_41_15_+1000_4gD.RAZUTqaDp6k6--
