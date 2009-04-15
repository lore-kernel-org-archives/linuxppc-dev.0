Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 174DCDDF8C
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 23:01:23 +1000 (EST)
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c
	drivers (v3)
From: Johannes Berg <johannes@sipsolutions.net>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20090415142225.2bfd37f6@hyperion.delvare>
References: <20090415142225.2bfd37f6@hyperion.delvare>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-w85SpofeRfo4bEvIEeNY"
Date: Wed, 15 Apr 2009 15:00:44 +0200
Message-Id: <1239800444.9071.5.camel@johannes.local>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-w85SpofeRfo4bEvIEeNY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-15 at 14:22 +0200, Jean Delvare wrote:
> The legacy i2c binding model is going away soon, so convert the AOA
> codec drivers to the new model or they'll break.
>=20
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Tested-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
> Johannes, this is a reworked patch which assumes that the onyx codec
> probing can fail. It's not exactly clean but that's the easiest
> approach for now. Can you please give it a try? Thanks.

This works.
Tested-by: Johannes Berg <johannes@sipsolutions.net> [quad G5]

johannes

--=-w85SpofeRfo4bEvIEeNY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5dp6AAoJEKVg1VMiehFY08QP/1wZZeUbmRig8pLNDNJT0HVS
NsV2M3aVHADncVNzJc+Npu+BT7j5yxmgOCxGVCg/YnODNa2agh0lm4djRJtrBwaw
qrCYtyBwG+RWs/ERCBwjGV5rlgaZP6FqnvF47zByexzUyRWJ6YhFIYlQwx47uOyM
3/EJSYi6Naitd2q4wEI2lFMXgYvTxZ7q0bvsz6c6Wh/kRqtcy+QdIpgtzjzmHfCK
/RXggG2L/UGKfaaRrT+Now/XqAKWP6xCewN9NimKmeLKCohWGSHKk5uGdQwh4Xg3
K39aXZUVJFNBzpfmHtftN7Xl9P5i9At6zs5GgORgQBj5MxY0ODwEQUDlHyfNga0n
+GzSvQLfyNGfvcaUFOutB9NuutnQ/+xqKcgt0RACHDiXgc3X6ji4pcI0NZiYssd+
CoXtsQ40IO+gY8Mv1/hZ2np5tKseA8mnwHCN1qa913BfXpKOD7OmxXplabtEjM5b
zjmMwBIVzti/Uy9i93doyXNIBKzb5oPBq3jf74MllpUp6BqwJRsMZTg49ul0e8Bu
LPnooJbbj+Lpu2hFPQUsQ070RgkT+XtPFjewhO+j0wkbXu3SWy61Gubclp3OccTc
jkKN7CTpggAD7WOkryjTXzg2ao8lpe1ajZX3vSVGvQqhp9Odge65LHX3ChGWa9xI
Ayn+8g8EjM7Du0Z6oaXS
=O4uf
-----END PGP SIGNATURE-----

--=-w85SpofeRfo4bEvIEeNY--
