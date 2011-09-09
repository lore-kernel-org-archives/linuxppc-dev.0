Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5A6DB6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Sep 2011 21:40:12 +1000 (EST)
Date: Fri, 9 Sep 2011 13:40:04 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
Message-ID: <20110909114004.GP1912@pengutronix.de>
References: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FbmEh7Ek6NM6xKh/"
In-Reply-To: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
Cc: Xu lei <B33228@freescale.com>, linux-mmc@vger.kernel.org,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--FbmEh7Ek6NM6xKh/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 09, 2011 at 08:05:46PM +0800, Roy Zang wrote:
> From: Xu lei <B33228@freescale.com>
>=20
> Freescale eSDHC registers only support 32-bit accesses,
> this patch ensures that all Freescale eSDHC register accesses
> are 32-bit.

So, what about the byte-swapping that Anton needed? You are simply
removing that if I am not mistaken.

> Signed-off-by: Xu lei <B33228@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> This is a patch resend=20
> http://patchwork.ozlabs.org/patch/106245/
> based on latest Linus tree.
>=20
> Andrew,
> Could you help to  pick up this patch first?

mmc-list is not dead, it must go via Chris, I'd think.

>  drivers/mmc/host/sdhci-of-esdhc.c |   18 ++++++++++++++----
>  1 files changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-o=
f-esdhc.c
> index fe604df..40036f6 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1,7 +1,7 @@
>  /*
>   * Freescale eSDHC controller driver.
>   *
> - * Copyright (c) 2007 Freescale Semiconductor, Inc.
> + * Copyright (c) 2007, 2010 Freescale Semiconductor, Inc.

I wonder if such a small change has impact on the copyright.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--FbmEh7Ek6NM6xKh/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5p+xQACgkQD27XaX1/VRskiACgtMP5UJy63XHoK+vZ8T8sNASN
hoUAoLQ5133aWMt+u5wfXo42XLwSN8sW
=ssB4
-----END PGP SIGNATURE-----

--FbmEh7Ek6NM6xKh/--
