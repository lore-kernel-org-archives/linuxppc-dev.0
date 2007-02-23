Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E7CADDE44
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 07:24:57 +1100 (EST)
Subject: Re: rtc suspend()/resume() restores system clock
From: Johannes Berg <johannes@sipsolutions.net>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0702231927220.8712@poirot.grange>
References: <200702211929.17203.david-b@pacbell.net>
	<200702211950.22422.david-b@pacbell.net>
	<Pine.LNX.4.60.0702222352460.6771@poirot.grange>
	<1172229450.3870.5.camel@johannes.berg>
	<Pine.LNX.4.60.0702231927220.8712@poirot.grange>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-JjbS1zQ0owr6QPZ/V+s1"
Date: Fri, 23 Feb 2007 21:24:35 +0100
Message-Id: <1172262275.3870.65.camel@johannes.berg>
Mime-Version: 1.0
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, Torrance <torrance123@gmail.com>,
	linux-pm@lists.osdl.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	john stultz <johnstul@us.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-JjbS1zQ0owr6QPZ/V+s1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-02-23 at 19:31 +0100, Guennadi Liakhovetski wrote:

> Johannes, is there any special meaning in "migrate all of powerpc to=20
> genrtc"? Or is it just porting every single rtc driver to the generic rtc=
=20
> API, moving it under drivers/rtc and adjusting its users or are there any=
=20
> global changes required to arch/powerpc?

I don't know. powerpc has some platform-specific rtc hooks that will
want conversion (or deletion?), I think.

johannes

--=-JjbS1zQ0owr6QPZ/V+s1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF302D/ETPhpq3jKURAo4sAKCFgLQ4ijCOpAuiNu9f8FhP0h/IzgCfTJYH
HgAnaJqH7UX5RnEWy+kV9zE=
=Fm8Y
-----END PGP SIGNATURE-----

--=-JjbS1zQ0owr6QPZ/V+s1--
