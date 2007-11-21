Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1B91BDDE34
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 09:53:05 +1100 (EST)
Date: Thu, 22 Nov 2007 09:52:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: 2.6.24-rc3-mm1- powerpc link failure
Message-Id: <20071122095256.dd5b6e39.sfr@canb.auug.org.au>
In-Reply-To: <4743E706.6010504@linux.vnet.ibm.com>
References: <20071120204525.ff27ac98.akpm@linux-foundation.org>
	<4743E706.6010504@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__22_Nov_2007_09_52_56_+1100_SNhmC_mXWA23hoE5"
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__22_Nov_2007_09_52_56_+1100_SNhmC_mXWA23hoE5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Nov 2007 13:36:30 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ib=
m.com> wrote:
>
> The kernel build fails on powerpc while linking,

Only for allyesconfig (or maybe some other config that builds a lot of
stuff in.

>   AS      .tmp_kallsyms3.o
>   LD      vmlinux.o
> ld: TOC section size exceeds 64k
> make: *** [vmlinux.o] Error 1
>=20
> The patch posted at http://lkml.org/lkml/2007/11/13/414, solves this=20
> failure.

However, that patch needs more testing especially to figure out what
performance effects it has.  i.e. not for merging, yet.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__22_Nov_2007_09_52_56_+1100_SNhmC_mXWA23hoE5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHRLbMTgG2atn1QN8RAv3JAJ0elWher97gDR4ohd9+9yNOAj27IgCcDCBD
xKL2XNiv9EK/IUoswd4ILUc=
=Wmga
-----END PGP SIGNATURE-----

--Signature=_Thu__22_Nov_2007_09_52_56_+1100_SNhmC_mXWA23hoE5--
