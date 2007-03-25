Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3328FDDE05
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Mar 2007 18:26:18 +1000 (EST)
Subject: Re: more bogomips :)
From: Johannes Berg <johannes@sipsolutions.net>
To: Christian Kujau <lists@nerdbynature.de>
In-Reply-To: <Pine.LNX.4.64.0703241645360.10654@sheep.housecafe.de>
References: <Pine.LNX.4.64.0703241645360.10654@sheep.housecafe.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xfH6UBvFLo5AWOrolQt3"
Date: Sun, 25 Mar 2007 10:26:07 +0200
Message-Id: <1174811167.20440.6.camel@johannes.berg>
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


--=-xfH6UBvFLo5AWOrolQt3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-03-24 at 16:48 +0000, Christian Kujau wrote:

> -bogomips       : 36.73

This value was retrieved when your CPU was set to the lower speed by cpu
freq.

> +bogomips       : 73.47

And that when it was at the higher speed.

> It seems that with a more recent kernel, bogomips have doubled (both=20
> with CONFIG_HZ=3D1000, if this matters). How comes?

They've always switched between those values afaik.

Interesting. This does raise the question of whether it's the right
thing to do, and it looks like a bug to me. The cpufreq core code scales
the loops per jiffy simply by the clock frequency difference which
(since we boot with slow frequency at least on my powerbook) means that
all our delays get to be twice as long during clocked-up operation
because the timebase doesn't change with cpufreq.

johannes

--=-xfH6UBvFLo5AWOrolQt3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGBjIf/ETPhpq3jKURAku4AJ0bFnloczd6AzTqROo0wfUzKf5tuwCcDYhu
xD76/nJeJRTziTmpkL30zc8=
=hWTI
-----END PGP SIGNATURE-----

--=-xfH6UBvFLo5AWOrolQt3--
