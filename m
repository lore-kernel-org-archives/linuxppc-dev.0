Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F300567B1E
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2006 03:07:47 +1000 (EST)
Date: Thu, 6 Apr 2006 03:07:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 00/15] powerpc: move some header files
Message-Id: <20060406030744.18a89ad5.sfr@canb.auug.org.au>
In-Reply-To: <C1CE62AD-7989-4DCA-B7B3-8A107ACBD153@kernel.crashing.org>
References: <11442138494042-git-send-email-sfr@canb.auug.org.au>
	<C40B1083-7953-4104-8FA3-5B9B4EBE1A77@kernel.crashing.org>
	<20060406020313.186a74ad.sfr@canb.auug.org.au>
	<C1CE62AD-7989-4DCA-B7B3-8A107ACBD153@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__6_Apr_2006_03_07_44_+1000_nkj.3O5Cj/YmVqW4"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__6_Apr_2006_03_07_44_+1000_nkj.3O5Cj/YmVqW4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Apr 2006 11:15:04 -0500 Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>
> I'm guessing you had to pull some of them in because of the following:
>=20
> io.h:#include <asm-ppc/io.h>
> mmu_context.h:#include <asm-ppc/mmu_context.h>
> mmu.h:#include <asm-ppc/mmu.h>
> pci-bridge.h:#include <asm-ppc/pci-bridge.h>
> pgalloc.h:#include <asm-ppc/pgalloc.h>
> pgtable.h:#include <asm-ppc/pgtable.h>
>=20
> I think addressing these will make life easier with the other includes.

I'll have a look at these in the morning, thanks for the hint.

I am thinking of creating an include/asm-powerpc/<xx>_32.h for each of the =
asm-ppc
files above and then only putting into them what we need for arch/powerpc.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__6_Apr_2006_03_07_44_+1000_nkj.3O5Cj/YmVqW4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEM/lgFdBgD/zoJvwRAh5OAJ49XX825yQEPjih1yl6WWob+IsJ1QCgjWBC
nzTW35prVwNSrpm4q3PILJs=
=PRrg
-----END PGP SIGNATURE-----

--Signature=_Thu__6_Apr_2006_03_07_44_+1000_nkj.3O5Cj/YmVqW4--
