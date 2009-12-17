Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F759B6F19
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 20:34:44 +1100 (EST)
Date: Thu, 17 Dec 2009 10:34:34 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [POWERPC] add U-Boot bootcount driver.
Message-ID: <20091217093434.GA19931@pengutronix.de>
References: <20091216024730.455b90fd@vitb-lp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
In-Reply-To: <20091216024730.455b90fd@vitb-lp>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2009 at 02:47:30AM +0300, Vitaly Bordug wrote:
>=20
> From: Heiko Schocher <hs@denx.de>
>=20
> This driver provides (read/write) access to the
> U-Boot bootcounter via PROC FS or sysFS.
>=20
> in u-boot, it uses a 8 byte mem area (it must hold the value over a
> soft reset of course), for storing a bootcounter (it counts many soft
> resets are done, on hard reset it starts with 0). If the bootcountvalue
> exceeds the value in the env variable "bootlimit", and alternative
> bootcmd stored in the env variable "altbootcmd" is run.

Hmm, both in my inbox and in patchwork, the patch seems line-wrapped.
Also, there are a few printk without loglevel. As probe has access to
a device structure, dev_* should be a nice option here.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksp+yoACgkQD27XaX1/VRtbXwCgvxRytWh+MVWtZLwaaSPLYFE3
nB0AoImNwH+7z5PfUJm54HoFmk7r6LDz
=MDuE
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
