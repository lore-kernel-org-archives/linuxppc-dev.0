Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5009C5ACC6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 02:27:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4DE7214C3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 02:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aoRSHU86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DE7214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Zbfn4RQxzF3X2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 13:27:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aoRSHU86";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Zbbz1BvZzF3Wl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 13:24:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="aoRSHU86"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Zbby6hcRz9s8F; Wed, 17 Oct 2018 13:24:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1539743086;
 bh=tUlXX7igIdocLYL6xUslZneb2kz04KFoBPTOivAH7FA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aoRSHU862FG27gc8rtqSfa0KOJGLtz573JNbMBe5R4ujJ29fdA99s4rQDOn9qb7wd
 Kix9vdxRIrrcrnF0nUShnXhVdjd4lNWHtNCNRfpsJ7Be7XSFL8L+Q/Ky+N6VtTBJ6A
 QMtUXrwPKPXEQ5+0+jZwU6zoN3AKSt3xWdFm1D0Y=
Date: Wed, 17 Oct 2018 11:46:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 2/4] powerpc/mm/iommu/vfio_spapr_tce: Change
 mm_iommu_get to reference a region
Message-ID: <20181017004614.GM16167@umbus.fritz.box>
References: <20181015092416.47380-1-aik@ozlabs.ru>
 <20181015092416.47380-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dzI2QqkSBOAresgT"
Content-Disposition: inline
In-Reply-To: <20181015092416.47380-3-aik@ozlabs.ru>
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
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--dzI2QqkSBOAresgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 08:24:14PM +1100, Alexey Kardashevskiy wrote:
> We are going to add another helper to preregister device memory so
> instead of having mm_iommu_new() which pre-registers the normal memory
> and references the region, we need separate helpers for pre-registerign
> and referencing.
>=20
> To make the mm_iommu_get name reflect what it is supposed to do, this
> changes mm_iommu_get() to reference the region so from now on for every
> mm_iommu_get() we need a matching mm_iommu_put().
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

=2E. ah, I see.

I think this should be folded with the first patch, so we don't have
an interim step where mm_iommu_get() has a misleading name.

> ---
>  arch/powerpc/mm/mmu_context_iommu.c |  5 +++++
>  drivers/vfio/vfio_iommu_spapr_tce.c | 33 ++++++++++++++++++++++---------=
--
>  2 files changed, 27 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index 8eeb99d..a8c4a3c 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -373,13 +373,18 @@ struct mm_iommu_table_group_mem_t *mm_iommu_get(str=
uct mm_struct *mm,
>  {
>  	struct mm_iommu_table_group_mem_t *mem, *ret =3D NULL;
> =20
> +	mutex_lock(&mem_list_mutex);
> +
>  	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
>  		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries)) {
>  			ret =3D mem;
> +			++mem->used;
>  			break;
>  		}
>  	}
> =20
> +	mutex_unlock(&mem_list_mutex);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_get);
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 1701798..56db071 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -151,7 +151,8 @@ static long tce_iommu_unregister_pages(struct tce_con=
tainer *container,
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
>  	struct tce_iommu_prereg *tcemem;
> -	bool found =3D false;
> +	bool found;
> +	long ret;
> =20
>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
>  		return -EINVAL;
> @@ -168,9 +169,13 @@ static long tce_iommu_unregister_pages(struct tce_co=
ntainer *container,
>  	}
> =20
>  	if (!found)
> -		return -ENOENT;
> +		ret =3D -ENOENT;
> +	else
> +		ret =3D tce_iommu_prereg_free(container, tcemem);
> =20
> -	return tce_iommu_prereg_free(container, tcemem);
> +	mm_iommu_put(container->mm, mem);
> +
> +	return ret;
>  }
> =20
>  static long tce_iommu_register_pages(struct tce_container *container,
> @@ -188,19 +193,21 @@ static long tce_iommu_register_pages(struct tce_con=
tainer *container,
>  	mem =3D mm_iommu_get(container->mm, vaddr, entries);
>  	if (mem) {
>  		list_for_each_entry(tcemem, &container->prereg_list, next) {
> -			if (tcemem->mem =3D=3D mem)
> -				return -EBUSY;
> +			if (tcemem->mem =3D=3D mem) {
> +				ret =3D -EBUSY;
> +				goto put_exit;
> +			}
>  		}
> +	} else {
> +		ret =3D mm_iommu_new(container->mm, vaddr, entries, &mem);
> +		if (ret)
> +			return ret;
>  	}
> =20
> -	ret =3D mm_iommu_new(container->mm, vaddr, entries, &mem);
> -	if (ret)
> -		return ret;
> -
>  	tcemem =3D kzalloc(sizeof(*tcemem), GFP_KERNEL);
>  	if (!tcemem) {
> -		mm_iommu_put(container->mm, mem);
> -		return -ENOMEM;
> +		ret =3D -ENOMEM;
> +		goto put_exit;
>  	}
> =20
>  	tcemem->mem =3D mem;
> @@ -209,6 +216,10 @@ static long tce_iommu_register_pages(struct tce_cont=
ainer *container,
>  	container->enabled =3D true;
> =20
>  	return 0;
> +
> +put_exit:
> +	mm_iommu_put(container->mm, mem);
> +	return ret;
>  }
> =20
>  static bool tce_page_is_contained(struct page *page, unsigned page_shift)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dzI2QqkSBOAresgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvGhlYACgkQbDjKyiDZ
s5K4Aw//Z1+YxlK4/FofI4UN+VrK90kuvsUxu1DPKnjVZMx9wFh6tNqdvxKsTj0t
6fc/HwEkEz34eIE//1yp5HTduAik4Rs6AvsVn+dd+RG/32NFGk74nxpEbs6TpS4u
nxWLTdIt94pZ2aXdpSBcncoJbaC3M+2LrDWhEN1R8+WGeVd4Gqcsax3H0u0+v9AC
vsppxI6XyQsM9htvs5G+ATZpbmA/4eAwEuXG2ZHMVF38zb7wDsLDNDCR0ojynhiM
vUK0YehqnVHPEAII1vgycVffuMlwVi8EJJQfdwxLg4SYNJ8mXMgP5JE47HzIbzLO
S2hHBLhe6tJjHnRuuF4+Y2HJZT1sxPklhckVnkl3AYwKXv6g2DWz1tV0PrzTBNfY
yuItj8fRg95QPE/3vAvD0Br2ACG+nGDzgNm7zHAnOozUgbv8/nQasIQW4WXDvBz6
X6pYJBX58kwUrDH07mAGiVzcMjcfDliy1osClnI3Xq9qKT1smEb6mS4gDDa1tI1M
cUX7bs7pXod9SHn18qcQFnq1R6Pgj5uGiP2GaLh7+mCo7Lv6+V8z8inwABYJpvMa
gEN4wOWvJMUpQNz21xmrpqhsANf39IPktONiO+tw+R/u4g18sEwbk9AYi0T4ArPR
h3WuUAui+MUAd0oGp8N2bvZTqLWXQu3AxMjOl4iDk0UoLjkwetM=
=6KaP
-----END PGP SIGNATURE-----

--dzI2QqkSBOAresgT--
