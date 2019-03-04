Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3905BC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 01:22:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4E720818
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 01:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DnoTX52R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4E720818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CMhD4MVbzDqJs
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 12:22:20 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CMfB5nGzzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 12:20:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="DnoTX52R"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44CMf95Dvsz9sBr; Mon,  4 Mar 2019 12:20:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551662433;
 bh=rzx0m50vQ/71W/bgtURboVD8g4QHSZYcVP3x6HZr1BU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DnoTX52RwiMak2GDL2CbEODGkhLoBWm8jNQrafpvTsj8XXEfpk0wGeJZFHf6Tl6lR
 1E7e3dfcSf5e0XYZxYUZ9xJ79jDCzqQOUrUkJavN90LcdRl2tDeuBqR/6XrQOoSwJa
 2qfUG2HL2kOmmoRBoTKEvUKw5PhMMQ9AhH7llOW0=
Date: Mon, 4 Mar 2019 11:54:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3] KVM: PPC: Allocate guest TCEs on demand too
Message-ID: <20190304005436.GG7792@umbus.fritz.box>
References: <20190301043436.90014-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1giRMj6yz/+FOIRq"
Content-Disposition: inline
In-Reply-To: <20190301043436.90014-1-aik@ozlabs.ru>
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


--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 03:34:36PM +1100, Alexey Kardashevskiy wrote:
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
> Changes:
> v3:
> * fixed alignments in kvmppc_rm_ioba_validate
>=20
> v2:
> * added kvm mutex around alloc_page to prevent races; in both place we
> test the pointer, if NULL, then take a lock and check again so on a fast
> path we do not take a lock at all
>=20
>=20
> ---
> For NVLink2 passthrough guests with 128TiB DMA windows and very fragmented
> system RAM the difference is gigabytes of RAM.
> ---
>  arch/powerpc/kvm/book3s_64_vio.c    | 29 ++++++------
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 71 ++++++++++++++++++++++++++---
>  2 files changed, 81 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index f02b04973710..7eed8c90ea3d 100644
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
> @@ -242,6 +243,20 @@ static vm_fault_t kvm_spapr_tce_fault(struct vm_faul=
t *vmf)
>  		return VM_FAULT_SIGBUS;
> =20
>  	page =3D stt->pages[vmf->pgoff];
> +	if (!page) {
> +		mutex_lock(&stt->kvm->lock);
> +		page =3D stt->pages[vmf->pgoff];
> +		if (!page) {
> +			page  =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> +			if (!page) {
> +				mutex_unlock(&stt->kvm->lock);
> +				return VM_FAULT_OOM;
> +			}
> +			stt->pages[vmf->pgoff] =3D page;
> +		}
> +		mutex_unlock(&stt->kvm->lock);
> +	}
> +
>  	get_page(page);
>  	vmf->page =3D page;
>  	return 0;
> @@ -296,7 +311,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	struct kvmppc_spapr_tce_table *siter;
>  	unsigned long npages, size =3D args->size;
>  	int ret =3D -ENOMEM;
> -	int i;
> =20
>  	if (!args->size || args->page_shift < 12 || args->page_shift > 34 ||
>  		(args->offset + args->size > (ULLONG_MAX >> args->page_shift)))
> @@ -320,12 +334,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
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
> @@ -352,11 +360,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
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
> index 2206bc729b9a..1cd9373f8bdc 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -158,23 +158,78 @@ static u64 *kvmppc_page_address(struct page *page)
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
> +	unsigned long i, idx, sttpage, sttpages;
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
> +	idx =3D (ioba >> stt->page_shift) - stt->offset;
> +	sttpage =3D idx / TCES_PER_PAGE;
> +	sttpages =3D _ALIGN_UP(idx % TCES_PER_PAGE + npages, TCES_PER_PAGE) /
> +			TCES_PER_PAGE;
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
> +		mutex_lock(&stt->kvm->lock);
> +		page =3D stt->pages[sttpage];
> +		if (!page) {
> +			page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> +			if (WARN_ON_ONCE(!page)) {
> +				mutex_unlock(&stt->kvm->lock);
> +				return;
> +			}
> +			stt->pages[sttpage] =3D page;
> +		}
> +		mutex_unlock(&stt->kvm->lock);
> +	}
>  	tbl =3D kvmppc_page_address(page);
> =20
>  	tbl[idx % TCES_PER_PAGE] =3D tce;
> @@ -381,7 +436,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsig=
ned long liobn,
>  	if (!stt)
>  		return H_TOO_HARD;
> =20
> -	ret =3D kvmppc_ioba_validate(stt, ioba, 1);
> +	ret =3D kvmppc_rm_ioba_validate(stt, ioba, 1, tce =3D=3D 0);
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> @@ -480,7 +535,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  	if (tce_list & (SZ_4K - 1))
>  		return H_PARAMETER;
> =20
> -	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> +	ret =3D kvmppc_rm_ioba_validate(stt, ioba, npages, false);
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> @@ -583,7 +638,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  	if (!stt)
>  		return H_TOO_HARD;
> =20
> -	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> +	ret =3D kvmppc_rm_ioba_validate(stt, ioba, npages, tce_value =3D=3D 0);
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> @@ -635,6 +690,10 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigne=
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

--1giRMj6yz/+FOIRq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx8d0sACgkQbDjKyiDZ
s5JdMA/+OtES3Z8D+JHJNS2HfeRoYfqioH6ytBcF098SY3oGqPUUsaEeF+nPxASr
WdJDwQRmecJ21OkECvprr7o7oWqlQt2yl1LQ6/9NC/D3usQKHCsT0jlYCfuVTGiW
0sW0aL1vukPgYHmru6TbIY75Y719JBk9OFdZtTYTovc43/m919xK8dtb+jWQ3noI
IkTo9QHyVZhCgpFla5n7oVX8M8QxCSyVUT7xhZRyvkEujOQmHshzQZomu70z0fZ7
BS63502nnKJ9wcPmGlCDkJkjUf6q1+FZ+c9hFaBaISqUiXF5P6Up6LthJ4MUdhrU
nX6YrTdaP/assRIMy9bmNjHTQWDyD8SAmAPS1H4sVqTIRQTAFQXwk/5zm8dikdfG
GDnDHzRsaDqBvWVuzxldaJPPbHWWFGKMJRf52Mv7ownjVzdzFxhObVp3exjPUaYi
UrXbHjSuNQXga7rpFFWayUTeRfWwZtNS9k+swhbTCiWu86YA7iVcGT5cXKdOU4bH
melmy4x61+HXhoiu25KkQoy0rEnPPYiFFO/6yK9L5pfJCBSuIKPkgIwSyrLn73cc
/ZTgl7toAAGR4nRMhi1bucDAs4dDLBrONPl3mPIrzjwHvySCUV/vTSr+FVmZiXcQ
16TGRaY72XHCRW9/tc6qwDpLu/4IyBLPpMVO36r4JdultjSVxxg=
=+YnJ
-----END PGP SIGNATURE-----

--1giRMj6yz/+FOIRq--
