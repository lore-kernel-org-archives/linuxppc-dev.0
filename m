Return-Path: <michael@ellerman.id.au>
Subject: Re: Is get_property() correct?
From: Michael Ellerman <michael@ellerman.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0610272341s3c655ebbn785b373f148f6174@mail.gmail.com>
References: <528646bc0610272341s3c655ebbn785b373f148f6174@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-sqRY04Pdg/U2x1x5tQPL"
Date: Sat, 28 Oct 2006 16:53:20 +1000
Message-Id: <1162018400.14822.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-sqRY04Pdg/U2x1x5tQPL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-10-28 at 00:41 -0600, Grant Likely wrote:
> Is the implementation of get_property correct?  The comment says it
> returns the value of a property; but the return statement just returns
> the property pointer (cast as void*) it got from of_find_property();
> not the value.

Minor correction, it returns the property->value pointer as a void *.

> Does the comment or the code need to change?

I don't think so. get_property() can't return the actual value because
it doesn't know what type it is, so it returns a void pointer to the
value and it's up to the caller to interpret it based on the callers
knowledge of what it's expecting, and/or the lenp.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-sqRY04Pdg/U2x1x5tQPL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFQv5gdSjSd0sB4dIRAlDIAKCQ9n1fm/D1Jrh0NuYS0yfbODU9VgCglVup
dMk/M2/DfrMLEYZbIwBMB14=
=Rei+
-----END PGP SIGNATURE-----

--=-sqRY04Pdg/U2x1x5tQPL--
