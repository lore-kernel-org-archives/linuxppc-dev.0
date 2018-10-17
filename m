Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174A7C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 02:29:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E5F214C3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 02:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IMm4b1zr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E5F214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZbjN36yGzF3LH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 13:29:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IMm4b1zr";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Zbbz1ccdzF3Wm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 13:24:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="IMm4b1zr"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Zbbz09lqz9s9h; Wed, 17 Oct 2018 13:24:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1539743087;
 bh=OvRWtHkE3PE3vXbr6KCwkJ7IfmQmEDXp2C8ExSPT3VY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IMm4b1zreEF8sZsSw3OaaWUwHG8EJ/2adu56m/0SDFMb4QiHQSFiPpgolf17JX21a
 9R6BjIN47lnBIq0AmFgnNmyng/drFHxbyv0GgqhpQAGrvu0ZjCGheNNHQbP4bxau2/
 X9XxPUuly1x/VCKAoNVBUbo8+MjsyKL5B6w0fwFE=
Date: Wed, 17 Oct 2018 11:44:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 1/4] powerpc/mm/iommu: Rename mm_iommu_get
Message-ID: <20181017004434.GL16167@umbus.fritz.box>
References: <20181015092416.47380-1-aik@ozlabs.ru>
 <20181015092416.47380-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="umrsQkkrw7viUWFs"
Content-Disposition: inline
In-Reply-To: <20181015092416.47380-2-aik@ozlabs.ru>
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


--umrsQkkrw7viUWFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 08:24:13PM +1100, Alexey Kardashevskiy wrote:
> Normally mm_iommu_get() is supposed to add a reference and
> mm_iommu_put() to remove it. However historically mm_iommu_find() does
> the referencing and mm_iommu_get() is doing allocation and referencing.
>=20
> This is step 1 towards simpler mm_iommu_get().
>=20
> This renames:
> - mm_iommu_get to mm_iommu_new;
> - mm_iommu_find to mm_iommu_get.
>=20
> This should cause no behavioural change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Erm.. as far as I can tell, mm_iommu_find() doesn't adjust any
reference counts, so renaming it to mm_iommu_get() doesn't really make
sense.

> ---
>  arch/powerpc/include/asm/mmu_context.h | 4 ++--
>  arch/powerpc/mm/mmu_context_iommu.c    | 8 ++++----
>  drivers/vfio/vfio_iommu_spapr_tce.c    | 6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index b694d6a..59d4941 100644
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
> index 56c2234..8eeb99d 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -126,7 +126,7 @@ static int mm_iommu_move_page_from_cma(struct page *p=
age)
>  	return 0;
>  }
> =20
> -long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long =
entries,
> +long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long =
entries,
>  		struct mm_iommu_table_group_mem_t **pmem)
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
> @@ -252,7 +252,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long=
 ua, unsigned long entries,
> =20
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(mm_iommu_get);
> +EXPORT_SYMBOL_GPL(mm_iommu_new);
> =20
>  static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
>  {
> @@ -368,7 +368,7 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm=
(struct mm_struct *mm,
>  	return ret;
>  }
> =20
> -struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
> +struct mm_iommu_table_group_mem_t *mm_iommu_get(struct mm_struct *mm,
>  		unsigned long ua, unsigned long entries)
>  {
>  	struct mm_iommu_table_group_mem_t *mem, *ret =3D NULL;
> @@ -382,7 +382,7 @@ struct mm_iommu_table_group_mem_t *mm_iommu_find(stru=
ct mm_struct *mm,
> =20
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(mm_iommu_find);
> +EXPORT_SYMBOL_GPL(mm_iommu_get);
> =20
>  long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
>  		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index ad63725..1701798 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -156,7 +156,7 @@ static long tce_iommu_unregister_pages(struct tce_con=
tainer *container,
>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
>  		return -EINVAL;
> =20
> -	mem =3D mm_iommu_find(container->mm, vaddr, size >> PAGE_SHIFT);
> +	mem =3D mm_iommu_get(container->mm, vaddr, size >> PAGE_SHIFT);
>  	if (!mem)
>  		return -ENOENT;
> =20
> @@ -185,7 +185,7 @@ static long tce_iommu_register_pages(struct tce_conta=
iner *container,
>  			((vaddr + size) < vaddr))
>  		return -EINVAL;
> =20
> -	mem =3D mm_iommu_find(container->mm, vaddr, entries);
> +	mem =3D mm_iommu_get(container->mm, vaddr, entries);
>  	if (mem) {
>  		list_for_each_entry(tcemem, &container->prereg_list, next) {
>  			if (tcemem->mem =3D=3D mem)
> @@ -193,7 +193,7 @@ static long tce_iommu_register_pages(struct tce_conta=
iner *container,
>  		}
>  	}
> =20
> -	ret =3D mm_iommu_get(container->mm, vaddr, entries, &mem);
> +	ret =3D mm_iommu_new(container->mm, vaddr, entries, &mem);
>  	if (ret)
>  		return ret;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--umrsQkkrw7viUWFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvGhe8ACgkQbDjKyiDZ
s5KK8g//Sxra0bJobEyLPqYnWTCaOkK5o0UhKq63uNtuzAfnS00Xr9/mNozRG4AH
ryaVWN0YJuXeyfdseYCOOOFc27I+ZGYw1CS7s76QE28JiduINCcpdH1xiy6s/EPi
IEPogg9Ha3P3+asvKlExyJtFpNVoVyc5Fm5+t1XCa+/+zMTNuDvqwWRXFJSdT2+L
GiDHsKraqjcRuvnewwxYPZJscnaOT566TqC4XXG9o4ir4G/8KFqfeDaVdBkWxd+q
vZxpSQRQ+B1AYFpmDj3wmj1secektjT1jB2vAbCgyJyKPeoxL06enOKk64Ez5bgt
EY+VnchDGRl1l8RnFRMhgdDMllYT+hj1gzW3x2lccB8ERgaNI3iJdR5FglEmM6ek
mRulqsPDW6SfZQK4wP+/XBJIRC71TkMiMWYawpFzbkTfXHWezfYos6h8yjR5vAHM
GI0/ahhXUsI5FWoIEQh+cGa7nuXKkEevPZVKbG6VvlxoFRe6+mLkBkDbFulbHG8/
fhcfuMfb2a0q9Yrx4a9RF+5LACmN5kbdH47aKAct+m6Qp/leTSNxanfWm21GZtS6
Ly/HERpfhPbdlvn68PrGoILn4dmNp+PmH00/BuJUroVQztYzmiWTuPe56llwurgF
X0XRWPgCHcjvW4Oezt3t/ZkTqfXPRTQ5GfUvwnbTUJgnjlTUikQ=
=Fu4h
-----END PGP SIGNATURE-----

--umrsQkkrw7viUWFs--
