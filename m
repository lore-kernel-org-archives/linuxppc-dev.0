Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 405A4DE050
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 10:27:39 +1000 (EST)
Subject: Re: Hotplug on PPC4xx
From: Michael Ellerman <michael@ellerman.id.au>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20090407192728.7218eea9@lappy.seanm.ca>
References: <20090406182023.0729073a@lappy.seanm.ca>
	<20090407192728.7218eea9@lappy.seanm.ca>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ejnM2/mXb/sMvolaFh4M"
Date: Wed, 08 Apr 2009 10:27:38 +1000
Message-Id: <1239150458.6848.2.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ejnM2/mXb/sMvolaFh4M
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-04-07 at 19:27 -0400, Sean MacLennan wrote:
> On Mon, 6 Apr 2009 18:20:23 -0400
> "Sean MacLennan" <sean.maclennan@ottawa.kanatek.ca> wrote:
>=20
> > I am trying to run the /sbin/hotplug from the kernel and it doesn't
> > work. Has anybody got it running?
>=20
> I looked into it some more. It turns out that the env pointers are
> freed before they are copied.

That sounds like a bug?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ejnM2/mXb/sMvolaFh4M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknb73oACgkQdSjSd0sB4dJhCACgwldKBNDHsMe5OUzFbNyNAdoE
f+8AoJ/zizf2mOg8Z7gY0JzOpTaP/hZU
=o87t
-----END PGP SIGNATURE-----

--=-ejnM2/mXb/sMvolaFh4M--
