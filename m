Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 160B2DDDCA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 14:19:49 +1000 (EST)
Date: Tue, 18 Sep 2007 14:19:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 09/28] cpm_uart: Be an of_platform device when
	CONFIG_PPC_CPM_NEW_BINDING is set.
Message-Id: <20070918141931.ee234750.sfr@canb.auug.org.au>
In-Reply-To: <20070917165738.GI6563@loki.buserror.net>
References: <20070917165643.GA6545@loki.buserror.net>
	<20070917165738.GI6563@loki.buserror.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__18_Sep_2007_14_19_31_+1000_65_uC6oman+EwgAh"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__18_Sep_2007_14_19_31_+1000_65_uC6oman+EwgAh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Sep 2007 11:57:38 -0500 Scott Wood <scottwood@freescale.com> wro=
te:
>
> +++ b/drivers/serial/cpm_uart/cpm_uart_core.c
> @@ -10,7 +10,7 @@
> +
> +#ifdef CONFIG_PPC_CPM_NEW_BINDING
> +#include <asm/of_platform.h>

linux/of_platform.h

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__18_Sep_2007_14_19_31_+1000_65_uC6oman+EwgAh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG71HbTgG2atn1QN8RAh2PAJ0VPkYmj5jwcSpcgtPaAMjJ5bAfXgCfQyEe
JOCW1AnDHrtxMdFadvfEcrc=
=ySpA
-----END PGP SIGNATURE-----

--Signature=_Tue__18_Sep_2007_14_19_31_+1000_65_uC6oman+EwgAh--
