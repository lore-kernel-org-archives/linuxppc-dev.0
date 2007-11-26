Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41BEDDDDFB
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 00:07:36 +1100 (EST)
Subject: Re: time accounting problem (powerpc only?)
From: Johannes Berg <johannes@sipsolutions.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1195814816.4149.94.camel@johannes.berg>
References: <1195814816.4149.94.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LPjZDLP2bIhoh/7P5BtP"
Date: Tue, 27 Nov 2007 00:55:14 +0100
Message-Id: <1196121315.6058.0.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-LPjZDLP2bIhoh/7P5BtP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> On my powerbook, with NO_HZ and HIGH_RES_TIMERS, I observed recently
> that powernowd would not ever switch between CPU speeds.

Also happens without NO_HZ (with HIGH_RES_TIMERS).

johannes

--=-LPjZDLP2bIhoh/7P5BtP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR0tc4aVg1VMiehFYAQLO4Q//Qm3GtSf8MqR0DC7/qiQVik9+qIHiA8CE
7n5fUOZ8yJWmXkbD4IHlbwgMCHLWOw6GfT1ziZCdLtpIGjTz3zkL9J7Us9LZv168
+uuI0pTdmxgy1lqqYobsNVHxb7XDRBmL6RY5l5yCX+DSnfwOL0m7ASnuts+7+2fK
5oOcdzN6zLykb4EN8WtzghKz8MSVvHwcJvxp6cfRahmyPp+Ub4CrTIvQUupg2X5T
dfEm6y6yjeqz8pA8HI2JAImWUgQ3OfzQNLc2id7SQ5KHTbAbXdW/cAxKLxThO/qH
kQ2Yolf5Pv9wnlfY0kLYvn83jjWr+8qRJJDB/kCyEoyuxh5zH0yb+e4Vy5nC7tHn
AXGJrTzAV53ojoI0GUhyv/JxVlEL3GBMkM8z0nmqlK5Sp+wtWy1HfKiGSrqwrzt+
0p25rNba5yGMtut9nFlMhDBk6ekGG7MTuYCVeXOmMNFlLbCroMAitjZpvn7Nx/2g
Wavt3jWDh77yZkym5wNrM4U2DNASAiDctP895zjBZ3aq8pTv+OxRQPuWvqgl6fvG
TGIP5Akuhqu9C4ceNq9eM8mpw4WngGIeGmQxLuPSXJoASzENQRNEyKmWnIYFgYwp
znvln1L54z0yVhhpAFwbnWg8y53XSVvJ+53tg1ugsycYoXrRP9BSVZUSRYnXjGuo
gaKcC1fO1ZM=
=/uxl
-----END PGP SIGNATURE-----

--=-LPjZDLP2bIhoh/7P5BtP--
