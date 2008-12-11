Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id ECCF4DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 19:42:16 +1100 (EST)
Date: Thu, 11 Dec 2008 19:42:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: linux-next: powerpc build warning
Message-Id: <20081211194201.0bec049a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__11_Dec_2008_19_42_01_+1100_VluBRiRzqF5zqeUV"
Cc: linux-next@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__11_Dec_2008_19_42_01_+1100_VluBRiRzqF5zqeUV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Today's linux-next build (powerpc allyesconfig) produced this warning:

arch/powerpc/mm/numa.c: In function 'do_init_bootmem':
arch/powerpc/mm/numa.c:932: warning: unused variable 'i'

Caused by commit 4a6186696e7f15b3ea4dafcdb64ee0703e0e4487 ("powerpc: Fix
boot freeze on machine with empty memory node") which is now in Linus'
tree.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__11_Dec_2008_19_42_01_+1100_VluBRiRzqF5zqeUV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklA0lkACgkQjjKRsyhoI8zMpgCgpH0ydVk430XYjIEtQHBgc9DN
B54An0b+zGGwfpp5prllqpynYzz7iYOo
=VeKL
-----END PGP SIGNATURE-----

--Signature=_Thu__11_Dec_2008_19_42_01_+1100_VluBRiRzqF5zqeUV--
