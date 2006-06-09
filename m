Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA32D67C0C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 21:47:17 +1000 (EST)
Subject: Re: [PATCH] convert powermac ide blink to new led infrastructure
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1149726524.23790.5.camel@localhost.localdomain>
References: <1149635136.32002.49.camel@johannes>
	<1149726524.23790.5.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xmzf2+82fxyhOilT2zVf"
Date: Fri, 09 Jun 2006 13:47:09 +0200
Message-Id: <1149853629.3864.9.camel@johannes.berg>
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


--=-xmzf2+82fxyhOilT2zVf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-06-08 at 10:28 +1000, Benjamin Herrenschmidt wrote:

> No objection, but a question: how do you bind the led to the hard disk
> by default ? some userland stuff ? can't be automatic at boot by
> default ?

The way it usually works is via sysfs. Automatic at boot could be
default by assigning a default name somewhere IIRC, but since I don't
use the LED I optimised for that case ;)
I'd say having a script that *enables* it at boot is probably cleaner
than having one that *disables* it, and having a Kconfig option just for
the default seems overkill.

johannes

--=-xmzf2+82fxyhOilT2zVf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIlfu6Vg1VMiehFYAQJ90g//TFV3I2esdVCPdipofQuDhyTjDCMoc7MD
5EsE7cHLvW9gDdfb4ABxctT18w6hYRln/G8dVaNspxNFfRVXgi0hho85mWTMlTAN
R85gmisTdohOqcinJjIrucZJhT8yNLI1dNH1JCVBqUHR3rmP7OU2zKRsvAK+H5Fm
CQQvVnXNUDy984p6bnLyINM9TyL7xhmXsA03jUySfXhytKxoMttriBMcrw96E4DY
p7ew+azfUZJkGlPZVte1ihK2SHdN47+yv0HdREFevOBU0k/TJYNHk0fcxifVWb29
fMHkHmcw+laDXk/VoaFoo5yJFjNaWV1c8Sl0M/4G1Mxu8kJydz9wEce2hNTOw637
eC7icZWfyB3fKBFT85LUePsMPmR6Xx53iTRFmgEXxQoI2wzMkA6gkyvKWhBz8mMy
ZNJvDn4xTB4L/Tf5VKt+ixcSNWN4IQ9T4FHf3eJ8YMoJojh4jeDVyci0IrRFcOdQ
9KIELjEFj42CsZske2LUDBRnvpEIK+ntyDXBkJFcRn0zmWonH3LqPQm4JHAun+dr
lO/Yq6Db15v2RKAyRkh4QZ+4UrrJk0/ibuQpkxYo8BmLAAwLtZQfSBRD9ONzZGBc
ykAqeYkApvh8b9dgnbB+nNhO3MHPiOWwxfhSDJ5chFiEbfvtjpTdOLI8RfZTPgLc
CtFLhjg2Z1Q=
=gUxC
-----END PGP SIGNATURE-----

--=-xmzf2+82fxyhOilT2zVf--
