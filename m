Return-Path: <wsa@pengutronix.de>
Date: Wed, 2 Jul 2008 15:33:43 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH 1/2] Convert i2c-mpc from a platform driver into
	a of_platform driver, V4
Message-ID: <20080702133343.GC4253@pengutronix.de>
References: <20080630230126.12482.87927.stgit@terra>
	<20080701181444.505c1544@hyperion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
In-Reply-To: <20080701181444.505c1544@hyperion.delvare>
Cc: Linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

On Tue, Jul 01, 2008 at 06:14:44PM +0200, Jean Delvare wrote:

> Applied, after fixing the patch so that it applies, fixing it again so
> that it is correct in the polling case, and fixing it again to make it
> pass checkpatch.pl.
So, it cannot be applied directly? :(

Could you repost the correct version perhaps? I'd like to test it, but
can't find it at http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/
(because it is scheduled for 2.6.27?).

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIa4O3D27XaX1/VRsRAl5cAJ9FLuUHbhGraXdmbton7AZz0ouFAQCgy1+/
ttcR+txcbspDocV9iLIVobE=
=HhBQ
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
