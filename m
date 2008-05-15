Return-Path: <michael@ellerman.id.au>
Subject: Re: [patch 3/4] macintosh: replace deprecated __initcall with
	device_initcall
From: Michael Ellerman <michael@ellerman.id.au>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080514230647.15d58897.akpm@linux-foundation.org>
References: <200805142312.m4ENCsdu026262@imap1.linux-foundation.org>
	<18475.47278.446992.728481@cargo.ozlabs.ibm.com>
	<20080514230647.15d58897.akpm@linux-foundation.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-C4tqPdlp33S0K2VS5iIb"
Date: Thu, 15 May 2008 16:28:28 +1000
Message-Id: <1210832908.17568.16.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, rpjday@crashcourse.ca,
	Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-C4tqPdlp33S0K2VS5iIb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-05-14 at 23:06 -0700, Andrew Morton wrote:
> On Thu, 15 May 2008 14:14:38 +1000 Paul Mackerras <paulus@samba.org> wrot=
e:
>=20
> > akpm@linux-foundation.org writes:
> >=20
> > > -__initcall(adb_init);
> > > +device_initcall(adb_init);
> >=20
> > There's no particular reason why this needs to go in 2.6.26, is there?
> > It looks to me like something that I should queue up for 2.6.27.
> >=20
>=20
> No, this make no difference in code generation - it's just a
> use-the-modern-interface thing.

I missed the memo about __initcall being deprecated, or is it only
deprecated for use in device drivers?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-C4tqPdlp33S0K2VS5iIb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIK9gMdSjSd0sB4dIRAvaVAJ9Tc5q2By5qrisLA/ZKOGkIivFKawCfWX9y
oHrK9/kE529FwwMxQ4QdzG4=
=bUDf
-----END PGP SIGNATURE-----

--=-C4tqPdlp33S0K2VS5iIb--
