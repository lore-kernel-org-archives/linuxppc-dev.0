Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C15EBDDED0
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 23:03:56 +1000 (EST)
Subject: Re: [PATCH] fix powerpc breakage in sg chaining code (again)
From: Johannes Berg <johannes@sipsolutions.net>
To: Jens Axboe <jens.axboe@oracle.com>
In-Reply-To: <20071024092334.GM14671@kernel.dk>
References: <1193173222.7733.42.camel@johannes.berg>
	<1193176034.4097.3.camel@johannes.berg>
	<20071024091446.GL14671@kernel.dk>
	<1193217742.5715.6.camel@johannes.berg>
	<20071024092334.GM14671@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rm6QY3pGzkytjDs5M8bf"
Date: Wed, 24 Oct 2007 13:21:46 +0200
Message-Id: <1193224906.4510.7.camel@johannes.berg>
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


--=-rm6QY3pGzkytjDs5M8bf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-24 at 11:23 +0200, Jens Axboe wrote:
> On Wed, Oct 24 2007, Johannes Berg wrote:
> > On Wed, 2007-10-24 at 11:14 +0200, Jens Axboe wrote:
> >=20
> > > I lost track - which kernel are you booting? This looks like somethin=
g
> > > that should be fixed, did you try 2.6.24-rc1?
> >=20
> > No, it came out after I pulled, I was on v2.6.23-6815-g0895e91. I'll
> > give it a try, but I don't think I can confirm it works before tomorrow=
.
> > I see the build failure got fixed with commit
> > 5edadbd0ae35d2daabaf6b44f2c58d67d4021ed2 too.
>=20
> 0895e91d60ef9bdef426d1ce14bb94bd5875870d is definitely too old, so it
> will break on IDE. I'm confident that a newer kernel will solve this
> issue.

It does indeed, 2.6.24-rc1 runs fine. Thanks.

johannes

--=-rm6QY3pGzkytjDs5M8bf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARx8qyqVg1VMiehFYAQKeuA//aqlVHGo6cc7iQeV3ja3goFV48mOb357G
xFNOTUcXpuF2slqLKq1Wnm4f7kVoMPzQq2Q4mzaJeQOIi4INJi34h9JZBWmQzfUF
unfwqEu3HBBz5O/InigP2+eYQElV5vPbO9/xubxq+q2H1NNU+3X8X0YbdXRzI2gE
nFgosFxtKc0Z9yR/Y71T9appnJJarz4RjA0mfnJwSBy2nyPfGa5cv6tqsxs1PK50
YSakA/XqfPUe6K783eVKFsmzNbevIh/sUTiOWywldMe+gJgimdLpQ8X2+CU9fFr/
exOuJFSLU2FNlsyOn+YHlANWNHifqsxpzFb2ZdAYk6m96XGwD5qCdK2w9rBWIxrn
x4PK8eKBEPxb40xjdDnd1wmYF4XhpVwFgpK3dsXoZdxKnV7xV71wpU7NpLzRiLSn
fYve8scVKT4fkDcRc6/k7YxkCY6JsEVe/QBFnW+wEWM7fEqkzDheECwCmDvhEJY5
frsowut0JTkWRfdUfNbSfzdoarczPMrfVPuHbEpnIPvqEOE6Gt0LkFiDYip4L7Hx
pybDKD/0jtQlj49VJymwOVNEWmykp/ZgfclA4E7dAtYRdqiPux8ZraCUOUnhGwQR
f/eaV9SRNyfa3HOHf6wgutz/SxVc5QgFLQSIqPbv44/Kgvnii07i2B17usah+1GN
JMoK6sd1YR0=
=nyDt
-----END PGP SIGNATURE-----

--=-rm6QY3pGzkytjDs5M8bf--
