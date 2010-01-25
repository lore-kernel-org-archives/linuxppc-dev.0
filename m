Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 391AE1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 07:48:39 +1100 (EST)
Date: Mon, 25 Jan 2010 21:48:33 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/3] i2c-mpc: add support for the MPC512x processors
	from Freescale
Message-ID: <20100125204833.GB9693@pengutronix.de>
References: <1264408029-5290-1-git-send-email-wg@grandegger.com>
	<1264408029-5290-2-git-send-email-wg@grandegger.com>
	<1264408029-5290-3-git-send-email-wg@grandegger.com>
	<20100125115211.GA5257@pengutronix.de>
	<4B5D894C.4090001@grandegger.com>
	<20100125151509.GD5257@pengutronix.de>
	<4B5DE3FB.10505@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
In-Reply-To: <4B5DE3FB.10505@grandegger.com>
Cc: Devicetree-discuss@lists.ozlabs.org, Linuxppc-dev@lists.ozlabs.org,
	Linux-i2c@vger.kernel.org, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> overkill to me. I will have a closer look, though. At a minimum I will
> replace "-1" with "MPC_I2C_PRESERVE_CLOCK".

Might be also an idea to define it with ~0 (clock is still unsigned). If
possible, the code checking for those two cases (0 and "-1") should be close
together. That could be a compromise until more quirks are needed ;)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkteA6EACgkQD27XaX1/VRsl0QCdHfqhq/t2ipj5ikJre/V9RWhQ
6hMAoImtshgFQs81jBThv8XBWDODYIAh
=fZeb
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
