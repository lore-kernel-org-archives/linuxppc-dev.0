Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3EC31DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 20:54:33 +1100 (EST)
Date: Wed, 22 Oct 2008 20:54:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mfd/wm8350: don't export static functions
Message-Id: <20081022205424.7163e6ec.sfr@canb.auug.org.au>
In-Reply-To: <20081022093721.GA10499@rakim.wolfsonmicro.main>
References: <20081016204754.a41646e5.sfr@canb.auug.org.au>
	<20081016120416.GA5753@rakim.wolfsonmicro.main>
	<20081022203112.5a213e8c.sfr@canb.auug.org.au>
	<20081022093721.GA10499@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__22_Oct_2008_20_54_24_+1100_XqF9jGtAW/1ZVANS"
Cc: LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>,
	linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus <torvalds@linux-foundation.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__22_Oct_2008_20_54_24_+1100_XqF9jGtAW/1ZVANS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, 22 Oct 2008 10:37:22 +0100 Mark Brown <broonie@opensource.wolfsonmi=
cro.com> wrote:
>
> On Wed, Oct 22, 2008 at 08:31:12PM +1100, Stephen Rothwell wrote:
>=20
> > I thought that this had been applied, but I have had to apply it to my
> > tree today again.
>=20
> Samuel doesn't seem to have picked it up (though looking at the CC list
> you've not sent it to him).  I'm going to push another batch of stuff to
> him later today, hopefully he will pick it up then.

OK, thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__22_Oct_2008_20_54_24_+1100_XqF9jGtAW/1ZVANS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj++FAACgkQjjKRsyhoI8zkMACeOzMeKulLpoaF0yQ+Zcq4JB8o
wSQAniHf/kLZ8yyOnahwVeKSRClcAqJT
=Q8bw
-----END PGP SIGNATURE-----

--Signature=_Wed__22_Oct_2008_20_54_24_+1100_XqF9jGtAW/1ZVANS--
