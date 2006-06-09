Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A72EA67C13
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 22:01:30 +1000 (EST)
Subject: Re: [PATCH] convert powermac ide blink to new led infrastructure
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20060609115608.GE23891@krispykreme>
References: <1149635136.32002.49.camel@johannes>
	<1149726524.23790.5.camel@localhost.localdomain>
	<1149853629.3864.9.camel@johannes.berg>
	<20060609115608.GE23891@krispykreme>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ol7UWH0Mm36mjeBQKXN3"
Date: Fri, 09 Jun 2006 14:01:12 +0200
Message-Id: <1149854473.3864.12.camel@johannes.berg>
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


--=-ol7UWH0Mm36mjeBQKXN3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-09 at 21:56 +1000, Anton Blanchard wrote:

> On the other hand, Ive come to expect it on my laptop :)

With my patch, just put

echo -n ide-disk > /sys/class/leds/pmu-front-led/trigger

into some startup script then :)

Do we really want the old Kconfig option in there selecting the new led
option, the ide-disk trigger and modifying the code to make this the
default trigger for the LED? I mean...

johannes

--=-ol7UWH0Mm36mjeBQKXN3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIljBqVg1VMiehFYAQIrPg/9ECwc2tkRGJ2m6hetOPieyMkogls7RNSq
fe8RjkmwzlVPxXh70NlJVomTC2H5TUlqR4D5/UcKNAGHn7z2ab/yNQVLbl7eLyNf
I+M6wwBEk+K0Qtb3YxI7CCUJqb+VxuOMSoZvTl38cUSct/0fV+WSeIcnxH9C1UlO
ZFVCtbjR+wTkwucM4ErjNOYs/1r+jQWsHM8we3yVSJYQkmulgoKcNO351y5xsOHo
UQb4VuERCDfUp0b9KyCEx93FJhVIMGDoRT7ADSqY7rtcRjC4+HXfuOTsOnDkEEJg
k8JR3mh70EqlEtf4/jp12DOvfMalkoNAh+kyhRnJQj1CrOx4W+CmfYfjckt1XYuF
P9tWMenMrHxMW4ng1hvoqXKRgAImTTXDsl6ODJFmv83s3C1brWeXlQalVcCAzN5F
TB8HdMKC0hEdB3DQstRemecet2Hyl7g89PbsBtSc0WR7/r6pSN2Sv6u52tpePi4Q
TxyOmAME332AtzJuMW31zIrjBROSbvghx0cwFLdImS5hHmpAshLNVkPc49sUkQef
W2wY81Wbf2vslzBLl4reQ3uPAkrd6EaXUIAqwlM8XC989GFqPsTG7GgJlSaLGRHP
vBCcJzn7vqFuEP9bWZJft8pzpmkgsxL17lPGOKA+y/lnoo6dL5iSipsa8cV40nJK
m46kZPqENUE=
=L1LJ
-----END PGP SIGNATURE-----

--=-ol7UWH0Mm36mjeBQKXN3--
