Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 59024B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 21:04:28 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id E9699DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 21:04:27 +1000 (EST)
Date: Thu, 10 Sep 2009 13:04:19 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Bart Van Assche <bart.vanassche@gmail.com>
Subject: Re: [PATCH 2/4] i2c/chips: Remove deprecated pcf8575-driver
Message-ID: <20090910110419.GA3266@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	<1252531371-14866-3-git-send-email-w.sang@pengutronix.de>
	<e2e108260909100352l2a30438fj9f0297c1974c0192@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
In-Reply-To: <e2e108260909100352l2a30438fj9f0297c1974c0192@mail.gmail.com>
Cc: linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org,
	linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> This patch removes the documentation file
> Documentation/i2c/chips/pcf8575 while there is no documentation under
> Documentation/ for the drivers/gpio/pcf857x.c driver. Shouldn't proper
> documentation for the pcf857x driver be added to the kernel tree
> before the pcf8575 driver is removed ?

I considered moving the documentation, but realized:

1st part is URLs for datasheets. Well, URLs easily grow outdated and those
datasheets are easily to find using your favourite search engine.

2nd part is a short description of the chips which is IMHO sufficently cove=
red
in drivers/gpio/Kconfig.

3rd part (Detection) and 4th part (sysfs-interface) are obsolete for the new
drivers. The gpiolib interface again is covered in Documentation/gpio.txt

So I concluded to simply drop the documentation.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqo3TMACgkQD27XaX1/VRvFjQCgo1FvA+7ru2LhEIdbNdz63gq+
qZgAoKZE9Vl9Ut69l9xYkFnYk5zyLUA5
=pc+E
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
