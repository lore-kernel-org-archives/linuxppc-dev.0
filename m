Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3434CDDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 04:41:18 +1100 (EST)
Subject: Re: Front LED on Mac mini G4
From: Johannes Berg <johannes@sipsolutions.net>
To: Florian Fainelli <florian.fainelli@int-evry.fr>
In-Reply-To: <200702201835.14882.florian.fainelli@int-evry.fr>
References: <200702201433.12851.florian.fainelli@int-evry.fr>
	<1171987020.15489.177.camel@johannes.berg>
	<200702201835.14882.florian.fainelli@int-evry.fr>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-wM6xLXJVzZy1p35v0Jkj"
Date: Tue, 20 Feb 2007 18:41:05 +0100
Message-Id: <1171993265.15489.211.camel@johannes.berg>
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


--=-wM6xLXJVzZy1p35v0Jkj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-02-20 at 18:35 +0100, Florian Fainelli wrote:

> It is a PowerMac10,1. After bypassing some device checks in via_pmu_led_i=
nit,=20
> I tried : echo 0 > /sys/class/leds/pmu-front-led/brightness
>=20
> which resulted in : PMU: bad reply len 85 and the brightness not changed =
of=20
> course.

Hm, ok.

> the check is in via-pmu.c line 1500
>=20
> Do you know what could cause this reply ?

No, I don't really know the PMU that well.

johannes

--=-wM6xLXJVzZy1p35v0Jkj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF2zKx/ETPhpq3jKURAursAKCGKjdWCEYiaeaLzHeonGf2f2KI6wCdHDlQ
lN4mF1QHJy5AziK3RdHFBng=
=9azh
-----END PGP SIGNATURE-----

--=-wM6xLXJVzZy1p35v0Jkj--
