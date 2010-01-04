Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8A03B7BEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Jan 2010 07:23:52 +1100 (EST)
Date: Mon, 4 Jan 2010 21:23:46 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH net-next 2/3] can: mscan-mpc5xxx: add support for the
	MPC521x processor
Message-ID: <20100104202346.GA8904@pengutronix.de>
References: <1262420274-16586-1-git-send-email-wg@grandegger.com>
	<1262420274-16586-2-git-send-email-wg@grandegger.com>
	<1262420274-16586-3-git-send-email-wg@grandegger.com>
	<20100102135734.GC2239@pengutronix.de>
	<4B3F6F6B.5070004@grandegger.com>
	<20100104162441.GA4665@pengutronix.de>
	<20100104194027.CB2053F6FD@gemini.denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
In-Reply-To: <20100104194027.CB2053F6FD@gemini.denx.de>
Cc: Netdev@vger.kernel.org, Devicetree-discuss@lists.ozlabs.org,
	Socketcan-core@lists.berlios.de, Linuxppc-dev@lists.ozlabs.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Wolfgang,

> We only support MPC512x Rev. 2 (and later). This is also true for
> other parts of the mainline kernel code - see for example trhe NAND
> driver.

Okay, good to know there are differences in NAND as well. As said before, it
makes sense to me to skip V1. It just should be documented IMHO, and, if
possible, the bindings should allow V1 support in case anyone dares.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktCTlIACgkQD27XaX1/VRtOwwCfXZRZyBXyiQeLmMbASY+sQQaA
5KwAnj5Uj/ATiOJxYE2uBwsm29lcAhM2
=Sbfj
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
