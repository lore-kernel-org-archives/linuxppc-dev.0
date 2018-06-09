Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412jYZ2LwlzDr9K
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jun 2018 12:15:46 +1000 (AEST)
Date: Sat, 9 Jun 2018 12:04:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH kernel 1/6] powerpc/powernv: Remove useless wrapper
Message-ID: <20180609020442.GY3344@umbus.fritz.box>
References: <20180608054633.18659-1-aik@ozlabs.ru>
 <20180608054633.18659-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JjNtGRvLZqzR8wa5"
In-Reply-To: <20180608054633.18659-2-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--JjNtGRvLZqzR8wa5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 03:46:28PM +1000, Alexey Kardashevskiy wrote:
> This gets rid of a useless wrapper around
> pnv_pci_ioda2_table_free_pages().
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 29f798c..d4c60b6 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2206,11 +2206,6 @@ static void pnv_ioda2_tce_free(struct iommu_table =
*tbl, long index,
>  	pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
>  }
> =20
> -static void pnv_ioda2_table_free(struct iommu_table *tbl)
> -{
> -	pnv_pci_ioda2_table_free_pages(tbl);
> -}
> -
>  static struct iommu_table_ops pnv_ioda2_iommu_ops =3D {
>  	.set =3D pnv_ioda2_tce_build,
>  #ifdef CONFIG_IOMMU_API
> @@ -2219,7 +2214,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops =
=3D {
>  #endif
>  	.clear =3D pnv_ioda2_tce_free,
>  	.get =3D pnv_tce_get,
> -	.free =3D pnv_ioda2_table_free,
> +	.free =3D pnv_pci_ioda2_table_free_pages,
>  };
> =20
>  static int pnv_pci_ioda_dev_dma_weight(struct pci_dev *dev, void *data)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JjNtGRvLZqzR8wa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsbNboACgkQbDjKyiDZ
s5KmbhAA3HYTAIXtvMRMSuqkB9fV3wq2aMSqJBej3lzlYhaGXYM6fLFWlKoIdjKQ
uosPrzWb6ykD+XwiAAjtCV3C/D7hRVb6Oj2Ym+DweAu7GwK0Hs0y80dOKbHWGIG2
/WK0QLx94TILckdC50sv/vsovknO/JpGdJisbSO7QWM3Xa8kjYMcXbizcTS5xEnL
bLn83eVrnQnT95BH+tZ64udPk6UZiMsVJTikGXwvvZBKIfyD+EexfCfD8mnCcBnI
+U8t5bR91BVVnBTrrBWs6mg5WPWZoHUgICc/86qlx7/1kqrb1M9dBkT/3+GQPFsR
PT5qCG5cnmm7IjJNMW3dNpU5bB1WPuF4neWxNqFHczgv9/HBugbSYLns6byu8cJA
LkUTZLaRZt4fM/oK7efarkoQbcNzL06zE1XRqspwx9OfyOxPngL5qObODcsP7mPH
xi2hEZYAQpWRRTabM7DRIZInWu9LnTD6U1hV0YemqT5ni8swuRTIa9gILeh3+/qQ
+qMvZvbHbfVqDE+45LVPyZB4J2hulrb4C5xi90sBttRsI3/86OszG+XEhNCBeJBO
6afpNxUPOm+d2NVuCdKoIo161WGUZTvXLjurgRWo98XvwNNs3vzM20NdafL1qZUC
M4jV1A4xXF++I5fqpRj2RQ4lwq+pKAd0VFkNdWU7XKRhWX6FFp8=
=88Jo
-----END PGP SIGNATURE-----

--JjNtGRvLZqzR8wa5--
