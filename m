Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A92A8DDF39
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 18:26:13 +1000 (EST)
Subject: Re: [PATCH] powermac: proper time of day after resume
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17976.5964.593278.752595@cargo.ozlabs.ibm.com>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.386891000@sipsolutions.net>
	<1169620444.18754.66.camel@localhost.localdomain>
	<1170357390.4036.9.camel@johannes.berg>
	<17976.5964.593278.752595@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-4rKYgrOSF9HBkfi9VjD3"
Date: Wed, 02 May 2007 10:26:53 +0200
Message-Id: <1178094413.13233.45.camel@johannes.berg>
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


--=-4rKYgrOSF9HBkfi9VjD3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 14:45 +1000, Paul Mackerras wrote:

> > +	/* get current RTC time and convert to seconds */
> > +	get_rtc_time(&cur_rtc_tm);
> > +	rtc_tm_to_time(&cur_rtc_tm, &cur_rtc_time);
>=20
> Why not just use get_boot_time() here?

Hm, I don't quite remember. I think I originally had it that way and Ben
asked me to do this, but I may be wrong. Ben, can you remember anything
of that? If not I'll dig through my old mail.

>   Or if not that, then use
> mktime() instead of rtc_tm_to_time().  Either way we don't need to
> select RTC_LIB.

Hm, I'll have to look into mktime() and see if I can change that.

johannes

--=-4rKYgrOSF9HBkfi9VjD3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOEtN/ETPhpq3jKURAjm6AJ4k2TvMC9zKI3vXwQMmvNCBqOYz+gCgsv7U
Pccwy+f0hktC/Z3C+JgWZAQ=
=We6p
-----END PGP SIGNATURE-----

--=-4rKYgrOSF9HBkfi9VjD3--
