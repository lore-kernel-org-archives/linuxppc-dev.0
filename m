Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EBC6467A40
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 03:31:31 +1000 (EST)
Subject: Re: [PATCH] convert powermac ide blink to new led infrastructure
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1151394629.2350.64.camel@localhost.localdomain>
References: <1149635136.32002.49.camel@johannes>
	<1150884676.23386.6.camel@johannes>
	<1151394629.2350.64.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8dZ9V3tpXIsGy+nXm68f"
Date: Tue, 27 Jun 2006 19:31:23 +0200
Message-Id: <1151429483.597.12.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Richard Purdie <rpurdie@rpsys.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-8dZ9V3tpXIsGy+nXm68f
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Looks good. Only one nit: in pmu_led_set(), you should be able to test
> if the requested state is identical to the current one and do nothing
> without taking the lock no ?
>=20
> Or does the upper level LED infrastructure takes care of it ?

I don't know, Richard? But yeah, I can do that too.

johannes

--=-8dZ9V3tpXIsGy+nXm68f
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARKFraaVg1VMiehFYAQJLag/9EdIHuV7n5uj2bR50i9EZocqJWxfLuLLb
BuVD2/bhUqnhOdG0SbM5SBdkgr5QEQtjILJrRmMaWOrC+Vdx8wOUrEPrsllmZ/EW
a0ZwDNGdw+J1EfbxuYec1ZmBPuEJBryi5cK3I/lhaLrZ+92y0LDuuD3b/tchX9An
r7YQbVFrih3tp4TkK1IrSGAPQpChrp803br0qL21BX8srDHROh/AEVIuNOvmLHoh
ALdcWEpgMc0TbEtKi3dWgWz+6CvGHZWuGJYma+zobt0pa5MN6xKN7NOmwxZ8lNzG
qaXeG7tB1rFUUlJqkJyqVaQSuGXMENnFCIJG0B+pdxl+6DJ8/AlUnShlLTMNl4gM
6CyBSlZo2wWhm09KRsdfm+n7Kgjytzc3AQqGi6KL70MQeq9z4F+HQBXqwOWFkBcm
aBoQPK71dD7gb2GLqEfV2Kfs6vDIphncaW3l2okCOdyGOA2C41uPHyYhHpI04/dJ
fKzCO7eKbeL86ASkkYG7F95I9YkNFQkAcaQc1ndH4Fh31sY1cUKG6iOFwxaGBjZp
VncVHSaU+pY6M3+l6CM28U+7iWbw/euAB9hqh3N2aJniL+ZhM2ZfcW0sq5RQUfbQ
sFX4NIzmdyEM0KYk8qGxoeNpJHRBaOEfrRkXnUZkj7MEZSqdWb4+3wNwNpdJTRJR
OqeBz0qHM6Y=
=y0yv
-----END PGP SIGNATURE-----

--=-8dZ9V3tpXIsGy+nXm68f--
