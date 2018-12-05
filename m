Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D92C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 04:43:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21C72084C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 04:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Vfc3ZD3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21C72084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438mMp6RQrzDqMg
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 15:43:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Vfc3ZD3W";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438mJj0T6DzDqjb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 15:41:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Vfc3ZD3W"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 438mJh2drLz9sBh; Wed,  5 Dec 2018 15:41:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1543984868;
 bh=ku6eXxDDgNrOYIprZkuzc7Hogt42P1coCjlqIzAKII8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vfc3ZD3WwiTunjJJZ8ilQvRrHqr2DKb431JhaVjS3XALytfwfiC6fV4roW3AuW8gW
 NRoXHoXz3Mi8UoY+B2miwq85zG/IjtJ13FCQoIhD6CpJzXiRTnZb81xcOpXvEMlTHm
 dBsJv3NCH5a3X9J/AxVQMRaTBljonctQwHUJgnQ8=
Date: Wed, 5 Dec 2018 15:25:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v4 02/19] powerpc/mm/iommu/vfio_spapr_tce: Change
 mm_iommu_get to reference a region
Message-ID: <20181205042548.GC6757@umbus.fritz.box>
References: <20181123055304.25116-1-aik@ozlabs.ru>
 <20181123055304.25116-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <20181123055304.25116-3-aik@ozlabs.ru>
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 04:52:47PM +1100, Alexey Kardashevskiy wrote:
> Normally mm_iommu_get() is supposed to add a reference and
> mm_iommu_put() to remove it. However historically mm_iommu_find() does
> the referencing and mm_iommu_get() is doing allocation and referencing.
>=20
> We are going to add another helper to preregister device memory so
> instead of having mm_iommu_new() which pre-registers the normal memory
> and references the region, we need separate helpers for pre-registering
> and referencing.
>=20
> This renames:
> - mm_iommu_get to mm_iommu_new;
> - mm_iommu_find to mm_iommu_get.
>=20
> To make the mm_iommu_get name reflect what it is supposed to do, this
> changes mm_iommu_get() to reference the region so from now on for every
> mm_iommu_get() we need a matching mm_iommu_put().
>=20
> This removes the check for exact match as the check for overlap is
> enough now.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.drobpear.id.au>

> ---
> Changes:
> v4:
> * squashed "powerpc/mm/iommu: Make mm_iommu_new() fail on existing region=
s" into this
>=20
> v2:
> * merged 2 patches into one
> ---
>  arch/powerpc/include/asm/mmu_context.h |  4 +--
>  arch/powerpc/mm/mmu_context_iommu.c    | 19 +++++++------
>  drivers/vfio/vfio_iommu_spapr_tce.c    | 37 +++++++++++++++++---------
>  3 files changed, 35 insertions(+), 25 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index 0381394..2d6b00d 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -21,7 +21,7 @@ struct mm_iommu_table_group_mem_t;
> =20
>  extern int isolate_lru_page(struct page *page);	/* from internal.h */
>  extern bool mm_iommu_preregistered(struct mm_struct *mm);
> -extern long mm_iommu_get(struct mm_struct *mm,
> +extern long mm_iommu_new(struct mm_struct *mm,
>  		unsigned long ua, unsigned long entries,
>  		struct mm_iommu_table_group_mem_t **pmem);
>  extern long mm_iommu_put(struct mm_struct *mm,
> @@ -32,7 +32,7 @@ extern struct mm_iommu_table_group_mem_t *mm_iommu_look=
up(struct mm_struct *mm,
>  		unsigned long ua, unsigned long size);
>  extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(
>  		struct mm_struct *mm, unsigned long ua, unsigned long size);
> -extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct=
 *mm,
> +extern struct mm_iommu_table_group_mem_t *mm_iommu_get(struct mm_struct =
*mm,
>  		unsigned long ua, unsigned long entries);
>  extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
>  		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index 1d5161f..580d89e 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -89,7 +89,7 @@ bool mm_iommu_preregistered(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
> =20
> -long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long =
entries,
> +long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long =
entries,
>  		struct mm_iommu_table_group_mem_t **pmem)
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
> @@ -102,12 +102,6 @@ long mm_iommu_get(struct mm_struct *mm, unsigned lon=
g ua, unsigned long entries,
> =20
>  	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,
>  			next) {
> -		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries)) {
> -			++mem->used;
> -			*pmem =3D mem;
> -			goto unlock_exit;
> -		}
> -
>  		/* Overlap? */
>  		if ((mem->ua < (ua + (entries << PAGE_SHIFT))) &&
>  				(ua < (mem->ua +
> @@ -202,7 +196,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long=
 ua, unsigned long entries,
> =20
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(mm_iommu_get);
> +EXPORT_SYMBOL_GPL(mm_iommu_new);
> =20
>  static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
>  {
> @@ -318,21 +312,26 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup_=
rm(struct mm_struct *mm,
>  	return ret;
>  }
> =20
> -struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
> +struct mm_iommu_table_group_mem_t *mm_iommu_get(struct mm_struct *mm,
>  		unsigned long ua, unsigned long entries)
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
> -EXPORT_SYMBOL_GPL(mm_iommu_find);
> +EXPORT_SYMBOL_GPL(mm_iommu_get);
> =20
>  long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
>  		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index ad63725..56db071 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -151,12 +151,13 @@ static long tce_iommu_unregister_pages(struct tce_c=
ontainer *container,
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
>  	struct tce_iommu_prereg *tcemem;
> -	bool found =3D false;
> +	bool found;
> +	long ret;
> =20
>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
>  		return -EINVAL;
> =20
> -	mem =3D mm_iommu_find(container->mm, vaddr, size >> PAGE_SHIFT);
> +	mem =3D mm_iommu_get(container->mm, vaddr, size >> PAGE_SHIFT);
>  	if (!mem)
>  		return -ENOENT;
> =20
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
> @@ -185,22 +190,24 @@ static long tce_iommu_register_pages(struct tce_con=
tainer *container,
>  			((vaddr + size) < vaddr))
>  		return -EINVAL;
> =20
> -	mem =3D mm_iommu_find(container->mm, vaddr, entries);
> +	mem =3D mm_iommu_get(container->mm, vaddr, entries);
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
> -	ret =3D mm_iommu_get(container->mm, vaddr, entries, &mem);
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

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwHU0wACgkQbDjKyiDZ
s5KnhRAAs3Q+zg6x2O5U0F0+pji0tZ6iNB5d7pDR8TUjvQkSe9aYwqoX9N8IZOWY
H6ESdgQZo0muLDKqbVGpB4kRphrtgyskCyVh+ItmKl8tL8HxzvB6sGe2BKksu0IG
kpwFaAguK4RmLIPHfjh+yAj6oeG5wjSNv2ik4WZUUjbvJ8JL4lkkSDmsUALbAMdh
mrxENkd1+KmY4n77ptrMmID8f3o14l3XHuZqELDAi2j1xvipO5+Y9+nitvx0VTTz
IXN2/Pf2bP6ZcZb87d6n3gxgU4E4H7N1mMHqDwF4FLWaEB2wDdg/qET5ZFWErGUN
HGJRRIquFhBBV/Ba6ZY4KhjAMCIrkOiobL25gdYbki2yZ0BCxhR7/M8uwFMFoSLk
02gMRS/TquLcSSBms2Sg9fyTtDKLRs018VtQEgW9vbBwO7UqeZb8KS2tqDGr5AkO
RdnAG0u3tNfUmVoDOPtOSh3lIKn6jnB5+Ezn9yTspViIucxIGtmPeajBnfYdbqJE
99jIoq1X/WI9pLE0c7MduiVxZ7kEktPSmZWza/yILtg1dYIaaZaSku1c12rVanHV
SCeoRs/mZodM5GvU3GQM1xeMm8q4TzChuZ1snK6g8sMY6K+b8ASjq2bX0xwUYXSF
P4ZmC5we14elw46auuMCsnnXTC6nWt9qi/ZLfngK/viCbNDC1ao=
=dmMg
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
