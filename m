Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 76C19DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 11:18:24 +1000 (EST)
Date: Thu, 1 May 2008 11:18:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] [POWERPC] devres: Add devm_ioremap_flags()
Message-Id: <20080501111817.e0d19258.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0804301106010.22992@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0804301106010.22992@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__1_May_2008_11_18_17_+1000_I.KODudsyXwzfRnh"
Cc: Andrew Morton <akpm@osdl.org>, htejun@gmail.com,
	Jeff Garzik <jeff@garzik.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, Emilian.Medve@Freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__1_May_2008_11_18_17_+1000_I.KODudsyXwzfRnh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Apr 2008 11:08:51 -0500 (CDT) Kumar Gala <galak@kernel.crashing.=
org> wrote:
>
> +++ b/arch/powerpc/lib/devres.c
> @@ -0,0 +1,33 @@
> +#include <linux/device.h>	/* devres_*(), devm_ioremap_release() */
> +#include <linux/io.h>		/* ioremap_flags() */
> +#include <linux/module.h>	/* EXPORT_SYMBOL() */

This file needs a copyright notice and license ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__1_May_2008_11_18_17_+1000_I.KODudsyXwzfRnh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIGRpdTgG2atn1QN8RAljoAJsEEhyCmz92exTYDTqpFy4aSQG69gCfWHnS
kCHJIEd0ARTyFnzKIcTMV2A=
=MxSH
-----END PGP SIGNATURE-----

--Signature=_Thu__1_May_2008_11_18_17_+1000_I.KODudsyXwzfRnh--
