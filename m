Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 65A6667B5B
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 01:07:53 +1100 (EST)
Subject: Re: [linux-pm] [RFC 0/3] experimental G5 powermac suspend
	implementation
From: Johannes Berg <johannes@sipsolutions.net>
To: Pavel Machek <pavel@suse.cz>
In-Reply-To: <1165930563.22338.32.camel@johannes.berg>
References: <20061211230208.526233000@sipsolutions.net> >
	<1165926068.22338.15.camel@johannes.berg>
	<20061212132240.GE5190@ucw.cz>
	<1165930563.22338.32.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0GM02Phdz5QtMFNH/Jww"
Date: Tue, 12 Dec 2006 15:07:43 +0100
Message-Id: <1165932463.22338.37.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org,
	Michael Buesch <mb@bu3sch.de>, Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-0GM02Phdz5QtMFNH/Jww
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-12 at 14:36 +0100, Johannes Berg wrote:

> Well the RTC of course ticks but the system clock obviously doesn't.
> Yes, I'll have to look at the time suspend/resume code. Do you know
> where to find it?

Never mind, found it easily enough: it's in arch/i386/kernel/time.c

johannes

--=-0GM02Phdz5QtMFNH/Jww
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFfrev/ETPhpq3jKURAnrEAKCPxyXqkQFmJlVQG9+GjWHl497gAACbBDWu
KSiapjwNyxkEzHoJRWdGidI=
=9dyk
-----END PGP SIGNATURE-----

--=-0GM02Phdz5QtMFNH/Jww--
