Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 604FEB7185
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 11:32:32 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C7C6DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 11:32:32 +1000 (EST)
Subject: Re: [PATCH 00/33] My PS3-specific patches for 2.6.31
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1244681320.5739.5.camel@pasglop>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244670213.3352.11.camel@pasglop>  <4A302B67.4000401@mlbassoc.com>
	<1244681320.5739.5.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-5x7knKrZEIrYTWvCn66Q"
Date: Thu, 11 Jun 2009 11:32:31 +1000
Message-Id: <1244683951.4674.5.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Gary Thomas <gary@mlbassoc.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-5x7knKrZEIrYTWvCn66Q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-06-11 at 10:48 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2009-06-10 at 15:53 -0600, Gary Thomas wrote:
>=20
> > Trying to understand the process (in preparation for any patches
> > I may want to push upstream) - how can this be too late for 2.6.31?
> > 2.6.30 just came out today...
>=20
> I'm taking the liberty to reply to the list here because I think
> more people need to understand that problem :-)
>=20
> Because the process is such that new features can only be merged
> during the 2 weeks merge window, which started ... yesterday.
>=20
> Also, it's frowned upon to have lots of new stuff close to the end of
> the merge window.
>=20
> The idea is that stuff to go into 2.6.31 should have essentially been
> ready to merge -before- the merge window opens, ie, before 2.6.30 is
> released, for us maintainers to be ready to push things out when the
> merge window open and spend that time sorting out collisions &
> conflicts, -not- reviewing new features that have been sent way too
> late.

The way I think of it is that the "merge window" is the time for
maintainers to merge with Linus.

So if you're sending patches to a maintainer you need to have sent all
your patches to them _before_ then. So the merge window for you is the
weeks prior to the "merge window".


cheers

--=-5x7knKrZEIrYTWvCn66Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkowXqwACgkQdSjSd0sB4dJfngCgxnZEn5tpmD5aFCwd9IVaqgG/
KEsAoLHeXmu3Ixug1vi5g6Rokm49YyU9
=wAhN
-----END PGP SIGNATURE-----

--=-5x7knKrZEIrYTWvCn66Q--
