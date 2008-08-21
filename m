Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4B626DE3D4
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 15:16:24 +1000 (EST)
Date: Thu, 21 Aug 2008 15:16:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] Add cuImage.mpc866ads to the bootwrapper as a
	cuboot-8xx target
Message-Id: <20080821151612.4bdf0692.sfr@canb.auug.org.au>
In-Reply-To: <20080731161020.GD20212@cs181140183.pp.htv.fi>
References: <20080731161020.GD20212@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__21_Aug_2008_15_16_12_+1000_Sn7z7LXiFPOaYfi8"
Cc: Scott Wood <scottwood@freescale.com>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__21_Aug_2008_15_16_12_+1000_Sn7z7LXiFPOaYfi8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Anyone going to add this patch to some tree (I have had it in linux-next
for a while).

http://patchwork.ozlabs.org/linuxppc/patch?id=3D19962

On Thu, 31 Jul 2008 19:10:22 +0300 Adrian Bunk <bunk@kernel.org> wrote:
>
> From: Scott Wood <scottwood@freescale.com>
>=20
> This patch fixes the following build error with mpc866_ads_defconfig:
>=20
> <--  snip  -->
>=20
> ...
>   WRAP    arch/powerpc/boot/cuImage.mpc866ads
> powerpc64-linux-ld: arch/powerpc/boot/cuboot-mpc866ads.o: No such file: N=
o such file or directory
> make[2]: *** [arch/powerpc/boot/cuImage.mpc866ads] Error 1
>=20
> <--  snip  -->
>=20
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
>=20
> ---
>=20
> This patch was sent by Scott Wood on:
> - 21 May 2008
>=20
>  arch/powerpc/boot/wrapper |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index d6c96d9..3b59e33 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -159,7 +159,7 @@ cuboot*)
>      binary=3Dy
>      gzip=3D
>      case "$platform" in
> -    *-mpc885ads|*-adder875*|*-ep88xc)
> +    *-mpc866ads|*-mpc885ads|*-adder875*|*-ep88xc)
>          platformo=3D$object/cuboot-8xx.o
>          ;;
>      *5200*|*-motionpro)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__21_Aug_2008_15_16_12_+1000_Sn7z7LXiFPOaYfi8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkis+hwACgkQjjKRsyhoI8ySNgCgu3rwVNPc0tZ1dEIeXhjr0/3f
cA8AoIi+/7qwt7BDAEie/GW4KqNyowqI
=qLcH
-----END PGP SIGNATURE-----

--Signature=_Thu__21_Aug_2008_15_16_12_+1000_Sn7z7LXiFPOaYfi8--
