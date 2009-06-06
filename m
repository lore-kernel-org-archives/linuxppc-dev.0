Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C5F0EB7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 18:37:48 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B244DDDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jun 2009 18:37:48 +1000 (EST)
Subject: Re: mailing list moving
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20090605190831.c5d59095.sfr@canb.auug.org.au>
References: <20090531150950.596d2681.sfr@canb.auug.org.au>
	<20090605172616.7fde58ab.sfr@canb.auug.org.au>
	<1244187520.11359.9.camel@concordia>
	<20090605190831.c5d59095.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-aNcJofUx5MRXSuo2fkg9"
Date: Sat, 06 Jun 2009 18:37:47 +1000
Message-Id: <1244277467.4277.12.camel@concordia>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linuxppc-dev-owner@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-aNcJofUx5MRXSuo2fkg9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-06-05 at 19:08 +1000, Stephen Rothwell wrote:
> Hi Michael,
>=20
> On Fri, 05 Jun 2009 17:38:40 +1000 Michael Ellerman <michael@ellerman.id.=
au> wrote:
> >
> > On Fri, 2009-06-05 at 17:26 +1000, Stephen Rothwell wrote:
> > > Hi all,
> > >=20
> > > On Sun, 31 May 2009 15:09:50 +1000 Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
> > >=20
> > > The archives on lists.ozlabs.org (and ozlabs.org) have unfortunately =
not
> > > retained their URLs (the basename of the article URLs changed).=20
> >=20
> > Would a rewrite rule fix it? It'd be nice for them to keep working.
>=20
> No, because the actual article numbers changed when I rebuilt the archive
> on the new server.
>=20
> Sorry.
>=20
> I do, however, have the old archives, so maybe we can do something ...

We could use the old archive to work out the mapping between old and new
and write a billion rewrite rules, but it'd probably crash the rewrite
code - and if not slow the server to a crawl.

So into the too hard basket I think :)

cheers

--=-aNcJofUx5MRXSuo2fkg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoqKtcACgkQdSjSd0sB4dKmIwCaApVL77B3SYb3S90ocK8QO4mY
oDoAn2MWHALPGxGM6P8uCoTcCOMzgCeG
=LFlV
-----END PGP SIGNATURE-----

--=-aNcJofUx5MRXSuo2fkg9--
