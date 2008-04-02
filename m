Return-Path: <johannes@sipsolutions.net>
Subject: Re: [PATCH 0/4] [POWERPC] lockdep support for ppc64
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@ozlabs.org>
In-Reply-To: <1207134128.10388.254.camel@pasglop>
References: <1207122728.672673.111194574046.qpush@grosgo>
	<1207129830.10910.25.camel@johannes.berg>
	<1207134128.10388.254.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+mtpSbjXJq5fZxF+Z2OO"
Date: Wed, 02 Apr 2008 15:20:56 +0200
Message-Id: <1207142456.10910.42.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-+mtpSbjXJq5fZxF+Z2OO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Haven't tested this version on G5 yet btw :-) (though I had a previous
> one working internally). I tested on POWER6 pSeries and old iSeries
> (spent a while fixing the later).
>=20
> I'll run more tests tomorrow hopefully and add a few patch fixing
> some of the issues that lockdep already starting showing.

Works fine, and on my box I don't see lockdep showing issues.

Thanks for picking this up from me and rewriting it :)

johannes

--=-+mtpSbjXJq5fZxF+Z2OO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/OINqVg1VMiehFYAQK7bQ/+Od4NKKVoG8lnoI3GWev1MOj0Cg8pLo31
ikYGDJ/i03gtWBff9qGiXotD7EdFFQURVXsjM0nAqp1iuOocou/zrUUyUrhIAhvu
l2imvNAuaDbZrBV4awSr9SxK2bxJkYb5iczuHHOav2F4wbihajNe6RTHV4K3vAhi
vd/7gD/06xRLpDwEAF71B9+0rE8XSnK7bAcOpZk3qUrgEXONUEKWHd+Yj1V5bq7j
3viB1e8VNSkM+CB5CdRofGIzew7UEYm8IV3lhbwYBegnsfq90iXAM1YXIRh3B1GW
1vJ0V+SZo6YS6YpO+R5wX1CqOX+kjU0cFmC8x+BShQmX+hswfvjQOwhfnLUl4Q6O
gcCCiHrUxXjPGXjG9N78Fm6iAypMhjeOY4DwRx0S218Ml8Vr5GwL4Li7EyQ4DNw/
PFgPJr2Zcpop4llxmkBQQXAPV3IctXs22UkouEhQAumaNLvRnNG0jj2eyIHAyd/o
lDlsy4ZnCjFccgTGV7SqU/K100RRtnSqr+FOsMuzPyoM/VGfLCpgfAXHSGx2xslP
frIcZPHLP32+R/+4vLAsui1pd3EpofaRXce1WaGh0QchxsGXFKpNFLE01bNrmt77
482D3mH7XKMXnQWyF/rhibP0IbtcvAbU/JTUSFJoXDH0CP6B6TtxDjsnRJhcgtKi
Uo0O6veOaWo=
=Cout
-----END PGP SIGNATURE-----

--=-+mtpSbjXJq5fZxF+Z2OO--
