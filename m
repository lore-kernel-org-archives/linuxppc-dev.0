Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3182667A5B
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 22:42:00 +1000 (EST)
Subject: Re: [snd] looking for layout-ids
From: Johannes Berg <johannes@sipsolutions.net>
To: Ken Moffat <zarniwhoop@ntlworld.com>
In-Reply-To: <20060525123247.GA19308@deepthought.linux.bogus>
References: <1148553785.11759.12.camel@johannes.berg>
	<20060525123247.GA19308@deepthought.linux.bogus>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nf6CIXKP3+RMXhF7BII+"
Date: Thu, 25 May 2006 14:41:48 +0200
Message-Id: <1148560908.11759.25.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-nf6CIXKP3+RMXhF7BII+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey,

>  How about 0x3c and 0x3d (PowerMac9,1) ?  I can't see anything in
> snd-aoa-fabric-layout that matches 60 or 61.  I last tried to play
> with this a few weeks ago, but gave up with what I assumed were
> config problems (undefined symbols) and had too many other things to
> get on with.

undefined symbols are usually because alsa isn't configured, or snd-pcm
isn't loaded.

>  Certainly, this is one of the machines where loading snd-powermac
> is catastrophic.

Catastrophic? How so? Anyway, I don't care much :)

Anyway, if you want to give it a spin, try the latest snd-aoa (see
http://johannes.sipsolutions.net/Projects/snd-aoa/ for a description).
It should report an unknown layout, which are those two ones you
described above. I think you probably have a tas and topaz combination,
so if you get i2sbus to load, I might be able to give you a patch to
test.

johannes

--=-nf6CIXKP3+RMXhF7BII+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHWmCqVg1VMiehFYAQIe0hAAs8KzS4XK0nrURGAmTWGyZidYUuFst5Xd
FjNea0fRM7P1Hyh9I9D3SZ/Gz3YiqLT6vVbkHL7GdsEslaIgVluEHUifYqyVnZTh
fDKdJ0MqL/zEKExT1pl0bnbpnSjAiqqWJ5mken1so86V6iYHH1ypfQIK07HLSJR/
QpUjqYFpsHL7Gf9xyjGkUjPEXgRkNNbBrPA/bmbqallB7tCsXxnkVBl9CupR7Kij
3tYLNqyksY6GhNeR8bX/jtCLtFQy5aVDyohfiaoo1UedQz5DZJXyOTOVEcNUzasy
9QruijoxpvnugEEONDnM3ub0jFJ0auqL4OqopKvtXE+5tEgTQQYkBjfejQ7HwNBR
jJZwNZQ++PnZ+NBi+C+v4vGOjkQn5fVoL442juTKrbG0XIHtZxEM2XIxOd+8YK8Q
ub4BTUdvelPiHqV0ddS2jfxcGYtjQgQkqImgXA7ECGtLH4VIBEBNh0l1okMGRZIz
NNmHwa/46yv3uGSzOtWGfrk/vIcH5LnRWlZnOWKcBJbAGHL8MJGZucS1k3IFY9wL
Gim86j3Aic4npWpAgsP5EieB4z+VdUek5h0cKg/nu60TuKmws/8w1imocU5a08O/
UnwG6Hb4idyxBzhLj55k+jgnpBh3mgeUUJ9cWEJ83rFW7QLksStkI78liLufn7pJ
UAlzFvsh9xQ=
=azfW
-----END PGP SIGNATURE-----

--=-nf6CIXKP3+RMXhF7BII+--
