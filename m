Return-Path: <robbat2@gentoo.org>
Received: from curie.orbis-terrarum.net (unknown [24.81.201.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.orbis-terrarum.net",
	Issuer "mail.orbis-terrarum.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AC53367BB6
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2006 17:25:51 +1000 (EST)
Date: Mon, 17 Jul 2006 00:19:07 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: setup arch
Message-ID: <20060717071907.GA16219@curie-int.orbis-terrarum.net>
References: <20060709170909.90774.qmail@web35812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
In-Reply-To: <20060709170909.90774.qmail@web35812.mail.mud.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(I tried to sent this before, but my mailserver wasn't playing nice).

On Sun, Jul 09, 2006 at 10:09:09AM -0700, Paul Smith wrote:
> I hesitate to lay this one out here because you all
> are way over my head. The regular forums have not
> responded to this in any meaningful way.
> Hi,=20
>=20
>=20
> Box:=20
> Quad 2.5 PPC=20
> 4.5 GB non ecc 533 Ram=20
> RocketRaid2320=20
> Nvida 6600 256mb=20
>=20
>=20
> software resources:=20
[snip the wrong iso files]

Look in the experimental directory of your local Gentoo mirror for
install-ppc64-minimal-dual-core-2006.0-32ul.iso=20

I believe this was because the dual-core patches aren't available in time f=
or
the actual release media creation, and this was created later to make the n=
ewer
systems usable.

Additionally, unless you're planning on contributing the the Noveau driver =
for
accelerated 2D/3D support on the Nvidia cards, you won't be getting far with
the nvidia card.

Getting an ATI card will give you working 3D in most cases.  See this list =
for
what's supported at the bleeding edge:
http://dri.freedesktop.org/wiki/ATIRadeon#head-298bd23baafb9c2fad1774d1d2fa=
54bd2aa55e7d

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFEuznrPpIsIjIzwiwRAlP4AJ4gcLsCJYeqteDzRsEjbvZHOCvptQCgtsE2
6H6cI4+xJdOzQq3qKH7mf8o=
=9fun
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
