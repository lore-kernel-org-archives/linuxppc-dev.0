Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 524A5DDE30
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 02:57:13 +1100 (EST)
Subject: Re: Front LED on Mac mini G4
From: Johannes Berg <johannes@sipsolutions.net>
To: Florian Fainelli <florian.fainelli@int-evry.fr>
In-Reply-To: <200702201433.12851.florian.fainelli@int-evry.fr>
References: <200702201433.12851.florian.fainelli@int-evry.fr>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-PNz69NIwXolHGuFGqhYK"
Date: Tue, 20 Feb 2007 16:57:00 +0100
Message-Id: <1171987020.15489.177.camel@johannes.berg>
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


--=-PNz69NIwXolHGuFGqhYK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-02-20 at 14:33 +0100, Florian Fainelli wrote:

> I would like to know whether it is possible or not to modify the via-pmu-=
led=20
> driver to make it work with the Mac mini G4 front LED, is there anything=20
> particular with this model ?

Not sure. If it's a PowerMac10,1 I think it should work.

> By the way, why is this driver only available as in-kernel and not module=
 ?

Because it's just an option of the via-pmu driver.

johannes

--=-PNz69NIwXolHGuFGqhYK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF2xpL/ETPhpq3jKURAoU/AKCR5DhSIt32xU/EiMdQd9xcXSU8YQCgqKyS
g9nHAaO7VbJE5G7lyikjiVo=
=7pG7
-----END PGP SIGNATURE-----

--=-PNz69NIwXolHGuFGqhYK--
