Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B10567B32
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 18:07:37 +1000 (EST)
Subject: Re: [PATCH] powermac: defer work in backlight key press
From: Johannes Berg <johannes@sipsolutions.net>
To: Aristeu Sergio Rozanski Filho <aris@valeta.org>
In-Reply-To: <20060704013923.GG27596@cathedrallabs.org>
References: <20060704013923.GG27596@cathedrallabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-T7/EOeOeMysWYzm2WHSh"
Date: Tue, 04 Jul 2006 10:06:59 +0200
Message-Id: <1152000419.20701.48.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-T7/EOeOeMysWYzm2WHSh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> =20
> +	/* we can receive multiple interrupts here, but the scheduled work
> +	 * will run only once, with the last value */
> +	pmac_backlight_key_queued =3D direction;

Shouldn't you be doing something like using the whole
pmac_backlight_key_queued in the workqueue, then setting it to 0 there
and using +=3D here? That way all keypresses will be adhered to.

johannes

--=-T7/EOeOeMysWYzm2WHSh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARKohoaVg1VMiehFYAQIcnQ/9G//c9oM4c55a7S/rbq6czDh01R9Jd6xI
3D5a178JKPNHkzlNu1YSMj5YeBOnFRkzSGvgkaThm+YKM6Yq4gdCdyEXZsUGRjQG
C16/HBiGKjpWX5fN4HLMeiZwX/X2lfM18PUg5b46UiXq6COno6V+Ct5heiSIECSU
7WZfcb70HfeF7ZMBuOGVIBNAmMuq+len/+oPaHFRHHQb9nyQHwM6bYhAKFZNifpQ
5GcQepfkJNptbe2ezKVQ17/vYOml7eBcH93pu0ZIeAypZlxna8UD2GiA6jMcloBc
DSSkJFnsJcKYhvleX/UpeztguvtlylWre54UtotTwNxxFukZVu4uhTNMga7GjRYU
eJJ+yUMlW2/7DqCi7WaSlYZvPEi11f8hWfMvEJHKuCTk60bbs+OPfNu0RODTO49e
AYwgk/Tzjq1egYrO1+EbpUqDsf+rjiE+Jf+w8JBw27vjiyna4QWsywjIoGQIti+9
lKeeFk/6IOBe8pZhr+bLsM5UzxEX7F4N0C/1HM4x7Kh/xen6K3TG8eW/Oq2qJ9FY
gFBTrrU7XlFoFqXEmx3z4o0R8JxpQrChn401yaaCB/Lx+E0qrWiw8MCIpPOvA0rK
yGMFLe1HsmGnqgnxAUwVs2fwgvxBK45h6XOclo3lbK29H0OXv6QFMFBYavHPcSi4
Pi7fd3qeMxw=
=Nmj8
-----END PGP SIGNATURE-----

--=-T7/EOeOeMysWYzm2WHSh--
