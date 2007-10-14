Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0FEE7DDE04
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 23:34:08 +1000 (EST)
Date: Sun, 14 Oct 2007 23:33:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH 1/2] clk for mpc52xx: platform part
Message-Id: <20071014233357.189bb0ef.sfr@canb.auug.org.au>
In-Reply-To: <20071014080923.GI3000@nd47.coderock.org>
References: <20071014080813.GH3000@nd47.coderock.org>
	<20071014080923.GI3000@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__14_Oct_2007_23_33_57_+1000_zrjG0HQq.r=iit3P"
Cc: david-b@pacbell.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__14_Oct_2007_23_33_57_+1000_zrjG0HQq.r=iit3P
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 14 Oct 2007 10:09:23 +0200 Domen Puncer <domen.puncer@telargo.com> =
wrote:
>
> +++ linux.git/arch/powerpc/platforms/52xx/mpc52xx_clock.c
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/errno.h>
> +#include <linux/spinlock.h>
> +#include <linux/clk.h>
> +
> +#include <asm/io.h>
> +#include <asm/mpc52xx.h>
> +#include <asm/clk_interface.h>

You should include <linux/of.h> to use struct device_node and its
accessors.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__14_Oct_2007_23_33_57_+1000_zrjG0HQq.r=iit3P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHEhrMTgG2atn1QN8RAisiAJ93W18Q1uHN5446DWiPihHKNVYy/gCfdaf7
O+VZbd7nQ9ALs2cnuCtbrsE=
=YHAl
-----END PGP SIGNATURE-----

--Signature=_Sun__14_Oct_2007_23_33_57_+1000_zrjG0HQq.r=iit3P--
