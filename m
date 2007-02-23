Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50A7FDDE36
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 22:17:53 +1100 (EST)
Subject: Re: several messages
From: Johannes Berg <johannes@sipsolutions.net>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0702222352460.6771@poirot.grange>
References: <200702211929.17203.david-b@pacbell.net>
	<200702211950.22422.david-b@pacbell.net>
	<Pine.LNX.4.60.0702222352460.6771@poirot.grange>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-cDwk91uBwu/qFu5OL5oW"
Date: Fri, 23 Feb 2007 12:17:30 +0100
Message-Id: <1172229450.3870.5.camel@johannes.berg>
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


--=-cDwk91uBwu/qFu5OL5oW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-02-22 at 23:58 +0100, Guennadi Liakhovetski wrote:

> I think, we only want 1, right? And the latter seems to be more generic /=
=20
> platform independent? And as a side-effect, powermac would have to migrat=
e=20
> to generic rtc:-)

Can we migrate all of powerpc to genrtc? But yes, I agree. Had enough to
do though already to get suspend working :)

johannes

--=-cDwk91uBwu/qFu5OL5oW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF3s1K/ETPhpq3jKURAqBaAKCjpO/qgcV3Np3alMq15nGj5PhYJwCfdoXp
kJ5f8zbUKkdzRtWtwHQOV0Q=
=CzDY
-----END PGP SIGNATURE-----

--=-cDwk91uBwu/qFu5OL5oW--
