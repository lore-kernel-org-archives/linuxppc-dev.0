Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 23246DE748
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 18:34:38 +1000 (EST)
Date: Thu, 21 Aug 2008 18:34:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: powerpc allmodconfig in current -mm
Message-Id: <20080821183417.f4ad1aee.sfr@canb.auug.org.au>
In-Reply-To: <20080820181626.0347c270.akpm@linux-foundation.org>
References: <20080820181626.0347c270.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__21_Aug_2008_18_34_17_+1000_sdUZcwoC_7SjoB6F"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__21_Aug_2008_18_34_17_+1000_sdUZcwoC_7SjoB6F
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, 20 Aug 2008 18:16:26 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> From: Andrew Morton <akpm@linux-foundation.org>
>=20
> powerpc allmodconfig:
>=20
> ERROR: "CMO_PageSize" [arch/powerpc/platforms/pseries/cmm.ko] undefined!
>=20
> (needed for 2.6.27)
>=20
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>=20
>  arch/powerpc/platforms/pseries/setup.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff -puN arch/powerpc/platforms/pseries/setup.c~powerpc-export-cmo_pages=
ize arch/powerpc/platforms/pseries/setup.c
> --- a/arch/powerpc/platforms/pseries/setup.c~powerpc-export-cmo_pagesize
> +++ a/arch/powerpc/platforms/pseries/setup.c
> @@ -71,6 +71,7 @@
>  int CMO_PrPSP =3D -1;
>  int CMO_SecPSP =3D -1;
>  unsigned long CMO_PageSize =3D (ASM_CONST(1) << IOMMU_PAGE_SHIFT);
> +EXPORT_SYMBOL(CMO_PageSize);
> =20
>  int fwnmi_active;  /* TRUE if an FWNMI handler is present */
> =20

Added to linux-next for today.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__21_Aug_2008_18_34_17_+1000_sdUZcwoC_7SjoB6F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkitKIkACgkQjjKRsyhoI8w/+ACfVvmsMW50Wtu0NLL37iUkqoHF
kJoAn0FitKIpgQDK+GtcJ0BH21pUXnyz
=Hj+X
-----END PGP SIGNATURE-----

--Signature=_Thu__21_Aug_2008_18_34_17_+1000_sdUZcwoC_7SjoB6F--
