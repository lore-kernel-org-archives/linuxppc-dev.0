Return-Path: <marc.leeman@gmail.com>
Date: Thu, 21 Jun 2007 20:33:50 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: network load 8245 vs. 8347E
Message-ID: <20070621183349.GT5417@chiana.homelinux.org>
References: <20070621141519.GQ5417@chiana.homelinux.org>
	<0090CCD0-EBB4-4475-BF03-36AF41E2DDA1@kernel.crashing.org>
	<20070621155616.GR5417@chiana.homelinux.org>
	<20070621171340.GS5417@chiana.homelinux.org>
	<467ABCDC.8060401@genesi-usa.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c7rykKtsZvepKFKR"
In-Reply-To: <467ABCDC.8060401@genesi-usa.com>
Cc: Linuxppc-dev@ozlabs.org
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--c7rykKtsZvepKFKR
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Isn't it just because the Intel  chipset is a REALLY nice ethernet
> controller and the integrated one in the 8347E isn't as good? :)

Well, that's something what I'm afraid off: that for any kind of decent
network performance we'd need an external chipset. But there are some
other hickups we need to investigate with the 8347.

I just hope it's either a configuration problem, a not so efficient
driver implementation -> no re-design :)

> You could try turning the interrupt coaelescing off in the e100
> driver and see how well it does, then. Or knock the bundling
> threshold or timer down to something similar to the 8347E is using..
> or turn the ones on the 8347E up to match the ones the e100 driver
> is using :)
>=20
> All these options used to be modprobe options but the latest
> e100 driver seems to hardcode a bunch of them probably for best
> performance. Anyway, putting them on a level peg would mean at
> least you are comparing onboard apples with pci apples.

I started doing this this evening, but at first glance, changing sysfs
params (on the gianfar driver) didn't change much.

I'll start comparing 8245/e100/2.4.34, 8245/e100/2.6.17 and
8347E/gianfar/2.6.21.1 tomorrow.

Anyway a load of 30% for a single process where an older processor only
takes around 5% seems too much of a difference to be solved with simple
parameter settings.

--=20
  greetz, marc
Open your ears, or your tentacles, or whatever orifice it is you
listen with!
	Crichton - Back and Back and Back to the Future
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--c7rykKtsZvepKFKR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGesSNUQpj09NWLeERAtqgAKCWjGX+XpLcRfdcKgzU6TT+6t4x8ACfd64s
Cu0IbXYcD8s3yv5Y7hVdnQ0=
=xF2N
-----END PGP SIGNATURE-----

--c7rykKtsZvepKFKR--
