Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D848EDE7DF
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 01:53:37 +1000 (EST)
Date: Tue, 29 Jul 2008 01:53:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Message-Id: <20080729015330.39aff7a5.sfr@canb.auug.org.au>
In-Reply-To: <alpine.LFD.1.10.0807280838580.3486@nehalem.linux-foundation.org>
References: <1217239117.11188.187.camel@pasglop>
	<alpine.LFD.1.10.0807280838580.3486@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__29_Jul_2008_01_53_30_+1000_otV=jz8EaQGALWEd"
Cc: akpm@linux-foundation.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__29_Jul_2008_01_53_30_+1000_otV=jz8EaQGALWEd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Mon, 28 Jul 2008 08:40:44 -0700 (PDT) Linus Torvalds <torvalds@linux-fou=
ndation.org> wrote:
>
> On Mon, 28 Jul 2008, Benjamin Herrenschmidt wrote:
> >=20
> > It's all in:
> >=20
> > git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
>=20
> It doesn't really seem to be. I get "Already up-to-date.", and the top=20
> commit there seems to be from July 3..
>=20
> Forgot to push?

It should be

	git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Ben seems to have copied from one of Paul's pull requests.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__29_Jul_2008_01_53_30_+1000_otV=jz8EaQGALWEd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiN63oACgkQjjKRsyhoI8z3RQCfUvfYXEWwAfDrjZlUX/rD7Zjo
IEMAoInTZg5TsnWFGxBZ4caAKTlNKTxd
=H+1v
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Jul_2008_01_53_30_+1000_otV=jz8EaQGALWEd--
