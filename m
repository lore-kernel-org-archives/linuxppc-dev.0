Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 34EFAB7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 21:07:46 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id C8C7DDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 21:07:45 +1000 (EST)
Date: Thu, 10 Sep 2009 13:07:40 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: Removing deprecated drivers from drivers/i2c/chips
Message-ID: <20090910110740.GB3266@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	<20090910124937.7b3df062@hyperion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
In-Reply-To: <20090910124937.7b3df062@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org, uclinux-dist-devel@blackfin.uclinux.org,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Not sure about the patch to drivers/gpio/pcf857x.c, as there is no gpio
> tree and no maintainer either AFAIK, I guess I shall pick it too?

I'd say so. An Ack from David Brownell would be nice, though.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqo3fwACgkQD27XaX1/VRubLQCfSgZNsCLqCMUHSTodsb+ADje7
8moAniKaGGL+YvVPQzmKGQiBL3LugOtg
=92rb
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
