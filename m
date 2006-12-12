Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DCFB767C93
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 00:36:31 +1100 (EST)
Subject: Re: [linux-pm] [RFC 0/3] experimental G5 powermac suspend
	implementation
From: Johannes Berg <johannes@sipsolutions.net>
To: Pavel Machek <pavel@suse.cz>
In-Reply-To: <20061212132240.GE5190@ucw.cz>
References: <20061211230208.526233000@sipsolutions.net> >
	<1165926068.22338.15.camel@johannes.berg>
	<20061212132240.GE5190@ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vTjyKeZZ4i6HmVbUdyyu"
Date: Tue, 12 Dec 2006 14:36:03 +0100
Message-Id: <1165930563.22338.32.camel@johannes.berg>
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


--=-vTjyKeZZ4i6HmVbUdyyu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-12 at 13:22 +0000, Pavel Machek wrote:

> Clock do not tick while suspended; I guess you need to copy time
> suspend/resume from i386 or something.

Well the RTC of course ticks but the system clock obviously doesn't.
Yes, I'll have to look at the time suspend/resume code. Do you know
where to find it?

johannes

--=-vTjyKeZZ4i6HmVbUdyyu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFfrBD/ETPhpq3jKURAt1lAJ4+5VxDHHZRT5VC+9rgd2k2wVS/2QCgmRAf
1a0kJBBZXqz4P8W05kY8GL0=
=OnQd
-----END PGP SIGNATURE-----

--=-vTjyKeZZ4i6HmVbUdyyu--
