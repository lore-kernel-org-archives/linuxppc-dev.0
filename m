Return-Path: <wsa@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8D8A0B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 16:26:18 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 279DFDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 16:26:18 +1000 (EST)
Date: Thu, 10 Sep 2009 08:26:09 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] Removing deprecated drivers from
	drivers/i2c/chips
Message-ID: <20090910062609.GA26454@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	<8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
In-Reply-To: <8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-mips@linux-mips.org,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	uclinux-dist-devel@blackfin.uclinux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> the Blackfin defconfigs refer to an input driver for the PCF8574, not
> the I2C client driver

Yup, I am aware of that. With the exception of:

blackfin/configs/PNAV-10_defconfig:773:CONFIG_SENSORS_PCF8574=3Dm

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqonAEACgkQD27XaX1/VRsuggCgvHIQBK0PDoMqr0mqllZhomK8
ym8An2/4gTJoai3W+CzOM659DgzCeQuK
=yoJc
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
