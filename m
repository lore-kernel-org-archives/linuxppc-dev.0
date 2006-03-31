Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2718D679EA
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 01:47:34 +1100 (EST)
Subject: Re: snd-aoa: new apple sound driver
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1143547826.13615.24.camel@localhost>
References: <1143547826.13615.24.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-kSum+LCKaZIlq94+igdP"
Date: Fri, 31 Mar 2006 16:47:24 +0200
Message-Id: <1143816444.23254.3.camel@localhost>
Mime-Version: 1.0
Cc: debian-powerpc <debian-powerpc@lists.debian.org>,
	Alastair Poole <netstar@gatheringofgray.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-kSum+LCKaZIlq94+igdP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Just FYI if anyone's thinking about using this:

> GPIO stuff.

Started, you can now turn on/off the lineout/speakers/headphones (note:
powerbooks have line out, not headphones despite the symbol on them),
but automatic switching isn't done yet.
Only on new machines with PMFs though.

> Clock setting.

Done except for master/slave switching.

johannes

--=-kSum+LCKaZIlq94+igdP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARC1A+6Vg1VMiehFYAQIDfA//W0AFV0ZUzNFjuLRODhJoTYFRQrE2tHd6
BmTiU8DtFKySA85Dg2nPQ3esN/82qEeIBJlJDo4LVb50LAJ3y2pi7utkFZAJVJJy
c4LdsExjnJ1ArnX6ULz0Tjq9mJ/NV5adPtY7Gox6y81sShUznCOPMc4C9Rg+qh02
oSX5JRDNBRzLFHr/L4o7CRHUid/TmMX9+A8cRTOmCryqDSnV4MEN/tLdLMQJ66k6
uSnkD28/AGz1Ra0773kHa2+y0ehRZjtLet2EdLtTwJOh00fbVTtun4JJxGYCB7vH
NB918STns1R45UGS6VQM/Q62OGGh0UmpO9Tcq45HBes84JBv0kAKC4OFtVlE1kVf
zJqDeUAa54Wref2nBgD+zKSR65LX92im2LNY2FB7Z7xbBD7qw417knBnDEvkz2DE
qIGwe+Z6vbMIht1pMEPNJHxs6nfUJ6NC2oLoc0X1ViudU5ypUqVFJtPn87U1ogio
radMLaTvji0k1wPJQdd9TlnvbSNt7J39ZJUmhz2KS04p8fRcq2vlovwbpsyP46iC
1YzVADWQi/sRKmLdwSZf37OHfHjEUG7/lyzHKDis4Vaz6M6kQrG6xyascTTNGkdl
6T/uNAsqoHLZDtSSDkfvwrjlHxw6SlvQYwzpG5dJ28KOIRXgg5yyMFc1C5DYnnwq
XMYJHhvteFg=
=1LHi
-----END PGP SIGNATURE-----

--=-kSum+LCKaZIlq94+igdP--
