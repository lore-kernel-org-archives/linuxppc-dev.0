Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3479CDDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 10:44:47 +1100 (EST)
Date: Wed, 19 Nov 2008 10:44:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: linux-next: spinlock lockup with next-20081118 on powerpc
Message-Id: <20081119104433.45a10893.sfr@canb.auug.org.au>
In-Reply-To: <20081119093023.48895b84.sfr@canb.auug.org.au>
References: <20081119093023.48895b84.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__19_Nov_2008_10_44_33_+1100_D6tX2_ZyKCmh+QSc"
Cc: linux-next@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__19_Nov_2008_10_44_33_+1100_D6tX2_ZyKCmh+QSc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 19 Nov 2008 09:30:23 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> This was on a Power5 partition.  I am attempting to reproduce the problem.

OK, it reproduces.  The machine is a Power5 partition (IBM,9124-720
eServer OpenPower 720) with 1 (2 way threaded) cpu (gr, rev2.1, 1.5GHz),
2G of memory, 2 NUMA nodes running Ubuntu Gutsy.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__19_Nov_2008_10_44_33_+1100_D6tX2_ZyKCmh+QSc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkjU2EACgkQjjKRsyhoI8zqnQCfa7fAlriAKHD51Xx8JBDowpDS
LT4AoIzul9lqKucHjsG7E7QgAoOxlFOg
=49AU
-----END PGP SIGNATURE-----

--Signature=_Wed__19_Nov_2008_10_44_33_+1100_D6tX2_ZyKCmh+QSc--
