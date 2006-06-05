Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1324267A3F
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jun 2006 22:44:09 +1000 (EST)
Subject: Re: snd-aoa: using feature calls for GPIOs
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1149477113.8543.1.camel@localhost.localdomain>
References: <1149187342.7875.9.camel@johannes>
	<1149477113.8543.1.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jAj+iVpnvdLllJv7W+pa"
Date: Mon, 05 Jun 2006 14:43:57 +0200
Message-Id: <1149511437.16022.7.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-jAj+iVpnvdLllJv7W+pa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-06-05 at 13:11 +1000, Benjamin Herrenschmidt wrote:

> The platform function write bit 0 of the register only afaik. Bit 0x4 is
> "output enable" so if you clear it, your GPIOs won't do much :)

Aha! Yes, I had read the code wrongly, I figured the pmfs only wrote but
in fact there's a read/mask too. Thanks :)

> Also, bit 0x2 is the input data, though it's only useful if "output
> enable" is cleared (or it will just reflect the state of the outputs).

Yeah ok, I'll change/retest the patch during the week.

Thanks,
johannes

--=-jAj+iVpnvdLllJv7W+pa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIQnCqVg1VMiehFYAQKQvQ//QU6tog8EM4lvQbEwSMzVIhUqK/EOd40m
1fzjmP+jcs3CEo/ZayuBxxL2ickoMpPSLSAZ+A3Unwof0S8SBnkPiu4XKYHBmYq6
JonL/v18ge06jcwpxAsUljB0Zgl5K8AStwgu3nGy8YgtATUiGXR5C976bCaEZy2D
kWeBbfdoF5Z9JbjYOfsQmaJI2v25OID5xtRSWedQwV7Y+1Afuqu4faT3FXYGNrt2
zgshaLFC1ReUXayjJM6ClbRbrgLROKcqrRBE7+9xK4T1x0YJvoA7KR5xoGnz4bhA
lNAtnlI5vZmOZP93G5V5cwNT7YQt8tP9+B9p1Fz+y/XJFg92qCcZOSBc99UnNYl0
aJ+83qqXqzTBdk2nV2RV9K35jhGkQtK1zluK+//mqZAxLkcIjZuYuV8WNKc+DDHP
nsSMgvSrWttZNMtaa0JmD2yVuf8clCQO5LAtqE5iqX/+kSr93tgRdj7DVsT9Ne56
F7LhIKGneHK2a8gCMIC0tDpJVRw1ctCgKcln2oFrtnBLluc0JyO252tA92cyowkw
ENEWtnRnMdhHj3fmSuCnoQKndP8JPNld3K8c2URzBjWGbfu0kowtpN6GuL1fevcL
0yvHexvYQNZWG8zEq1oO1VNdoRmttTYoywPfv7ZlWZLMe07hBdUajxS1xkeVjAXY
40XhAFP5V+g=
=cxUf
-----END PGP SIGNATURE-----

--=-jAj+iVpnvdLllJv7W+pa--
