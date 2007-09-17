Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8E152DDE40
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 23:28:25 +1000 (EST)
Date: Mon, 17 Sep 2007 23:28:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 1/3] usb: add device-tree-aware ehci driver
Message-Id: <20070917232809.1221acd9.sfr@canb.auug.org.au>
In-Reply-To: <20070917125543.GA29584@ru.mvista.com>
References: <20070917125039.GA29525@ru.mvista.com>
	<20070917125543.GA29584@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__17_Sep_2007_23_28_09_+1000_1Ag5rbq1JwRN.J4J"
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__17_Sep_2007_23_28_09_+1000_1Ag5rbq1JwRN.J4J
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Sep 2007 16:55:43 +0400 Valentine Barshak <vbarshak@ru.mvista.co=
m> wrote:
>
> +++ linux-2.6/drivers/usb/host/ehci-ppc-of.c	2007-09-15 16:12:56.00000000=
0 +0400
> @@ -0,0 +1,220 @@
> +
> +#include <asm/of_platform.h>
> +#include <asm/prom.h>

Please use linux/of.h and linux/of_platform.h instead.

> +static int ehci_hcd_ppc_of_shutdown(struct of_device *op)
> +{
> +	struct usb_hcd *hcd =3D dev_get_drvdata(&op->dev);
> +
> +        if (hcd->driver->shutdown)
> +                hcd->driver->shutdown(hcd);

White space has gone a bit funny here.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__17_Sep_2007_23_28_09_+1000_1Ag5rbq1JwRN.J4J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG7oDvTgG2atn1QN8RApaKAJ47RbbeuOOUCV69XO2bBim57IxSbgCdGOev
2fn4PUtcb/fQ70qARu4nVIA=
=M5hv
-----END PGP SIGNATURE-----

--Signature=_Mon__17_Sep_2007_23_28_09_+1000_1Ag5rbq1JwRN.J4J--
