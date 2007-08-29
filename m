Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83CC5DDD07
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 20:31:08 +1000 (EST)
Subject: Re: [PATCH, RFC] linkstation: implement standby
From: Johannes Berg <johannes@sipsolutions.net>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0708290015580.3552@poirot.grange>
References: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
	<1188214327.7837.9.camel@johannes.berg>
	<Pine.LNX.4.60.0708290015580.3552@poirot.grange>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LYa5Qdaw79xbeo7vSDHy"
Date: Wed, 29 Aug 2007 12:32:18 +0200
Message-Id: <1188383538.19891.8.camel@johannes.berg>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-LYa5Qdaw79xbeo7vSDHy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-08-29 at 00:30 +0200, Guennadi Liakhovetski wrote:

> > > +#ifdef CONFIG_PM
> >=20
> > some of those probably want to be CONFIG_PM_SLEEP now.
>=20
> Well, I wasn't sure when PM can be used not meaning PM_SLEEP, so, I left=20
> PM for now. Can certainly change, if it really matters.

You end up compiling more code than necessary if PM_SLEEP is disabled
but PM is enabled (i.e. runtime powermanagement enabled but no sleep
states)

johannes

--=-LYa5Qdaw79xbeo7vSDHy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBG1Usy/ETPhpq3jKURAj2bAJ9rcatEc2DlfM7nMUqVSTldOpOB6wCfW/kF
JU4UWPdFXqZg4WkYl4738x0=
=D0k3
-----END PGP SIGNATURE-----

--=-LYa5Qdaw79xbeo7vSDHy--
