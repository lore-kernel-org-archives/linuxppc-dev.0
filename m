Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 8D421DDDF3
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 03:28:30 +1100 (EST)
Date: Tue, 10 Feb 2009 17:28:19 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] i2c-mpc: do not allow interruptions when waiting for
	I2C   to complete
Message-ID: <20090210162819.GC15678@pengutronix.de>
References: <1233928837-3401-1-git-send-email-timur@freescale.com>
	<ed82fe3e0902100659p2eec9de6j61f9ffb504d60a89@mail.gmail.com>
	<20090210165554.0da8bf7c@hyperion.delvare>
	<4991A4F2.8030506@freescale.com>
	<20090210171000.1f45cc2d@hyperion.delvare>
	<4991A970.70508@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
In-Reply-To: <4991A970.70508@freescale.com>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	Kumar Gala <kumar.gala@freescale.com>, linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I don't see his Signed-off-by on any patch to i2c-mpc.c for the past
> three years (at least).  I do see yours, however.  You have directly

Ben is the I2C-"embedded"-maintainer. This job was created less than
a year ago, this is why you don't see sob from him regarding this
driver.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmRqyMACgkQD27XaX1/VRsljQCgruu/3sbaE9DKIa8s34hrG4WV
FOcAoMsTjfDCvW8ldExbvhDFzdTF95EG
=eWN5
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
