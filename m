Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2B6B1DDF03
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 18:31:04 +1100 (EST)
Date: Wed, 17 Dec 2008 18:30:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: next-20081216 - powerpc link error 'dynreloc miscount'
Message-Id: <20081217183054.79fa2546.sfr@canb.auug.org.au>
In-Reply-To: <20081217070858.GA7424@linux.vnet.ibm.com>
References: <20081216223754.0c8e21d4.sfr@canb.auug.org.au>
	<20081217070858.GA7424@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__17_Dec_2008_18_30_54_+1100_ZWTYu0wcAuYkD1Z/"
Cc: linux-kbuild@vger.kernel.org, mel@csn.ul.ie,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, sam@ravnborg.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__17_Dec_2008_18_30_54_+1100_ZWTYu0wcAuYkD1Z/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kamalesh,

On Wed, 17 Dec 2008 12:38:58 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ib=
m.com> wrote:
>
> 	next-20081216 build breaks on powerpc
>=20
> ld: dynreloc miscount for kernel/built-in.o, section .opd
> ld: can not edit opd Bad value
> make: *** [vmlinux.o] Error 1
>=20
> # ld --version
> GNU ld version 2.16.1 Debian GNU/Linux
>=20
> # gcc --version
> gcc (GCC) 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)

Yeah, I have seen this as well.  A later toolchain (gcc 4.3.2, binutils
2.19) works ok.  Also it is only a problem for some configs (see
http://kisskb.ellerman.id.au/kisskb/branch/9/).  It started with
next-20081215.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__17_Dec_2008_18_30_54_+1100_ZWTYu0wcAuYkD1Z/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklIqq4ACgkQjjKRsyhoI8yypgCgq67JOQdiBWnaaMVNomra3fGv
v0MAnjZrE9xk/okAHYOFBkgin3X51aGh
=jl4r
-----END PGP SIGNATURE-----

--Signature=_Wed__17_Dec_2008_18_30_54_+1100_ZWTYu0wcAuYkD1Z/--
