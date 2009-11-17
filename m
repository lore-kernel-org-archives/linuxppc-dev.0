Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 8DEFEB6EE9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 10:23:14 +1100 (EST)
Date: Tue, 17 Nov 2009 21:08:21 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [RFC PATCH 1/5] Rework OpenFirmware GPIO handling
Message-ID: <20091117200821.GA3154@pengutronix.de>
References: <1258472546-31343-1-git-send-email-dbaryshkov@gmail.com>
	<1258472546-31343-2-git-send-email-dbaryshkov@gmail.com>
	<20091117161244.GA6849@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <20091117161244.GA6849@oksana.dev.rtsoft.ru>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@lists.ozlabs.org,
	David Brownell <dbrownell@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> And it turned out that the only sane solution is to write
> OF-pdata-hooks for the each driver (that we do for many drivers
> already):

Or to support Grant in getting rid of of_platform :)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksDArUACgkQD27XaX1/VRs90wCfVIES3k6ZlQ/3+ckFfNFBFxUp
+0EAoMDs0GZPCFBf2gkOlO41dE67cCGn
=6ozf
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
