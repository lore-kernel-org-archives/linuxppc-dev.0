Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CBFF5DDF39
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 19:21:04 +1000 (EST)
Subject: Re: [PATCH] fix powerpc breakage in sg chaining code (again)
From: Johannes Berg <johannes@sipsolutions.net>
To: Jens Axboe <jens.axboe@oracle.com>
In-Reply-To: <20071024091446.GL14671@kernel.dk>
References: <1193173222.7733.42.camel@johannes.berg>
	<1193176034.4097.3.camel@johannes.berg>
	<20071024091446.GL14671@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ahoop8o/lltDkpykSpMC"
Date: Wed, 24 Oct 2007 11:22:22 +0200
Message-Id: <1193217742.5715.6.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ahoop8o/lltDkpykSpMC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-24 at 11:14 +0200, Jens Axboe wrote:

> I lost track - which kernel are you booting? This looks like something
> that should be fixed, did you try 2.6.24-rc1?

No, it came out after I pulled, I was on v2.6.23-6815-g0895e91. I'll
give it a try, but I don't think I can confirm it works before tomorrow.
I see the build failure got fixed with commit
5edadbd0ae35d2daabaf6b44f2c58d67d4021ed2 too.

johannes

--=-ahoop8o/lltDkpykSpMC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARx8OzaVg1VMiehFYAQKaPA//VxDqPuDWlkK0hE5xDeqYfiu8BnjVwOif
/+AyEyXpBVAvS71nLj0SoQ/2MVX0IVCeD7whxbU0NAfV4NnnWZvvwLu7IpIiyJW6
iL1z4/iiLKGE/WCX6QC+uVFsvAStHE3CMJ4VHDUeuDt15jdNWx4aKh6/yX8ZelXj
YBDOpP+YVZ/7/jrxuqbzaWggr+i8Vj6jtuNvzwa3WjkftdSVn5HG27Dcqop5FqtI
UHPNaat4E0lgOan4pbLghSseZ7ytRsU0nlK45Ahz02UkkmrzvhirwvOSbNOZ7OMA
qkBPZmTTAv/KaXcHwjSQlIr4BAbMGu8hq+Tz1Lz6t9ss5VnNGraie9Vqf3WTAbvA
I6b9mNf1XHq7tAMj6l5HXjZQ4jJTM3sFuptLTm+/hmngISkqwtVHVJxb5Db/rxA+
/D5OQGd6rnQyD5Hs1+dGuSD1Ro4K9E3HZfPmaUK4nd9fQ1IRhGbJxoAXTx8jVmzr
2DVST5fyKAro2wneaU2gonH5IBbVQAEpj6uVJzaBxu2EyK+x+gen0QvEP0y7nOmr
DmnuX8h5zTb5wqgj2090KT28j3KvL0BktznXpZA5nr3zfgk7JLJ1QMnaEWjuBylx
ArBNUZz+3Q6tvgheP2UR2evOT4jTJT31yJQ4CYJ7E5w7Ag1tdH9F5vztKCy51jZH
xUYEigNpyUo=
=R00a
-----END PGP SIGNATURE-----

--=-ahoop8o/lltDkpykSpMC--
