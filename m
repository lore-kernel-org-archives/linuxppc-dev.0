Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 993BAB6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 19:41:02 +1000 (EST)
Date: Thu, 19 May 2011 11:40:46 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 0/7] Consolidate sdhci pltfm & OF drivers and get
	them self registered
Message-ID: <20110519094046.GA2219@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
In-Reply-To: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
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


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

> Changes since v1:
>  * Rebase on cjb's mmc-next tree

Is it maybe possible that you get access to
http://opensource.freescale.com/git or another machine? A branch to pull
=66rom would be more convenient, because the series does not apply to
mmc-next anymore, so an extra step to go "back in time" is needed.

(minor) When applying I got:

Applying: mmc: sdhci: make sdhci-pltfm device drivers self registered
/home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:384: trailing whitespace.
/home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:817: space before tab in=
 indent.
 	struct tegra_sdhci_platform_data *plat;
/home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:867: trailing whitespace.

Applying: sdhci: rename sdhci-esdhc-imx.c to sdhci-esdhc.c
/home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:780: trailing whitespace.

See later comments for further issues.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3U5Z4ACgkQD27XaX1/VRvTrACfeBXJzoQO911nMrx10wtlkXDw
p1EAmwYXFQH6XMdjXZLuJRLA5pDE3h9o
=tg5z
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
