Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FFEFDDED5
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Dec 2006 09:38:55 +1100 (EST)
Subject: Re: [PATCH] SMU LED driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1167081952.3522.0.camel@localhost.localdomain>
References: <20061224112351.GA27260@hansmi.ch>
	<1167081952.3522.0.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-sjaunnkGz1wG5lmXJCjj"
Date: Tue, 26 Dec 2006 23:38:26 +0100
Message-Id: <1167172706.13592.1.camel@johannes.berg>
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


--=-sjaunnkGz1wG5lmXJCjj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-26 at 08:25 +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2006-12-24 at 12:23 +0100, Michael Hanselmann wrote:
> > This patch adds a driver for the front LED in recent PowerMacs which
> > have an SMU.
>=20
> As for the PMU driver, I'm pretty unhappy that it sycnhronously waits
> for the completion. The original code I wrote was fully asynchronous.

That'd be my code. I can see if I can somehow get rid of that.

johannes

--=-sjaunnkGz1wG5lmXJCjj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFkaRh/ETPhpq3jKURArFwAKCAaMTg/rjPM/aqshL8GmHCqwmsQACeIDwP
pbJtCbft/sr6mZuKKZ9TNpE=
=J9qn
-----END PGP SIGNATURE-----

--=-sjaunnkGz1wG5lmXJCjj--
