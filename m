Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 422F167A64
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 20:39:29 +1000 (EST)
Subject: Re: PowerMac7,3 sound (was: PowerBook5,4 -- no sound?)
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <je3bf85twf.fsf@sykes.suse.de>
References: <878xq51t61.fsf@briny.internal.ondioline.org>
	<je1wvxo70l.fsf@sykes.suse.de>
	<1145220233.9833.11.camel@localhost.localdomain>
	<je7j5phz9j.fsf@sykes.suse.de>
	<1145231658.9833.17.camel@localhost.localdomain>
	<je3bgdhwre.fsf@sykes.suse.de>
	<1145233812.9833.21.camel@localhost.localdomain>
	<je1wvwfh7s.fsf@sykes.suse.de>
	<1145307118.3912.11.camel@localhost.localdomain>
	<1147862072.14395.25.camel@johannes>  <je3bf85twf.fsf@sykes.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6o2xfwXutl9uQpLC8g60"
Date: Thu, 18 May 2006 12:39:18 +0200
Message-Id: <1147948758.15507.52.camel@johannes>
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


--=-6o2xfwXutl9uQpLC8g60
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 21:32 +0200, Andreas Schwab wrote:

> I have the following sound resources in /proc/iomem:
>=20
>         80008000-800083ff : 0.00010000:i2s
>           80008000-800083ff : Sound DMA
>         80010000-80010fff : 0.00010000:i2s
>           80010000-80010fff : Sound Control
>=20
> I'm not sure whether the first mapping should be split, but I don't know
> much about how resource mappings work.

That looks like you have snd-powermac loaded, or some other driver,
otherwise it shouldn't show up in /proc/iomem at all. It isn't my
driver, because it would generated 'i2sbus ...' names there.

> The layout id is 36, and it has both line out and headphone, detected as =
a
> Snapper.

Hmm. What's that again? tas3004 or 3001? I'll look at the OSX layout
file.

johannes

--=-6o2xfwXutl9uQpLC8g60
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGxO06Vg1VMiehFYAQJb2A/9HLK8H/sA6rd9rSwehwBzx/CTCrVxldgg
fvE9l8pm51BLaVdUqj9IAxUBqHrwkvb+PIB2gleysQOUqURW/iP0cbaaS8qqtbfM
5/JTJbbyO7P+4oZ3a9iehTGdwnOnvQdW99Bc3X9AqNhyN9XGRaGgdm4b5ecS7myP
WWgm/HH5yLL80yNCVR8M+vzhPgfeKCj28QZeb0/pRT37OAk4VbU45fOvdlNcjZAt
XV2rFuL2UBVQi1PCf3lmFl2xJKImk2+skrVm8lbyGGS0gY+AmjoJNvoicpt3M0hI
RLAJON2od8HJtAJ0tGfiFpdhttgW7lF+0yiPsd7NSGeNz83+Mr4MNgeFppiZyaGV
q9oHERynodNstwqCBmZaClOqXgK+rNfu1PwN6iesYJWZq0uK3+eZV5UvBmM1gh2P
DABZNd6bVmluWw+ckHWUeqdjtSm9f6laLDPDE5kY2oGbo/n2mQhLTwnjcuEX7rmh
xgvl/nySHjbyEP1n18qz7E2x6afc2ff2bvIKbu2FF0rrGFIoF1ZVPEhfzGFVHfAa
Q3LrcSwsw4jo7o5bxoql9GJSSo8W/fsVOEyRj9IHNiXkRkdZ1nTeBp5CvjwDhg4j
n4nu1boLdlgrku4lzBKZ4bgylVIY97U8ltszZC8VY+eXPVtDfUiW8Y7ghpmHQwVS
5hqGyHHUPDM=
=0osM
-----END PGP SIGNATURE-----

--=-6o2xfwXutl9uQpLC8g60--
