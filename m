Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9195CB718B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 03:06:04 +1000 (EST)
Date: Thu, 19 May 2011 19:05:48 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 0/7] Consolidate sdhci pltfm & OF drivers and get them
	self registered
Message-ID: <20110519170548.GA1075@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<20110519094046.GA2219@pengutronix.de>
	<20110519160901.GC26816@S2100-06.ap.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
In-Reply-To: <20110519160901.GC26816@S2100-06.ap.freescale.net>
Cc: Chris Ball <cjb@laptop.org>, Anton Vorontsov <avorontsov@ru.mvista.com>,
	sameo@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
	patches@linaro.org, devicetree-discuss@lists.ozlabs.org,
	linux-mmc@vger.kernel.org, Saeed Bishara <saeed@marvell.com>,
	Xiaobo Xie <X.Xie@freescale.com>, kernel@pengutronix.de,
	Mike Rapoport <mike@compulab.co.il>, Olof Johansson <olof@lixom.net>,
	Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org,
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


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

> Should I go for v3 right now to address the patch applying problems
> and that ESDHC_IMX build issue, or hold for a while to see if you
> have more comments on v2?

Please wait a little bit more.

> And what is your position on patch #5 which merges esdhc imx and mpc
> support into one?  As Anton has voted a NO there, I would probably
> drop the patch if there is another person has strong opinion to get
> imx and mpc stay separated.

This was the other main issue I spotted so far. I wanted to have another lo=
ok
tomorrow, yet the tendency is that I agree with Anton.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3VTewACgkQD27XaX1/VRvEVQCgoMGHWdXFq4VEDCKT4inZMq7b
/UEAnjZoFTYmmWA06EPFIGVIRqEvbO7A
=MmT8
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
