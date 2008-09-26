Return-Path: <dgibson@ozlabs.org>
Date: Fri, 26 Sep 2008 11:15:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC] GPIO-Watchdog in devicetree
Message-ID: <20080926011513.GB13228@yookeroo.seuss>
References: <20080922194357.GA32041@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
In-Reply-To: <20080922194357.GA32041@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2008 at 09:43:57PM +0200, Wolfram Sang wrote:
> Hello all,
>=20
> I understood that the device-tree is for describing hardware and should
> not contain driver specific information. I have problems drawing this
> line right now. I made a driver for watchdogs which are pinged by
> toggling a gpio. Currently the device-tree entry looks like this:
>=20
> 	watchdog@gpio {
> 		compatible =3D "gpio-watchdog";
> 		gpios =3D	<&gpio_simple 19 0>;
> 	};

This certainly isn't right.  The unit address should be based on the
'reg' property.  If there's no 'reg' property, there should be no unit
address.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFI3DehaILKxv3ab8YRAsjXAJ96uSgi5RYIiFpuoKzU16RYD2kcWwCgiaqi
wsm5vSv+WLGqjYaOALoe4fc=
=4MqY
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
