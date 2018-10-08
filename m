Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D096CC6787A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 01:08:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A96C205C9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 01:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kNAh5JEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A96C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TfHr00MtzF31L
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 12:08:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kNAh5JEU";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tf1z4KJbzF37J
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="kNAh5JEU"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Tf1z2wt7z9sj6; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Tf1z1sYhz9sCr; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1539046599;
 bh=bEJ19bhK+ll2wVGimVyyKUjgglFHTMXwvUksA2etBNM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kNAh5JEUQGdB5alCdOo+EitbzRqXDJl4bYEKUOPE2qIx9T/yzVEH2hF+XPl+V9Ff3
 05X5IrplekT5yfFJIT5vL1HyUEjBxu1JzPxo/UlGfh3IIJOf2q28gL7Wv/SvHRKpw5
 WZNO7cc88c5qGh7XaaNYvxn5/ioXY6r7BxC+++g0=
Date: Tue, 9 Oct 2018 10:30:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v5 17/33] KVM: PPC: Book3S HV: Framework and hcall stubs
 for nested virtualization
Message-ID: <20181008233004.GA7004@umbus.fritz.box>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
 <1538976679-1363-18-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1ozVqH6bFr/3sC51"
Content-Disposition: inline
In-Reply-To: <1538976679-1363-18-git-send-email-paulus@ozlabs.org>
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


--1ozVqH6bFr/3sC51
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 04:31:03PM +1100, Paul Mackerras wrote:
> This starts the process of adding the code to support nested HV-style
> virtualization.  It defines a new H_SET_PARTITION_TABLE hypercall which
> a nested hypervisor can use to set the base address and size of a
> partition table in its memory (analogous to the PTCR register).
> On the host (level 0 hypervisor) side, the H_SET_PARTITION_TABLE
> hypercall from the guest is handled by code that saves the virtual
> PTCR value for the guest.
>=20
> This also adds code for creating and destroying nested guests and for
> reading the partition table entry for a nested guest from L1 memory.
> Each nested guest has its own shadow LPID value, different in general
> from the LPID value used by the nested hypervisor to refer to it.  The
> shadow LPID value is allocated at nested guest creation time.
>=20
> Nested hypervisor functionality is only available for a radix guest,
> which therefore means a radix host on a POWER9 (or later) processor.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>


> ---
>  arch/powerpc/include/asm/hvcall.h         |   5 +
>  arch/powerpc/include/asm/kvm_book3s.h     |  10 +-
>  arch/powerpc/include/asm/kvm_book3s_64.h  |  33 ++++
>  arch/powerpc/include/asm/kvm_book3s_asm.h |   3 +
>  arch/powerpc/include/asm/kvm_host.h       |   5 +
>  arch/powerpc/kvm/Makefile                 |   3 +-
>  arch/powerpc/kvm/book3s_hv.c              |  31 ++-
>  arch/powerpc/kvm/book3s_hv_nested.c       | 301 ++++++++++++++++++++++++=
++++++
>  8 files changed, 384 insertions(+), 7 deletions(-)
>  create mode 100644 arch/powerpc/kvm/book3s_hv_nested.c
>=20
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm=
/hvcall.h
> index a0b17f9..c95c651 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -322,6 +322,11 @@
>  #define H_GET_24X7_DATA		0xF07C
>  #define H_GET_PERF_COUNTER_INFO	0xF080
> =20
> +/* Platform-specific hcalls used for nested HV KVM */
> +#define H_SET_PARTITION_TABLE	0xF800
> +#define H_ENTER_NESTED		0xF804
> +#define H_TLB_INVALIDATE	0xF808
> +
>  /* Values for 2nd argument to H_SET_MODE */
>  #define H_SET_MODE_RESOURCE_SET_CIABR		1
>  #define H_SET_MODE_RESOURCE_SET_DAWR		2
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include=
/asm/kvm_book3s.h
> index 91c9779..43f212e 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -274,6 +274,13 @@ static inline void kvmppc_save_tm_sprs(struct kvm_vc=
pu *vcpu) {}
>  static inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu) {}
>  #endif
> =20
> +long kvmhv_nested_init(void);
> +void kvmhv_nested_exit(void);
> +void kvmhv_vm_nested_init(struct kvm *kvm);
> +long kvmhv_set_partition_table(struct kvm_vcpu *vcpu);
> +void kvmhv_set_ptbl_entry(unsigned int lpid, u64 dw0, u64 dw1);
> +void kvmhv_release_all_nested(struct kvm *kvm);
> +
>  void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac);
> =20
>  extern int kvm_irq_bypass;
> @@ -387,9 +394,6 @@ extern int kvmppc_h_logical_ci_store(struct kvm_vcpu =
*vcpu);
>  /* TO =3D 31 for unconditional trap */
>  #define INS_TW				0x7fe00008
> =20
> -/* LPIDs we support with this build -- runtime limit may be lower */
> -#define KVMPPC_NR_LPIDS			(LPID_RSVD + 1)
> -
>  #define SPLIT_HACK_MASK			0xff000000
>  #define SPLIT_HACK_OFFS			0xfb000000
> =20
> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/incl=
ude/asm/kvm_book3s_64.h
> index 5c0e2d9..6d67b6a 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> @@ -23,6 +23,39 @@
>  #include <linux/string.h>
>  #include <asm/bitops.h>
>  #include <asm/book3s/64/mmu-hash.h>
> +#include <asm/cpu_has_feature.h>
> +
> +#ifdef CONFIG_PPC_PSERIES
> +static inline bool kvmhv_on_pseries(void)
> +{
> +	return !cpu_has_feature(CPU_FTR_HVMODE);
> +}
> +#else
> +static inline bool kvmhv_on_pseries(void)
> +{
> +	return false;
> +}
> +#endif
> +
> +/*
> + * Structure for a nested guest, that is, for a guest that is managed by
> + * one of our guests.
> + */
> +struct kvm_nested_guest {
> +	struct kvm *l1_host;		/* L1 VM that owns this nested guest */
> +	int l1_lpid;			/* lpid L1 guest thinks this guest is */
> +	int shadow_lpid;		/* real lpid of this nested guest */
> +	pgd_t *shadow_pgtable;		/* our page table for this guest */
> +	u64 l1_gr_to_hr;		/* L1's addr of part'n-scoped table */
> +	u64 process_table;		/* process table entry for this guest */
> +	long refcnt;			/* number of pointers to this struct */
> +	struct mutex tlb_lock;		/* serialize page faults and tlbies */
> +	struct kvm_nested_guest *next;
> +};
> +
> +struct kvm_nested_guest *kvmhv_get_nested(struct kvm *kvm, int l1_lpid,
> +					  bool create);
> +void kvmhv_put_nested(struct kvm_nested_guest *gp);
> =20
>  /* Power architecture requires HPT is at least 256kiB, at most 64TiB */
>  #define PPC_MIN_HPT_ORDER	18
> diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/inc=
lude/asm/kvm_book3s_asm.h
> index d978fdf..eb3ba63 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_asm.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
> @@ -25,6 +25,9 @@
>  #define XICS_MFRR		0xc
>  #define XICS_IPI		2	/* interrupt source # for IPIs */
> =20
> +/* LPIDs we support with this build -- runtime limit may be lower */
> +#define KVMPPC_NR_LPIDS			(LPID_RSVD + 1)
> +
>  /* Maximum number of threads per physical core */
>  #define MAX_SMT_THREADS		8
> =20
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index c9cc42f..c35d4f2 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -46,6 +46,7 @@
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  #include <asm/kvm_book3s_asm.h>		/* for MAX_SMT_THREADS */
>  #define KVM_MAX_VCPU_ID		(MAX_SMT_THREADS * KVM_MAX_VCORES)
> +#define KVM_MAX_NESTED_GUESTS	KVMPPC_NR_LPIDS
> =20
>  #else
>  #define KVM_MAX_VCPU_ID		KVM_MAX_VCPUS
> @@ -287,6 +288,7 @@ struct kvm_arch {
>  	u8 radix;
>  	u8 fwnmi_enabled;
>  	bool threads_indep;
> +	bool nested_enable;
>  	pgd_t *pgtable;
>  	u64 process_table;
>  	struct dentry *debugfs_dir;
> @@ -312,6 +314,9 @@ struct kvm_arch {
>  #endif
>  	struct kvmppc_ops *kvm_ops;
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	u64 l1_ptcr;
> +	int max_nested_lpid;
> +	struct kvm_nested_guest *nested_guests[KVM_MAX_NESTED_GUESTS];
>  	/* This array can grow quite large, keep it at the end */
>  	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
>  #endif
> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> index f872c04..e814f40 100644
> --- a/arch/powerpc/kvm/Makefile
> +++ b/arch/powerpc/kvm/Makefile
> @@ -75,7 +75,8 @@ kvm-hv-y +=3D \
>  	book3s_hv.o \
>  	book3s_hv_interrupts.o \
>  	book3s_64_mmu_hv.o \
> -	book3s_64_mmu_radix.o
> +	book3s_64_mmu_radix.o \
> +	book3s_hv_nested.o
> =20
>  kvm-hv-$(CONFIG_PPC_TRANSACTIONAL_MEM) +=3D \
>  	book3s_hv_tm.o
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 8425d72..4c72f2f 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -934,6 +934,19 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>  		if (ret =3D=3D H_TOO_HARD)
>  			return RESUME_HOST;
>  		break;
> +
> +	case H_SET_PARTITION_TABLE:
> +		ret =3D H_FUNCTION;
> +		if (vcpu->kvm->arch.nested_enable)
> +			ret =3D kvmhv_set_partition_table(vcpu);
> +		break;
> +	case H_ENTER_NESTED:
> +		ret =3D H_FUNCTION;
> +		break;
> +	case H_TLB_INVALIDATE:
> +		ret =3D H_FUNCTION;
> +		break;
> +
>  	default:
>  		return RESUME_HOST;
>  	}
> @@ -4153,8 +4166,7 @@ void kvmppc_setup_partition_table(struct kvm *kvm)
>  			__pa(kvm->arch.pgtable) | RADIX_PGD_INDEX_SIZE;
>  		dw1 =3D PATB_GR | kvm->arch.process_table;
>  	}
> -
> -	mmu_partition_table_set_entry(kvm->arch.lpid, dw0, dw1);
> +	kvmhv_set_ptbl_entry(kvm->arch.lpid, dw0, dw1);
>  }
> =20
>  /*
> @@ -4250,6 +4262,10 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcp=
u *vcpu)
>  /* Must be called with kvm->lock held and mmu_ready =3D 0 and no vcpus r=
unning */
>  int kvmppc_switch_mmu_to_hpt(struct kvm *kvm)
>  {
> +	if (kvm->arch.nested_enable) {
> +		kvm->arch.nested_enable =3D false;
> +		kvmhv_release_all_nested(kvm);
> +	}
>  	kvmppc_free_radix(kvm);
>  	kvmppc_update_lpcr(kvm, LPCR_VPM1,
>  			   LPCR_VPM1 | LPCR_UPRT | LPCR_GTSE | LPCR_HR);
> @@ -4370,6 +4386,8 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
> =20
>  	kvmppc_alloc_host_rm_ops();
> =20
> +	kvmhv_vm_nested_init(kvm);
> +
>  	/*
>  	 * Since we don't flush the TLB when tearing down a VM,
>  	 * and this lpid might have previously been used,
> @@ -4513,8 +4531,10 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *=
kvm)
> =20
>  	/* Perform global invalidation and return lpid to the pool */
>  	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +		if (kvm->arch.nested_enable)
> +			kvmhv_release_all_nested(kvm);
>  		kvm->arch.process_table =3D 0;
> -		kvmppc_setup_partition_table(kvm);
> +		kvmhv_set_ptbl_entry(kvm->arch.lpid, 0, 0);
>  	}
>  	kvmppc_free_lpid(kvm->arch.lpid);
> =20
> @@ -4985,6 +5005,10 @@ static int kvmppc_book3s_init_hv(void)
>  	if (r < 0)
>  		return -ENODEV;
> =20
> +	r =3D kvmhv_nested_init();
> +	if (r)
> +		return r;
> +
>  	r =3D kvm_init_subcore_bitmap();
>  	if (r)
>  		return r;
> @@ -5043,6 +5067,7 @@ static void kvmppc_book3s_exit_hv(void)
>  	if (kvmppc_radix_possible())
>  		kvmppc_radix_exit();
>  	kvmppc_hv_ops =3D NULL;
> +	kvmhv_nested_exit();
>  }
> =20
>  module_init(kvmppc_book3s_init_hv);
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3=
s_hv_nested.c
> new file mode 100644
> index 0000000..32782624
> --- /dev/null
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -0,0 +1,301 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright IBM Corporation, 2018
> + * Authors Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> + *	   Paul Mackerras <paulus@ozlabs.org>
> + *
> + * Description: KVM functions specific to running nested KVM-HV guests
> + * on Book3S processors (specifically POWER9 and later).
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/kvm_host.h>
> +
> +#include <asm/kvm_ppc.h>
> +#include <asm/mmu.h>
> +#include <asm/pgtable.h>
> +#include <asm/pgalloc.h>
> +
> +static struct patb_entry *pseries_partition_tb;
> +
> +static void kvmhv_update_ptbl_cache(struct kvm_nested_guest *gp);
> +
> +long kvmhv_nested_init(void)
> +{
> +	long int ptb_order;
> +	unsigned long ptcr;
> +	long rc;
> +
> +	if (!kvmhv_on_pseries())
> +		return 0;
> +	if (!radix_enabled())
> +		return -ENODEV;
> +
> +	/* find log base 2 of KVMPPC_NR_LPIDS, rounding up */
> +	ptb_order =3D __ilog2(KVMPPC_NR_LPIDS - 1) + 1;
> +	if (ptb_order < 8)
> +		ptb_order =3D 8;
> +	pseries_partition_tb =3D kmalloc(sizeof(struct patb_entry) << ptb_order,
> +				       GFP_KERNEL);
> +	if (!pseries_partition_tb) {
> +		pr_err("kvm-hv: failed to allocated nested partition table\n");
> +		return -ENOMEM;
> +	}
> +
> +	ptcr =3D __pa(pseries_partition_tb) | (ptb_order - 8);
> +	rc =3D plpar_hcall_norets(H_SET_PARTITION_TABLE, ptcr);
> +	if (rc !=3D H_SUCCESS) {
> +		pr_err("kvm-hv: Parent hypervisor does not support nesting (rc=3D%ld)\=
n",
> +		       rc);
> +		kfree(pseries_partition_tb);
> +		pseries_partition_tb =3D NULL;
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +void kvmhv_nested_exit(void)
> +{
> +	/*
> +	 * N.B. the kvmhv_on_pseries() test is there because it enables
> +	 * the compiler to remove the call to plpar_hcall_norets()
> +	 * when CONFIG_PPC_PSERIES=3Dn.
> +	 */
> +	if (kvmhv_on_pseries() && pseries_partition_tb) {
> +		plpar_hcall_norets(H_SET_PARTITION_TABLE, 0);
> +		kfree(pseries_partition_tb);
> +		pseries_partition_tb =3D NULL;
> +	}
> +}
> +
> +void kvmhv_set_ptbl_entry(unsigned int lpid, u64 dw0, u64 dw1)
> +{
> +	if (cpu_has_feature(CPU_FTR_HVMODE)) {
> +		mmu_partition_table_set_entry(lpid, dw0, dw1);
> +	} else {
> +		pseries_partition_tb[lpid].patb0 =3D cpu_to_be64(dw0);
> +		pseries_partition_tb[lpid].patb1 =3D cpu_to_be64(dw1);

To double check my understanding: we don't need any locking on pseries
on pseries_partition_tb, because the allocation of lpids is properly
synchronized, so we assume that code which knows about an lpid "owns"
that slot in the table.  Is that right?

> +	}
> +}
> +
> +static void kvmhv_set_nested_ptbl(struct kvm_nested_guest *gp)
> +{
> +	unsigned long dw0;
> +
> +	dw0 =3D PATB_HR | radix__get_tree_size() |
> +		__pa(gp->shadow_pgtable) | RADIX_PGD_INDEX_SIZE;
> +	kvmhv_set_ptbl_entry(gp->shadow_lpid, dw0, gp->process_table);
> +}
> +
> +void kvmhv_vm_nested_init(struct kvm *kvm)
> +{
> +	kvm->arch.max_nested_lpid =3D -1;
> +}
> +
> +/*
> + * Handle the H_SET_PARTITION_TABLE hcall.
> + * r4 =3D guest real address of partition table + log_2(size) - 12
> + * (formatted as for the PTCR).
> + */
> +long kvmhv_set_partition_table(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	unsigned long ptcr =3D kvmppc_get_gpr(vcpu, 4);
> +	int srcu_idx;
> +	long ret =3D H_SUCCESS;
> +
> +	srcu_idx =3D srcu_read_lock(&kvm->srcu);
> +	/*
> +	 * Limit the partition table to 4096 entries (because that's what
> +	 * hardware supports), and check the base address.
> +	 */
> +	if ((ptcr & PRTS_MASK) > 12 - 8 ||
> +	    !kvm_is_visible_gfn(vcpu->kvm, (ptcr & PRTB_MASK) >> PAGE_SHIFT))
> +		ret =3D H_PARAMETER;

Note there's a subtle dependency on 64k page size here, since you only
validate the table's base address.

> +	srcu_read_unlock(&kvm->srcu, srcu_idx);
> +	if (ret =3D=3D H_SUCCESS)
> +		kvm->arch.l1_ptcr =3D ptcr;
> +	return ret;
> +}
> +
> +/*
> + * Reload the partition table entry for a guest.
> + * Caller must hold gp->tlb_lock.
> + */
> +static void kvmhv_update_ptbl_cache(struct kvm_nested_guest *gp)
> +{
> +	int ret;
> +	struct patb_entry ptbl_entry;
> +	unsigned long ptbl_addr;
> +	struct kvm *kvm =3D gp->l1_host;
> +
> +	ret =3D -EFAULT;
> +	ptbl_addr =3D (kvm->arch.l1_ptcr & PRTB_MASK) + (gp->l1_lpid << 4);
> +	if (gp->l1_lpid < (1ul << ((kvm->arch.l1_ptcr & PRTS_MASK) + 8)))
> +		ret =3D kvm_read_guest(kvm, ptbl_addr,
> +				     &ptbl_entry, sizeof(ptbl_entry));
> +	if (ret) {
> +		gp->l1_gr_to_hr =3D 0;
> +		gp->process_table =3D 0;
> +	} else {
> +		gp->l1_gr_to_hr =3D be64_to_cpu(ptbl_entry.patb0);
> +		gp->process_table =3D be64_to_cpu(ptbl_entry.patb1);
> +	}
> +	kvmhv_set_nested_ptbl(gp);
> +}
> +
> +struct kvm_nested_guest *kvmhv_alloc_nested(struct kvm *kvm, unsigned in=
t lpid)
> +{
> +	struct kvm_nested_guest *gp;
> +	long shadow_lpid;
> +
> +	gp =3D kzalloc(sizeof(*gp), GFP_KERNEL);
> +	if (!gp)
> +		return NULL;
> +	gp->l1_host =3D kvm;
> +	gp->l1_lpid =3D lpid;
> +	mutex_init(&gp->tlb_lock);
> +	gp->shadow_pgtable =3D pgd_alloc(kvm->mm);
> +	if (!gp->shadow_pgtable)
> +		goto out_free;
> +	shadow_lpid =3D kvmppc_alloc_lpid();
> +	if (shadow_lpid < 0)
> +		goto out_free2;
> +	gp->shadow_lpid =3D shadow_lpid;
> +
> +	return gp;
> +
> + out_free2:
> +	pgd_free(kvm->mm, gp->shadow_pgtable);
> + out_free:
> +	kfree(gp);
> +	return NULL;
> +}
> +
> +/*
> + * Free up any resources allocated for a nested guest.
> + */
> +static void kvmhv_release_nested(struct kvm_nested_guest *gp)
> +{
> +	kvmhv_set_ptbl_entry(gp->shadow_lpid, 0, 0);
> +	kvmppc_free_lpid(gp->shadow_lpid);
> +	if (gp->shadow_pgtable)
> +		pgd_free(gp->l1_host->mm, gp->shadow_pgtable);
> +	kfree(gp);
> +}
> +
> +static void kvmhv_remove_nested(struct kvm_nested_guest *gp)
> +{
> +	struct kvm *kvm =3D gp->l1_host;
> +	int lpid =3D gp->l1_lpid;
> +	long ref;
> +
> +	spin_lock(&kvm->mmu_lock);
> +	if (gp =3D=3D kvm->arch.nested_guests[lpid]) {
> +		kvm->arch.nested_guests[lpid] =3D NULL;
> +		if (lpid =3D=3D kvm->arch.max_nested_lpid) {
> +			while (--lpid >=3D 0 && !kvm->arch.nested_guests[lpid])
> +				;
> +			kvm->arch.max_nested_lpid =3D lpid;
> +		}
> +		--gp->refcnt;
> +	}
> +	ref =3D gp->refcnt;
> +	spin_unlock(&kvm->mmu_lock);
> +	if (ref =3D=3D 0)
> +		kvmhv_release_nested(gp);
> +}
> +
> +/*
> + * Free up all nested resources allocated for this guest.
> + * This is called with no vcpus of the guest running, when
> + * switching the guest to HPT mode or when destroying the
> + * guest.
> + */
> +void kvmhv_release_all_nested(struct kvm *kvm)
> +{
> +	int i;
> +	struct kvm_nested_guest *gp;
> +	struct kvm_nested_guest *freelist =3D NULL;
> +
> +	spin_lock(&kvm->mmu_lock);
> +	for (i =3D 0; i <=3D kvm->arch.max_nested_lpid; i++) {
> +		gp =3D kvm->arch.nested_guests[i];
> +		if (!gp)
> +			continue;
> +		kvm->arch.nested_guests[i] =3D NULL;
> +		if (--gp->refcnt =3D=3D 0) {
> +			gp->next =3D freelist;
> +			freelist =3D gp;
> +		}
> +	}
> +	kvm->arch.max_nested_lpid =3D -1;
> +	spin_unlock(&kvm->mmu_lock);
> +	while ((gp =3D freelist) !=3D NULL) {
> +		freelist =3D gp->next;
> +		kvmhv_release_nested(gp);
> +	}
> +}
> +
> +/* caller must hold gp->tlb_lock */
> +void kvmhv_flush_nested(struct kvm_nested_guest *gp)
> +{
> +	kvmhv_update_ptbl_cache(gp);
> +	if (gp->l1_gr_to_hr =3D=3D 0)
> +		kvmhv_remove_nested(gp);
> +}
> +
> +struct kvm_nested_guest *kvmhv_get_nested(struct kvm *kvm, int l1_lpid,
> +					  bool create)
> +{
> +	struct kvm_nested_guest *gp, *newgp;
> +
> +	if (l1_lpid >=3D KVM_MAX_NESTED_GUESTS ||
> +	    l1_lpid >=3D (1ul << ((kvm->arch.l1_ptcr & PRTS_MASK) + 12 - 4)))
> +		return NULL;
> +
> +	spin_lock(&kvm->mmu_lock);
> +	gp =3D kvm->arch.nested_guests[l1_lpid];
> +	if (gp)
> +		++gp->refcnt;
> +	spin_unlock(&kvm->mmu_lock);
> +
> +	if (gp || !create)
> +		return gp;
> +
> +	newgp =3D kvmhv_alloc_nested(kvm, l1_lpid);
> +	if (!newgp)
> +		return NULL;
> +	spin_lock(&kvm->mmu_lock);
> +	if (kvm->arch.nested_guests[l1_lpid]) {
> +		/* someone else beat us to it */
> +		gp =3D kvm->arch.nested_guests[l1_lpid];
> +	} else {
> +		kvm->arch.nested_guests[l1_lpid] =3D newgp;
> +		++newgp->refcnt;
> +		gp =3D newgp;
> +		newgp =3D NULL;
> +		if (l1_lpid > kvm->arch.max_nested_lpid)
> +			kvm->arch.max_nested_lpid =3D l1_lpid;
> +	}
> +	++gp->refcnt;
> +	spin_unlock(&kvm->mmu_lock);
> +
> +	if (newgp)
> +		kvmhv_release_nested(newgp);
> +
> +	return gp;
> +}
> +
> +void kvmhv_put_nested(struct kvm_nested_guest *gp)
> +{
> +	struct kvm *kvm =3D gp->l1_host;
> +	long ref;
> +
> +	spin_lock(&kvm->mmu_lock);
> +	ref =3D --gp->refcnt;
> +	spin_unlock(&kvm->mmu_lock);
> +	if (ref =3D=3D 0)
> +		kvmhv_release_nested(gp);
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1ozVqH6bFr/3sC51
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu76HkACgkQbDjKyiDZ
s5KTwBAAkplFXlmCVIObO2b3SwARQkgYblAtK/RtkiRiywRCp/hdBIet5Bn1XflM
QdXVkqdYDGx6MmGJH1UcrCyn6sd3mSbGEN9KHqNsvoDoaXFmhumqQDzcqRIiq0bu
5i1HYdnImA8nUoaBgUV+w6A/zbRx4TTIOSuEA2igeHuNKHA/d0G8Ngg2FXsOzdfK
PzxM8kgNCmqIeY75SXKArc8ZaB35Cw+LQmAz86tyUYiXdJLRvmLmMHdNXPg/mzH1
7hGU7C+HFHh25bg4xNGQLqpd6rTbPAMMW8FaWBAFLuglWlxcC/pPTFxH1unAff6x
LzdyWmeCNqVb2SMqzvTi3KD51qb4mdyyIOQYi24KaVtiGGoYxNeTLpVjCiX4WBnL
DLSY6R30/6/4t5EVr7UdRilWz7mmxvVAk8llqWP3Jh5T+J4JwQKensaadzdgKDNq
oIVoyLKgeV5hGGK4+BUn4sHkn4nF+zjgONBraclImcFKfOw0VahR1UlBvIDzbfUg
XBYj5px8RM3eOxbGaUhJ/ob/Dh5rdOD1dECVo8+I2tFjdQZ30on07EOnboitKsKw
LU1JSn/wGLZKiv37zkvuSWxrzigwrPC1EyIuZl6wf6CSGnKs0I3YHVAv70Rip06o
5SmbHpnaSVtsaNvbkLdSDYQtjOSrLPko6BoG5b6bmM/ziiVPb+w=
=RWXs
-----END PGP SIGNATURE-----

--1ozVqH6bFr/3sC51--
