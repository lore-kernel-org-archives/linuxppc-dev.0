Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qh6nG60rZzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 15:04:02 +1000 (AEST)
Date: Fri, 8 Apr 2016 15:00:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel] vfio_iommu_spapr_tce: Remove unneeded
 iommu_group_get_iommudata
Message-ID: <20160408050044.GF3332@voom.fritz.box>
References: <1460091281-14664-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mrJd9p1Ce66CJMxE"
In-Reply-To: <1460091281-14664-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--mrJd9p1Ce66CJMxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2016 at 02:54:41PM +1000, Alexey Kardashevskiy wrote:
> This removes iommu_group_get_iommudata() as the result is never used.
> As this is a minor cleanup, no change in behavior is expected.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 0582b72..6419566 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -331,14 +331,12 @@ static void tce_iommu_free_table(struct iommu_table=
 *tbl);
>  static void tce_iommu_release(void *iommu_data)
>  {
>  	struct tce_container *container =3D iommu_data;
> -	struct iommu_table_group *table_group;
>  	struct tce_iommu_group *tcegrp;
>  	long i;
> =20
>  	while (tce_groups_attached(container)) {
>  		tcegrp =3D list_first_entry(&container->group_list,
>  				struct tce_iommu_group, next);
> -		table_group =3D iommu_group_get_iommudata(tcegrp->grp);
>  		tce_iommu_detach_group(iommu_data, tcegrp->grp);
>  	}
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mrJd9p1Ce66CJMxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBzr8AAoJEGw4ysog2bOS0zQP/2Q6pZrRfk31x7eLNvJuWgKv
gbNaPMxctWQuV7bFs4DqgEtkm87mH4n4NwrBhcHu75dZVVOqHKBxvHljgfX1Vaen
MRd6UcdrYN9oRvifi33K+gY0Vy/xleEQiV24D9ERr5nzLF+jgWf0ycdQyLacEo4m
MxrV9iQenIDwg4TEEd4VnDnbKoS48BGxyh4/CvZZNXhJNSJxVVWSXZ50ZZOrVpgt
Pfi4eOHnPBfaW44uF3K3Dq+6F2n1BOm6sXjkbGsod1hchicVqHcP8jXOgmEDp6fd
3DCjCcw8HD3Ywl7RvgzTU+Tae7hrRIafOOqy1B92VwrYgkHRoHEPAaij2RHMPIiG
i6p/bBbRpwaZ1StMz4iJLB+XJ5h5Jw6Wdu0J2ZJnH3BtOCvlR9/vDn1V4f5GCamx
JroE1lkqrTcBKh7iPJAEO+tXK7q3qg8OmprJUVGSiKu20TDqQYM6aDyrHwHpIR83
F5mqtHGD1B2ZE3rWopbCAO813kBKEu6EDPFFs3iDVxsX2EfmozOurr5jzw5ZcVH9
gGUhPnlIzvdUrhiQwmP3JGgrQhLtwDT2m/mchEQ8bKkG0fm6/pKY+uxqKrIFfu//
cE93HI2prDofUmNQYZaicsIEVnHHvCD3YPrqLvy46RqzI3cC3aTGmXPuajoEbE2e
GieOXDFuGJ4LkmkN9O+q
=WNaL
-----END PGP SIGNATURE-----

--mrJd9p1Ce66CJMxE--
