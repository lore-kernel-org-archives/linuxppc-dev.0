Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E6DF9DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 13:34:27 +1100 (EST)
Date: Wed, 7 Nov 2007 13:34:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH v3 04/13] [POWERPC] Add generic support for simple
	MPC5200 based boards
Message-Id: <20071107133426.63593b98.sfr@canb.auug.org.au>
In-Reply-To: <20071106200520.10913.47002.stgit@hekate.izotz.org>
References: <20071106200446.10913.29338.stgit@hekate.izotz.org>
	<20071106200520.10913.47002.stgit@hekate.izotz.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__7_Nov_2007_13_34_26_+1100_H7/kusSwv=esmC0Z"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__7_Nov_2007_13_34_26_+1100_H7/kusSwv=esmC0Z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marian,

On Tue, 06 Nov 2007 21:05:20 +0100 Marian Balakowicz <m8@semihalf.com> wrot=
e:
>
> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
> +
> +#include <linux/pci.h>
> +#include <linux/of.h>
> +#include <asm/time.h>
> +#include <asm/io.h>

Its not clear to me that you need any of the above four includes.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__7_Nov_2007_13_34_26_+1100_H7/kusSwv=esmC0Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHMSQ3TgG2atn1QN8RAnQBAJwPD8Tm0xvCN/RHp7c1Wm3pRapBzACfUBSq
1JJ9gVwgU8aTk2G9zytMgcc=
=Sr1p
-----END PGP SIGNATURE-----

--Signature=_Wed__7_Nov_2007_13_34_26_+1100_H7/kusSwv=esmC0Z--
