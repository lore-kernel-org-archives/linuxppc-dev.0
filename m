Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B8DFDDDE3
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 23:31:37 +1100 (EST)
Subject: Re: adding more machines to snd-aoa
From: Johannes Berg <johannes@sipsolutions.net>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20081024122616.GA19424@iram.es>
References: <1224769461.6002.12.camel@johannes.berg>
	<20081023153510.GA28277@iram.es>
	<1224776462.6002.45.camel@johannes.berg>
	<20081023164302.GA29454@iram.es>
	<1224837623.6002.84.camel@johannes.berg>
	<20081024122616.GA19424@iram.es>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-gZqPgE/+bCkHFTW+v0ev"
Date: Fri, 24 Oct 2008 14:30:19 +0200
Message-Id: <1224851419.611.5.camel@johannes.berg>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux User #330250 <linuxuser330250@gmx.net>,
	Sjoerd Simons <sjoerd@luon.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-gZqPgE/+bCkHFTW+v0ev
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-10-24 at 14:26 +0200, Gabriel Paubert wrote:

> > Right. I'll assume it has a microphone too, built-in.=20
>=20
> I doubt it:=20
> - no mention found in the doc
> - it seems to be output-only (#-inputs in the device tree is 0,
> #-outputs is 3).

Yeah, I've disabled it in the patch I sent you.

> I could also send you the device tree of my PowerBook G3: it does
> have the device-id property with a value of 10, but the parent
> node is called davbus instead of i2s. That one definitely has
> a microphone...

No, I don't really care about davbus at this point. TBH, I don't care
much about the other machines either, and there are lots... I'll have to
find a way to map the #-inputs and #-outputs to the information
otherwise I'll have to dig out all the manuals or something...

> > Could you try the
> > patch below, enable all snd-aoa modules and see what happens?
> >=20
>=20
> I won't have time in the next few days, sorry.=20

No worries, let me know when you can.

johannes

--=-gZqPgE/+bCkHFTW+v0ev
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJAb/XAAoJEKVg1VMiehFYmvUP/ikVLzc+9bdAd5dkxeIPtLAJ
K6V9YwjdyO6g2dOCBI44OQIIiFOeLKV8iqnRNALFCKv8l6n/JIKuwoubY7NQs+Dy
m9kx+o1jOQEHASrP6Tc4HJkWeYcdAdZn8l6wtFkrhrWbbd6Ng00kLaorCfP9/ie5
axLUWHLS2uAqBv3WUIscOqRj+yE9Yzc/6xtPy6xt3nnYT3nS4UBOu8OIyQUyHL75
nU7BigziMAsqCwvsvBXKl6odd2njxb+t49wvDG8/78CKAZhg16m9W7PRKiud9CT9
ZNW8SyejmJu27X5tnU1gUTmrxdlYflBD5TLv+KlFSvE/LB9Vdzi4Q6feErcZlwDt
DonYQiMRzPxY7v4gxLv9dd9Nn2pF2YlwEBamLYhO9nHiWDezpqoOY93bTohRGZc+
5PUk+WftdYjnkPOAP/YU/aqXfq4x9tz1dGbSH/ppYVnFxbb322MT2Ht4FkeGjwUF
xfBduxAY22dFUEbbZhZmayEC7I3NodJtdqRxV6c3bX83YEtjBNLZJQGMjuTh0U5R
NnFrHmBs2jKMWgfP3sPrLZfhL/1Sreqj2BIbsuXZ6NvHQuMi3u/iv496CmrYdnmF
Egau8kPmOn9uNEq0xzV7+oxTo3RPrfw4DVh6uDd6fnHvrtk6EagHbI3lJAYfgQ81
1iSGlkVlBisVm3RlUOE0
=wUpF
-----END PGP SIGNATURE-----

--=-gZqPgE/+bCkHFTW+v0ev--
