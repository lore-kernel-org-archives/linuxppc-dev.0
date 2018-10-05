Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EDFC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:21:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22FE620834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nLA0EeQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FE620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RJ5c6h5JzF3M4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:21:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nLA0EeQl";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RGjX3B94zF3Jl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:19:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="nLA0EeQl"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42RGjX0ZCkzB2xQ; Fri,  5 Oct 2018 14:19:12 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42RGjW6P2Lz9sBj; Fri,  5 Oct 2018 14:19:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538713151;
 bh=oOHLd/NjKxUseAZuzexnT4vvrPql5Rc5E1mLTFtrGYQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nLA0EeQlLdkUCizgC8OyUteuMszKvOzuzXHOusgW0MLt5KNKTTjlAKmoryJeKA8ub
 79NKPo50sM4pGbKUY7BWlNzfyJjzk0848K382peYExA1uFuv7x0SpPzy2veYyndnGr
 j/Yv7s9NfSzT9e4gXAxz2oY9DyjzvSvYV7k8g9Jc=
Date: Fri, 5 Oct 2018 13:45:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v4 24/32] KVM: PPC: Book3S HV: Use hypercalls for TLB
 invalidation when nested
Message-ID: <20181005034511.GJ7004@umbus.fritz.box>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
 <1538654169-15602-25-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8jNwmpfkpox/fiJK"
Content-Disposition: inline
In-Reply-To: <1538654169-15602-25-git-send-email-paulus@ozlabs.org>
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
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--8jNwmpfkpox/fiJK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2018 at 09:56:01PM +1000, Paul Mackerras wrote:
> This adds code to call the H_TLB_INVALIDATE hypercall when running as
> a guest, in the cases where we need to invalidate TLBs (or other MMU
> caches) as part of managing the mappings for a nested guest.  Calling
> H_TLB_INVALIDATE lets the nested hypervisor inform the parent
> hypervisor about changes to partition-scoped page tables or the
> partition table without needing to do hypervisor-privileged tlbie
> instructions.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/kvm_book3s_64.h |  5 +++++
>  arch/powerpc/kvm/book3s_64_mmu_radix.c   | 30 ++++++++++++++++++++++++++=
++--
>  arch/powerpc/kvm/book3s_hv_nested.c      | 30 ++++++++++++++++++++++++--=
----
>  3 files changed, 57 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/incl=
ude/asm/kvm_book3s_64.h
> index a02f0b3..aa5bf85 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> @@ -24,6 +24,7 @@
>  #include <asm/bitops.h>
>  #include <asm/book3s/64/mmu-hash.h>
>  #include <asm/cpu_has_feature.h>
> +#include <asm/ppc-opcode.h>
> =20
>  #ifdef CONFIG_PPC_PSERIES
>  static inline bool kvmhv_on_pseries(void)
> @@ -117,6 +118,10 @@ struct kvm_nested_guest *kvmhv_get_nested(struct kvm=
 *kvm, int l1_lpid,
>  					  bool create);
>  void kvmhv_put_nested(struct kvm_nested_guest *gp);
> =20
> +/* Encoding of first parameter for H_TLB_INVALIDATE */
> +#define H_TLBIE_P1_ENC(ric, prs, r)	(___PPC_RIC(ric) | ___PPC_PRS(prs) |=
 \
> +					 ___PPC_R(r))
> +
>  /* Power architecture requires HPT is at least 256kiB, at most 64TiB */
>  #define PPC_MIN_HPT_ORDER	18
>  #define PPC_MAX_HPT_ORDER	46
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/bo=
ok3s_64_mmu_radix.c
> index 4c1eccb..ae0e3ed 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> @@ -201,17 +201,43 @@ static void kvmppc_radix_tlbie_page(struct kvm *kvm=
, unsigned long addr,
>  				    unsigned int pshift, unsigned int lpid)
>  {
>  	unsigned long psize =3D PAGE_SIZE;
> +	int psi;
> +	long rc;
> +	unsigned long rb;
> =20
>  	if (pshift)
>  		psize =3D 1UL << pshift;
> +	else
> +		pshift =3D PAGE_SHIFT;
> =20
>  	addr &=3D ~(psize - 1);
> -	radix__flush_tlb_lpid_page(lpid, addr, psize);
> +
> +	if (!kvmhv_on_pseries()) {
> +		radix__flush_tlb_lpid_page(lpid, addr, psize);
> +		return;
> +	}
> +
> +	psi =3D shift_to_mmu_psize(pshift);
> +	rb =3D addr | (mmu_get_ap(psi) << PPC_BITLSHIFT(58));
> +	rc =3D plpar_hcall_norets(H_TLB_INVALIDATE, H_TLBIE_P1_ENC(0, 0, 1),
> +				lpid, rb);
> +	if (rc)
> +		pr_err("KVM: TLB page invalidation hcall failed, rc=3D%ld\n", rc);
>  }
> =20
>  static void kvmppc_radix_flush_pwc(struct kvm *kvm, unsigned int lpid)
>  {
> -	radix__flush_pwc_lpid(lpid);
> +	long rc;
> +
> +	if (!kvmhv_on_pseries()) {
> +		radix__flush_pwc_lpid(lpid);
> +		return;
> +	}
> +
> +	rc =3D plpar_hcall_norets(H_TLB_INVALIDATE, H_TLBIE_P1_ENC(1, 0, 1),
> +				lpid, TLBIEL_INVAL_SET_LPID);
> +	if (rc)
> +		pr_err("KVM: TLB PWC invalidation hcall failed, rc=3D%ld\n", rc);
>  }
> =20
>  static unsigned long kvmppc_radix_update_pte(struct kvm *kvm, pte_t *pte=
p,
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3=
s_hv_nested.c
> index 26151e8..35f8111 100644
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -298,14 +298,32 @@ void kvmhv_nested_exit(void)
>  	}
>  }
> =20
> +static void kvmhv_flush_lpid(unsigned int lpid)
> +{
> +	long rc;
> +
> +	if (!kvmhv_on_pseries()) {
> +		radix__flush_tlb_lpid(lpid);
> +		return;
> +	}
> +
> +	rc =3D plpar_hcall_norets(H_TLB_INVALIDATE, H_TLBIE_P1_ENC(2, 0, 1),
> +				lpid, TLBIEL_INVAL_SET_LPID);
> +	if (rc)
> +		pr_err("KVM: TLB LPID invalidation hcall failed, rc=3D%ld\n", rc);
> +}
> +
>  void kvmhv_set_ptbl_entry(unsigned int lpid, u64 dw0, u64 dw1)
>  {
> -	if (cpu_has_feature(CPU_FTR_HVMODE)) {
> +	if (!kvmhv_on_pseries()) {
>  		mmu_partition_table_set_entry(lpid, dw0, dw1);
> -	} else {
> -		pseries_partition_tb[lpid].patb0 =3D cpu_to_be64(dw0);
> -		pseries_partition_tb[lpid].patb1 =3D cpu_to_be64(dw1);
> +		return;
>  	}
> +
> +	pseries_partition_tb[lpid].patb0 =3D cpu_to_be64(dw0);
> +	pseries_partition_tb[lpid].patb1 =3D cpu_to_be64(dw1);
> +	/* L0 will do the necessary barriers */
> +	kvmhv_flush_lpid(lpid);
>  }
> =20
>  static void kvmhv_set_nested_ptbl(struct kvm_nested_guest *gp)
> @@ -482,7 +500,7 @@ static void kvmhv_flush_nested(struct kvm_nested_gues=
t *gp)
>  	spin_lock(&kvm->mmu_lock);
>  	kvmppc_free_pgtable_radix(kvm, gp->shadow_pgtable, gp->shadow_lpid);
>  	spin_unlock(&kvm->mmu_lock);
> -	radix__flush_tlb_lpid(gp->shadow_lpid);
> +	kvmhv_flush_lpid(gp->shadow_lpid);
>  	kvmhv_update_ptbl_cache(gp);
>  	if (gp->l1_gr_to_hr =3D=3D 0)
>  		kvmhv_remove_nested(gp);
> @@ -766,7 +784,7 @@ static void kvmhv_emulate_tlbie_lpid(struct kvm_vcpu =
*vcpu,
>  		spin_lock(&kvm->mmu_lock);
>  		kvmppc_free_pgtable_radix(kvm, gp->shadow_pgtable,
>  					  gp->shadow_lpid);
> -		radix__flush_tlb_lpid(gp->shadow_lpid);
> +		kvmhv_flush_lpid(gp->shadow_lpid);
>  		spin_unlock(&kvm->mmu_lock);
>  		break;
>  	case 1:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8jNwmpfkpox/fiJK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu23kcACgkQbDjKyiDZ
s5K8jBAAxfPii/YRyweXgMHAKuJijrt3C2HYfdNbkuOpBOo3KkR3xd2lmFq/54jk
oZ1eNfAmU1E2+t7c9nlDEkq2P+6ULgd0jUMvFXsnUPUPhcKPEtRzAvxo2LW3ikxF
V8b+yeUJjfbmCmt/ei7Rl/cNxkSATCAX+RhbQEIQZ5gFpHrLas41cEwT3RE0K6y4
H9/yNO9DQEXfu8jRmLva+CC+hY6T4TX+FZV0jo8VNJIlVZGgw9GHfkFFBjczOXoK
7JpBfzGUKp7qBxVDR4NkbysbEqUOEUPrWucOi2jGKEod1hbiUBNpdsTKrhmTcmQK
rO3OnKfXyeXdH+8fpEQhKpkm2L3xhfS2rI/JFVbIISI+M7OTnk2LRCof0R+3QZLw
iY1Au0qU6WahXaaztDLsOfa6Huw0P4Ke87n8yBTKVc5AM0e5yps/1rvaTaqa3l00
34QI4X0x+j42wr4Vp3tij4ctWDRin8eRvdv0D/Co3At8i/XxLocsfmgPI9ZXoyey
EoekcttTUm9d1gxylUzjTRumeRiC9zJipWrwweHjoIE2rsmQAeIGHxbRXQ5T0dq6
S0wByfG3tM0tVNDW2Wv+AZjp74YVorVaF0i8FQk8Dgak5Wnn+SRynhhsl9t3E1zF
O6taq0jehQYiWSLDR1DeHpO/Jj1x887IrAIKKzIX+4TxSVtHNhw=
=Di5E
-----END PGP SIGNATURE-----

--8jNwmpfkpox/fiJK--
