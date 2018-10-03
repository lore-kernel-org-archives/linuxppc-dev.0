Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2A9C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:29:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5329720652
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UcdtX73t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5329720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q5hW34JlzF3B3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 16:29:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UcdtX73t";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q5X252ryzF3B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 16:21:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="UcdtX73t"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Q5X232FnzB2xk; Wed,  3 Oct 2018 16:21:54 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Q5X22Msrz9sB7; Wed,  3 Oct 2018 16:21:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538547714;
 bh=jkl2VZHXNR7+aUV2zncdctKmwJFS7RKcTXP3+yZsUZA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UcdtX73tei4ftngJT23oCTVepBs2ib50413Y+KuG8/LMQbElrQ/KT52+gsW7wsurB
 U6NHsbeZdjcpxOOy4rs4hK7X5VC6PmmG2FJHbzdX5XMEdxt/wVBP+IK9uKdGsEDWMw
 oGefeoiRQVLaa6RGCXGA4GvHB/qggPHsY8R4z4dQ=
Date: Wed, 3 Oct 2018 16:17:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 32/33] KVM: PPC: Book3S HV: Use hypercalls for TLB
 invalidation when nested
Message-ID: <20181003061752.GX1886@umbus.fritz.box>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-33-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SvF6CGw9fzJC4Rcx"
Content-Disposition: inline
In-Reply-To: <1538479892-14835-33-git-send-email-paulus@ozlabs.org>
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


--SvF6CGw9fzJC4Rcx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2018 at 09:31:31PM +1000, Paul Mackerras wrote:
> This adds code to call the H_TLB_INVALIDATE hypercall when running as
> a guest, in the cases where we need to invalidate TLBs (or other MMU
> caches) as part of managing the mappings for a nested guest.  Calling
> H_TLB_INVALIDATE is an alternative to doing the tlbie instruction and
> having it be emulated by our hypervisor.

Why is supporting two methods useful, rather than just settling on
one?  Having both just sounds like asking for untested and therefore
broken code paths lying around.

> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/include/asm/kvm_book3s_64.h |  5 +++++
>  arch/powerpc/kvm/book3s_64_mmu_radix.c   | 30 ++++++++++++++++++++++++++=
+--
>  arch/powerpc/kvm/book3s_hv_nested.c      | 33 +++++++++++++++++++++++---=
------
>  3 files changed, 57 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/incl=
ude/asm/kvm_book3s_64.h
> index f0fa14c..95280e2 100644
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
> @@ -121,6 +122,10 @@ struct kvm_nested_guest *kvmhv_get_nested(struct kvm=
 *kvm, int l1_lpid,
>  void kvmhv_put_nested(struct kvm_nested_guest *gp);
>  int kvmhv_nested_next_lpid(struct kvm *kvm, int lpid);
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
> index b74abdd..6c93f5c 100644
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
> index 914ca78..81c81d51 100644
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -368,17 +368,32 @@ void kvmhv_nested_exit(void)
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
> -		/* this will be emulated, L0 will do the necessary barriers */
> -		asm volatile(PPC_TLBIE_5(%0, %1, 2, 0, 1) : :
> -			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
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
> @@ -543,7 +558,7 @@ static void kvmhv_flush_nested(struct kvm_nested_gues=
t *gp)
>  	spin_lock(&kvm->mmu_lock);
>  	kvmppc_free_pgtable_radix(kvm, gp->shadow_pgtable, gp->shadow_lpid);
>  	spin_unlock(&kvm->mmu_lock);
> -	radix__flush_tlb_lpid(gp->shadow_lpid);
> +	kvmhv_flush_lpid(gp->shadow_lpid);
>  	kvmhv_update_ptbl_cache(gp);
>  	if (gp->l1_gr_to_hr =3D=3D 0)
>  		kvmhv_remove_nested(gp);
> @@ -839,7 +854,7 @@ static void kvmhv_emulate_tlbie_lpid(struct kvm_vcpu =
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

--SvF6CGw9fzJC4Rcx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu0XxAACgkQbDjKyiDZ
s5J1qQ/8C2wNzantm6FEml0tWRtqrq52k4UGHe90GKbLLkz5yTa/33WfF12LvKJU
eK8W3Mp4ZraJYRUUIOu/V647MQLuXDRrl4bwhuxGJ3QEPbyAY9P36jl8uxzKB6ax
YFIMdzmsvKoSg6UKkRYeHsOZLRbIOWbpxhzEFhvyfe7EWb+NwFXOLPixIsvdj65m
jQWRIL3BvYz58mgqiq3ocwL1W6LtT+W6DOx+OxS3txq/EAGqjft4PbTqPcARLqrb
v5LN6/ZGSCacmMFYC/LAzHOUXSFFX2Cb4LP58kN4ZA4t8EWJeEv7xBiIOOUDStjk
EpErf5COOlnr7EKIcSUCSY3m3kBoy8Zf2ouEBfVBkGrmnXgH4KZhpf5RB/KI/dbz
L8DyDiiZxRlvY6z1BmblNP4B52oPlMoT6irjeiI2kbhK2v/OiKlYg6WQGz2J3NVC
oH3PsGWSNUqLjniCi72hXFrqpJYezBUc4SBnilm5rVKQg7UjSm8DstqsJjFxY1vg
MOY9I7f2knsUIRb8vJpgOSEHuBySiwz3ciKoHIoS8NTU4jlrwCWPjUt3xwHJM5Jf
X+/kb3Y8sYsKm4cNOX+XM6bgJBjoFEW0WwDydQH5QUmHJZjVgFoNaaXAIYYlijF7
9/Jgo6nVvY06WyuYgLxZd767PBlbCZl7ikQrYgsw7UnUvz+yPfY=
=abKP
-----END PGP SIGNATURE-----

--SvF6CGw9fzJC4Rcx--
