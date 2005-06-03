Return-Path: <wolfi@mittelerde.physik.uni-konstanz.de>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de
	[134.34.140.224])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E012679EA
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jun 2005 19:33:31 +1000 (EST)
Date: Fri, 3 Jun 2005 11:33:18 +0200
From: Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050603093316.GA4777@halley.zuhause>
References: <1117424155.5228.28.camel@gaston>
	<3db27390050530145939d260e4@mail.gmail.com>
	<20050602130502.GA6151@halley.zuhause>
	<1117750504.31082.76.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
In-Reply-To: <1117750504.31082.76.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: ppc32: Rework power management take #3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 03, 2005 at 08:15:03AM +1000, Benjamin Herrenschmidt wrote:
>=20
> > Today I applied the two mentioned patches to rc5-git6. There were quite
> > a lot of offsets and one time fuzz 2 (hunk 10 in via-pm.c). But still I
> > get a freeze on my PowerBook6,2 (12", 1Ghz from Dec. 2004) when I
> > suspend to disk from X. If I suspend from tty1 the first time, the
> > following suspends work well even from X.
> >=20
> > Thanks for your work,
>=20
> Bizarre... The kernel is normally first opens a new tty and switches to
> it before suspend. It seems that this opening of a new tty is
> conflicting in some way with X "nv" driver and causing that freeze. Are
> you also using an fbdev like rivafb or nvidiafb or are you defaulting to
> offb ? If you do, Can you try booting with video=3Dofonly and tell me if
> it helps ?
>=20
> Ben.
Normally I use rivafb, but I tried video=3Dofonly and did not get a
freeze. I tried it three times and I hope that this is good statistics.
With 2.6.12-rc2 and riva fb I got the freeze in about 80% of all initial
suspends, with rc{4,5-git6} and riva fb I had it everytime. But it may
still well be that there is a random component since I learned to
workaround the problem by switching to tty1 and thus don't trigger the
freeze condition that often.


Thanks,

Wolfi

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCoCPcH0o2mefAfsQRAlBVAJ4+fv4SRawcbQyshdsSKxWKDM9VXgCeLurX
tYad/iC6Ku3mWE6KFioKciE=
=/Xv/
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
