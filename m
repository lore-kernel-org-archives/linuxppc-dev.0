Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59ACE67C5E
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 23:21:31 +1100 (EST)
Subject: Re: [RFC 0/3] experimental G5 powermac suspend implementation
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20061211230208.526233000@sipsolutions.net>>
References: <20061211230208.526233000@sipsolutions.net>>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pAgtPYD2UrDsob/q3e/K"
Date: Tue, 12 Dec 2006 13:21:07 +0100
Message-Id: <1165926068.22338.15.camel@johannes.berg>
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>,
	Michael Buesch <mb@bu3sch.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-pAgtPYD2UrDsob/q3e/K
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Date/time is restored to wherever it was when suspending. Does anyone
know how to fix that? Does the RTC somehow warp the time on resume or do
we somehow mark the time/date __nosave?

johannes

--=-pAgtPYD2UrDsob/q3e/K
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFfp6z/ETPhpq3jKURAkP3AJwJlvmerj96HokTLeU9aln+3eX3hQCfZq31
kSuDVWiEudyiXOxDBq3a99g=
=xUB7
-----END PGP SIGNATURE-----

--=-pAgtPYD2UrDsob/q3e/K--
