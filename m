Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681FFC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 00:49:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 004F721850
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 00:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mv7XWyrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004F721850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448v7k2xGbzDqJc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 11:49:06 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448v5l61h1zDqJX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 11:47:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="mv7XWyrb"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 448v5k6xKzz9s47; Thu, 28 Feb 2019 11:47:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551314842;
 bh=7F9jVzrmCExevuR1705D7iejU3i6DDP1p9rKk51nz4w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mv7XWyrbe33dcZzqNNwVU99aT1A/szBKT65de0S1MOP+KlvjBaz0cWOp5AblYFY2X
 97TGHZxq+qWZomfB4TaafRfJPPiUqbvaxLqRB8XBFkwneKX96nhN98rk1+DEQKBMbb
 iVojbLiYSZJkTuja/syLwS08n/EwrJ+WEb/OyuIo=
Date: Thu, 28 Feb 2019 11:15:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] KVM: PPC: Allocate guest TCEs on demand too
Message-ID: <20190228001546.GA7734@umbus.fritz.box>
References: <20190227084235.22795-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20190227084235.22795-1-aik@ozlabs.ru>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 07:42:35PM +1100, Alexey Kardashevskiy wrote:
> We already allocate hardware TCE tables in multiple levels and skip
> intermediate levels when we can, now it is a turn of the KVM TCE tables.
> Thankfully these are allocated already in 2 levels.
>=20
> This moves the table's last level allocation from the creating helper to
> kvmppc_tce_put() and kvm_spapr_tce_fault().
>=20
> This adds kvmppc_rm_ioba_validate() to do an additional test if
> the consequent kvmppc_tce_put() needs a page which has not been allocated;
> if this is the case, we bail out to virtual mode handlers.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> For NVLink2 passthrough guests with 128TiB DMA windows (when we push GPU =
RAM
> above the PCI MMIO window in the guest) and very fragmented system RAM
> the difference is about 16GiB of RAM before and after this patch.
>=20
> ---
>  arch/powerpc/kvm/book3s_64_vio.c    | 21 ++++------
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 62 ++++++++++++++++++++++++++---
>  2 files changed, 64 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index f02b049..281b56b 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -228,7 +228,8 @@ static void release_spapr_tce_table(struct rcu_head *=
head)
>  	unsigned long i, npages =3D kvmppc_tce_pages(stt->size);
> =20
>  	for (i =3D 0; i < npages; i++)
> -		__free_page(stt->pages[i]);
> +		if (stt->pages[i])
> +			__free_page(stt->pages[i]);
> =20
>  	kfree(stt);
>  }
> @@ -241,6 +242,12 @@ static vm_fault_t kvm_spapr_tce_fault(struct vm_faul=
t *vmf)
>  	if (vmf->pgoff >=3D kvmppc_tce_pages(stt->size))
>  		return VM_FAULT_SIGBUS;
> =20
> +	if (!stt->pages[vmf->pgoff]) {
> +		stt->pages[vmf->pgoff] =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> +		if (!stt->pages[vmf->pgoff])
> +			return VM_FAULT_OOM;
> +	}
> +
>  	page =3D stt->pages[vmf->pgoff];
>  	get_page(page);
>  	vmf->page =3D page;
> @@ -296,7 +303,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	struct kvmppc_spapr_tce_table *siter;
>  	unsigned long npages, size =3D args->size;
>  	int ret =3D -ENOMEM;
> -	int i;
> =20
>  	if (!args->size || args->page_shift < 12 || args->page_shift > 34 ||
>  		(args->offset + args->size > (ULLONG_MAX >> args->page_shift)))
> @@ -320,12 +326,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	stt->kvm =3D kvm;
>  	INIT_LIST_HEAD_RCU(&stt->iommu_tables);
> =20
> -	for (i =3D 0; i < npages; i++) {
> -		stt->pages[i] =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> -		if (!stt->pages[i])
> -			goto fail;
> -	}
> -
>  	mutex_lock(&kvm->lock);
> =20
>  	/* Check this LIOBN hasn't been previously allocated */
> @@ -352,11 +352,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	if (ret >=3D 0)
>  		return ret;
> =20
> - fail:
> -	for (i =3D 0; i < npages; i++)
> -		if (stt->pages[i])
> -			__free_page(stt->pages[i]);
> -
>  	kfree(stt);
>   fail_acct:
>  	kvmppc_account_memlimit(kvmppc_stt_pages(npages), false);
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 2206bc7..fbb920d 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -158,23 +158,69 @@ static u64 *kvmppc_page_address(struct page *page)
>  	return (u64 *) page_address(page);
>  }
> =20
> +/*
> + * TCEs pages are allocated in kvmppc_tce_put() which won't be able to d=
o so
> + * in real mode.
> + * Check if kvmppc_tce_put() can succeed in real mode, i.e. a TCEs page =
is
> + * allocated or not required (when clearing a tce entry).
> + */
> +static long kvmppc_rm_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> +		unsigned long ioba, unsigned long npages, bool clearing)
> +{
> +	unsigned long i, sttpage, sttpages;
> +	unsigned long ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> +
> +	if (ret)
> +		return ret;
> +	/*
> +	 * clearing=3D=3Dtrue says kvmppc_tce_put won't be allocating pages
> +	 * for empty tces.
> +	 */
> +	if (clearing)
> +		return H_SUCCESS;
> +
> +	sttpage =3D ((ioba >> stt->page_shift) - stt->offset) / TCES_PER_PAGE;
> +	sttpages =3D (npages + TCES_PER_PAGE - 1) / TCES_PER_PAGE;
> +	for (i =3D sttpage; i < sttpage + sttpages; ++i)
> +		if (!stt->pages[i])
> +			return H_TOO_HARD;
> +
> +	return H_SUCCESS;
> +}
> +
>  /*
>   * Handles TCE requests for emulated devices.
>   * Puts guest TCE values to the table and expects user space to convert =
them.
>   * Called in both real and virtual modes.
>   * Cannot fail so kvmppc_tce_validate must be called before it.
>   *
> - * WARNING: This will be called in real-mode on HV KVM and virtual
> - *          mode on PR KVM
> + * WARNING: This will be called in real-mode on HV HPT KVM and virtual
> + *          mode on PR KVM or HV radix KVM
>   */
>  void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
>  		unsigned long idx, unsigned long tce)
>  {
>  	struct page *page;
>  	u64 *tbl;
> +	unsigned long sttpage;
> =20
>  	idx -=3D stt->offset;
> -	page =3D stt->pages[idx / TCES_PER_PAGE];
> +	sttpage =3D idx / TCES_PER_PAGE;
> +	page =3D stt->pages[sttpage];
> +
> +	if (!page) {
> +		/* We allow any TCE, not just with read|write permissions */
> +		if (!tce)
> +			return;
> +		/*
> +		 * We must not end up here in real mode,
> +		 * kvmppc_rm_ioba_validate() takes care of this.
> +		 */
> +		page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> +		if (WARN_ON_ONCE(!page))
> +			return;
> +		stt->pages[sttpage] =3D page;
> +	}
>  	tbl =3D kvmppc_page_address(page);
> =20
>  	tbl[idx % TCES_PER_PAGE] =3D tce;
> @@ -381,7 +427,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsig=
ned long liobn,
>  	if (!stt)
>  		return H_TOO_HARD;
> =20
> -	ret =3D kvmppc_ioba_validate(stt, ioba, 1);
> +	ret =3D kvmppc_rm_ioba_validate(stt, ioba, 1, tce =3D=3D 0);
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> @@ -480,7 +526,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  	if (tce_list & (SZ_4K - 1))
>  		return H_PARAMETER;
> =20
> -	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> +	ret =3D kvmppc_rm_ioba_validate(stt, ioba, npages, false);
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> @@ -583,7 +629,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  	if (!stt)
>  		return H_TOO_HARD;
> =20
> -	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> +	ret =3D kvmppc_rm_ioba_validate(stt, ioba, npages, tce_value =3D=3D 0);
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> @@ -635,6 +681,10 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigne=
d long liobn,
> =20
>  	idx =3D (ioba >> stt->page_shift) - stt->offset;
>  	page =3D stt->pages[idx / TCES_PER_PAGE];
> +	if (!page) {
> +		vcpu->arch.regs.gpr[4] =3D 0;
> +		return H_SUCCESS;
> +	}
>  	tbl =3D (u64 *)page_address(page);
> =20
>  	vcpu->arch.regs.gpr[4] =3D tbl[idx % TCES_PER_PAGE];

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx3KDIACgkQbDjKyiDZ
s5IrKg/+IkP+fkJBE2M0hHJOabhZeyCK24YUeOm+SVmuxaKiUyUWMcYCNGsCUIIu
SJtaZ5O1vhHu+9aGlQ9hSKZJqoggd6uCZT7vHczGJ9/nq2mPsHEwQjli7EBF7Gyw
v7ad92mjNSKJRc/U78XFbbXJKZn3iD8XlbWi9Fk/iXMl6kJchw/EJrbor0jjSSw0
hys8VDDd8Anr1RhfgO7DWIn/55n49pKo/KorqI3C6+5AWIl7HkgFy+LZyrCt73h+
UvwDf6R0h2zebM4H1ZACBPqc1dNP/fbNm2qJfkdJhFQuiYO5sHGj21Jeo3r6dz+S
6ZFNB3KCH0UzvtawHiGI85+MDeNJprrSL+IG9+Y8BLKT3Iy9JikVvRWBziDWBF6k
+mYQrpgy2i5BzkifkEB3nbu3Hq1p1EH40jKLwFicpWqwTQV4egSkcn1en2NFSLkt
Vq1WT+enxHdQ1uyCo0/Tsee5YTNfHWy2YhYZp8BLMYIfHKcUhs+Ds9gbLHEOYryv
4x4JvCEqIHINUiP+R5pSmR+KilwTAGe87SIDMExPnILiMp8GOYQxp96DfIUiFjkw
uNd5ClEgZCrKf7XqIFBWOO3uBKMbcNx7asD/dZuoXUYi9pux/zAPkHP2WMyZxfOq
iSLAXaxSyIUeWsHViKnVzpRgT+4M8/VTAoaFMk/6lshuVrLt1Qk=
=jLqy
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
