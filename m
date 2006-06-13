Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8675C67B2A
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 02:06:05 +1000 (EST)
Subject: Re: 32 bit userland on G5
From: Johannes Berg <johannes@sipsolutions.net>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1150202709.12423.21.camel@hades.cambridge.redhat.com>
References: <1150194348.9208.33.camel@johannes>
	<1150202709.12423.21.camel@hades.cambridge.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-N0qCy+zI0CjEYgr3GKas"
Date: Tue, 13 Jun 2006 18:05:31 +0200
Message-Id: <1150214746.6305.3.camel@johannes>
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


--=-N0qCy+zI0CjEYgr3GKas
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-06-13 at 13:45 +0100, David Woodhouse wrote:

> Why? Just because older hardware wasn't capable of enforcing the
> permissions, that doesn't mean that we shouldn't enforce them now.

Yeah, I was just thinking that there are programs relying on that and if
they run in the 32-bit compat mode they might rightfully do so... Dunno.

johannes

--=-N0qCy+zI0CjEYgr3GKas
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARI7iSaVg1VMiehFYAQIvRA//WsR3KnjHtUZN7N873OTCb+DyHpIovWY7
wOjyziMdTczw8jgnO5fppfkNuuzqO2kcUexw/mr1Hw1tzJjNgHHlLaBuVP4llzjj
APGuMJbOvJtveZEFXiQrUZsm3ZR4hQ8WzWSRkM1GqbjCI+KB3AE8lVT+zq9Lz+Wd
1HW4hpq/0COTYX6dDeVV4E4iiAz3TJ/dG6stK3kbbmgO05IQ88Bo8BPrg2ErT6+x
1fFnAiWdIdnOIsZxNbSnGOaLo1jlOpvFWbhcTBcTDoeh0PFVwYtx5LdOQguBYEX4
UJsX91a7YKxyqhyhEdrZES0k4j1J7jmUeaIQv4+CDt0+F/j5ufr65vCtPpoZvPWt
zjv6fFgWhOiG3864dYMJpWo2HMDffQqcKUrVfzThfQBjqSwN3KD5gyO48dt4PpBA
I3nm+QJPw0reOzCRP//KZvD4mchkVb7sOLjigq53PqM4sI2dn6rPoT5/HPLdrhTz
hk9DIIN/adlEC4f2QyV3YbB3o5WX59l3dpGI8oowr4LSc0yKFWKRoWWGpEDieIJH
8bhoXSW8+H6KfVVmZJgdczykLjqdTL6kZAzJRJLSBMcuWKoayZJWz0zGvZfaPxIc
dXqiXkSHFn7o1sKAMNpmvns1AwZuWiwB8Y4uYCO2t2rmKXoGOkfRHkly2Qgt2/er
NRb48UhyXtE=
=R4Ao
-----END PGP SIGNATURE-----

--=-N0qCy+zI0CjEYgr3GKas--
