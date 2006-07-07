Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 574AC679F0
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 18:05:04 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 01/12] snd-powermac: no longer
	handle	anything with a layout-id property
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1152250720.9862.32.camel@localhost.localdomain>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
	<s5hac7yvfhe.wl%tiwai@suse.de> <jehd26aa25.fsf@sykes.suse.de>
	<jeu0631xpr.fsf@sykes.suse.de> <1151619973.22380.50.camel@mindpipe>
	<jehd231rjx.fsf@sykes.suse.de>
	<1152250720.9862.32.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-VaSI8/8qr3X0MFFBbTnv"
Date: Fri, 07 Jul 2006 10:04:37 +0200
Message-Id: <1152259477.15068.15.camel@localhost>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
	netstar@gatheringofgray.com, linuxppc-dev@ozlabs.org,
	Lee Revell <rlrevell@joe-job.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-VaSI8/8qr3X0MFFBbTnv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-07-07 at 15:38 +1000, Benjamin Herrenschmidt wrote:

> There is still an issue... wether to enable softvol or not... With
> snd-aoa, the card name is always the same but wether it has hardware
> volume control or not (Toonie doesn't) is not known... Alsa should have
> ways to add softvol automatically if no master volume control exist.

Hm, good point. I probably need to completely revamp the card handling
and not create a card object before the codecs are registered. That way,
I could influence the naming through the codecs.

johannes

--=-VaSI8/8qr3X0MFFBbTnv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARK4Vk6Vg1VMiehFYAQKg/RAAlKLk8tg6GGMcCxKnJrc4tfeNBrzcidKq
ynVfy4FLiLcyaT9vajGZwPg+wdBVFInlKMVJWhRAvlu7x/s2FpZTL9jLgXINAeIP
LbfUa1zQiKSKK3GDo6vBTVvXJDfnWuY+Wjh0R8a7isPH8n5yfdYnTL2x+59bwh2/
JWw1LACnrURGY3gfUkULEFVglwRvIk0VuSlDhc/cfKqwTlHIvwvEX+V/vPm1KlOJ
8RjYes+6rbQ9Ham3XHbfpJr1iCbFrYJnZe+gJj9NCCLMItxOC5MCdOg5J7xjwYlh
fI9WQZJZQfBYz+Glp3IGjHMDNFb0+8rgPzzSl0WmCG4xVR/tcyEkkgyLcsunMBV1
l9s03fkNxcDn8cjeyu/701zuJMG/D7+BNz528yaSfYqPYRHCiZd9lx8CmKa05jWH
4pYVNF4NUsfe2vh5UHLz0bTXhH/+zI0/yFGRAwt8jsYVFO+cX5319JH7JledFso3
6tF2L1hfdRQAw4ZVnkeuSGx8GS39k2hlzDe8zpS9pEND00zwuygl920UvNIL67pZ
v1tR6A03xglwJi8tdKBB4gd0GKgv4jjT/VxBVoOc2ktuC6J5gulO9i9caZxxZAiV
aUmMFfwGeM9zQEfOd43gfdBIOkcNRk/TGFnOFt4YW7sLnwDzyDG4ZmqCqEDeKYD1
A6yvrrmJMII=
=/4Me
-----END PGP SIGNATURE-----

--=-VaSI8/8qr3X0MFFBbTnv--
