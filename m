Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B42E67B3C
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 06:57:50 +1000 (EST)
Subject: Re: [OOPS] 2.6.17-rc3 on an mpc8241
From: Johannes Berg <johannes@sipsolutions.net>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0606142245370.12545@poirot.grange>
References: <Pine.LNX.4.60.0606142245370.12545@poirot.grange>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Me4ksTniF6CldmVnYdIk"
Date: Wed, 14 Jun 2006 22:57:38 +0200
Message-Id: <1150318658.13958.26.camel@johannes.berg>
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


--=-Me4ksTniF6CldmVnYdIk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-14 at 22:48 +0200, Guennadi Liakhovetski wrote:
> Corrupted stack?...

Looks weird.
Enable slab debugging? :)

johannes

--=-Me4ksTniF6CldmVnYdIk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARJB4QKVg1VMiehFYAQJiMw//ejCzT+ViLv8dardQ2iGMDZ9ej8KjC2dg
lBaY6iAVayjMGOWGP6x/n/xuhij54wjDM78LPKcvoKrE41y0uDwdltC//uJ23i/j
2qdNelYOxh+8zX3XRFkyHr6BxJY18avbdFaC+TS55kHWUxFEozMecfYqOYAOjOkd
sgl4UVlDHS1ZsETqI1d8gzomzE8/P43jk/fgRzCTl7qrPgERWhKy5XA6eNky+5wE
FDfXEHWNM8X8ZS+pgWx1BWoGbfPtEK0psZc1SRhLvyoVeqhUgQB9cwFjhR+Vt2+K
6xUaya49DAuzowHNwv9PVslIqOgj8voEjnXSQPC4MFARQ12YY8y6CLh73iK7OH+c
HUgDkuRIfpzm45tOFBtpIyNen5aE5qEcrnot5xUJ33a9JVYynu6TLE8Cqo1XNtpq
Ifk7wDVgG0053a6PYqsD2ZJlY8urJ4J6CR7MlCyE6dlTTqdKA4HfW4l7aGYBGyg8
RIX9rLyMn3xq8XdzCPTyWyU3AxlzN4qERDJjUgJoYnDxlWWB8ooubd+SSVDlHGoq
DMBTUhJxatAJEXEMlWoNBv+MJ1M4xzvNpUgBnoGx0XEbXlOVfasYTlqTZH4L7uhk
5lmHZijX2INc5TUr6bcOBDHK5RkPp3sDSyitx33xp9xdHHaYEsV1cssuTArP/+sH
/VKj3h2YbMI=
=LWJm
-----END PGP SIGNATURE-----

--=-Me4ksTniF6CldmVnYdIk--
