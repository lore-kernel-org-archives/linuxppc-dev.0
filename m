Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F1B59DDF67
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Mar 2007 18:31:10 +1000 (EST)
Subject: Re: more bogomips :)
From: Johannes Berg <johannes@sipsolutions.net>
To: Christian Kujau <lists@nerdbynature.de>
In-Reply-To: <1174811167.20440.6.camel@johannes.berg>
References: <Pine.LNX.4.64.0703241645360.10654@sheep.housecafe.de>
	<1174811167.20440.6.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9OFJyzuJakm/lKfKF10h"
Date: Sun, 25 Mar 2007 10:31:03 +0200
Message-Id: <1174811463.20440.7.camel@johannes.berg>
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


--=-9OFJyzuJakm/lKfKF10h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-03-25 at 10:26 +0200, Johannes Berg wrote:

> Interesting. This does raise the question of whether it's the right
> thing to do, and it looks like a bug to me.
[...]
> because the timebase doesn't change with cpufreq.

Thinko. We don't use lpj for udelay anyway.

johannes

--=-9OFJyzuJakm/lKfKF10h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGBjNH/ETPhpq3jKURAtsZAJ4jnsYhOFjyH/WuG5wVEE6++Li8XQCgifxt
XYHP78GbZ2JvaB5XrFfIJt0=
=jups
-----END PGP SIGNATURE-----

--=-9OFJyzuJakm/lKfKF10h--
