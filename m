Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 060B4DDE9C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 14:08:03 +1000 (EST)
Date: Tue, 23 Oct 2007 14:07:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Problems with allyesconfig kernel build
Message-Id: <20071023140757.c7a3730d.sfr@canb.auug.org.au>
In-Reply-To: <20071023140231.12698d1c.sfr@canb.auug.org.au>
References: <20071023140231.12698d1c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__23_Oct_2007_14_07_57_+1000_ls3nIvdk2rQc1tu_"
Cc: Andrew Morton <akpm@linux-foundation.org>, amodra@bigpond.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__23_Oct_2007_14_07_57_+1000_ls3nIvdk2rQc1tu_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Oct 2007 14:02:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> We link .text.init.refok immediately after .text, but with
> allyesconfig, .text ends up very large.

Just to give you some idea of what "very large" means, this is an
allyesconfig built vmlinux from August:

$ ls -l vmlinux
-rwxr-xr-x 1 sfr sfr 378704409 2007-08-21 13:44 vmlinux
$ size vmlinux
   text    data     bss     dec     hex filename
41368641        9142448 3491272 54002361        33802b9 vmlinux

:-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__23_Oct_2007_14_07_57_+1000_ls3nIvdk2rQc1tu_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHHXOhTgG2atn1QN8RAmbpAKCG/dFgm1Ihm0MSUEhsZy1Bwe3pxQCgkUB+
pTFRQqeUAlp/WEjDCg4Dj5o=
=Z4MA
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Oct_2007_14_07_57_+1000_ls3nIvdk2rQc1tu_--
