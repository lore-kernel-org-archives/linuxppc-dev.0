Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4F859679A6
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2006 10:29:00 +1000 (EST)
Date: Wed, 5 Apr 2006 10:28:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Message-Id: <20060405102837.66b44c43.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0604041612320.30113-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0604041612320.30113-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__5_Apr_2006_10_28_37_+1000_f=m16pQy4_7kJ7xT"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__5_Apr_2006_10_28_37_+1000_f=m16pQy4_7kJ7xT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Apr 2006 16:14:04 -0500 (CDT) Kumar Gala <galak@kernel.crashing.o=
rg> wrote:
>
> Please pull from 'for_paulus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git
>=20
> to receive the following updates:
>=20
>  arch/powerpc/configs/mpc85xx_cds_defconfig |  846 ++++++++++++++++++++++=
+++++++
>  arch/powerpc/kernel/ppc_ksyms.c            |    1=20
>  arch/powerpc/platforms/85xx/Kconfig        |    9=20
>  arch/powerpc/platforms/85xx/Makefile       |    1=20
>  arch/powerpc/platforms/85xx/mpc85xx_cds.c  |  359 ++++++++++++
>  arch/powerpc/platforms/85xx/mpc85xx_cds.h  |   43 +
>  arch/ppc/kernel/ppc_ksyms.c                |    1=20
>  include/asm-ppc/mpc85xx.h                  |    3=20
>  8 files changed, 1262 insertions(+), 1 deletion(-)
>=20
> Andy Fleming:
>       Add 85xx CDS to arch/powerpc

Could these "add xxx to arch/powerpc" patches please move any relevant
headers files to include/asm-powerpc as well.  It would be nice if we
could remove the hack from the powerpc Makefile that include files from
include/asm-ppc.  i.e. My opinion is that if any ARCH=3Dpowerpc build
requires a file in include/asm-ppc, then that file should be moved to
include/asm-powerpc.  I am doing a set of patches to that effect.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__5_Apr_2006_10_28_37_+1000_f=m16pQy4_7kJ7xT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEMw8+FdBgD/zoJvwRAkpyAJ0WnqUuJe8uJs9RSfJr+XT+lHwVTgCeJU9k
cpgsvEMLlU4qZRK8wqGHBuw=
=9zpQ
-----END PGP SIGNATURE-----

--Signature=_Wed__5_Apr_2006_10_28_37_+1000_f=m16pQy4_7kJ7xT--
