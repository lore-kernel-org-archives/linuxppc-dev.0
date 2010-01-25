Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3D061007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Jan 2010 23:02:13 +1100 (EST)
Date: Mon, 25 Jan 2010 13:02:09 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 0/3] i2c-mpc: add support for the Freescale MPC512x and
	other fixes
Message-ID: <20100125120209.GC5257@pengutronix.de>
References: <1264408029-5290-1-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
In-Reply-To: <1264408029-5290-1-git-send-email-wg@grandegger.com>
Cc: Devicetree-discuss@lists.ozlabs.org, Linuxppc-dev@lists.ozlabs.org,
	Linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2010 at 09:27:06AM +0100, Wolfgang Grandegger wrote:

> This patch series adds support for the MPC512x from Freescale to the
> i2c-mpc driver. At that occasion, issues with  __devinit[data] have
> been fixed and the doc of the FSL I2C dts bindings updated. It has
> been tested on a MPC5121ADS, TQM5200 and TQM8560 board

Nice :) BTW, is there a git-tree meanwhile for your or Anatolij's
MPC5121-development?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktdiEEACgkQD27XaX1/VRswCACeIagD9gPY5IAZqq6EwELDc8Ic
7GMAn2RkpFStIydd9uKhiitbHx7xeT7r
=62Gf
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
