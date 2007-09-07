Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D59D4DDF2C
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 05:25:05 +1000 (EST)
Subject: Re: [RFC/PATCH 2/2] Generic clockevents and no-idle-HZ for PowerPC
From: Johannes Berg <johannes@sipsolutions.net>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070907191616.GB6765@lixom.net>
References: <18144.4702.673658.336384@cargo.ozlabs.ibm.com>
	<1189173891.28781.162.camel@johannes.berg>
	<20070907191616.GB6765@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ZHmaNJLv/t2WPKA9Aibs"
Date: Fri, 07 Sep 2007 21:26:28 +0200
Message-Id: <1189193188.28781.193.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ZHmaNJLv/t2WPKA9Aibs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-09-07 at 14:16 -0500, Olof Johansson wrote:
> On Fri, Sep 07, 2007 at 04:04:51PM +0200, Johannes Berg wrote:
> > On Fri, 2007-09-07 at 00:44 +1000, Paul Mackerras wrote:
> > > This creates a clockevent for the PowerPC decrementer and registers i=
t
> > > with the generic clock/timer system, and implements the dynamic ticks
> > > (no idle HZ) option for PowerPC.
> >=20
> > I tried both patches applied and with/without CONFIG_NOHZ but my quad G=
5
> > won't boot. Anybody else have more luck?
>=20
> Did you try with the two changes I suggested? Patch below.

No, I hadn't dug through mail yet. I'm away from the machine, will give
it a try early next week. Thanks!

johannes

--=-ZHmaNJLv/t2WPKA9Aibs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBG4aXk/ETPhpq3jKURAmBjAKCduJbcI9Pr0wrtSVPbKrwgHNkHtgCeMumZ
YCXpC6CAnRqIbsujcpAlv0o=
=CwLW
-----END PGP SIGNATURE-----

--=-ZHmaNJLv/t2WPKA9Aibs--
