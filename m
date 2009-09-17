Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id F00A5B7334
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 00:31:56 +1000 (EST)
Date: Thu, 17 Sep 2009 16:13:31 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Dragos Carp <dragos.carp@toptica.com>
Subject: Re: [spi-devel-general] [PATCH] mpc52xx_psc_spi: enlarge clock range
Message-ID: <20090917141331.GA3169@pengutronix.de>
References: <20090916204853.GA21627@pengutronix.de>
	<4AB241FA.9090604@toptica.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
In-Reply-To: <4AB241FA.9090604@toptica.com>
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I wasn't aware that MPC5200 differ from MPC5200B in this regard. I also
> couldn't find any MPC5200 user manual on Freescale's webpage.

Hmm, it was the first hit using a web search engine :)

http://www.freescale.com/files/microcontrollers/doc/user_guide/MPC5200UM.pd=
f?WT_TYPE=3DUsers%20Guides&WT_VENDOR=3DFREESCALE&WT_FILE_FORMAT=3Dpdf&WT_AS=
SET=3DDocumentation

> Is there a #define that I can use to distinguish between the two
> processor variants? Querying the PVR register is not a nice solution

I think you should have two different functions for calculation, one for 52=
00
and one for 5200B. During init query the device tree for 'fsl,mpc5200-psc-s=
pi'
or 'fsl,mpc5200b-psc-spi' and make the driver use the proper function.

(BTW I haven't checked for further differences between 5200 and 5200B; there
may be more)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqyRAsACgkQD27XaX1/VRuQnQCfbNK9MQn+0fWdhbq83XGhswFI
O4EAn34mzpcWELuI6+JEI8AOTJTe0W7q
=/3uW
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
