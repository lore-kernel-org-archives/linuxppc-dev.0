Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D32EEDDEEA
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 23:55:14 +1100 (EST)
Subject: Re: [PATCH 2/3] powermac: proper time of day after resume
From: Johannes Berg <johannes@sipsolutions.net>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20070125110951.GA31911@iram.es>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.386891000@sipsolutions.net>
	<1169620444.18754.66.camel@localhost.localdomain>
	<20070124085420.GA19810@iram.es>
	<1169631177.18754.82.camel@localhost.localdomain>
	<20070124103621.GA22579@iram.es>
	<2435847C-A9FC-4430-A122-416B9B347038@kernel.crashing.org>
	<20070125110951.GA31911@iram.es>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-gR9Ky+dfdn1oaGGdsl6N"
Date: Thu, 25 Jan 2007 13:54:05 +0100
Message-Id: <1169729645.19614.1.camel@johannes.berg>
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


--=-gR9Ky+dfdn1oaGGdsl6N
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-01-25 at 12:09 +0100, Gabriel Paubert wrote:

> If we did suspend the machines to save power, the only solution=20
> would be to tell NTP to synchronize with the master clock by=20
> stepping the time (not slewing) at resume time.

You also know that you have such a requirement, and obviously also know
what you could do to fix it.

I see this as a non-issue. Even if we *try* to sync with the second
transition (which is likely rather hard to do) then we won't have the
required precision for a bunch of applications, so it's futile to try it
anyway.

Besides, if we don't do it at all the time just keeps running where it
was before suspend...

johannes

--=-gR9Ky+dfdn1oaGGdsl6N
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFuKht/ETPhpq3jKURArY4AJ9esAwmO3sFj733WBpReyjvLY/93QCgmBa/
1s6bO1KapntvDYiQOrbg4UQ=
=YGlX
-----END PGP SIGNATURE-----

--=-gR9Ky+dfdn1oaGGdsl6N--
