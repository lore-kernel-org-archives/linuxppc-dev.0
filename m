Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A5A1FDDE9C
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 10:08:55 +1000 (EST)
Date: Fri, 21 Sep 2007 10:08:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 6/9] fs_enet: Be an of_platform device when
	CONFIG_PPC_CPM_NEW_BINDING is set.
Message-Id: <20070921100841.6904f2bc.sfr@canb.auug.org.au>
In-Reply-To: <20070920220121.GF28784@loki.buserror.net>
References: <20070920220043.GA28769@loki.buserror.net>
	<20070920220121.GF28784@loki.buserror.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__21_Sep_2007_10_08_41_+1000_qdnM2RilxVeJnVaw"
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__21_Sep_2007_10_08_41_+1000_qdnM2RilxVeJnVaw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Sep 2007 17:01:21 -0500 Scott Wood <scottwood@freescale.com> wro=
te:
>
> +++ b/drivers/net/fs_enet/fs_enet-main.c
> @@ -44,12 +44,18 @@
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>
> =20
> +#ifdef CONFIG_PPC_CPM_NEW_BINDING
> +#include <asm/of_platform.h>

Hmm, didn't I already ask you to change this to linux/of_platform.h?

> +++ b/drivers/net/fs_enet/mac-fcc.c
> @@ -42,6 +42,10 @@
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>
> =20
> +#ifdef CONFIG_PPC_CPM_NEW_BINDING
> +#include <asm/of_device.h>

And this to linux/of_device.h

> +++ b/drivers/net/fs_enet/mac-fec.c
> @@ -43,6 +43,10 @@
>  #include <asm/commproc.h>
>  #endif
> =20
> +#ifdef CONFIG_PPC_CPM_NEW_BINDING
> +#include <asm/of_device.h>

And this?

> +++ b/drivers/net/fs_enet/mac-scc.c
> @@ -43,6 +43,10 @@
>  #include <asm/commproc.h>
>  #endif
> =20
> +#ifdef CONFIG_PPC_CPM_NEW_BINDING
> +#include <asm/of_platform.h>

And this

> +++ b/drivers/net/fs_enet/mii-fec.c
> @@ -36,6 +36,10 @@
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>
> =20
> +#ifdef CONFIG_PPC_CPM_NEW_BINDING
> +#include <asm/of_platform.h>

And here

Sorry if I missed these last time around.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__21_Sep_2007_10_08_41_+1000_qdnM2RilxVeJnVaw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG8wuNTgG2atn1QN8RArnKAKCA8grKB7mEO/yuRuI/Gk66ZZJ6tQCgipUD
ocag1rXWzL6kFe+1ZzSuDJI=
=Z3BX
-----END PGP SIGNATURE-----

--Signature=_Fri__21_Sep_2007_10_08_41_+1000_qdnM2RilxVeJnVaw--
