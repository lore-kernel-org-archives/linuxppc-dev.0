Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: remove IOMMU_VMERGE config option
From: Michael Ellerman <michael@ellerman.id.au>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100303085404R.fujita.tomonori@lab.ntt.co.jp>
References: <20100303085404R.fujita.tomonori@lab.ntt.co.jp>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-wpioZUw2UKI5VfpEQVHU"
Date: Wed, 03 Mar 2010 11:13:52 +1100
Message-ID: <1267575232.7814.21.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
	arnd@arndb.de, benh@kernel.crashing.or
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-wpioZUw2UKI5VfpEQVHU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-03-03 at 08:54 +0900, FUJITA Tomonori wrote:
> Seems that IOMMU_VMERGE option description gives the false
> information:
>=20
> http://marc.info/?l=3Dlinux-sparc&m=3D126753808727669&w=3D2
> http://marc.info/?l=3Dlinux-sparc&m=3D126753880528825&w=3D2
>=20
> IOMMU_VMERGE is unnecessary nowadays so how about removing it?

Except you didn't remove it, you just made it uneditable? Why not get
rid of it entirely.

cheers

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 155d571..2dfa83b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -314,17 +314,8 @@ config 8XX_MINIMAL_FPEMU
>  	  It is recommended that you build a soft-float userspace instead.
> =20
>  config IOMMU_VMERGE
> -	bool "Enable IOMMU virtual merging"
> +	def_bool y
>  	depends on PPC64
> -	default y
> -	help
> -	  Cause IO segments sent to a device for DMA to be merged virtually
> -	  by the IOMMU when they happen to have been allocated contiguously.
> -	  This doesn't add pressure to the IOMMU allocator. However, some
> -	  drivers don't support getting large merged segments coming back
> -	  from *_map_sg().
> -
> -	  Most drivers don't have this problem; it is safe to say Y here.
> =20
>  config IOMMU_HELPER
>  	def_bool PPC64



--=-wpioZUw2UKI5VfpEQVHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkuNqboACgkQdSjSd0sB4dIQrwCfX8idcGbc4vLkHhYgq4Yn64Ul
GloAn2ATMOaBvF7cbtEVTwCPOOLCNsnB
=FP/9
-----END PGP SIGNATURE-----

--=-wpioZUw2UKI5VfpEQVHU--
