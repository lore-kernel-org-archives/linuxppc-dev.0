Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8DAC9DDE04
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 20:24:48 +1100 (EST)
Subject: Re: [PATCH] mpic: make sparse happy
From: Johannes Berg <johannes@sipsolutions.net>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <91eb052edd9d5c608658fcdcfdc7589c@bga.com>
References: <91eb052edd9d5c608658fcdcfdc7589c@bga.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xFhCkln1xRdak7uKWocp"
Date: Thu, 21 Feb 2008 10:23:16 +0100
Message-Id: <1203585796.17534.121.camel@johannes.berg>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xFhCkln1xRdak7uKWocp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Wed, 2008-02-20 at 23:50 -0600, Milton Miller wrote:
> At Wed Feb 20 22:31:44 EST 2008, Johannes Berg wrote:
> > I was running sparse on something else and noticed sparse warnings
> > and especially the bogus code that is fixed by the first hunk of
> > this patch, so I fixed them all while at it.
>=20
> But your change is not equivalent!

> You now write to the register with dcr, big, and little endian variants!

Ouch, you're right, doh.

johannes

--=-xFhCkln1xRdak7uKWocp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR71DA6Vg1VMiehFYAQKPVxAAj/HgYRPTGL+EjU2N5lD0wxEt0bEWv8Fk
uGlzUwBE6PAzgx08LfrUxaV2/UzDMkrHWF/IndsMEUMCZDvixeLPFk9M3wHxADEA
8V7wftjs8YD4Nm+fVwH09ArsiHgaVUe9Wl+Bv43sPypPy32jtZP2bkZLcS0izQT0
ytG746XTI0cp194y9wCQWvAu5v+SYzldn+eQ+Ed90HxJLdLQv9Aa3YnJz9PMyJY3
W94aUpLB5WJ/x/gQMwJS0en+bOzyCR7MZZxzu24oK7wgZ4bgFUzT0dlx1gR6Xscx
Z3VTTUUIkqkNsKFwO230UZ7fM933B0nivtY0P6opvv5bzAxJumYMQR6Gqk8gtS9Y
xoHEhs1D1RG4mlPe+kccS+39+224aWEUuFoddYal7juGVW7BVaJhpD5FMMCb8sYY
hDHTxgfn7/1mkSjQEF7dPJR29WCBuVKjkB1fsbX0qQJwLXaU3p+whiCOLZMHZTri
54czdwJVb7P1+GIWpjt1cfvwXCOmZEXCm51z1eWO8Z0Ok3BEMRlNaHhLNqoTLnMn
CeiiEQ1kGZsHdbe8EEsX8XiaSRME5glEqzLaLXgpbnlSp9tmFWA8ym1/S1JO/ci5
rlND9BdMvuyu6RpAA0UgcoNZl4z3MkyqBf7hBtk+Tri7ng7yCwTqI/u7dHf9dCXG
bXPeOe7vzXs=
=WIXm
-----END PGP SIGNATURE-----

--=-xFhCkln1xRdak7uKWocp--
