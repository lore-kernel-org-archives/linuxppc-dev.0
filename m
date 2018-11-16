Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C234FC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 03:25:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4079620818
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 03:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IwkRxjt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4079620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42x3X46ZckzF3hx
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 14:25:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IwkRxjt8";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42x3TQ3BzRzF3hh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 14:23:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="IwkRxjt8"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42x3TP6Fnmz9sBn; Fri, 16 Nov 2018 14:23:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1542338585;
 bh=wJ/Piq3sTjhjRyE2e30ArCi0HcW16uMlEmCanQI0Rqk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IwkRxjt8Dn1++EFcu6MFwHgGTHDvtDiCdGq7+v9o6dGcdcUnZNR649LZNA1Oo0lNn
 HX2y5b2rFgKs41/o1UEhLodTPQcDKpojO95YyzXGlXLlmgjevzlQj9JMUZZEWN5WBt
 KwsQe7RFqjmPbj9d33HVEh6An2pcCDMKdYdWFy8g=
Date: Fri, 16 Nov 2018 14:11:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3 04/22] powerpc/vfio/iommu/kvm: Do not pin
 device memory
Message-ID: <20181116031116.GA23632@umbus>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-5-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20181113082823.2440-5-aik@ozlabs.ru>
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
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:28:05PM +1100, Alexey Kardashevskiy wrote:
> This new memory does not have page structs as it is not plugged to
> the host so gup() will fail anyway.
>=20
> This adds 2 helpers:
> - mm_iommu_newdev() to preregister the "memory device" memory so
> the rest of API can still be used;
> - mm_iommu_is_devmem() to know if the physical address is one of thise
> new regions which we must avoid unpinning of.
>=20
> This adds @mm to tce_page_is_contained() and iommu_tce_xchg() to test
> if the memory is device memory to avoid pfn_to_page().
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/iommu.h       |  5 +-
>  arch/powerpc/include/asm/mmu_context.h |  5 ++
>  arch/powerpc/kernel/iommu.c            |  9 ++-
>  arch/powerpc/kvm/book3s_64_vio.c       | 18 +++---
>  arch/powerpc/mm/mmu_context_iommu.c    | 83 +++++++++++++++++++++++---
>  drivers/vfio/vfio_iommu_spapr_tce.c    | 28 +++++----
>  6 files changed, 116 insertions(+), 32 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 35db0cb..a8aeac0 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -218,8 +218,9 @@ extern void iommu_register_group(struct iommu_table_g=
roup *table_group,
>  extern int iommu_add_device(struct device *dev);
>  extern void iommu_del_device(struct device *dev);
>  extern int __init tce_iommu_bus_notifier_init(void);
> -extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
> -		unsigned long *hpa, enum dma_data_direction *direction);
> +extern long iommu_tce_xchg(struct mm_struct *mm, struct iommu_table *tbl,
> +		unsigned long entry, unsigned long *hpa,
> +		enum dma_data_direction *direction);
>  #else
>  static inline void iommu_register_group(struct iommu_table_group *table_=
group,
>  					int pci_domain_number,
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index 2d6b00d..f0f9f3d 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -24,6 +24,9 @@ extern bool mm_iommu_preregistered(struct mm_struct *mm=
);
>  extern long mm_iommu_new(struct mm_struct *mm,
>  		unsigned long ua, unsigned long entries,
>  		struct mm_iommu_table_group_mem_t **pmem);
> +extern long mm_iommu_newdev(struct mm_struct *mm, unsigned long ua,
> +		unsigned long entries, unsigned long dev_hpa,
> +		struct mm_iommu_table_group_mem_t **pmem);
>  extern long mm_iommu_put(struct mm_struct *mm,
>  		struct mm_iommu_table_group_mem_t *mem);
>  extern void mm_iommu_init(struct mm_struct *mm);
> @@ -39,6 +42,8 @@ extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_gr=
oup_mem_t *mem,
>  extern long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
>  		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
>  extern void mm_iommu_ua_mark_dirty_rm(struct mm_struct *mm, unsigned lon=
g ua);
> +extern bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
> +		unsigned int pageshift);
>  extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
>  extern void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem);
>  #endif
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index f0dc680..8ccfdd9 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -47,6 +47,7 @@
>  #include <asm/fadump.h>
>  #include <asm/vio.h>
>  #include <asm/tce.h>
> +#include <asm/mmu_context.h>
> =20
>  #define DBG(...)
> =20
> @@ -993,15 +994,17 @@ int iommu_tce_check_gpa(unsigned long page_shift, u=
nsigned long gpa)
>  }
>  EXPORT_SYMBOL_GPL(iommu_tce_check_gpa);
> =20
> -long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
> -		unsigned long *hpa, enum dma_data_direction *direction)
> +long iommu_tce_xchg(struct mm_struct *mm, struct iommu_table *tbl,
> +		unsigned long entry, unsigned long *hpa,
> +		enum dma_data_direction *direction)
>  {
>  	long ret;
> =20
>  	ret =3D tbl->it_ops->exchange(tbl, entry, hpa, direction);
> =20
>  	if (!ret && ((*direction =3D=3D DMA_FROM_DEVICE) ||
> -			(*direction =3D=3D DMA_BIDIRECTIONAL)))
> +			(*direction =3D=3D DMA_BIDIRECTIONAL)) &&
> +			!mm_iommu_is_devmem(mm, *hpa, tbl->it_page_shift))
>  		SetPageDirty(pfn_to_page(*hpa >> PAGE_SHIFT));

What about the equivalent real mode paths?  I guess they won't ever be
called for this case, since they're only used on POWER8.  However some
checks or WARN_ON() or something to make that clear would be nice.

>  	/* if (unlikely(ret))
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 62a8d03..532ab797 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -397,12 +397,13 @@ static long kvmppc_tce_validate(struct kvmppc_spapr=
_tce_table *stt,
>  	return H_SUCCESS;
>  }
> =20
> -static void kvmppc_clear_tce(struct iommu_table *tbl, unsigned long entr=
y)
> +static void kvmppc_clear_tce(struct mm_struct *mm, struct iommu_table *t=
bl,
> +		unsigned long entry)
>  {
>  	unsigned long hpa =3D 0;
>  	enum dma_data_direction dir =3D DMA_NONE;
> =20
> -	iommu_tce_xchg(tbl, entry, &hpa, &dir);
> +	iommu_tce_xchg(mm, tbl, entry, &hpa, &dir);
>  }
> =20
>  static long kvmppc_tce_iommu_mapped_dec(struct kvm *kvm,
> @@ -433,7 +434,7 @@ static long kvmppc_tce_iommu_do_unmap(struct kvm *kvm,
>  	unsigned long hpa =3D 0;
>  	long ret;
> =20
> -	if (WARN_ON_ONCE(iommu_tce_xchg(tbl, entry, &hpa, &dir)))
> +	if (WARN_ON_ONCE(iommu_tce_xchg(kvm->mm, tbl, entry, &hpa, &dir)))
>  		return H_TOO_HARD;
> =20
>  	if (dir =3D=3D DMA_NONE)
> @@ -441,7 +442,7 @@ static long kvmppc_tce_iommu_do_unmap(struct kvm *kvm,
> =20
>  	ret =3D kvmppc_tce_iommu_mapped_dec(kvm, tbl, entry);
>  	if (ret !=3D H_SUCCESS)
> -		iommu_tce_xchg(tbl, entry, &hpa, &dir);
> +		iommu_tce_xchg(kvm->mm, tbl, entry, &hpa, &dir);
> =20
>  	return ret;
>  }
> @@ -487,7 +488,7 @@ long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct =
iommu_table *tbl,
>  	if (mm_iommu_mapped_inc(mem))
>  		return H_TOO_HARD;
> =20
> -	ret =3D iommu_tce_xchg(tbl, entry, &hpa, &dir);
> +	ret =3D iommu_tce_xchg(kvm->mm, tbl, entry, &hpa, &dir);
>  	if (WARN_ON_ONCE(ret)) {
>  		mm_iommu_mapped_dec(mem);
>  		return H_TOO_HARD;
> @@ -566,7 +567,7 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned=
 long liobn,
>  					entry, ua, dir);
> =20
>  		if (ret !=3D H_SUCCESS) {
> -			kvmppc_clear_tce(stit->tbl, entry);
> +			kvmppc_clear_tce(vcpu->kvm->mm, stit->tbl, entry);
>  			goto unlock_exit;
>  		}
>  	}
> @@ -655,7 +656,8 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  					iommu_tce_direction(tce));
> =20
>  			if (ret !=3D H_SUCCESS) {
> -				kvmppc_clear_tce(stit->tbl, entry);
> +				kvmppc_clear_tce(vcpu->kvm->mm, stit->tbl,
> +						entry);
>  				goto unlock_exit;
>  			}
>  		}
> @@ -704,7 +706,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>  				return ret;
> =20
>  			WARN_ON_ONCE(1);
> -			kvmppc_clear_tce(stit->tbl, entry);
> +			kvmppc_clear_tce(vcpu->kvm->mm, stit->tbl, entry);
>  		}
>  	}
> =20
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index 580d89e..62fe5fe 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -47,6 +47,8 @@ struct mm_iommu_table_group_mem_t {
>  		struct page **hpages;	/* vmalloc'ed */
>  		phys_addr_t *hpas;
>  	};
> +#define MM_IOMMU_TABLE_INVALID_HPA	((uint64_t)-1)
> +	u64 dev_hpa;		/* Device memory base address */
>  };
> =20
>  static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
> @@ -89,7 +91,8 @@ bool mm_iommu_preregistered(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
> =20
> -long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long =
entries,
> +static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
> +		unsigned long entries, unsigned long dev_hpa,
>  		struct mm_iommu_table_group_mem_t **pmem)
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
> @@ -112,11 +115,13 @@ long mm_iommu_new(struct mm_struct *mm, unsigned lo=
ng ua, unsigned long entries,
> =20
>  	}
> =20
> -	ret =3D mm_iommu_adjust_locked_vm(mm, entries, true);
> -	if (ret)
> -		goto unlock_exit;
> +	if (dev_hpa =3D=3D MM_IOMMU_TABLE_INVALID_HPA) {
> +		ret =3D mm_iommu_adjust_locked_vm(mm, entries, true);
> +		if (ret)
> +			goto unlock_exit;
> =20
> -	locked_entries =3D entries;
> +		locked_entries =3D entries;
> +	}
> =20
>  	mem =3D kzalloc(sizeof(*mem), GFP_KERNEL);
>  	if (!mem) {
> @@ -124,6 +129,13 @@ long mm_iommu_new(struct mm_struct *mm, unsigned lon=
g ua, unsigned long entries,
>  		goto unlock_exit;
>  	}
> =20
> +	if (dev_hpa !=3D MM_IOMMU_TABLE_INVALID_HPA) {
> +		mem->pageshift =3D __ffs(dev_hpa | (entries << PAGE_SHIFT));
> +		mem->dev_hpa =3D dev_hpa;
> +		goto good_exit;
> +	}
> +	mem->dev_hpa =3D MM_IOMMU_TABLE_INVALID_HPA;
> +
>  	/*
>  	 * For a starting point for a maximum page size calculation
>  	 * we use @ua and @entries natural alignment to allow IOMMU pages
> @@ -180,6 +192,7 @@ long mm_iommu_new(struct mm_struct *mm, unsigned long=
 ua, unsigned long entries,
> =20
>  	}
> =20
> +good_exit:
>  	atomic64_set(&mem->mapped, 1);
>  	mem->used =3D 1;
>  	mem->ua =3D ua;
> @@ -196,13 +209,31 @@ long mm_iommu_new(struct mm_struct *mm, unsigned lo=
ng ua, unsigned long entries,
> =20
>  	return ret;
>  }
> +
> +long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long =
entries,
> +		struct mm_iommu_table_group_mem_t **pmem)
> +{
> +	return mm_iommu_do_alloc(mm, ua, entries, MM_IOMMU_TABLE_INVALID_HPA,
> +			pmem);
> +}
>  EXPORT_SYMBOL_GPL(mm_iommu_new);
> =20
> +long mm_iommu_newdev(struct mm_struct *mm, unsigned long ua,
> +		unsigned long entries, unsigned long dev_hpa,
> +		struct mm_iommu_table_group_mem_t **pmem)
> +{
> +	return mm_iommu_do_alloc(mm, ua, entries, dev_hpa, pmem);
> +}
> +EXPORT_SYMBOL_GPL(mm_iommu_newdev);
> +
>  static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
>  {
>  	long i;
>  	struct page *page =3D NULL;
> =20
> +	if (!mem->hpas)
> +		return;
> +
>  	for (i =3D 0; i < mem->entries; ++i) {
>  		if (!mem->hpas[i])
>  			continue;
> @@ -244,6 +275,7 @@ static void mm_iommu_release(struct mm_iommu_table_gr=
oup_mem_t *mem)
>  long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_mem_=
t *mem)
>  {
>  	long ret =3D 0;
> +	unsigned long entries, dev_hpa;
> =20
>  	mutex_lock(&mem_list_mutex);
> =20
> @@ -265,9 +297,12 @@ long mm_iommu_put(struct mm_struct *mm, struct mm_io=
mmu_table_group_mem_t *mem)
>  	}
> =20
>  	/* @mapped became 0 so now mappings are disabled, release the region */
> +	entries =3D mem->entries;
> +	dev_hpa =3D mem->dev_hpa;
>  	mm_iommu_release(mem);
> =20
> -	mm_iommu_adjust_locked_vm(mm, mem->entries, false);
> +	if (dev_hpa =3D=3D MM_IOMMU_TABLE_INVALID_HPA)
> +		mm_iommu_adjust_locked_vm(mm, entries, false);
> =20
>  unlock_exit:
>  	mutex_unlock(&mem_list_mutex);
> @@ -337,7 +372,7 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_m=
em_t *mem,
>  		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
>  {
>  	const long entry =3D (ua - mem->ua) >> PAGE_SHIFT;
> -	u64 *va =3D &mem->hpas[entry];
> +	u64 *va;
> =20
>  	if (entry >=3D mem->entries)
>  		return -EFAULT;
> @@ -345,6 +380,12 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_=
mem_t *mem,
>  	if (pageshift > mem->pageshift)
>  		return -EFAULT;
> =20
> +	if (!mem->hpas) {
> +		*hpa =3D mem->dev_hpa + (ua - mem->ua);
> +		return 0;
> +	}
> +
> +	va =3D &mem->hpas[entry];
>  	*hpa =3D (*va & MM_IOMMU_TABLE_GROUP_PAGE_MASK) | (ua & ~PAGE_MASK);
> =20
>  	return 0;
> @@ -355,7 +396,6 @@ long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_grou=
p_mem_t *mem,
>  		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
>  {
>  	const long entry =3D (ua - mem->ua) >> PAGE_SHIFT;
> -	void *va =3D &mem->hpas[entry];
>  	unsigned long *pa;
> =20
>  	if (entry >=3D mem->entries)
> @@ -364,7 +404,12 @@ long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_gro=
up_mem_t *mem,
>  	if (pageshift > mem->pageshift)
>  		return -EFAULT;
> =20
> -	pa =3D (void *) vmalloc_to_phys(va);
> +	if (!mem->hpas) {
> +		*hpa =3D mem->dev_hpa + (ua - mem->ua);
> +		return 0;
> +	}
> +
> +	pa =3D (void *) vmalloc_to_phys(&mem->hpas[entry]);
>  	if (!pa)
>  		return -EFAULT;
> =20
> @@ -394,6 +439,26 @@ extern void mm_iommu_ua_mark_dirty_rm(struct mm_stru=
ct *mm, unsigned long ua)
>  	*pa |=3D MM_IOMMU_TABLE_GROUP_PAGE_DIRTY;
>  }
> =20
> +extern bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
> +		unsigned int pageshift)
> +{
> +	struct mm_iommu_table_group_mem_t *mem;
> +	const unsigned long pagesize =3D 1UL << pageshift;
> +
> +	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
> +		if (mem->dev_hpa =3D=3D MM_IOMMU_TABLE_INVALID_HPA)
> +			continue;
> +
> +		if ((mem->dev_hpa <=3D hpa) &&
> +				(hpa + pagesize <=3D mem->dev_hpa +
> +				 (mem->entries << PAGE_SHIFT)))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(mm_iommu_is_devmem);
> +
>  long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem)
>  {
>  	if (atomic64_inc_not_zero(&mem->mapped))
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 56db071..ed89137 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -222,8 +222,15 @@ static long tce_iommu_register_pages(struct tce_cont=
ainer *container,
>  	return ret;
>  }
> =20
> -static bool tce_page_is_contained(struct page *page, unsigned page_shift)
> +static bool tce_page_is_contained(struct mm_struct *mm, unsigned long hp=
a,
> +		unsigned int page_shift)
>  {
> +	struct page *page;
> +
> +	if (mm_iommu_is_devmem(mm, hpa, page_shift))
> +		return true;
> +
> +	page =3D pfn_to_page(hpa >> PAGE_SHIFT);
>  	/*
>  	 * Check that the TCE table granularity is not bigger than the size of
>  	 * a page we just found. Otherwise the hardware can get access to
> @@ -499,7 +506,8 @@ static int tce_iommu_clear(struct tce_container *cont=
ainer,
> =20
>  		direction =3D DMA_NONE;
>  		oldhpa =3D 0;
> -		ret =3D iommu_tce_xchg(tbl, entry, &oldhpa, &direction);
> +		ret =3D iommu_tce_xchg(container->mm, tbl, entry, &oldhpa,
> +				&direction);
>  		if (ret)
>  			continue;
> =20
> @@ -537,7 +545,6 @@ static long tce_iommu_build(struct tce_container *con=
tainer,
>  		enum dma_data_direction direction)
>  {
>  	long i, ret =3D 0;
> -	struct page *page;
>  	unsigned long hpa;
>  	enum dma_data_direction dirtmp;
> =20
> @@ -548,15 +555,16 @@ static long tce_iommu_build(struct tce_container *c=
ontainer,
>  		if (ret)
>  			break;
> =20
> -		page =3D pfn_to_page(hpa >> PAGE_SHIFT);
> -		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
> +		if (!tce_page_is_contained(container->mm, hpa,
> +				tbl->it_page_shift)) {
>  			ret =3D -EPERM;
>  			break;
>  		}
> =20
>  		hpa |=3D offset;
>  		dirtmp =3D direction;
> -		ret =3D iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
> +		ret =3D iommu_tce_xchg(container->mm, tbl, entry + i, &hpa,
> +				&dirtmp);
>  		if (ret) {
>  			tce_iommu_unuse_page(container, hpa);
>  			pr_err("iommu_tce: %s failed ioba=3D%lx, tce=3D%lx, ret=3D%ld\n",
> @@ -583,7 +591,6 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		enum dma_data_direction direction)
>  {
>  	long i, ret =3D 0;
> -	struct page *page;
>  	unsigned long hpa;
>  	enum dma_data_direction dirtmp;
> =20
> @@ -596,8 +603,8 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		if (ret)
>  			break;
> =20
> -		page =3D pfn_to_page(hpa >> PAGE_SHIFT);
> -		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
> +		if (!tce_page_is_contained(container->mm, hpa,
> +				tbl->it_page_shift)) {
>  			ret =3D -EPERM;
>  			break;
>  		}
> @@ -610,7 +617,8 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		if (mm_iommu_mapped_inc(mem))
>  			break;
> =20
> -		ret =3D iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
> +		ret =3D iommu_tce_xchg(container->mm, tbl, entry + i, &hpa,
> +				&dirtmp);
>  		if (ret) {
>  			/* dirtmp cannot be DMA_NONE here */
>  			tce_iommu_unuse_page_v2(container, tbl, entry + i);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvuNVEACgkQbDjKyiDZ
s5LPjQ//dF5iPmQNNcDDjpN9aiaPo5ftaJAvc/aLBWu4tGEAnYlgO3G+qqwwLlGE
cfJ2cJ0Pqt1hVnfKmreYhZFVBY39CJjFu/pDhfCjiCMQIIKsQkt2jkf6goKkYrMx
ZG/mrYvR+7vEZUvqXGLdPWGUT/XinQgA2+I4Uigkvtwg4Q706oMSsVjksfydNfvo
ARS7a49XB48jOQc2ojpU41KJwOTE8rghU846maaP7le6sAy3GiVBcFaMD0yubkVB
CqtCYzNZNDqUALLF83rFHHfr7JAQX6QehtBVCQIuYKdGQY5dCWxJGShR4fBvwYxt
+2vWXGg7ae/vOhPQyOhttrfObcRgAk3GQKC6vVzLd0hAXg6LYA/lmGuiK6l3e/b/
BKKpoMk8quiwG3RHacp469YZYMeg7pzRvuC2HcVQMblml5GnQm8uwMq2ZRV7EBhV
FuczsPcetlszKBIUE2XB/793kWK0S41u50f4sm9KUo9ERDrnzKeG8FbfIrTyCuF9
Zh65sItQqdO4A9kRv8CNep7GN6CNcLUBYIx/e7e/jNrB4beGvcPI0pJ1BvKV2Ktw
sRBYiWiUz0FWME2japhvTfbRnZV/5U4X/qEy2Q2TRJdZBwmAwPAv2kg1b0/+iV3B
jDvl95+EVDeLWJx8zEm3jCAo1fXiWknXa5l50WinmgvCu1O0bG8=
=l5+v
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
