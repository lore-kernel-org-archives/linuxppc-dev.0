Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id ACEF9DDE08
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 17:57:39 +1000 (EST)
Date: Sat, 14 Jun 2008 17:57:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: hs@denx.de
Subject: Re: [PATCH] [8xx] powerpc: Add support for the MPC852 based mgsuvd
	board from keymile.
Message-Id: <20080614175733.a2036f44.sfr@canb.auug.org.au>
In-Reply-To: <4852D0D0.4030701@denx.de>
References: <20080612152838.GA2756@loki.buserror.net> <4852A09B.100@denx.de>
	<4852977B.8030800@freescale.com> <4852D0D0.4030701@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__14_Jun_2008_17_57_33_+1000_BS2HVVJIV0+zUv7k"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__14_Jun_2008_17_57_33_+1000_BS2HVVJIV0+zUv7k
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Fri, 13 Jun 2008 21:56:00 +0200 Heiko Schocher <hs@denx.de> wrote:
>
> +++ b/arch/powerpc/platforms/8xx/mgsuvd.c
> @@ -0,0 +1,93 @@
> +/* arch/powerpc/platforms/8xx/mgsuvd.c

We have stopped putting file names in files.

> +#include <linux/ioport.h>
> +#include <linux/device.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/processor.h>
> +#include <asm/system.h>
> +#include <asm/cpm1.h>
> +#include <asm/fs_pd.h>

I am petty sure you don't need to include linux/device.h, but you should
include asm/prom.h for the flat device tree accessors.

Also, we don't put a space between a function name and the opening
parenthesis.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__14_Jun_2008_17_57_33_+1000_BS2HVVJIV0+zUv7k
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhTee0ACgkQTgG2atn1QN+ACwCfQszRJoL4ku/0cpfAXMrxmVML
/scAmwU9fLzMoPa6n+cIoll8XUdJOSRb
=KMza
-----END PGP SIGNATURE-----

--Signature=_Sat__14_Jun_2008_17_57_33_+1000_BS2HVVJIV0+zUv7k--
