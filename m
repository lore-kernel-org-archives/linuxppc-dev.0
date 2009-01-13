Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C7302DE15F
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 03:31:30 +1100 (EST)
Date: Wed, 14 Jan 2009 03:31:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: origin tree build failure
Message-Id: <20090114033120.0333b392.sfr@canb.auug.org.au>
In-Reply-To: <20090112093214.GA6798@elte.hu>
References: <20090112104837.69feedec.sfr@canb.auug.org.au>
	<1231719015.22571.4.camel@pasglop> <20090112090552.GD26750@elte.hu>
	<20090112202427.3b918490.sfr@canb.auug.org.au>
	<20090112093214.GA6798@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__14_Jan_2009_03_31_20_+1100_x2xlRncLGCorQ0+P"
Cc: Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Mike Travis <travis@sgi.com>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__14_Jan_2009_03_31_20_+1100_x2xlRncLGCorQ0+P
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Mon, 12 Jan 2009 10:32:14 +0100 Ingo Molnar <mingo@elte.hu> wrote:
>
> * Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > > It slipped through because it didnt get caught in build tests because=
=20
> > > cpufreq isnt enabled in the powerpc defconfig.
> >=20
> > Which is one of the reasons we have linux-next: "integration testing".
>=20
> Build bugs slipped through that net too in the past.

Of course they have.

> And we dont really want developers and maintainers to rely on an external=
=20
> middle man facility to be able to submit patches. So the best method is t=
o=20
> make the defconfigs good enough to catch everyday build bugs. Random=20
> testing and linux-next can then catch the weird special cases as well.

linux-next is merely a tool - it can't catch anything if you don't use it.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__14_Jan_2009_03_31_20_+1100_x2xlRncLGCorQ0+P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklswdgACgkQjjKRsyhoI8yMbQCePksZa7PGK1uX5+gy2kGELckw
ORoAoKGyNUvR9gFiT10dOcdHj6Llo479
=1XlA
-----END PGP SIGNATURE-----

--Signature=_Wed__14_Jan_2009_03_31_20_+1100_x2xlRncLGCorQ0+P--
