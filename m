Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31545C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:43:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8DB205C9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YShgcl1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8DB205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q4gK2MbbzF3FF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 15:43:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YShgcl1f";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q4bX2tj8zF37V
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 15:39:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="YShgcl1f"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Q4bX1vd2z9s7W; Wed,  3 Oct 2018 15:39:52 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Q4bX0nKWz9s9m; Wed,  3 Oct 2018 15:39:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538545192;
 bh=uXfjc3Xgb/ZIFPt7aMefoHK0vwhHLrIcM55RxMLnUBE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YShgcl1fK/7m4MTqdZ5HbV+tILg07ee2+Fz3DfHe72jhQBfaaZAn7IFxMB81YRQBw
 d7yf+yvxx8iIAxZx4TWBRGxbd4I3niblFsQADR5uoou6q8xEYOicU0FJO5Hh3K0uET
 ZFOmBrLyeAu4+hHVNq/+tsYHJNXbwQXo0c4iAPu8=
Date: Wed, 3 Oct 2018 15:39:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 22/33] KVM: PPC: Book3S HV: Handle page fault for a
 nested guest
Message-ID: <20181003053913.GP1886@umbus.fritz.box>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-23-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MWF3YmTHhoLNIVQC"
Content-Disposition: inline
In-Reply-To: <1538479892-14835-23-git-send-email-paulus@ozlabs.org>
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


--MWF3YmTHhoLNIVQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2018 at 09:31:21PM +1000, Paul Mackerras wrote:
> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20
> Consider a normal (L1) guest running under the main hypervisor (L0),
> and then a nested guest (L2) running under the L1 guest which is acting
> as a nested hypervisor. L0 has page tables to map the address space for
> L1 providing the translation from L1 real address -> L0 real address;
>=20
> 	L1
> 	|
> 	| (L1 -> L0)
> 	|
> 	----> L0
>=20
> There are also page tables in L1 used to map the address space for L2
> providing the translation from L2 real address -> L1 read address. Since
> the hardware can only walk a single level of page table, we need to
> maintain in L0 a "shadow_pgtable" for L2 which provides the translation
> from L2 real address -> L0 real address. Which looks like;
>=20
> 	L2				L2
> 	|				|
> 	| (L2 -> L1)			|
> 	|				|
> 	----> L1			| (L2 -> L0)
> 	      |				|
> 	      | (L1 -> L0)		|
> 	      |				|
> 	      ----> L0			--------> L0
>=20
> When a page fault occurs while running a nested (L2) guest we need to
> insert a pte into this "shadow_pgtable" for the L2 -> L0 mapping. To
> do this we need to:
>=20
> 1. Walk the pgtable in L1 memory to find the L2 -> L1 mapping, and
>    provide a page fault to L1 if this mapping doesn't exist.
> 2. Use our L1 -> L0 pgtable to convert this L1 address to an L0 address,
>    or try to insert a pte for that mapping if it doesn't exist.
> 3. Now we have a L2 -> L0 mapping, insert this into our shadow_pgtable
>=20
> Once this mapping exists we can take rc faults when hardware is unable
> to automatically set the reference and change bits in the pte. On these
> we need to:
>=20
> 1. Check the rc bits on the L2 -> L1 pte match, and otherwise reflect
>    the fault down to L1.
> 2. Set the rc bits in the L1 -> L0 pte which corresponds to the same
>    host page.
> 3. Set the rc bits in the L2 -> L0 pte.
>=20
> As we reuse a large number of functions in book3s_64_mmu_radix.c for
> this we also needed to refactor a number of these functions to take
> an lpid parameter so that the correct lpid is used for tlb invalidations.
> The functionality however has remained the same.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Some comments below, but no showstoppers, so,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  .../powerpc/include/asm/book3s/64/tlbflush-radix.h |   1 +
>  arch/powerpc/include/asm/kvm_book3s.h              |  19 ++
>  arch/powerpc/include/asm/kvm_book3s_64.h           |   4 +
>  arch/powerpc/include/asm/kvm_host.h                |   2 +
>  arch/powerpc/kvm/book3s_64_mmu_radix.c             | 196 +++++++-----
>  arch/powerpc/kvm/book3s_hv_nested.c                | 334 +++++++++++++++=
+++++-
>  arch/powerpc/mm/tlb-radix.c                        |   9 +
>  7 files changed, 478 insertions(+), 87 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/p=
owerpc/include/asm/book3s/64/tlbflush-radix.h
> index 1154a6d..671316f 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> @@ -53,6 +53,7 @@ extern void radix__flush_tlb_lpid_page(unsigned int lpi=
d,
>  					unsigned long addr,
>  					unsigned long page_size);
>  extern void radix__flush_pwc_lpid(unsigned int lpid);
> +extern void radix__flush_tlb_lpid(unsigned int lpid);
>  extern void radix__local_flush_tlb_lpid(unsigned int lpid);
>  extern void radix__local_flush_tlb_lpid_guest(unsigned int lpid);
> =20
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include=
/asm/kvm_book3s.h
> index 0a97446..d983778 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -188,17 +188,34 @@ extern int kvmppc_book3s_hcall_implemented(struct k=
vm *kvm, unsigned long hc);
>  extern int kvmppc_book3s_radix_page_fault(struct kvm_run *run,
>  			struct kvm_vcpu *vcpu,
>  			unsigned long ea, unsigned long dsisr);
> +extern int kvmppc_mmu_walk_radix_tree(struct kvm_vcpu *vcpu, gva_t eaddr,
> +				      struct kvmppc_pte *gpte, u64 root,
> +				      u64 *pte_ret_p);
>  extern int kvmppc_mmu_radix_translate_table(struct kvm_vcpu *vcpu, gva_t=
 eaddr,
>  			struct kvmppc_pte *gpte, u64 table,
>  			int table_index, u64 *pte_ret_p);
>  extern int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
>  			struct kvmppc_pte *gpte, bool data, bool iswrite);
> +extern bool kvmppc_hv_handle_set_rc(struct kvm *kvm, pgd_t *pgtable,
> +				    bool writing, unsigned long gpa,
> +				    unsigned int lpid);
> +extern int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
> +				unsigned long gpa,
> +				struct kvm_memory_slot *memslot,
> +				bool writing, bool kvm_ro,
> +				pte_t *inserted_pte, unsigned int *levelp);
>  extern int kvmppc_init_vm_radix(struct kvm *kvm);
>  extern void kvmppc_free_radix(struct kvm *kvm);
> +extern void kvmppc_free_pgtable_radix(struct kvm *kvm, pgd_t *pgd,
> +				      unsigned int lpid);
>  extern int kvmppc_radix_init(void);
>  extern void kvmppc_radix_exit(void);
>  extern int kvm_unmap_radix(struct kvm *kvm, struct kvm_memory_slot *mems=
lot,
>  			unsigned long gfn);
> +extern void kvmppc_unmap_pte(struct kvm *kvm, pte_t *pte,
> +			     unsigned long gpa, unsigned int shift,
> +			     struct kvm_memory_slot *memslot,
> +			     unsigned int lpid);
>  extern int kvm_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslo=
t,
>  			unsigned long gfn);
>  extern int kvm_test_age_radix(struct kvm *kvm, struct kvm_memory_slot *m=
emslot,
> @@ -289,6 +306,8 @@ void kvmhv_restore_hv_return_state(struct kvm_vcpu *v=
cpu,
>  long int kvmhv_nested_page_fault(struct kvm_vcpu *vcpu);
>  int kvmhv_emulate_priv(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  			unsigned int instr);
> +int kvmhv_handle_nested_trap(struct kvm_run *run, struct kvm_vcpu *vcpu,
> +			     struct task_struct *tsk);
> =20
>  void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac);
> =20
> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/incl=
ude/asm/kvm_book3s_64.h
> index 6d67b6a..5496152 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> @@ -549,6 +549,10 @@ static inline void copy_to_checkpoint(struct kvm_vcp=
u *vcpu)
>  }
>  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> =20
> +extern int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
> +			     unsigned long gpa, unsigned int level,
> +			     unsigned long mmu_seq, unsigned int lpid);
> +
>  #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
> =20
>  #endif /* __ASM_KVM_BOOK3S_64_H__ */
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index ceb9f20..64c4807 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -367,7 +367,9 @@ struct kvmppc_pte {
>  	bool may_write		: 1;
>  	bool may_execute	: 1;
>  	unsigned long wimg;
> +	unsigned long rc;
>  	u8 page_size;		/* MMU_PAGE_xxx */
> +	u16 page_shift;

It's a bit ugly that this has both page_size and page_shift, which is
redundant information AFAICT.  Also, why does page_shift need to be
u16 - given that 2^255 bytes is much more than our supported address
space, let alone a plausible page size.

>  };
> =20
>  struct kvmppc_mmu {
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/bo=
ok3s_64_mmu_radix.c
> index bd06a95..ee6f493 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> @@ -29,43 +29,16 @@
>   */
>  static int p9_supported_radix_bits[4] =3D { 5, 9, 9, 13 };
> =20
> -/*
> - * Used to walk a partition or process table radix tree in guest memory
> - * Note: We exploit the fact that a partition table and a process
> - * table have the same layout, a partition-scoped page table and a
> - * process-scoped page table have the same layout, and the 2nd
> - * doubleword of a partition table entry has the same layout as
> - * the PTCR register.
> - */
> -int kvmppc_mmu_radix_translate_table(struct kvm_vcpu *vcpu, gva_t eaddr,
> -				     struct kvmppc_pte *gpte, u64 table,
> -				     int table_index, u64 *pte_ret_p)
> +int kvmppc_mmu_walk_radix_tree(struct kvm_vcpu *vcpu, gva_t eaddr,
> +			       struct kvmppc_pte *gpte, u64 root,
> +			       u64 *pte_ret_p)
>  {
>  	struct kvm *kvm =3D vcpu->kvm;
>  	int ret, level, ps;
> -	unsigned long ptbl, root;
> -	unsigned long rts, bits, offset;
> -	unsigned long size, index;
> -	struct prtb_entry entry;
> +	unsigned long rts, bits, offset, index;
>  	u64 pte, base, gpa;
>  	__be64 rpte;
> =20
> -	if ((table & PRTS_MASK) > 24)
> -		return -EINVAL;
> -	size =3D 1ul << ((table & PRTS_MASK) + 12);
> -
> -	/* Is the table big enough to contain this entry? */
> -	if ((table_index * sizeof(entry)) >=3D size)
> -		return -EINVAL;
> -
> -	/* Read the table to find the root of the radix tree */
> -	ptbl =3D (table & PRTB_MASK) + (table_index * sizeof(entry));
> -	ret =3D kvm_read_guest(kvm, ptbl, &entry, sizeof(entry));
> -	if (ret)
> -		return ret;
> -
> -	/* Root is stored in the first double word */
> -	root =3D be64_to_cpu(entry.prtb0);

This refactoring somewhat obscures the changes directly relevant to
the nested guest handling.  Ideally it would be nice to fold some of
this into the earlier reworkings.

>  	rts =3D ((root & RTS1_MASK) >> (RTS1_SHIFT - 3)) |
>  		((root & RTS2_MASK) >> RTS2_SHIFT);
>  	bits =3D root & RPDS_MASK;
> @@ -79,6 +52,7 @@ int kvmppc_mmu_radix_translate_table(struct kvm_vcpu *v=
cpu, gva_t eaddr,
> =20
>  	/* Walk each level of the radix tree */
>  	for (level =3D 3; level >=3D 0; --level) {
> +		u64 addr;
>  		/* Check a valid size */
>  		if (level && bits !=3D p9_supported_radix_bits[level])
>  			return -EINVAL;
> @@ -90,10 +64,13 @@ int kvmppc_mmu_radix_translate_table(struct kvm_vcpu =
*vcpu, gva_t eaddr,
>  		if (base & ((1UL << (bits + 3)) - 1))
>  			return -EINVAL;
>  		/* Read the entry from guest memory */
> -		ret =3D kvm_read_guest(kvm, base + (index * sizeof(rpte)),
> -				     &rpte, sizeof(rpte));
> -		if (ret)
> +		addr =3D base + (index * sizeof(rpte));
> +		ret =3D kvm_read_guest(kvm, addr, &rpte, sizeof(rpte));
> +		if (ret) {
> +			if (pte_ret_p)
> +				*pte_ret_p =3D addr;
>  			return ret;
> +		}
>  		pte =3D __be64_to_cpu(rpte);
>  		if (!(pte & _PAGE_PRESENT))
>  			return -ENOENT;
> @@ -119,6 +96,7 @@ int kvmppc_mmu_radix_translate_table(struct kvm_vcpu *=
vcpu, gva_t eaddr,
>  		if (offset =3D=3D mmu_psize_defs[ps].shift)
>  			break;
>  	gpte->page_size =3D ps;
> +	gpte->page_shift =3D offset;
> =20
>  	gpte->eaddr =3D eaddr;
>  	gpte->raddr =3D gpa;
> @@ -128,12 +106,51 @@ int kvmppc_mmu_radix_translate_table(struct kvm_vcp=
u *vcpu, gva_t eaddr,
>  	gpte->may_write =3D !!(pte & _PAGE_WRITE);
>  	gpte->may_execute =3D !!(pte & _PAGE_EXEC);
> =20
> +	gpte->rc =3D pte & (_PAGE_ACCESSED | _PAGE_DIRTY);
> +
>  	if (pte_ret_p)
>  		*pte_ret_p =3D pte;
> =20
>  	return 0;
>  }
> =20
> +/*
> + * Used to walk a partition or process table radix tree in guest memory
> + * Note: We exploit the fact that a partition table and a process
> + * table have the same layout, a partition-scoped page table and a
> + * process-scoped page table have the same layout, and the 2nd
> + * doubleword of a partition table entry has the same layout as
> + * the PTCR register.
> + */
> +int kvmppc_mmu_radix_translate_table(struct kvm_vcpu *vcpu, gva_t eaddr,
> +				     struct kvmppc_pte *gpte, u64 table,
> +				     int table_index, u64 *pte_ret_p)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	int ret;
> +	unsigned long size, ptbl, root;
> +	struct prtb_entry entry;
> +
> +	if ((table & PRTS_MASK) > 24)
> +		return -EINVAL;
> +	size =3D 1ul << ((table & PRTS_MASK) + 12);
> +
> +	/* Is the table big enough to contain this entry? */
> +	if ((table_index * sizeof(entry)) >=3D size)
> +		return -EINVAL;
> +
> +	/* Read the table to find the root of the radix tree */
> +	ptbl =3D (table & PRTB_MASK) + (table_index * sizeof(entry));
> +	ret =3D kvm_read_guest(kvm, ptbl, &entry, sizeof(entry));
> +	if (ret)
> +		return ret;
> +
> +	/* Root is stored in the first double word */
> +	root =3D be64_to_cpu(entry.prtb0);
> +
> +	return kvmppc_mmu_walk_radix_tree(vcpu, eaddr, gpte, root, pte_ret_p);
> +}
> +
>  int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
>  			   struct kvmppc_pte *gpte, bool data, bool iswrite)
>  {
> @@ -181,7 +198,7 @@ int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva=
_t eaddr,
>  }
> =20
>  static void kvmppc_radix_tlbie_page(struct kvm *kvm, unsigned long addr,
> -				    unsigned int pshift)
> +				    unsigned int pshift, unsigned int lpid)
>  {
>  	unsigned long psize =3D PAGE_SIZE;
> =20
> @@ -189,12 +206,12 @@ static void kvmppc_radix_tlbie_page(struct kvm *kvm=
, unsigned long addr,
>  		psize =3D 1UL << pshift;
> =20
>  	addr &=3D ~(psize - 1);
> -	radix__flush_tlb_lpid_page(kvm->arch.lpid, addr, psize);
> +	radix__flush_tlb_lpid_page(lpid, addr, psize);
>  }
> =20
> -static void kvmppc_radix_flush_pwc(struct kvm *kvm)
> +static void kvmppc_radix_flush_pwc(struct kvm *kvm, unsigned int lpid)
>  {
> -	radix__flush_pwc_lpid(kvm->arch.lpid);
> +	radix__flush_pwc_lpid(lpid);
>  }
> =20
>  static unsigned long kvmppc_radix_update_pte(struct kvm *kvm, pte_t *pte=
p,
> @@ -239,16 +256,17 @@ static void kvmppc_pmd_free(pmd_t *pmdp)
>  	kmem_cache_free(kvm_pmd_cache, pmdp);
>  }
> =20
> -static void kvmppc_unmap_pte(struct kvm *kvm, pte_t *pte,
> -			     unsigned long gpa, unsigned int shift,
> -			     struct kvm_memory_slot *memslot)
> +void kvmppc_unmap_pte(struct kvm *kvm, pte_t *pte,
> +		      unsigned long gpa, unsigned int shift,
> +		      struct kvm_memory_slot *memslot,
> +		      unsigned int lpid)
> =20
>  {
>  	unsigned long old;
> =20
>  	old =3D kvmppc_radix_update_pte(kvm, pte, ~0UL, 0, gpa, shift);
> -	kvmppc_radix_tlbie_page(kvm, gpa, shift);
> -	if (old & _PAGE_DIRTY) {
> +	kvmppc_radix_tlbie_page(kvm, gpa, shift, lpid);
> +	if ((old & _PAGE_DIRTY) && (lpid =3D=3D kvm->arch.lpid)) {
>  		unsigned long gfn =3D gpa >> PAGE_SHIFT;
>  		unsigned long page_size =3D PAGE_SIZE;
> =20
> @@ -271,7 +289,8 @@ static void kvmppc_unmap_pte(struct kvm *kvm, pte_t *=
pte,
>   * and emit a warning if encountered, but there may already be data
>   * corruption due to the unexpected mappings.
>   */
> -static void kvmppc_unmap_free_pte(struct kvm *kvm, pte_t *pte, bool full)
> +static void kvmppc_unmap_free_pte(struct kvm *kvm, pte_t *pte, bool full,
> +				  unsigned int lpid)
>  {
>  	if (full) {
>  		memset(pte, 0, sizeof(long) << PTE_INDEX_SIZE);
> @@ -285,14 +304,15 @@ static void kvmppc_unmap_free_pte(struct kvm *kvm, =
pte_t *pte, bool full)
>  			WARN_ON_ONCE(1);
>  			kvmppc_unmap_pte(kvm, p,
>  					 pte_pfn(*p) << PAGE_SHIFT,
> -					 PAGE_SHIFT, NULL);
> +					 PAGE_SHIFT, NULL, lpid);
>  		}
>  	}
> =20
>  	kvmppc_pte_free(pte);
>  }
> =20
> -static void kvmppc_unmap_free_pmd(struct kvm *kvm, pmd_t *pmd, bool full)
> +static void kvmppc_unmap_free_pmd(struct kvm *kvm, pmd_t *pmd, bool full,
> +				  unsigned int lpid)
>  {
>  	unsigned long im;
>  	pmd_t *p =3D pmd;
> @@ -307,20 +327,21 @@ static void kvmppc_unmap_free_pmd(struct kvm *kvm, =
pmd_t *pmd, bool full)
>  				WARN_ON_ONCE(1);
>  				kvmppc_unmap_pte(kvm, (pte_t *)p,
>  					 pte_pfn(*(pte_t *)p) << PAGE_SHIFT,
> -					 PMD_SHIFT, NULL);
> +					 PMD_SHIFT, NULL, lpid);
>  			}
>  		} else {
>  			pte_t *pte;
> =20
>  			pte =3D pte_offset_map(p, 0);
> -			kvmppc_unmap_free_pte(kvm, pte, full);
> +			kvmppc_unmap_free_pte(kvm, pte, full, lpid);
>  			pmd_clear(p);
>  		}
>  	}
>  	kvmppc_pmd_free(pmd);
>  }
> =20
> -static void kvmppc_unmap_free_pud(struct kvm *kvm, pud_t *pud)
> +static void kvmppc_unmap_free_pud(struct kvm *kvm, pud_t *pud,
> +				  unsigned int lpid)
>  {
>  	unsigned long iu;
>  	pud_t *p =3D pud;
> @@ -334,36 +355,42 @@ static void kvmppc_unmap_free_pud(struct kvm *kvm, =
pud_t *pud)
>  			pmd_t *pmd;
> =20
>  			pmd =3D pmd_offset(p, 0);
> -			kvmppc_unmap_free_pmd(kvm, pmd, true);
> +			kvmppc_unmap_free_pmd(kvm, pmd, true, lpid);
>  			pud_clear(p);
>  		}
>  	}
>  	pud_free(kvm->mm, pud);
>  }
> =20
> -void kvmppc_free_radix(struct kvm *kvm)
> +void kvmppc_free_pgtable_radix(struct kvm *kvm, pgd_t *pgd, unsigned int=
 lpid)
>  {
>  	unsigned long ig;
> -	pgd_t *pgd;
> =20
> -	if (!kvm->arch.pgtable)
> +	if (!pgd)

Not sure if this test is worth it, since most of the callers have to
test for a NULL pgtable for other reasons anyway.

>  		return;
> -	pgd =3D kvm->arch.pgtable;
>  	for (ig =3D 0; ig < PTRS_PER_PGD; ++ig, ++pgd) {
>  		pud_t *pud;
> =20
>  		if (!pgd_present(*pgd))
>  			continue;
>  		pud =3D pud_offset(pgd, 0);
> -		kvmppc_unmap_free_pud(kvm, pud);
> +		kvmppc_unmap_free_pud(kvm, pud, lpid);
>  		pgd_clear(pgd);
>  	}
> -	pgd_free(kvm->mm, kvm->arch.pgtable);
> -	kvm->arch.pgtable =3D NULL;
> +}
> +
> +void kvmppc_free_radix(struct kvm *kvm)
> +{
> +	if (kvm->arch.pgtable) {
> +		kvmppc_free_pgtable_radix(kvm, kvm->arch.pgtable,
> +					  kvm->arch.lpid);
> +		pgd_free(kvm->mm, kvm->arch.pgtable);
> +		kvm->arch.pgtable =3D NULL;
> +	}
>  }
> =20
>  static void kvmppc_unmap_free_pmd_entry_table(struct kvm *kvm, pmd_t *pm=
d,
> -					      unsigned long gpa)
> +					unsigned long gpa, unsigned int lpid)
>  {
>  	pte_t *pte =3D pte_offset_kernel(pmd, 0);
> =20
> @@ -373,13 +400,13 @@ static void kvmppc_unmap_free_pmd_entry_table(struc=
t kvm *kvm, pmd_t *pmd,
>  	 * flushing the PWC again.
>  	 */
>  	pmd_clear(pmd);
> -	kvmppc_radix_flush_pwc(kvm);
> +	kvmppc_radix_flush_pwc(kvm, lpid);
> =20
> -	kvmppc_unmap_free_pte(kvm, pte, false);
> +	kvmppc_unmap_free_pte(kvm, pte, false, lpid);
>  }
> =20
>  static void kvmppc_unmap_free_pud_entry_table(struct kvm *kvm, pud_t *pu=
d,
> -					unsigned long gpa)
> +					unsigned long gpa, unsigned int lpid)
>  {
>  	pmd_t *pmd =3D pmd_offset(pud, 0);
> =20
> @@ -389,9 +416,9 @@ static void kvmppc_unmap_free_pud_entry_table(struct =
kvm *kvm, pud_t *pud,
>  	 * so can be freed without flushing the PWC again.
>  	 */
>  	pud_clear(pud);
> -	kvmppc_radix_flush_pwc(kvm);
> +	kvmppc_radix_flush_pwc(kvm, lpid);
> =20
> -	kvmppc_unmap_free_pmd(kvm, pmd, false);
> +	kvmppc_unmap_free_pmd(kvm, pmd, false, lpid);
>  }
> =20
>  /*
> @@ -403,9 +430,9 @@ static void kvmppc_unmap_free_pud_entry_table(struct =
kvm *kvm, pud_t *pud,
>   */
>  #define PTE_BITS_MUST_MATCH (~(_PAGE_WRITE | _PAGE_DIRTY | _PAGE_ACCESSE=
D))
> =20
> -static int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
> -			     unsigned long gpa, unsigned int level,
> -			     unsigned long mmu_seq)
> +int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
> +		      unsigned long gpa, unsigned int level,
> +		      unsigned long mmu_seq, unsigned int lpid)
>  {
>  	pgd_t *pgd;
>  	pud_t *pud, *new_pud =3D NULL;
> @@ -458,7 +485,7 @@ static int kvmppc_create_pte(struct kvm *kvm, pgd_t *=
pgtable, pte_t pte,
>  			WARN_ON_ONCE((pud_val(*pud) ^ pte_val(pte)) &
>  							PTE_BITS_MUST_MATCH);
>  			kvmppc_radix_update_pte(kvm, (pte_t *)pud,
> -					      0, pte_val(pte), hgpa, PUD_SHIFT);
> +					0, pte_val(pte), hgpa, PUD_SHIFT);

This is an unconnected whitespace change, AFAICT.

>  			ret =3D 0;
>  			goto out_unlock;
>  		}
> @@ -471,7 +498,8 @@ static int kvmppc_create_pte(struct kvm *kvm, pgd_t *=
pgtable, pte_t pte,
>  			goto out_unlock;
>  		}
>  		/* Valid 1GB page here already, remove it */
> -		kvmppc_unmap_pte(kvm, (pte_t *)pud, hgpa, PUD_SHIFT, NULL);
> +		kvmppc_unmap_pte(kvm, (pte_t *)pud, hgpa, PUD_SHIFT, NULL,
> +				 lpid);
>  	}
>  	if (level =3D=3D 2) {
>  		if (!pud_none(*pud)) {
> @@ -480,7 +508,7 @@ static int kvmppc_create_pte(struct kvm *kvm, pgd_t *=
pgtable, pte_t pte,
>  			 * install a large page, so remove and free the page
>  			 * table page.
>  			 */
> -			kvmppc_unmap_free_pud_entry_table(kvm, pud, gpa);
> +			kvmppc_unmap_free_pud_entry_table(kvm, pud, gpa, lpid);
>  		}
>  		kvmppc_radix_set_pte_at(kvm, gpa, (pte_t *)pud, pte);
>  		ret =3D 0;
> @@ -506,7 +534,7 @@ static int kvmppc_create_pte(struct kvm *kvm, pgd_t *=
pgtable, pte_t pte,
>  			WARN_ON_ONCE((pmd_val(*pmd) ^ pte_val(pte)) &
>  							PTE_BITS_MUST_MATCH);
>  			kvmppc_radix_update_pte(kvm, pmdp_ptep(pmd),
> -					      0, pte_val(pte), lgpa, PMD_SHIFT);
> +					0, pte_val(pte), lgpa, PMD_SHIFT);
>  			ret =3D 0;
>  			goto out_unlock;
>  		}
> @@ -520,7 +548,8 @@ static int kvmppc_create_pte(struct kvm *kvm, pgd_t *=
pgtable, pte_t pte,
>  			goto out_unlock;
>  		}
>  		/* Valid 2MB page here already, remove it */
> -		kvmppc_unmap_pte(kvm, pmdp_ptep(pmd), lgpa, PMD_SHIFT, NULL);
> +		kvmppc_unmap_pte(kvm, pmdp_ptep(pmd), lgpa, PMD_SHIFT, NULL,
> +				 lpid);
>  	}
>  	if (level =3D=3D 1) {
>  		if (!pmd_none(*pmd)) {
> @@ -529,7 +558,7 @@ static int kvmppc_create_pte(struct kvm *kvm, pgd_t *=
pgtable, pte_t pte,
>  			 * install a large page, so remove and free the page
>  			 * table page.
>  			 */
> -			kvmppc_unmap_free_pmd_entry_table(kvm, pmd, gpa);
> +			kvmppc_unmap_free_pmd_entry_table(kvm, pmd, gpa, lpid);
>  		}
>  		kvmppc_radix_set_pte_at(kvm, gpa, pmdp_ptep(pmd), pte);
>  		ret =3D 0;
> @@ -569,8 +598,8 @@ static int kvmppc_create_pte(struct kvm *kvm, pgd_t *=
pgtable, pte_t pte,
>  	return ret;
>  }
> =20
> -static bool kvmppc_hv_handle_set_rc(struct kvm *kvm, pgd_t *pgtable,
> -				    bool writing, unsigned long gpa)
> +bool kvmppc_hv_handle_set_rc(struct kvm *kvm, pgd_t *pgtable, bool writi=
ng,
> +			     unsigned long gpa, unsigned int lpid)
>  {
>  	unsigned long pgflags;
>  	unsigned int shift;
> @@ -597,11 +626,11 @@ static bool kvmppc_hv_handle_set_rc(struct kvm *kvm=
, pgd_t *pgtable,
>  	return false;
>  }
> =20
> -static int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
> -				unsigned long gpa,
> -				struct kvm_memory_slot *memslot,
> -				bool writing, bool kvm_ro,
> -				pte_t *inserted_pte, unsigned int *levelp)
> +int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
> +				   unsigned long gpa,
> +				   struct kvm_memory_slot *memslot,
> +				   bool writing, bool kvm_ro,
> +				   pte_t *inserted_pte, unsigned int *levelp)
>  {
>  	struct kvm *kvm =3D vcpu->kvm;
>  	struct page *page =3D NULL;
> @@ -683,7 +712,7 @@ static int kvmppc_book3s_instantiate_page(struct kvm_=
vcpu *vcpu,
> =20
>  	/* Allocate space in the tree and write the PTE */
>  	ret =3D kvmppc_create_pte(kvm, kvm->arch.pgtable, pte, gpa, level,
> -				mmu_seq);
> +				mmu_seq, kvm->arch.lpid);
>  	if (inserted_pte)
>  		*inserted_pte =3D pte;
>  	if (levelp)
> @@ -758,7 +787,7 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *ru=
n, struct kvm_vcpu *vcpu,
>  	if (dsisr & DSISR_SET_RC) {
>  		spin_lock(&kvm->mmu_lock);
>  		if (kvmppc_hv_handle_set_rc(kvm, kvm->arch.pgtable,
> -					    writing, gpa))
> +					    writing, gpa, kvm->arch.lpid))
>  			dsisr &=3D ~DSISR_SET_RC;
>  		spin_unlock(&kvm->mmu_lock);
> =20
> @@ -786,7 +815,8 @@ int kvm_unmap_radix(struct kvm *kvm, struct kvm_memor=
y_slot *memslot,
> =20
>  	ptep =3D __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
>  	if (ptep && pte_present(*ptep))
> -		kvmppc_unmap_pte(kvm, ptep, gpa, shift, memslot);
> +		kvmppc_unmap_pte(kvm, ptep, gpa, shift, memslot,
> +				 kvm->arch.lpid);
>  	return 0;			=09
>  }
> =20
> @@ -841,7 +871,7 @@ static int kvm_radix_test_clear_dirty(struct kvm *kvm,
>  			ret =3D 1 << (shift - PAGE_SHIFT);
>  		kvmppc_radix_update_pte(kvm, ptep, _PAGE_DIRTY, 0,
>  					gpa, shift);
> -		kvmppc_radix_tlbie_page(kvm, gpa, shift);
> +		kvmppc_radix_tlbie_page(kvm, gpa, shift, kvm->arch.lpid);
>  	}
>  	return ret;
>  }
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3=
s_hv_nested.c
> index f8f9fab..c160df3 100644
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -12,10 +12,13 @@
>  #include <linux/kvm_host.h>
> =20
>  #include <asm/kvm_ppc.h>
> +#include <asm/kvm_book3s.h>
>  #include <asm/mmu.h>
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> +#include <asm/pte-walk.h>
>  #include <asm/disassemble.h>
> +#include <asm/reg.h>
> =20
>  static struct patb_entry *pseries_partition_tb;
> =20
> @@ -393,10 +396,20 @@ struct kvm_nested_guest *kvmhv_alloc_nested(struct =
kvm *kvm, unsigned int lpid)
>   */
>  static void kvmhv_release_nested(struct kvm_nested_guest *gp)
>  {
> +	struct kvm *kvm =3D gp->l1_host;
> +
> +	if (gp->shadow_pgtable) {
> +		/*
> +		 * No vcpu is using this struct and no call to
> +		 * kvmhv_remove_nest_rmap can find this struct,
> +		 * so we don't need to hold kvm->mmu_lock.
> +		 */
> +		kvmppc_free_pgtable_radix(kvm, gp->shadow_pgtable,
> +					  gp->shadow_lpid);
> +		pgd_free(kvm->mm, gp->shadow_pgtable);
> +	}
>  	kvmhv_set_ptbl_entry(gp->shadow_lpid, 0, 0);
>  	kvmppc_free_lpid(gp->shadow_lpid);
> -	if (gp->shadow_pgtable)
> -		pgd_free(gp->l1_host->mm, gp->shadow_pgtable);
>  	kfree(gp);
>  }
> =20
> @@ -453,6 +466,12 @@ void kvmhv_release_all_nested(struct kvm *kvm)
>  /* caller must hold gp->tlb_lock */
>  void kvmhv_flush_nested(struct kvm_nested_guest *gp)
>  {
> +	struct kvm *kvm =3D gp->l1_host;
> +
> +	spin_lock(&kvm->mmu_lock);
> +	kvmppc_free_pgtable_radix(kvm, gp->shadow_pgtable, gp->shadow_lpid);
> +	spin_unlock(&kvm->mmu_lock);
> +	radix__flush_tlb_lpid(gp->shadow_lpid);
>  	kvmhv_update_ptbl_cache(gp);
>  	if (gp->l1_gr_to_hr =3D=3D 0)
>  		kvmhv_remove_nested(gp);
> @@ -512,9 +531,28 @@ void kvmhv_put_nested(struct kvm_nested_guest *gp)
>  		kvmhv_release_nested(gp);
>  }
> =20
> -long kvmhv_nested_page_fault(struct kvm_vcpu *vcpu)
> +static bool kvmhv_invalidate_shadow_pte(struct kvm_vcpu *vcpu,
> +					struct kvm_nested_guest *gp,
> +					long gpa, int *shift_ret)
>  {
> -	return RESUME_HOST;
> +	struct kvm *kvm =3D vcpu->kvm;
> +	bool ret =3D false;
> +	pte_t *ptep;
> +	int shift;
> +
> +	spin_lock(&kvm->mmu_lock);
> +	ptep =3D __find_linux_pte(gp->shadow_pgtable, gpa, NULL, &shift);
> +	if (!shift)
> +		shift =3D PAGE_SHIFT;
> +	if (ptep && pte_present(*ptep)) {
> +		kvmppc_unmap_pte(kvm, ptep, gpa, shift, NULL, gp->shadow_lpid);
> +		ret =3D true;
> +	}
> +	spin_unlock(&kvm->mmu_lock);
> +
> +	if (shift_ret)
> +		*shift_ret =3D shift;
> +	return ret;
>  }
> =20
>  static int kvmhv_emulate_priv_mtspr(struct kvm_run *run, struct kvm_vcpu=
 *vcpu,
> @@ -570,3 +608,291 @@ int kvmhv_emulate_priv(struct kvm_run *run, struct =
kvm_vcpu *vcpu,
> =20
>  	return rc;
>  }
> +
> +/* Used to convert a nested guest real address to a L1 guest real addres=
s */
> +static int kvmhv_translate_addr_nested(struct kvm_vcpu *vcpu,
> +				       struct kvm_nested_guest *gp,
> +				       unsigned long n_gpa, unsigned long dsisr,
> +				       struct kvmppc_pte *gpte_p)
> +{
> +	u64 fault_addr, flags =3D dsisr & DSISR_ISSTORE;
> +	int ret;
> +
> +	ret =3D kvmppc_mmu_walk_radix_tree(vcpu, n_gpa, gpte_p, gp->l1_gr_to_hr,
> +					 &fault_addr);
> +
> +	if (ret) {
> +		/* We didn't find a pte */
> +		if (ret =3D=3D -EINVAL) {
> +			/* Unsupported mmu config */
> +			flags |=3D DSISR_UNSUPP_MMU;
> +		} else if (ret =3D=3D -ENOENT) {
> +			/* No translation found */
> +			flags |=3D DSISR_NOHPTE;
> +		} else if (ret =3D=3D -EFAULT) {
> +			/* Couldn't access L1 real address */
> +			flags |=3D DSISR_PRTABLE_FAULT;
> +			vcpu->arch.fault_gpa =3D fault_addr;
> +		} else {
> +			/* Unknown error */
> +			return ret;
> +		}
> +		goto resume_host;

This is effectively forwarding the fault to L1, yes?  In which case a
different name might be better than the ambiguous "resume_host".

> +	} else {
> +		/* We found a pte -> check permissions */
> +		if (dsisr & DSISR_ISSTORE) {
> +			/* Can we write? */
> +			if (!gpte_p->may_write) {
> +				flags |=3D DSISR_PROTFAULT;
> +				goto resume_host;
> +			}
> +		} else if (vcpu->arch.trap =3D=3D BOOK3S_INTERRUPT_H_INST_STORAGE) {
> +			/* Can we execute? */
> +			if (!gpte_p->may_execute) {
> +				flags |=3D SRR1_ISI_N_OR_G;
> +				goto resume_host;
> +			}
> +		} else {
> +			/* Can we read? */
> +			if (!gpte_p->may_read && !gpte_p->may_write) {
> +				flags |=3D DSISR_PROTFAULT;
> +				goto resume_host;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +
> +resume_host:
> +	vcpu->arch.fault_dsisr =3D flags;
> +	if (vcpu->arch.trap =3D=3D BOOK3S_INTERRUPT_H_INST_STORAGE) {
> +		vcpu->arch.shregs.msr &=3D ~0x783f0000ul;
> +		vcpu->arch.shregs.msr |=3D flags;
> +	}
> +	return RESUME_HOST;
> +}
> +
> +static long kvmhv_handle_nested_set_rc(struct kvm_vcpu *vcpu,
> +				       struct kvm_nested_guest *gp,
> +				       unsigned long n_gpa,
> +				       struct kvmppc_pte gpte,
> +				       unsigned long dsisr)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	bool writing =3D !!(dsisr & DSISR_ISSTORE);
> +	u64 pgflags;
> +	bool ret;
> +
> +	/* Are the rc bits set in the L1 partition scoped pte? */
> +	pgflags =3D _PAGE_ACCESSED;
> +	if (writing)
> +		pgflags |=3D _PAGE_DIRTY;
> +	if (pgflags & ~gpte.rc)
> +		return RESUME_HOST;
> +
> +	spin_lock(&kvm->mmu_lock);
> +	/* Set the rc bit in the pte of our (L0) pgtable for the L1 guest */
> +	ret =3D kvmppc_hv_handle_set_rc(kvm, kvm->arch.pgtable, writing,
> +				     gpte.raddr, kvm->arch.lpid);
> +	spin_unlock(&kvm->mmu_lock);
> +	if (!ret)
> +		return -EINVAL;
> +
> +	/* Set the rc bit in the pte of the shadow_pgtable for the nest guest */
> +	ret =3D kvmppc_hv_handle_set_rc(kvm, gp->shadow_pgtable, writing, n_gpa,
> +				      gp->shadow_lpid);
> +	if (!ret)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static inline int kvmppc_radix_level_to_shift(int level)
> +{
> +	switch (level) {
> +	case 2:
> +		return PUD_SHIFT;
> +	case 1:
> +		return PMD_SHIFT;
> +	default:
> +		return PAGE_SHIFT;
> +	}
> +}
> +
> +static inline int kvmppc_radix_shift_to_level(int shift)
> +{
> +	if (shift =3D=3D PUD_SHIFT)
> +		return 2;
> +	if (shift =3D=3D PMD_SHIFT)
> +		return 1;
> +	if (shift =3D=3D PAGE_SHIFT)
> +		return 0;
> +	WARN_ON_ONCE(1);
> +	return 0;
> +}
> +
> +/* called with gp->tlb_lock held */
> +static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
> +					  struct kvm_nested_guest *gp)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	struct kvm_memory_slot *memslot;
> +	struct kvmppc_pte gpte;
> +	pte_t pte, *pte_p;
> +	unsigned long mmu_seq;
> +	unsigned long dsisr =3D vcpu->arch.fault_dsisr;
> +	unsigned long ea =3D vcpu->arch.fault_dar;
> +	unsigned long n_gpa, gpa, gfn, perm =3D 0UL;
> +	unsigned int shift, l1_shift, level;
> +	bool writing =3D !!(dsisr & DSISR_ISSTORE);
> +	bool kvm_ro =3D false;
> +	long int ret;
> +
> +	if (!gp->l1_gr_to_hr) {
> +		kvmhv_update_ptbl_cache(gp);
> +		if (!gp->l1_gr_to_hr)
> +			return RESUME_HOST;
> +	}
> +
> +	/* Convert the nested guest real address into a L1 guest real address */
> +
> +	n_gpa =3D vcpu->arch.fault_gpa & ~0xF000000000000FFFULL;
> +	if (!(dsisr & DSISR_PRTABLE_FAULT))
> +		n_gpa |=3D ea & 0xFFF;
> +	ret =3D kvmhv_translate_addr_nested(vcpu, gp, n_gpa, dsisr, &gpte);
> +
> +	/*
> +	 * If the hardware found a translation but we don't now have a usable
> +	 * translation in the l1 partition-scoped tree, remove the shadow pte
> +	 * and let the guest retry.
> +	 */
> +	if (ret =3D=3D RESUME_HOST &&
> +	    (dsisr & (DSISR_PROTFAULT | DSISR_BADACCESS | DSISR_NOEXEC_OR_G |
> +		      DSISR_BAD_COPYPASTE)))
> +		goto inval;
> +	if (ret)
> +		return ret;
> +
> +	/* Failed to set the reference/change bits */
> +	if (dsisr & DSISR_SET_RC) {
> +		ret =3D kvmhv_handle_nested_set_rc(vcpu, gp, n_gpa, gpte, dsisr);
> +		if (ret =3D=3D RESUME_HOST)
> +			return ret;
> +		if (ret)
> +			goto inval;
> +		dsisr &=3D ~DSISR_SET_RC;
> +		if (!(dsisr & (DSISR_BAD_FAULT_64S | DSISR_NOHPTE |
> +			       DSISR_PROTFAULT)))
> +			return RESUME_GUEST;
> +	}
> +
> +	/*
> +	 * We took an HISI or HDSI while we were running a nested guest which
> +	 * means we have no partition scoped translation for that. This means
> +	 * we need to insert a pte for the mapping into our shadow_pgtable.
> +	 */
> +
> +	l1_shift =3D gpte.page_shift;
> +	if (l1_shift < PAGE_SHIFT) {
> +		/* We don't support l1 using a page size smaller than our own */
> +		pr_err("KVM: L1 guest page shift (%d) less than our own (%d)\n",
> +			l1_shift, PAGE_SHIFT);
> +		return -EINVAL;
> +	}
> +	gpa =3D gpte.raddr;
> +	gfn =3D gpa >> PAGE_SHIFT;
> +
> +	/* 1. Get the corresponding host memslot */
> +
> +	memslot =3D gfn_to_memslot(kvm, gfn);
> +	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID)) {
> +		if (dsisr & (DSISR_PRTABLE_FAULT | DSISR_BADACCESS)) {
> +			/* unusual error -> reflect to the guest as a DSI */
> +			kvmppc_core_queue_data_storage(vcpu, ea, dsisr);
> +			return RESUME_GUEST;
> +		}
> +		/* passthrough of emulated MMIO case... */
> +		pr_err("emulated MMIO passthrough?\n");
> +		return -EINVAL;
> +	}
> +	if (memslot->flags & KVM_MEM_READONLY) {
> +		if (writing) {
> +			/* Give the guest a DSI */
> +			kvmppc_core_queue_data_storage(vcpu, ea,
> +					DSISR_ISSTORE | DSISR_PROTFAULT);
> +			return RESUME_GUEST;
> +		}
> +		kvm_ro =3D true;
> +	}
> +
> +	/* 2. Find the host pte for this L1 guest real address */
> +
> +	/* Used to check for invalidations in progress */
> +	mmu_seq =3D kvm->mmu_notifier_seq;
> +	smp_rmb();
> +
> +	/* See if can find translation in our partition scoped tables for L1 */
> +	pte =3D __pte(0);
> +	spin_lock(&kvm->mmu_lock);
> +	pte_p =3D __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
> +	if (!shift)
> +		shift =3D PAGE_SHIFT;
> +	if (pte_p)
> +		pte =3D *pte_p;
> +	spin_unlock(&kvm->mmu_lock);
> +
> +	if (!pte_present(pte) || (writing && !(pte_val(pte) & _PAGE_WRITE))) {
> +		/* No suitable pte found -> try to insert a mapping */
> +		ret =3D kvmppc_book3s_instantiate_page(vcpu, gpa, memslot,
> +					writing, kvm_ro, &pte, &level);
> +		if (ret =3D=3D -EAGAIN)
> +			return RESUME_GUEST;
> +		else if (ret)
> +			return ret;
> +		shift =3D kvmppc_radix_level_to_shift(level);
> +	}
> +
> +	/* 3. Compute the pte we need to insert for nest_gpa -> host r_addr */
> +
> +	/* The permissions is the combination of the host and l1 guest ptes */
> +	perm |=3D gpte.may_read ? 0UL : _PAGE_READ;
> +	perm |=3D gpte.may_write ? 0UL : _PAGE_WRITE;
> +	perm |=3D gpte.may_execute ? 0UL : _PAGE_EXEC;
> +	pte =3D __pte(pte_val(pte) & ~perm);
> +
> +	/* What size pte can we insert? */
> +	if (shift > l1_shift) {
> +		u64 mask;
> +		unsigned int actual_shift =3D PAGE_SHIFT;
> +		if (PMD_SHIFT < l1_shift)
> +			actual_shift =3D PMD_SHIFT;
> +		mask =3D (1UL << shift) - (1UL << actual_shift);
> +		pte =3D __pte(pte_val(pte) | (gpa & mask));
> +		shift =3D actual_shift;
> +	}
> +	level =3D kvmppc_radix_shift_to_level(shift);
> +	n_gpa &=3D ~((1UL << shift) - 1);
> +
> +	/* 4. Insert the pte into our shadow_pgtable */
> +
> +	ret =3D kvmppc_create_pte(kvm, gp->shadow_pgtable, pte, n_gpa, level,
> +				mmu_seq, gp->shadow_lpid);
> +	if (ret =3D=3D -EAGAIN)
> +		ret =3D RESUME_GUEST;	/* Let the guest try again */
> +
> +	return ret;
> +
> + inval:
> +	kvmhv_invalidate_shadow_pte(vcpu, gp, n_gpa, NULL);
> +	return RESUME_GUEST;
> +}
> +
> +long int kvmhv_nested_page_fault(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_nested_guest *gp =3D vcpu->arch.nested;
> +	long int ret;
> +
> +	mutex_lock(&gp->tlb_lock);
> +	ret =3D __kvmhv_nested_page_fault(vcpu, gp);
> +	mutex_unlock(&gp->tlb_lock);
> +	return ret;
> +}
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index fef3e1e..4c4dfc4 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -833,6 +833,15 @@ EXPORT_SYMBOL_GPL(radix__flush_pwc_lpid);
>  /*
>   * Flush partition scoped translations from LPID (=3DLPIDR)
>   */
> +void radix__flush_tlb_lpid(unsigned int lpid)
> +{
> +	_tlbie_lpid(lpid, RIC_FLUSH_ALL);
> +}
> +EXPORT_SYMBOL_GPL(radix__flush_tlb_lpid);
> +
> +/*
> + * Flush partition scoped translations from LPID (=3DLPIDR)
> + */
>  void radix__local_flush_tlb_lpid(unsigned int lpid)
>  {
>  	_tlbiel_lpid(lpid, RIC_FLUSH_ALL);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MWF3YmTHhoLNIVQC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu0Vf8ACgkQbDjKyiDZ
s5KV2A/9EXN1zLaFxqKgCJJhPmIKX90lJIEgzOiLUfKZFg+Q3pXhEvCd9cj+/jdc
6a7y89oLbmuRVL351KMNsdL7WWuC0/23oBktBA4T5j0At9Sx61QmXk5yZAvmSj6y
0UCQJWYKcZCu7jIGOExVFV+skrqX7dXUov4rF02LT8gI4MT0UkhCn2hVdGJmx9Ec
B4zUMOmEWIaAAKP55JUB7lCGUSmHdQPieDmigMEbf4ohXjcfiIht4yBj515abQCt
EoOzpqkbxu2cabaDzsXa42lehsWp7qCe+FdmcHFOO2JPQ22WDSp5Y8cCculB/jfP
If81wNlHi33XT7YIyJpOy7OmG0uFBCzDdUx8lMXH7FCcsS3P+qG2USkWlYne7bLq
1cD08QhW7m9q20DPy14El8CO0pXcWh5ZDif2Hx0uaemGGPLHVnxqinDnmmYNs3rn
TFiZTqp4tzDrdfDmji/qhcO6L+/3sEjKcdIMbi36VWF3Nzi3WVLgpURMH6ANXOeI
AOL4xksj41UGkK/zT1kP57ff/utG0NfReQFKzb8WGdM5mlBE+OncSYfsLqflMKt9
DGo9Zh3+dHuCU30fPkmJ0LJEng/su06eIrWP2UeEBFtGCDoW+jOZdFLJza5+HrP7
TOzQjXgcGNfG0JwRfybXHcgnOHzkeWeubJPEJNC5EMYG1UFan6s=
=uWRZ
-----END PGP SIGNATURE-----

--MWF3YmTHhoLNIVQC--
