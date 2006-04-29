Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A4D7679FD
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 19:28:01 +1000 (EST)
Subject: Re: [PATCH] convert powermac ide blink to new led infrastructure
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1146237326.19164.111.camel@localhost>
References: <1146235779.19164.109.camel@localhost>
	<1146237326.19164.111.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-UJG/bvH6uExxbiuvPnL/"
Date: Sat, 29 Apr 2006 11:27:52 +0200
Message-Id: <1146302872.5019.19.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Richard Purdie <rpurdie@openedhand.com>,
	debian-powerpc <debian-powerpc@lists.debian.org>,
	John Lenz <lenz@cs.wisc.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-UJG/bvH6uExxbiuvPnL/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-04-28 at 17:15 +0200, Johannes Berg wrote:
> =20
> +config ADB_PMU_LED
> +	bool "Support for the Power/iBook front LED"
> +	depends on LEDS_CLASS && ADB_PMU

come to think of it, that should probably be
	depends on ADB_PMU
	select LEDS_CLASS

since we should imho consider the led stuff as infrastructure for other
stuff. Opinions?

johannes

--=-UJG/bvH6uExxbiuvPnL/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARFMxlaVg1VMiehFYAQJEDQ//SYW3f//MnpbDkUkbZ0jEIvrsTK4mKSVy
GclSczdyWwkqqjZ0JWLduyTwoXcTrkvLYjl5hZLuqlvjzu2b6lwQuvFXour+NBKu
O201bFNiqGkqqFpijMUqdqputOaPrbCtN5elJV4yaAK4ERIxQg3SZ7SYs3w5HqQg
quBEn4Pv3EgYmoz6b167WaQfK1CHAB3ZRuCMBZwRTYpzmdCiIl5Wfjl+Hm1a36Sj
6a/YyVMiESJcMH+Z9hk1qFbDWTAj+F9MZCSA9RXLlaGKWW2RRQI9fGjaEPMpFojQ
2RLAsEbckudgT8BkUB+DdeNNiqq42Cv9XFnILZULi2kS73cj0WWUNjOqWVVqs37E
Ms+JBR3hICzzqYRUhIZ8UsBvCd3bwT0pV1itzDdDW8wZSGx2AwB05Yx1yQ545Drr
aViPG0jLYRAEnIAPIPY8sjLcgrpgtLLKcDLStMfnxHQeEEdVHeRi26xCJAZYrPq/
UTnEnzpG7CuBaTqpEWip7c5qNFqbHRQy0n2/9AxMrOdEIWR+lfYkfjTJcs8zqaD3
QaA40kTT2+2JDckkPOEqvxrJKI1j4wtQA8w/wTTCafyBJ26D50BK/TNOgNucoRTu
W0s3nk6UxEvAusnq47RqIkY1IvnEjC5yb+Kf1Olfdy2TmAG4LNlOghCr4o2/v2AV
hPgD36PgXU8=
=1zCQ
-----END PGP SIGNATURE-----

--=-UJG/bvH6uExxbiuvPnL/--
