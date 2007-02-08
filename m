Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 38817DDEC3
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 00:10:58 +1100 (EST)
Subject: Re: [PATCH 11/12] powermac: disallow pmu sleep notifiers from
	aborting sleep
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jetzxxk2bh.fsf@sykes.suse.de>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124615.015873000@sipsolutions.net>
	<jetzxxk2bh.fsf@sykes.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-kh4fsVQc73uA6iUXXnaL"
Date: Thu, 08 Feb 2007 14:08:13 +0100
Message-Id: <1170940093.4385.40.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-kh4fsVQc73uA6iUXXnaL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-02-07 at 23:52 +0100, Andreas Schwab wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
>=20
> > Tracing through the code, no current PMU sleep notifier can abort sleep=
.
> > Since no new PMU sleep notifiers should be added, this patch simplifies=
 the
> > code and removes the ability to abort sleep.
>=20
> There is a use of PBOOK_SLEEP_OK left in
> arch/powerpc/platforms/powermac/time.c.

Ouch. Yeah, the patch was done assuming my time resume patch is applied.

I found another one though, in dmasound.

johannes

--=-kh4fsVQc73uA6iUXXnaL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFyyC9/ETPhpq3jKURAnGRAJ0S/3NOcKKrrWPqVtTaKp3PzFU4XwCcD6cu
e4Owi7xYOVz2EsJ7KGTmIAQ=
=cS92
-----END PGP SIGNATURE-----

--=-kh4fsVQc73uA6iUXXnaL--
