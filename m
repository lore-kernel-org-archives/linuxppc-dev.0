Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix /dev/oldmem for kdump
From: Michael Ellerman <michael@ellerman.id.au>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
In-Reply-To: <48637594.5040709@in.ibm.com>
References: <48637594.5040709@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-oRNupS9RKN4vvX6I1SuQ"
Date: Thu, 03 Jul 2008 16:15:10 +1000
Message-Id: <1215065710.17950.12.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-oRNupS9RKN4vvX6I1SuQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-06-26 at 16:25 +0530, Sachin P. Sant wrote:
> This one has been pending for a long time. Somehow never
> made it upstream.
>=20
> Resending the patch which fixes /dev/oldmem interface for kdump.
>=20
> Tested with 2.6.26-rc8.
>=20
> Signed-off-by : Michael Ellerman <michael@ellerman.id.au>

Even though I wrote this, it was so long ago I can't really vouch for
it. If you've tested it and it works Sachin then we should merge it. Is
this fix in distros or does it not apply?

> Also make sure we're only reading one page or less at a time.

It looks like the generic code ensures that I think, but it can't hurt.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-oRNupS9RKN4vvX6I1SuQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIbG5udSjSd0sB4dIRAgGAAJ95T6gspZa23wwXjhIZD64CCL97uwCgxYBv
o9btEfHKzw495c1zyASC/6k=
=1ia0
-----END PGP SIGNATURE-----

--=-oRNupS9RKN4vvX6I1SuQ--
