Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2DA41DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 17:17:52 +1000 (EST)
Date: Wed, 8 Aug 2007 17:17:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: geoffrey.levand@am.sony.com
Subject: Re: [patch 0/3] PS3 bugfix patches for 2.6.23
Message-Id: <20070808171738.40d99505.sfr@canb.auug.org.au>
In-Reply-To: <20070808033119.833895506@am.sony.com>
References: <20070808033119.833895506@am.sony.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__8_Aug_2007_17_17_38_+1000_3g=7euyrL+bKSa0J"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__8_Aug_2007_17_17_38_+1000_3g=7euyrL+bKSa0J
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geoff,

On Tue, 07 Aug 2007 20:31:19 -0700 geoffrey.levand@am.sony.com wrote:
>
> This small set of PS3 bugfix patches for 2.6.23.
>=20
>   [patch 1/3] PS3: Fix storage probe logic
>   [patch 2/3] PS3: Remove incomplete message
>   [patch 3/3] PS3: Update ps3_defconfig
>=20
> Patch 1 fixes a cold startup timing bug in the hard disk probe logic.
>=20
> Patch 2 removes the 'incomplete' message in the PS3 Kconfig.  We now
> have all drivers and platform support needed to build a kernel for the
> PS3.  The only major thing missing is wireless networking support, which
> we plan to have ready for 2.6.24.

$ mkdir ../ps3
$ make O=3D../ps3 ps3_defconfig
$ make O=3D../ps3
	.
	.
  LD      .tmp_vmlinux1
arch/powerpc/platforms/built-in.o: In function `of_has_vicinity':
/home/sfr/kernels/linus/arch/powerpc/platforms/cell/spu_base.c:681: undefin=
ed reference to `.spu_devnode'
arch/powerpc/platforms/built-in.o: In function `init_aff_fw_vicinity_node':
/home/sfr/kernels/linus/arch/powerpc/platforms/cell/spu_base.c:726: undefin=
ed reference to `.spu_devnode'
arch/powerpc/platforms/built-in.o: In function `aff_devnode_spu':
/home/sfr/kernels/linus/arch/powerpc/platforms/cell/spu_base.c:690: undefin=
ed reference to `.spu_devnode'
arch/powerpc/platforms/built-in.o: In function `aff_node_next_to':
/home/sfr/kernels/linus/arch/powerpc/platforms/cell/spu_base.c:703: undefin=
ed reference to `.spu_devnode'
/home/sfr/kernels/linus/arch/powerpc/platforms/cell/spu_base.c:705: undefin=
ed reference to `.spu_devnode'
arch/powerpc/platforms/built-in.o:/home/sfr/kernels/linus/arch/powerpc/plat=
forms/cell/spu_base.c:649: more undefined references to `.spu_devnode' foll=
ow
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [_all] Error 2

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__8_Aug_2007_17_17_38_+1000_3g=7euyrL+bKSa0J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGuW4eTgG2atn1QN8RAksPAJ4tBlywfJL0ZlyGh8IGcQx+JKDkawCgh5kS
jX7qukCbef3wg2qeuxAJ63M=
=qJQU
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Aug_2007_17_17_38_+1000_3g=7euyrL+bKSa0J--
