Date: Tue, 16 May 2000 17:21:31 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (update: mem>64MB)
Message-ID: <20000516172131.I15302@cheops.usf.Uni-Osnabrueck.DE>
References: <20000511150009.D8481@cheops.usf.Uni-Osnabrueck.DE> <Pine.SUN.4.21.0005140159110.4879-100000@panix.com> <20000515105218.C4202@cheops.usf.Uni-Osnabrueck.DE> <392162B4.CDD36DE7@mondonet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oxV4ZoPwBLqAyY+a"
In-Reply-To: <392162B4.CDD36DE7@mondonet.net>; from m.scarpa@mondonet.net on Tue, May 16, 2000 at 05:01:08PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--oxV4ZoPwBLqAyY+a
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2000 at 05:01:08PM +0200, Mario Scarpa wrote:
> Bernhard Reiter wrote:
> > Mario Scarpa            hard freeze as described?  64 MB + other proble=
ms

> I was out for a while, now I'm back.
> My config is like the following:
> Lombard 400MHz with 64MB (from Apple) running 2.2.15pre20 on Debian 2.2.
>=20
> I'm experiencing (seldom) freezes with this config when I have
> some heavy network activity and, even more seldom, when the
> system boots up and initialize the serial driver.
> My problems started when I compiled the USB driver into the kernel
> (or, at least, began to be visible).
>=20
> No problem during any compilation (and I do quite a lot of this)...

Well with 64MB I never had freeses to far.

Chris told me that he has a 333Mhz lombard.
I have the 400 Mhz model, maybe this makes a difference which is
more problematic when the clock speed it higher.

Jeramy, what speed does your lombard run on?
	Bernhard
--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

--oxV4ZoPwBLqAyY+a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkhZ3gACgkQh9ag3dpKERaiPACfQ9ou+2QMwZcgEK5L/yqT1FRB
8EkAn3wxoHb44ZQcuTHIRjtv5CH81wQp
=LUgW
-----END PGP SIGNATURE-----

--oxV4ZoPwBLqAyY+a--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
