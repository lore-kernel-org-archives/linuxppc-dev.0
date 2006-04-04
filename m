Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 68A77679E0
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2006 01:53:19 +1000 (EST)
Subject: Re: snd-aoa: new apple sound driver
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1143547826.13615.24.camel@localhost>
References: <1143547826.13615.24.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-4shF2yLTwnQl0eh1Ww5A"
Date: Tue, 04 Apr 2006 17:51:35 +0200
Message-Id: <1144165895.4282.8.camel@localhost>
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


--=-4shF2yLTwnQl0eh1Ww5A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-03-28 at 14:10 +0200, Johannes Berg wrote:

> I'm going to write a snd-aoa-codec-tas3004 soon, so
> that I can use the new code here on both of my machines.

somewhat done, but I suggest you use it only on powerbook5,6 now where I
confirmed that it works (before I add more error checking, proper
handling of some cases etc.)

johannes

--=-4shF2yLTwnQl0eh1Ww5A
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARDKWBqVg1VMiehFYAQKFMg//QBBv46GZ6lkXBsIoHOM7vbcz6SufTWFv
WA9KxOfk+QD9xLURWFD6t1mekzJoue+dlCQMd3003wWJvQIVABM7UJBpp67l7rYH
JkJI4BvJ8gg0GRKhD5orrdSMQRQkDdVDnLfAcBwQnhtNFEvBK0aoZtY4Xz3UHS7H
WJKK5614ifoEhJ9NT4++xdk7NyuVEMkiI6CXlU49xxUj7nofaegPGA8tBoAQXr7e
ZY+P9wjeU3/yuvjAcqmpz23senzWcO1mXW674L3hLXUVE5jHVsuZ1NHG1hWlQ+MM
UVbpIj3w7F5qHOlmjlvd37nSKbbZAiDZ077WKpZ2KJgg6jcnujyzV+/iVktLgz7M
yEARYrrF+iv/L1NFcTJg2kZo/IKBcFiVJQxAl12puoiGhli/CEnFYw3QKVtldnV0
hnO3w/oQ9+0fksiJpIi9njyq7oYI/LQIcM72SHkgV9zm3saS18dQo6lQr9Uoejf7
Z2HXRPx7z1y6udS4ThZUtgIZc29PAR7QKbTxvtzGBtAMxZ3w3ZhJtnXi639hRpih
fzgZ5Esn10Rr8q+bRaZvuHEgk6PmAxP8h6LIWpgHQ1jNVKcElZy2ttMqMFCBwKgW
zSAP+tpV0qaLfFoEPBT390FD6a4bw4dTGNho6/hIzDkS8MeyKsJPmg2bCWpVXaht
eAndwR5VI60=
=dRkT
-----END PGP SIGNATURE-----

--=-4shF2yLTwnQl0eh1Ww5A--
