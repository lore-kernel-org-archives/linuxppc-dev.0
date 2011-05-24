Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2573BB6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 05:41:03 +1000 (EST)
Date: Tue, 24 May 2011 21:40:54 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and
	sdhci-esdhc-imx
Message-ID: <20110524194054.GC25727@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
In-Reply-To: <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, sameo@linux.intel.com,
	Arnd Bergmann <arnd@arndb.de>, patches@linaro.org,
	devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org,
	Saeed Bishara <saeed@marvell.com>,
	Xiaobo Xie <X.Xie@freescale.com>, kernel@pengutronix.de,
	Mike Rapoport <mike@compulab.co.il>, Olof Johansson <olof@lixom.net>,
	Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2011 at 09:22:56PM +0800, Shawn Guo wrote:
> This patch is to consolidate SDHCI driver for Freescale eSDHC
> controller found on both MPCxxx and i.MX platforms.  It merges
> sdhci-of-esdhc.c into sdhci-esdhc.c, so that the same pair of
> .probe/.remove hook works with eSDHC for two platforms.
>=20
> As the results, sdhci-of-esdhc.c and sdhci-esdhc.h are removed, and
> header esdhc.h containing the definition of esdhc_platform_data is
> put into the public folder.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

I agree with Anton about not merging the two...

> +#ifndef CONFIG_MMC_SDHCI_ESDHC_IMX
> +#define cpu_is_mx25()	(0)
> +#define cpu_is_mx35()	(0)
> +#define cpu_is_mx51()	(0)
> +#define cpu_is_imx()	(0)
> +#else
> +#define cpu_is_imx()	(1)
> +#endif

=2E.. e.g. that looks a bit frightening.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3cCcYACgkQD27XaX1/VRtUwQCgoIV85fwgIwLJrNnpZcKcpuon
2t8AnAurv1dsjn89lmIF70htQOUZ02xt
=L9v8
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
