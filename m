Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74BDD67B37
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 08:11:16 +1000 (EST)
Subject: Re: [OOPS] 2.6.17-rc3 on an mpc8241
From: Johannes Berg <johannes@sipsolutions.net>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0606150007430.12545@poirot.grange>
References: <Pine.LNX.4.60.0606142245370.12545@poirot.grange>
	<1150318658.13958.26.camel@johannes.berg>
	<Pine.LNX.4.60.0606142300120.12545@poirot.grange>
	<Pine.LNX.4.60.0606150007430.12545@poirot.grange>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-zIaxQ1RnwkQHsFdsnrxg"
Date: Thu, 15 Jun 2006 00:11:06 +0200
Message-Id: <1150323066.13958.28.camel@johannes.berg>
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


--=-zIaxQ1RnwkQHsFdsnrxg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-06-15 at 00:08 +0200, Guennadi Liakhovetski wrote:

> Ghm, ok, I know what that was - the very same bug I myself reported=20
> earlier in asm-offsets...=20

in asm-offsets? Are you saying that you know what caused this and I
shouldn't bother looking at it?

> how do you say it in English - twice in the same=20
> trap?:-)

No idea :)

johannes

--=-zIaxQ1RnwkQHsFdsnrxg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARJCJeKVg1VMiehFYAQImag//Xh/wi9dJcRJfYt3xB9bZqueBOyH1D/q6
Cbec186DuOIlK8tlddP+QLu3iyUBu6E1Y83Lv4Kr+mkDNyVxB1agHP6UBpyYoEb1
7DHYnO9M7RAl7H2OcYzcFOkpIrESlkc70ocZJdjcjf0/cV9bqRBL+sgFr2zLZQ8O
XsmffbRtPrOPmcGKrOLzV1W5lrJiOlL4xYOJOz6Uj5sYXDrFudF68zri+QA5oTzj
kCHP11Q2LGlA5JhzXEUDgEK4OyMeZe1IfZXSTk+NAB/B3lGRVfZiPaoZslCPUMjf
RwdLxD1yG6jK3ITye55CYQ/4sdbPd0grTSdIAG/CSSFm1ejAV1VfUQqX6lSuBaOe
VJY4OZDwNsuLoLiPvWjpPD4ZedrN6yoBV9CLzpiseeWCa9XQjrFAPZFja+We7tu1
ZDRREr5nvMvKTigudnB/Io/R1q0ZQZ7tchzeJ6cyD3p5FRnytj08EWlbL08z5gFY
MsoCesQd17+vaA8xNpPKgTd9pJgmSG2X/gtukuLiFcegKBjpfqhIDtW7lzvmfJCv
TXqZdS0UJEYM/j4kGskic0Dz/Bm9Yyfr4yvXqh0xhdXCdg2cZj8ziKGQvprnqKxQ
bQSZX9qfGgzsG704ahGDFLZaeNhMSYZMUqs+hDYU5YO+E4T0EKoTy8y3/wwf6jgc
uvwtJ+ZhdT4=
=H5vS
-----END PGP SIGNATURE-----

--=-zIaxQ1RnwkQHsFdsnrxg--
