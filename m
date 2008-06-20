Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id A53D9DDF21
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 02:26:57 +1000 (EST)
Date: Fri, 20 Jun 2008 18:26:51 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Esben Haabendal <eha@doredevelopment.dk>
Subject: Re: [PATCH] CPM2 i2c driver
Message-ID: <20080620162651.GF17701@pengutronix.de>
References: <485B73DC.8070707@doredevelopment.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+ts6NCQ4mrNQIV8p"
In-Reply-To: <485B73DC.8070707@doredevelopment.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--+ts6NCQ4mrNQIV8p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Esben,

On Fri, Jun 20, 2008 at 11:09:48AM +0200, Esben Haabendal wrote:

> Here is an i2c driver for Freescale processors with CPM2. It is based on
> previous work by Angelos Manousaridis which again were based on a driver
> from Heiko Schocher.
Just recently a similar driver was added to the i2c-tree:

http://article.gmane.org/gmane.linux.kernel/684037

Maybe you can bring in your special knowledge and check if it is missing
features from your implementation?

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--+ts6NCQ4mrNQIV8p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIW9pLD27XaX1/VRsRAgaYAJ9uwS3lZxup9apPsPI4dkuJ+3TwzACfSFpw
YPS84AgLuGeVwweOyn+1kEE=
=o8vf
-----END PGP SIGNATURE-----

--+ts6NCQ4mrNQIV8p--
