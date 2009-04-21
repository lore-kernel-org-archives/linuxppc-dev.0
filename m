Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6726DDDFD2
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 19:42:22 +1000 (EST)
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20090421112921.373fae89@hyperion.delvare>
References: <20090420225425.2a150a4f@hyperion.delvare>
	<1240261492.4632.21.camel@johannes.local>
	<20090421112921.373fae89@hyperion.delvare>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-nrMTzKGHld4lDBFdObB3"
Date: Tue, 21 Apr 2009 11:41:43 +0200
Message-Id: <1240306903.17388.14.camel@johannes.local>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-nrMTzKGHld4lDBFdObB3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> > Have you taken care of snd-powermac similarly?
>=20
> Yes I did, see my patch "keywest: Convert to new-style i2c driver" to
> the alsa-devel and linuxppc-dev mailing lists:
> http://ozlabs.org/pipermail/linuxppc-dev/2009-April/070884.html
>=20
> Would you be able to test this patch? This would be very welcome. I can
> resend it to you if it helps.

Cool. No, was just wondering, I can't test it, none of my machines can
use that (which is why I wrote aoa, heh)

johannes

--=-nrMTzKGHld4lDBFdObB3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ7ZTUAAoJEKVg1VMiehFY7TsP/0Z4xG04Sm2WJz2tLnne1xlB
Ha8PgerkkM/8ivdwFZhKZRu1uqd69xxPjNOaP4bPjgczT15/AyEM6K7Vb1mdhfVI
RJOpDmOc87fIgcaKP0sFXhkNONCDzvCezErG/5THoCQGrNDf3CyXyamKPvHrYgyx
FJ11t1RlaJVlh/KoUN0bQ+zCzFlHSzYynIAjseJ3V5GA2K6AWoAGJ1N1F1Y/hlq6
buOtBFqgoncXH3AQQfcc/WBfQy6hKxqyp72CTxjR8JW/noEshSRIxbFxIY4ZhId/
RJoJgn4iBxGFM24CpwDyWQ8M4MRwFCROUR1HecKcE/ZOjHge5bztP+ngOQY48yCl
q4aIh0cwB+5RWPLxhqE/5LuN96CrGx1GIycZHaPobG1ci+V2i9cEDPNNDQJFjGFI
mZUy5H4hsvxrnLjoUAd0O+23BplY/iVjZqhYobGPbszJUUPfy/Lp1gg3esNkG7/4
5pTMfa2rdp2L1r3HDoriUBodvcbNTIeFLvMkxbJUlVz9/OzcIFYC+ROzed5IRymk
2Ul3S/B5Zi7ZlwA+yzKG3Uz9a/mLkOEUt+i1GZdGCHZzW8yn2xpvAqY1BqMOqFPq
/ntQHyxYWvt5FqUs6gLWeOK0Mwu43s+/5c6R4io5HSWwuHK2hNkeR8SN2w1gHCtE
TeBEpJgQfhoDtgfXg91i
=kzNu
-----END PGP SIGNATURE-----

--=-nrMTzKGHld4lDBFdObB3--
