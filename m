Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A444DDE144
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 13:39:30 +1000 (EST)
Subject: Re: [PATCH 1/6] powerpc: Move #ifdef'ed body of do_IRQ() into a
	separate function
From: Michael Ellerman <michael@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090423164917.GA20190@ld0162-tx32.am.freescale.net>
References: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
	<20090423164917.GA20190@ld0162-tx32.am.freescale.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-p0D8ubDB3KnQjzW2gnQw"
Date: Fri, 24 Apr 2009 13:39:30 +1000
Message-Id: <1240544370.6566.10.camel@localhost>
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


--=-p0D8ubDB3KnQjzW2gnQw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-04-23 at 11:49 -0500, Scott Wood wrote:
> On Thu, Apr 23, 2009 at 11:31:37AM +1000, Michael Ellerman wrote:
> > +	handler =3D desc->handler;
>=20
> Should be desc->handle_irq.  It's fixed in a later patch, but this breaks
> bisect.

Ah crud, thanks for spotting it. That's an artifact of me reordering the
patches. Will resend.

cheers


--=-p0D8ubDB3KnQjzW2gnQw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknxNHIACgkQdSjSd0sB4dJ4KwCeI6ggfn5PDd1VEAEGY678TzVT
utgAoIjdcgPlRLEsv1HA1/CHw9Hz6ihv
=DSKJ
-----END PGP SIGNATURE-----

--=-p0D8ubDB3KnQjzW2gnQw--
