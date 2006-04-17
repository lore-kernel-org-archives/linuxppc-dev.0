Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A36B0679EF
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 06:57:36 +1000 (EST)
Subject: Re: PowerBook5,4 -- no sound?
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1145307118.3912.11.camel@localhost.localdomain>
References: <878xq51t61.fsf@briny.internal.ondioline.org>
	<je1wvxo70l.fsf@sykes.suse.de>
	<1145220233.9833.11.camel@localhost.localdomain>
	<je7j5phz9j.fsf@sykes.suse.de>
	<1145231658.9833.17.camel@localhost.localdomain>
	<je3bgdhwre.fsf@sykes.suse.de>
	<1145233812.9833.21.camel@localhost.localdomain>
	<je1wvwfh7s.fsf@sykes.suse.de>
	<1145307118.3912.11.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-41NkwVLfeh4UyPTWawfB"
Date: Mon, 17 Apr 2006 22:57:29 +0200
Message-Id: <1145307449.4116.18.camel@localhost>
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


--=-41NkwVLfeh4UyPTWawfB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-18 at 06:51 +1000, Benjamin Herrenschmidt wrote:
> >=20
> > request_mem_region(80000000 - 80000fff, i2sbus control)
> >=20
> >       80000000-8007ffff : 0.80000000:mac-io
> >         8000002c-8000002f : 0.0000004c:fans
> >         80000030-80000033 : 0.0000004c:fans
> >         80000034-80000037 : 0.0000004c:fans
> >         8000004c-8000004f : 0.0000004c:fans
> >         80000050-8000008a : 0.00000050:gpio
>=20
> Johannes,
>=20
> Look like the bugs in the device-tree I told you about ...

I suppose so. I guess I'll have to go hardcode it then. Ick.

johannes

--=-41NkwVLfeh4UyPTWawfB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUAREQBNqVg1VMiehFYAQIuNQ//WlEc79saaw+OKPQ9faF0j4XnDWr2SKnt
eFOi8+N9h4Nln89p1OKOflJFqaCEW1bytB+9ppDAZ++bpnnT9SPhGeiswCLnudr6
6TWfICkBLqe0H71lw3anI71eebgVkLMwXJkMmTdwx4sj9NIxWqCkFQIJSQkcQKHr
r5hrn/+U5srz8B3y7XlgfBMly6lb2+UWzWFsMI/yZoV+pLBix7UFf5JDPBvw/TCS
Jw7wv2fJCHkVyUAmQxNQj/jZuIaM9QmzSybl/zxlxbmqrTvslOVeo4qQv5AnM9w5
tkypyMNDAOwiXaQRDQPdP2KDl/D/OaSuQFGPfEqpJvDdQm1PVxB4mz71iI4AATzK
8HUZKJrOkb1HUKo7tZ6Igt+7upvn9KrOxcFLY9OyX9vEcpuJiEWj+w/ou6/ckgux
4ZljRQ2XOQDng+qtPwGbXMAgD16PsOC0yJtF4UUMZmoFZPeDwMmJmNLTJV5ymi5n
tJBEUd631uovqRMuUo0BAelNKSlvxQPcU/E+hP++4z7U62Wmd7LrkQLHAqh/rWFB
xnbjz2QDTDONYmBs1HrDkrc/im9oKfy76HYUskR8GMu1xbh12i3PyPROWpWE0pfY
dDGLqW/p1WE1Dqis9ObXYy2o6AzGrMmO7hcdQKMePHn8RGQqgilAedWTP7Jjw5pl
nn0Kk8svvWo=
=qrfw
-----END PGP SIGNATURE-----

--=-41NkwVLfeh4UyPTWawfB--
