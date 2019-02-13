Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6E2C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 04:50:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA25E222BB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 04:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f68qRXRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA25E222BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43znBk649rzDqMb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 15:50:06 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zn953bPgzDqMM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 15:48:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="f68qRXRF"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43zn951yVlz9sDr; Wed, 13 Feb 2019 15:48:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1550033321;
 bh=cpk5wAM05fg43IYLuGcEQ5K26gOcLDuBVW5W5RqhBh0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f68qRXRFYvZAbTrpAoj4OLbhUpAVyT41yHoUoxaD9fRJOVXzX48Grd+FkyD3t3DGI
 2DGnKpjqW0C6+b7v/hIqXuvifAdAJX8/FFN/qB1fxIksnrf9wnGmDiSrsD4U3L1z08
 CYKAfAwJQwwe/5BG5w5D9m/chIiYQZz3tj+k9dyE=
Date: Wed, 13 Feb 2019 15:48:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v2] powerpc/powernv/ioda: Fix locked_vm counting
 for memory used by IOMMU tables
Message-ID: <20190213044835.GJ1884@umbus.fritz.box>
References: <20190213033818.51452-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XAtoqsFAXbjZCl7Z"
Content-Disposition: inline
In-Reply-To: <20190213033818.51452-1-aik@ozlabs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--XAtoqsFAXbjZCl7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 02:38:18PM +1100, Alexey Kardashevskiy wrote:
> We store 2 multilevel tables in iommu_table - one for the hardware and
> one with the corresponding userspace addresses. Before allocating
> the tables, the iommu_table_group_ops::get_table_size() hook returns
> the combined size of the two and VFIO SPAPR TCE IOMMU driver adjusts
> the locked_vm counter correctly. When the table is actually allocated,
> the amount of allocated memory is stored in iommu_table::it_allocated_size
> and used to decrement the locked_vm counter when we release the memory
> used by the table; .get_table_size() and .create_table() calculate it
> independently but the result is expected to be the same.
>=20
> However the allocator does not add the userspace table size to
> .it_allocated_size so when we destroy the table because of VFIO PCI
> unplug (i.e. VFIO container is gone but the userspace keeps running),
> we decrement locked_vm by just a half of size of memory we are releasing.
>=20
> To make things worse, since we enabled on-demain allocation of

s/demain/demand/

> indirect levels, it_allocated_size contains only the amount of memory
> actually allocated at the table creation time which can just be
> a fraction. It is not a problem with incrementing locked_vm (as
> get_table_size() value is used) but it is with decrementing.
>=20
> As the result, we leak locked_vm and may not be able to allocate more
> IOMMU tables after few iterations of hotplug/unplug.
>=20
> This sets it_allocated_size in the pnv_pci_ioda2_ops::create_table()
> hook to what pnv_pci_ioda2_get_table_size() returns so from now on
> we have a single place which calculates the maximum memory a table can
> occupy. The original meaning of it_allocated_size is somewhat lost now
> though.
>=20
> We do not ditch it_allocated_size whatsoever here and we do not call
> get_table_size() from vfio_iommu_spapr_tce.c when decrementing locked_vm
> as we may have multiple IOMMU groups per container and even though they
> all are supposed to have the same get_table_size() implementation,
> there is a small chance for failure or confusion.
>=20
> Fixes: 090bad39b "powerpc/powernv: Add indirect levels to it_userspace"
> Fixes: a68bd1267 "powerpc/powernv/ioda: Allocate indirect TCE levels on d=
emand"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Apart from the typo above,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v2:
> * this is reworked "[PATCH kernel] powerpc/powernv/ioda: Store correct am=
ount of memory used for table"
>=20
> ---
>  arch/powerpc/platforms/powernv/pci-ioda-tce.c | 1 -
>  arch/powerpc/platforms/powernv/pci-ioda.c     | 7 ++++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc=
/platforms/powernv/pci-ioda-tce.c
> index 697449a..e28f03e 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> @@ -313,7 +313,6 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 b=
us_offset,
>  			page_shift);
>  	tbl->it_level_size =3D 1ULL << (level_shift - 3);
>  	tbl->it_indirect_levels =3D levels - 1;
> -	tbl->it_allocated_size =3D total_allocated;
>  	tbl->it_userspace =3D uas;
>  	tbl->it_nid =3D nid;
> =20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 7db3119..d415739 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2592,8 +2592,13 @@ static long pnv_pci_ioda2_create_table_userspace(
>  		int num, __u32 page_shift, __u64 window_size, __u32 levels,
>  		struct iommu_table **ptbl)
>  {
> -	return pnv_pci_ioda2_create_table(table_group,
> +	long ret =3D pnv_pci_ioda2_create_table(table_group,
>  			num, page_shift, window_size, levels, true, ptbl);
> +
> +	if (!ret)
> +		(*ptbl)->it_allocated_size =3D pnv_pci_ioda2_get_table_size(
> +				page_shift, window_size, levels);
> +	return ret;
>  }
> =20
>  static void pnv_ioda2_take_ownership(struct iommu_table_group *table_gro=
up)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XAtoqsFAXbjZCl7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjoaEACgkQbDjKyiDZ
s5LdYxAA1T9+YXrUhXM76lZdujnW2EiPxZwMGQOgJwykQqgx+VbuJCuml5U1rnTh
zrNbqzVRrxkj3qNfkoEDlhvHFtFJikD963Dj5aOthVO1+mDivhm+sD+NPCwSUDzX
VGcMpX2gmvG5801J43mfxNV+mCAIBgzCe//tmlejqfm/ugXqOGYKkCVfX/HZ3xZH
+eVN5rp0adDCcL0Mant2kojnCu9CP1fYiZXFl78+AZ94YQxPCt7fVz8YyuQ8C6n4
VdVZzpmso11KMVazlymgb35ynUp7UtJID6UjBddFI6OuXT9bsvE/oKA987PS5Dgx
yKO3hifq/e3XPF+clTS55ap1QOOZhn7lHaSPTKPIUOhBZTOrg9REhhomeZF6JbxM
JP8+FD+3uQOjVksBFWrAWAVWzCGy9Ay/Fg1cMvVcH18qUNdk/LP8rawG6YMgOJpf
nMXMVKPaZ7fpmDBKXAakAkGAlu592KdVaSNoukgKO7gybqRJBLZN5K6KdBpva0Nf
XmpIWVjuMzlzRye/4dq7SEO3l66+SKiwJ/ya/uY6H26gErDQgR17d+SOGvJ1P4ze
fBJocFP1PzEUq4QuZE9a0MepKzHbl+SumTM1aBVSuM8+7AxGeLFxmqtqsaNZb5Xq
BEPTB9CkeBf/DTi+Rj163lYbgse5k082jk8/xTW9mp8aEWCbEbE=
=zLIk
-----END PGP SIGNATURE-----

--XAtoqsFAXbjZCl7Z--
