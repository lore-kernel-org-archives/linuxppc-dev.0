Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D44DC67BDD
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 23:37:59 +1100 (EST)
Subject: Re: [linux-pm] [RFC 0/3] experimental G5 powermac suspend
	implementation
From: Johannes Berg <johannes@sipsolutions.net>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20061212173421.GA31090@iram.es>
References: <20061211230208.526233000@sipsolutions.net>
	<1165926068.22338.15.camel@johannes.berg>
	<20061212132240.GE5190@ucw.cz>
	<1165930563.22338.32.camel@johannes.berg>
	<1165932463.22338.37.camel@johannes.berg>
	<20061212173421.GA31090@iram.es>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-an/5wNr5OlSu7oLhnO+V"
Date: Wed, 13 Dec 2006 13:37:27 +0100
Message-Id: <1166013447.7273.3.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Pavel Machek <pavel@suse.cz>,
	linux-pm@lists.osdl.org, Michael Buesch <mb@bu3sch.de>,
	Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-an/5wNr5OlSu7oLhnO+V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-12 at 18:34 +0100, Gabriel Paubert wrote:

> Timer is also restored from RTC on wakeup on powerbooks, so=20
> there is already something under arch/powerpc...

Right :) Sending a patch in a minute.

johannes

--=-an/5wNr5OlSu7oLhnO+V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFf/QG/ETPhpq3jKURAiMKAJ0ZoACDOrqNabpFVhxfWOI+LbPIzgCfXIGg
IRyxbEHa/s6ehr1fe3Y1Q2c=
=80dL
-----END PGP SIGNATURE-----

--=-an/5wNr5OlSu7oLhnO+V--
