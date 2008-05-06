Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 2237DDE0C0
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 03:03:55 +1000 (EST)
Date: Tue, 6 May 2008 17:40:54 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [i2c] [PATCH6/7] i2c: adds support for i2c bus on Freescale
	CPM1/CPM2 controllers
Message-ID: <20080506154054.GC4265@pengutronix.de>
References: <47FF71A9.4010907@scram.de> <20080506135113.GA4265@pengutronix.de>
	<4820770B.1010002@scram.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
In-Reply-To: <4820770B.1010002@scram.de>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux I2C <i2c@lm-sensors.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2008 at 05:19:39PM +0200, Jochen Friedrich wrote:
> setbits8() and clrbits8() use a bitmask as second argument.
Ouch! Guess my mind wanted to read in_8 and out_8 for some reason...
Sorry and thanks for clarifying!

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIIHwGD27XaX1/VRsRAgMAAKCuMHYpHITge6JsAJL5zq3rxHWDzACeLVXM
EYriBQiZ3qWFJdwjM5mfXC8=
=zDgZ
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
