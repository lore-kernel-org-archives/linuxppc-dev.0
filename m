Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3377DDFF2
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 01:43:30 +1100 (EST)
Subject: Re: powerbook VT garbled between rc7 and rc8
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <je7i65r42j.fsf@sykes.suse.de>
References: <1229078554.3600.8.camel@johannes.berg>
	<je7i65r42j.fsf@sykes.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-P8djv1NRuv1uRWWhpfC1"
Date: Fri, 12 Dec 2008 15:43:19 +0100
Message-Id: <1229092999.3600.10.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-P8djv1NRuv1uRWWhpfC1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-12-12 at 13:05 +0100, Andreas Schwab wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
>=20
> > After upgrading to -rc8 yesterday my powerbook started up today with th=
e
> > screen totally garbled, only occasionally was a word readable.
>=20
> Try 6c34bc2976b30dc8b56392c020e25bae1f363cab (Revert "radeonfb:
> accelerate imageblit and other improvements").

That's post -rc8, ok, but -rc7 worked fine here, and the stuff it
reverts is all pre -rc7, no? Strange. I'll try later.

johannes

--=-P8djv1NRuv1uRWWhpfC1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJQniEAAoJEKVg1VMiehFYws4QAJ5SNHzZmd7YAU8aAeXs/WqE
3f+CBCT0zuqCTY05Ca8XIRHUkoq6FGygT/p6iZo0JCrUUJFEgdQ0HMJL90kHx5aT
f+5ic2sNM0BaaO+IdI8R4JUkMDjnxnJBp7C0tJI7oUp613CNYU32JIb4E9ZwnTL2
xkNus8qbmVPN4fLyMQ6Mj5PxIwNWmCevYO/nDbJJ+XOuxHe1ld76FQ0uEMkgZND8
yW4YwqpRoq+C5nJfCq8AjXMMveVFKGxVjCKEFu2IYqkqRnUsQ5KoLoA8/lXrh/bD
utod9/XBGp2QXLhGr/DOpN2DLDuc3qlex5Z97hOCR9G36OWMKEQYBno6FFEFEpb5
fTPO4Lbfk7SItYkPrRR0o+HNSmF+3YL2YZNA8BxC+bLM4Rqp9YiYtZI7QhXn7o8z
juqAJqomQnihM9fQuMiQEMhWD1sg8OLo1wLw9p7EazxocLdplA0uyJj2tuf7ftLz
/6koivwFOpIomtZvDdpLdsOGIbj+taCnMo9jV1qs00F5tdC/wHfPYaVOP4AHsYBG
cUgXCmiVfBvVRY/ebqTmywF0tXo5mUUHHYN9lsiOB9fX8X8HoNlNs6WYj41XkqCB
qoOaWq2A6iRGe7doLErqOuL4WqhNGtf3szaYx+qWPjnOKWa6J/0dxzcVu4gSADYh
BkENyiKZ5OVBCo+KdLDp
=JH9q
-----END PGP SIGNATURE-----

--=-P8djv1NRuv1uRWWhpfC1--
