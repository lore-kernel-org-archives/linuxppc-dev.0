Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 73145DDF97
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 14:11:52 +1100 (EST)
Date: Wed, 31 Oct 2007 14:11:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 3/4] PowerPC: 440GRx Rainier board support.
Message-Id: <20071031141149.a1c85909.sfr@canb.auug.org.au>
In-Reply-To: <20071030165739.GA22126@ru.mvista.com>
References: <20071030164511.GA21973@ru.mvista.com>
	<20071030165739.GA22126@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__31_Oct_2007_14_11_49_+1100__boP+ZQYYT.j=xal"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__31_Oct_2007_14_11_49_+1100__boP+ZQYYT.j=xal
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Oct 2007 19:57:39 +0300 Valentine Barshak <vbarshak@ru.mvista.co=
m> wrote:
>
> +++ linux-2.6/arch/powerpc/platforms/44x/rainier.c	2007-10-30 18:00:15.00=
0000000 +0300
> +#include <linux/init.h>
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/time.h>
> +#include <asm/uic.h>
> +#include <asm/of_platform.h>

You want <linux/of_platform.h>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__31_Oct_2007_14_11_49_+1100__boP+ZQYYT.j=xal
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHJ/J5TgG2atn1QN8RAiKCAJ9KTE5Wc+lZDr8El3kVg0UsdXfCfwCdGR8y
XqJo2N2D0h/T+GFT1x4PfGg=
=dpwF
-----END PGP SIGNATURE-----

--Signature=_Wed__31_Oct_2007_14_11_49_+1100__boP+ZQYYT.j=xal--
