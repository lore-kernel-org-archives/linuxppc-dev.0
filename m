Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFFBC67879
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 01:03:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031FC20C0A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 01:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DDwWoudN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031FC20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TfBN19HKzF37q
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 12:03:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DDwWoudN";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tf200pFyzF3Bw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 11:56:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="DDwWoudN"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Tf1z70j6zB4N6; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Tf1z6SW8z9sj2; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1539046599;
 bh=ZRVNLYtpEvbgpFRIxaihENO/7dSve1gbpbhtTdzmHik=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DDwWoudNencRkMrP/7gf0d3/+O1A/m4v/E7hSXkKnqyv8j7/mex9+o8W4+45XjY0r
 vlG+/qbpv5SDXqgkFu3AolKGoMghkJqREREpdq3vR3YXW6FxJI+PttS2VIPi4j1XU7
 yaNmD1zzbkFRvFQRFjgSyJ4uka5B0g6mQQpkjvxs=
Date: Tue, 9 Oct 2018 11:20:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v5 09/33] KVM: PPC: Book3S HV: Streamlined guest
 entry/exit path on P9 for radix guests
Message-ID: <20181009002042.GF7004@umbus.fritz.box>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
 <1538976679-1363-10-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aPOcx+xoD6gZZHnz"
Content-Disposition: inline
In-Reply-To: <1538976679-1363-10-git-send-email-paulus@ozlabs.org>
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


--aPOcx+xoD6gZZHnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 04:30:55PM +1100, Paul Mackerras wrote:
> This creates an alternative guest entry/exit path which is used for
> radix guests on POWER9 systems when we have indep_threads_mode=3DY.  In
> these circumstances there is exactly one vcpu per vcore and there is
> no coordination required between vcpus or vcores; the vcpu can enter
> the guest without needing to synchronize with anything else.
>=20
> The new fast path is implemented almost entirely in C in book3s_hv.c
> and runs with the MMU on until the guest is entered.  On guest exit
> we use the existing path until the point where we are committed to
> exiting the guest (as distinct from handling an interrupt in the
> low-level code and returning to the guest) and we have pulled the
> guest context from the XIVE.  At that point we check a flag in the
> stack frame to see whether we came in via the old path and the new
> path; if we came in via the new path then we go back to C code to do
> the rest of the process of saving the guest context and restoring the
> host context.
>=20
> The C code is split into separate functions for handling the
> OS-accessible state and the hypervisor state, with the idea that the
> latter can be replaced by a hypercall when we implement nested
> virtualization.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/asm-prototypes.h |   2 +
>  arch/powerpc/include/asm/kvm_ppc.h        |   2 +
>  arch/powerpc/kvm/book3s_hv.c              | 429 ++++++++++++++++++++++++=
+++++-
>  arch/powerpc/kvm/book3s_hv_ras.c          |   2 +
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  95 ++++++-
>  arch/powerpc/kvm/book3s_xive.c            |  63 +++++
>  6 files changed, 589 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/inc=
lude/asm/asm-prototypes.h
> index 0c1a2b0..5c9b00c 100644
> --- a/arch/powerpc/include/asm/asm-prototypes.h
> +++ b/arch/powerpc/include/asm/asm-prototypes.h
> @@ -165,4 +165,6 @@ void kvmhv_load_host_pmu(void);
>  void kvmhv_save_guest_pmu(struct kvm_vcpu *vcpu, bool pmu_in_use);
>  void kvmhv_load_guest_pmu(struct kvm_vcpu *vcpu);
> =20
> +int __kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu);
> +
>  #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index 83d61b8..245e564 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -585,6 +585,7 @@ extern int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu,=
 u64 icpval);
> =20
>  extern int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 i=
rq,
>  			       int level, bool line_status);
> +extern void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu);
>  #else
>  static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 ser=
ver,
>  				       u32 priority) { return -1; }
> @@ -607,6 +608,7 @@ static inline int kvmppc_xive_set_icp(struct kvm_vcpu=
 *vcpu, u64 icpval) { retur
> =20
>  static inline int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id=
, u32 irq,
>  				      int level, bool line_status) { return -ENODEV; }
> +static inline void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu) { }
>  #endif /* CONFIG_KVM_XIVE */
> =20
>  /*
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 0e17593..0c1dd76 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3080,6 +3080,269 @@ static noinline void kvmppc_run_core(struct kvmpp=
c_vcore *vc)
>  }
> =20
>  /*
> + * Load up hypervisor-mode registers on P9.
> + */
> +static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_lim=
it)
> +{
> +	struct kvmppc_vcore *vc =3D vcpu->arch.vcore;
> +	s64 hdec;
> +	u64 tb, purr, spurr;
> +	int trap;
> +	unsigned long host_hfscr =3D mfspr(SPRN_HFSCR);
> +	unsigned long host_ciabr =3D mfspr(SPRN_CIABR);
> +	unsigned long host_dawr =3D mfspr(SPRN_DAWR);
> +	unsigned long host_dawrx =3D mfspr(SPRN_DAWRX);
> +	unsigned long host_psscr =3D mfspr(SPRN_PSSCR);
> +	unsigned long host_pidr =3D mfspr(SPRN_PID);
> +
> +	hdec =3D time_limit - mftb();
> +	if (hdec < 0)
> +		return BOOK3S_INTERRUPT_HV_DECREMENTER;
> +	mtspr(SPRN_HDEC, hdec);
> +
> +	if (vc->tb_offset) {
> +		u64 new_tb =3D mftb() + vc->tb_offset;
> +		mtspr(SPRN_TBU40, new_tb);
> +		tb =3D mftb();
> +		if ((tb & 0xffffff) < (new_tb & 0xffffff))
> +			mtspr(SPRN_TBU40, new_tb + 0x1000000);
> +		vc->tb_offset_applied =3D vc->tb_offset;
> +	}
> +
> +	if (vc->pcr)
> +		mtspr(SPRN_PCR, vc->pcr);
> +	mtspr(SPRN_DPDES, vc->dpdes);
> +	mtspr(SPRN_VTB, vc->vtb);
> +
> +	local_paca->kvm_hstate.host_purr =3D mfspr(SPRN_PURR);
> +	local_paca->kvm_hstate.host_spurr =3D mfspr(SPRN_SPURR);
> +	mtspr(SPRN_PURR, vcpu->arch.purr);
> +	mtspr(SPRN_SPURR, vcpu->arch.spurr);
> +
> +	if (cpu_has_feature(CPU_FTR_DAWR)) {
> +		mtspr(SPRN_DAWR, vcpu->arch.dawr);
> +		mtspr(SPRN_DAWRX, vcpu->arch.dawrx);
> +	}
> +	mtspr(SPRN_CIABR, vcpu->arch.ciabr);
> +	mtspr(SPRN_IC, vcpu->arch.ic);
> +	mtspr(SPRN_PID, vcpu->arch.pid);
> +
> +	mtspr(SPRN_PSSCR, vcpu->arch.psscr | PSSCR_EC |
> +	      (local_paca->kvm_hstate.fake_suspend << PSSCR_FAKE_SUSPEND_LG));
> +
> +	mtspr(SPRN_HFSCR, vcpu->arch.hfscr);
> +
> +	mtspr(SPRN_SPRG0, vcpu->arch.shregs.sprg0);
> +	mtspr(SPRN_SPRG1, vcpu->arch.shregs.sprg1);
> +	mtspr(SPRN_SPRG2, vcpu->arch.shregs.sprg2);
> +	mtspr(SPRN_SPRG3, vcpu->arch.shregs.sprg3);
> +
> +	mtspr(SPRN_AMOR, ~0UL);
> +
> +	mtspr(SPRN_LPCR, vc->lpcr);
> +	isync();
> +
> +	kvmppc_xive_push_vcpu(vcpu);
> +
> +	mtspr(SPRN_SRR0, vcpu->arch.shregs.srr0);
> +	mtspr(SPRN_SRR1, vcpu->arch.shregs.srr1);
> +
> +	trap =3D __kvmhv_vcpu_entry_p9(vcpu);
> +
> +	/* Advance host PURR/SPURR by the amount used by guest */
> +	purr =3D mfspr(SPRN_PURR);
> +	spurr =3D mfspr(SPRN_SPURR);
> +	mtspr(SPRN_PURR, local_paca->kvm_hstate.host_purr +
> +	      purr - vcpu->arch.purr);
> +	mtspr(SPRN_SPURR, local_paca->kvm_hstate.host_spurr +
> +	      spurr - vcpu->arch.spurr);
> +	vcpu->arch.purr =3D purr;
> +	vcpu->arch.spurr =3D spurr;
> +
> +	vcpu->arch.ic =3D mfspr(SPRN_IC);
> +	vcpu->arch.pid =3D mfspr(SPRN_PID);
> +	vcpu->arch.psscr =3D mfspr(SPRN_PSSCR) & PSSCR_GUEST_VIS;
> +
> +	vcpu->arch.shregs.sprg0 =3D mfspr(SPRN_SPRG0);
> +	vcpu->arch.shregs.sprg1 =3D mfspr(SPRN_SPRG1);
> +	vcpu->arch.shregs.sprg2 =3D mfspr(SPRN_SPRG2);
> +	vcpu->arch.shregs.sprg3 =3D mfspr(SPRN_SPRG3);
> +
> +	mtspr(SPRN_PSSCR, host_psscr);
> +	mtspr(SPRN_HFSCR, host_hfscr);
> +	mtspr(SPRN_CIABR, host_ciabr);
> +	mtspr(SPRN_DAWR, host_dawr);
> +	mtspr(SPRN_DAWRX, host_dawrx);
> +	mtspr(SPRN_PID, host_pidr);
> +
> +	/*
> +	 * Since this is radix, do a eieio; tlbsync; ptesync sequence in
> +	 * case we interrupted the guest between a tlbie and a ptesync.
> +	 */
> +	asm volatile("eieio; tlbsync; ptesync");
> +
> +	mtspr(SPRN_LPID, vcpu->kvm->arch.host_lpid);	/* restore host LPID */
> +	isync();
> +
> +	vc->dpdes =3D mfspr(SPRN_DPDES);
> +	vc->vtb =3D mfspr(SPRN_VTB);
> +	mtspr(SPRN_DPDES, 0);
> +	if (vc->pcr)
> +		mtspr(SPRN_PCR, 0);
> +
> +	if (vc->tb_offset_applied) {
> +		u64 new_tb =3D mftb() - vc->tb_offset_applied;
> +		mtspr(SPRN_TBU40, new_tb);
> +		tb =3D mftb();
> +		if ((tb & 0xffffff) < (new_tb & 0xffffff))
> +			mtspr(SPRN_TBU40, new_tb + 0x1000000);
> +		vc->tb_offset_applied =3D 0;
> +	}
> +
> +	mtspr(SPRN_HDEC, 0x7fffffff);
> +	mtspr(SPRN_LPCR, vcpu->kvm->arch.host_lpcr);
> +
> +	return trap;
> +}
> +
> +/*
> + * Virtual-mode guest entry for POWER9 and later when the host and
> + * guest are both using the radix MMU.  The LPIDR has already been set.
> + */
> +int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit)
> +{
> +	struct kvmppc_vcore *vc =3D vcpu->arch.vcore;
> +	unsigned long host_dscr =3D mfspr(SPRN_DSCR);
> +	unsigned long host_tidr =3D mfspr(SPRN_TIDR);
> +	unsigned long host_iamr =3D mfspr(SPRN_IAMR);
> +	s64 dec;
> +	u64 tb;
> +	int trap, save_pmu;
> +
> +	dec =3D mfspr(SPRN_DEC);
> +	tb =3D mftb();
> +	if (dec < 512)
> +		return BOOK3S_INTERRUPT_HV_DECREMENTER;
> +	local_paca->kvm_hstate.dec_expires =3D dec + tb;
> +	if (local_paca->kvm_hstate.dec_expires < time_limit)
> +		time_limit =3D local_paca->kvm_hstate.dec_expires;
> +
> +	vcpu->arch.ceded =3D 0;
> +
> +	kvmhv_save_host_pmu();		/* saves it to PACA kvm_hstate */
> +
> +	kvmppc_subcore_enter_guest();
> +
> +	vc->entry_exit_map =3D 1;
> +	vc->in_guest =3D 1;
> +
> +	if (vcpu->arch.vpa.pinned_addr) {
> +		struct lppaca *lp =3D vcpu->arch.vpa.pinned_addr;
> +		u32 yield_count =3D be32_to_cpu(lp->yield_count) + 1;
> +		lp->yield_count =3D cpu_to_be32(yield_count);
> +		vcpu->arch.vpa.dirty =3D 1;
> +	}
> +
> +	if (cpu_has_feature(CPU_FTR_TM) ||
> +	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
> +		kvmppc_restore_tm_hv(vcpu, vcpu->arch.shregs.msr, true);
> +
> +	kvmhv_load_guest_pmu(vcpu);
> +
> +	msr_check_and_set(MSR_FP | MSR_VEC | MSR_VSX);
> +	load_fp_state(&vcpu->arch.fp);
> +	load_vr_state(&vcpu->arch.vr);
> +
> +	mtspr(SPRN_DSCR, vcpu->arch.dscr);
> +	mtspr(SPRN_IAMR, vcpu->arch.iamr);
> +	mtspr(SPRN_PSPB, vcpu->arch.pspb);
> +	mtspr(SPRN_FSCR, vcpu->arch.fscr);
> +	mtspr(SPRN_TAR, vcpu->arch.tar);
> +	mtspr(SPRN_EBBHR, vcpu->arch.ebbhr);
> +	mtspr(SPRN_EBBRR, vcpu->arch.ebbrr);
> +	mtspr(SPRN_BESCR, vcpu->arch.bescr);
> +	mtspr(SPRN_WORT, vcpu->arch.wort);
> +	mtspr(SPRN_TIDR, vcpu->arch.tid);
> +	mtspr(SPRN_DAR, vcpu->arch.shregs.dar);
> +	mtspr(SPRN_DSISR, vcpu->arch.shregs.dsisr);
> +	mtspr(SPRN_AMR, vcpu->arch.amr);
> +	mtspr(SPRN_UAMOR, vcpu->arch.uamor);
> +
> +	if (!(vcpu->arch.ctrl & 1))
> +		mtspr(SPRN_CTRLT, mfspr(SPRN_CTRLF) & ~1);
> +
> +	mtspr(SPRN_DEC, vcpu->arch.dec_expires - mftb());
> +
> +	if (vcpu->arch.doorbell_request) {
> +		vc->dpdes =3D 1;
> +		smp_wmb();
> +		vcpu->arch.doorbell_request =3D 0;
> +	}
> +
> +	trap =3D kvmhv_load_hv_regs_and_go(vcpu, time_limit);
> +
> +	vcpu->arch.slb_max =3D 0;
> +	dec =3D mfspr(SPRN_DEC);
> +	tb =3D mftb();
> +	vcpu->arch.dec_expires =3D dec + tb;
> +	vcpu->cpu =3D -1;
> +	vcpu->arch.thread_cpu =3D -1;
> +	vcpu->arch.ctrl =3D mfspr(SPRN_CTRLF);
> +
> +	vcpu->arch.iamr =3D mfspr(SPRN_IAMR);
> +	vcpu->arch.pspb =3D mfspr(SPRN_PSPB);
> +	vcpu->arch.fscr =3D mfspr(SPRN_FSCR);
> +	vcpu->arch.tar =3D mfspr(SPRN_TAR);
> +	vcpu->arch.ebbhr =3D mfspr(SPRN_EBBHR);
> +	vcpu->arch.ebbrr =3D mfspr(SPRN_EBBRR);
> +	vcpu->arch.bescr =3D mfspr(SPRN_BESCR);
> +	vcpu->arch.wort =3D mfspr(SPRN_WORT);
> +	vcpu->arch.tid =3D mfspr(SPRN_TIDR);
> +	vcpu->arch.amr =3D mfspr(SPRN_AMR);
> +	vcpu->arch.uamor =3D mfspr(SPRN_UAMOR);
> +	vcpu->arch.dscr =3D mfspr(SPRN_DSCR);
> +
> +	mtspr(SPRN_PSPB, 0);
> +	mtspr(SPRN_WORT, 0);
> +	mtspr(SPRN_AMR, 0);
> +	mtspr(SPRN_UAMOR, 0);
> +	mtspr(SPRN_DSCR, host_dscr);
> +	mtspr(SPRN_TIDR, host_tidr);
> +	mtspr(SPRN_IAMR, host_iamr);
> +	mtspr(SPRN_PSPB, 0);
> +
> +	msr_check_and_set(MSR_FP | MSR_VEC | MSR_VSX);
> +	store_fp_state(&vcpu->arch.fp);
> +	store_vr_state(&vcpu->arch.vr);
> +
> +	if (cpu_has_feature(CPU_FTR_TM) ||
> +	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
> +		kvmppc_save_tm_hv(vcpu, vcpu->arch.shregs.msr, true);
> +
> +	save_pmu =3D 1;
> +	if (vcpu->arch.vpa.pinned_addr) {
> +		struct lppaca *lp =3D vcpu->arch.vpa.pinned_addr;
> +		u32 yield_count =3D be32_to_cpu(lp->yield_count) + 1;
> +		lp->yield_count =3D cpu_to_be32(yield_count);
> +		vcpu->arch.vpa.dirty =3D 1;
> +		save_pmu =3D lp->pmcregs_in_use;
> +	}
> +
> +	kvmhv_save_guest_pmu(vcpu, save_pmu);
> +
> +	vc->entry_exit_map =3D 0x101;
> +	vc->in_guest =3D 0;
> +
> +	mtspr(SPRN_DEC, local_paca->kvm_hstate.dec_expires - mftb());
> +
> +	kvmhv_load_host_pmu();
> +
> +	kvmppc_subcore_exit_guest();
> +
> +	return trap;
> +}
> +
> +/*
>   * Wait for some other vcpu thread to execute us, and
>   * wake us up when we need to handle something in the host.
>   */
> @@ -3405,6 +3668,167 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_ru=
n, struct kvm_vcpu *vcpu)
>  	return vcpu->arch.ret;
>  }
> =20
> +static int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
> +				 struct kvm_vcpu *vcpu, u64 time_limit)
> +{
> +	int trap, r, pcpu, pcpu0;
> +	int srcu_idx;
> +	struct kvmppc_vcore *vc;
> +	struct kvm *kvm =3D vcpu->kvm;
> +
> +	trace_kvmppc_run_vcpu_enter(vcpu);
> +
> +	kvm_run->exit_reason =3D 0;
> +	vcpu->arch.ret =3D RESUME_GUEST;
> +	vcpu->arch.trap =3D 0;
> +
> +	vc =3D vcpu->arch.vcore;
> +	vcpu->arch.ceded =3D 0;
> +	vcpu->arch.run_task =3D current;
> +	vcpu->arch.kvm_run =3D kvm_run;
> +	vcpu->arch.stolen_logged =3D vcore_stolen_time(vc, mftb());
> +	vcpu->arch.state =3D KVMPPC_VCPU_RUNNABLE;
> +	vcpu->arch.busy_preempt =3D TB_NIL;
> +	vcpu->arch.last_inst =3D KVM_INST_FETCH_FAILED;
> +	vc->runnable_threads[0] =3D vcpu;
> +	vc->n_runnable =3D 1;
> +	vc->runner =3D vcpu;
> +
> +	/* See if the MMU is ready to go */
> +	if (!kvm->arch.mmu_ready) {
> +		r =3D kvmhv_setup_mmu(vcpu);
> +		if (r) {
> +			kvm_run->exit_reason =3D KVM_EXIT_FAIL_ENTRY;
> +			kvm_run->fail_entry.
> +				hardware_entry_failure_reason =3D 0;
> +			vcpu->arch.ret =3D r;
> +			goto out;
> +		}
> +	}
> +
> +	if (need_resched())
> +		cond_resched();
> +
> +	kvmppc_update_vpas(vcpu);
> +
> +	init_vcore_to_run(vc);
> +	vc->preempt_tb =3D TB_NIL;
> +
> +	preempt_disable();
> +	pcpu =3D smp_processor_id();
> +	vc->pcpu =3D pcpu;
> +	kvmppc_prepare_radix_vcpu(vcpu, pcpu);
> +
> +	local_irq_disable();
> +	hard_irq_disable();
> +	if (signal_pending(current))
> +		goto sigpend;
> +	if (lazy_irq_pending() || need_resched() || !kvm->arch.mmu_ready)
> +		goto out;
> +
> +	kvmppc_core_prepare_to_enter(vcpu);
> +
> +	kvmppc_clear_host_core(pcpu);
> +
> +	local_paca->kvm_hstate.tid =3D 0;
> +	local_paca->kvm_hstate.napping =3D 0;
> +	local_paca->kvm_hstate.kvm_split_mode =3D NULL;
> +	kvmppc_start_thread(vcpu, vc);
> +	kvmppc_create_dtl_entry(vcpu, vc);
> +	trace_kvm_guest_enter(vcpu);
> +
> +	vc->vcore_state =3D VCORE_RUNNING;
> +	trace_kvmppc_run_core(vc, 0);
> +
> +	mtspr(SPRN_LPID, vc->kvm->arch.lpid);
> +	isync();
> +
> +	/* See comment above in kvmppc_run_core() about this */
> +	pcpu0 =3D pcpu;
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		pcpu0 &=3D ~0x3UL;
> +
> +	if (cpumask_test_cpu(pcpu0, &kvm->arch.need_tlb_flush)) {
> +		radix__local_flush_tlb_lpid_guest(kvm->arch.lpid);
> +		/* Clear the bit after the TLB flush */
> +		cpumask_clear_cpu(pcpu0, &kvm->arch.need_tlb_flush);
> +	}
> +
> +	trace_hardirqs_on();
> +	guest_enter_irqoff();
> +
> +	srcu_idx =3D srcu_read_lock(&kvm->srcu);
> +
> +	this_cpu_disable_ftrace();
> +
> +	trap =3D kvmhv_p9_guest_entry(vcpu, time_limit);
> +	vcpu->arch.trap =3D trap;
> +
> +	this_cpu_enable_ftrace();
> +
> +	srcu_read_unlock(&kvm->srcu, srcu_idx);
> +
> +	mtspr(SPRN_LPID, kvm->arch.host_lpid);
> +	isync();
> +
> +	trace_hardirqs_off();
> +	set_irq_happened(trap);
> +
> +	kvmppc_set_host_core(pcpu);
> +
> +	local_irq_enable();
> +	guest_exit();
> +
> +	cpumask_clear_cpu(pcpu, &kvm->arch.cpu_in_guest);
> +
> +	preempt_enable();
> +
> +	/* cancel pending decrementer exception if DEC is now positive */
> +	if (get_tb() < vcpu->arch.dec_expires && kvmppc_core_pending_dec(vcpu))
> +		kvmppc_core_dequeue_dec(vcpu);
> +
> +	trace_kvm_guest_exit(vcpu);
> +	r =3D RESUME_GUEST;
> +	if (trap)
> +		r =3D kvmppc_handle_exit_hv(kvm_run, vcpu, current);
> +	vcpu->arch.ret =3D r;
> +
> +	if (is_kvmppc_resume_guest(r) && vcpu->arch.ceded &&
> +	    !kvmppc_vcpu_woken(vcpu)) {
> +		kvmppc_set_timer(vcpu);
> +		while (vcpu->arch.ceded && !kvmppc_vcpu_woken(vcpu)) {
> +			if (signal_pending(current)) {
> +				vcpu->stat.signal_exits++;
> +				kvm_run->exit_reason =3D KVM_EXIT_INTR;
> +				vcpu->arch.ret =3D -EINTR;
> +				break;
> +			}
> +			spin_lock(&vc->lock);
> +			kvmppc_vcore_blocked(vc);
> +			spin_unlock(&vc->lock);
> +		}
> +	}
> +	vcpu->arch.ceded =3D 0;
> +
> +	vc->vcore_state =3D VCORE_INACTIVE;
> +	trace_kvmppc_run_core(vc, 1);
> +
> + done:
> +	kvmppc_remove_runnable(vc, vcpu);
> +	trace_kvmppc_run_vcpu_exit(vcpu, kvm_run);
> +
> +	return vcpu->arch.ret;
> +
> + sigpend:
> +	vcpu->stat.signal_exits++;
> +	kvm_run->exit_reason =3D KVM_EXIT_INTR;
> +	vcpu->arch.ret =3D -EINTR;
> + out:
> +	local_irq_enable();
> +	preempt_enable();
> +	goto done;
> +}
> +
>  static int kvmppc_vcpu_run_hv(struct kvm_run *run, struct kvm_vcpu *vcpu)
>  {
>  	int r;
> @@ -3480,7 +3904,10 @@ static int kvmppc_vcpu_run_hv(struct kvm_run *run,=
 struct kvm_vcpu *vcpu)
>  	vcpu->arch.state =3D KVMPPC_VCPU_BUSY_IN_HOST;
> =20
>  	do {
> -		r =3D kvmppc_run_vcpu(run, vcpu);
> +		if (kvm->arch.threads_indep && kvm_is_radix(kvm))
> +			r =3D kvmhv_run_single_vcpu(run, vcpu, ~(u64)0);
> +		else
> +			r =3D kvmppc_run_vcpu(run, vcpu);
> =20
>  		if (run->exit_reason =3D=3D KVM_EXIT_PAPR_HCALL &&
>  		    !(vcpu->arch.shregs.msr & MSR_PR)) {
> diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_h=
v_ras.c
> index ee564b6..0787f12 100644
> --- a/arch/powerpc/kvm/book3s_hv_ras.c
> +++ b/arch/powerpc/kvm/book3s_hv_ras.c
> @@ -177,6 +177,7 @@ void kvmppc_subcore_enter_guest(void)
> =20
>  	local_paca->sibling_subcore_state->in_guest[subcore_id] =3D 1;
>  }
> +EXPORT_SYMBOL_GPL(kvmppc_subcore_enter_guest);
> =20
>  void kvmppc_subcore_exit_guest(void)
>  {
> @@ -187,6 +188,7 @@ void kvmppc_subcore_exit_guest(void)
> =20
>  	local_paca->sibling_subcore_state->in_guest[subcore_id] =3D 0;
>  }
> +EXPORT_SYMBOL_GPL(kvmppc_subcore_exit_guest);
> =20
>  static bool kvmppc_tb_resync_required(void)
>  {
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/b=
ook3s_hv_rmhandlers.S
> index 45dd637..ea84696 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -47,8 +47,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>  #define NAPPING_NOVCPU	2
> =20
>  /* Stack frame offsets for kvmppc_hv_entry */
> -#define SFS			160
> +#define SFS			208
>  #define STACK_SLOT_TRAP		(SFS-4)
> +#define STACK_SLOT_SHORT_PATH	(SFS-8)
>  #define STACK_SLOT_TID		(SFS-16)
>  #define STACK_SLOT_PSSCR	(SFS-24)
>  #define STACK_SLOT_PID		(SFS-32)
> @@ -57,6 +58,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>  #define STACK_SLOT_DAWR		(SFS-56)
>  #define STACK_SLOT_DAWRX	(SFS-64)
>  #define STACK_SLOT_HFSCR	(SFS-72)
> +/* the following is used by the P9 short path */
> +#define STACK_SLOT_NVGPRS	(SFS-152)	/* 18 gprs */
> =20
>  /*
>   * Call kvmppc_hv_entry in real mode.
> @@ -1020,6 +1023,9 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
>  no_xive:
>  #endif /* CONFIG_KVM_XICS */
> =20
> +	li	r0, 0
> +	stw	r0, STACK_SLOT_SHORT_PATH(r1)
> +
>  deliver_guest_interrupt:	/* r4 =3D vcpu, r13 =3D paca */
>  	/* Check if we can deliver an external or decrementer interrupt now */
>  	ld	r0, VCPU_PENDING_EXC(r4)
> @@ -1034,13 +1040,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  	bl	kvmppc_guest_entry_inject_int
>  	ld	r4, HSTATE_KVM_VCPU(r13)
>  71:
> -	ld	r10, VCPU_PC(r4)
> -	ld	r11, VCPU_MSR(r4)
>  	ld	r6, VCPU_SRR0(r4)
>  	ld	r7, VCPU_SRR1(r4)
>  	mtspr	SPRN_SRR0, r6
>  	mtspr	SPRN_SRR1, r7
> =20
> +fast_guest_entry_c:
> +	ld	r10, VCPU_PC(r4)
> +	ld	r11, VCPU_MSR(r4)
>  	/* r11 =3D vcpu->arch.msr & ~MSR_HV */
>  	rldicl	r11, r11, 63 - MSR_HV_LG, 1
>  	rotldi	r11, r11, 1 + MSR_HV_LG
> @@ -1117,6 +1124,83 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  	HRFI_TO_GUEST
>  	b	.
> =20
> +/*
> + * Enter the guest on a P9 or later system where we have exactly
> + * one vcpu per vcore and we don't need to go to real mode
> + * (which implies that host and guest are both using radix MMU mode).
> + * r3 =3D vcpu pointer
> + * Most SPRs and all the VSRs have been loaded already.
> + */
> +_GLOBAL(__kvmhv_vcpu_entry_p9)
> +EXPORT_SYMBOL_GPL(__kvmhv_vcpu_entry_p9)
> +	mflr	r0
> +	std	r0, PPC_LR_STKOFF(r1)
> +	stdu	r1, -SFS(r1)
> +
> +	li	r0, 1
> +	stw	r0, STACK_SLOT_SHORT_PATH(r1)
> +
> +	std	r3, HSTATE_KVM_VCPU(r13)
> +	mfcr	r4
> +	stw	r4, SFS+8(r1)
> +
> +	std	r1, HSTATE_HOST_R1(r13)
> +
> +	reg =3D 14
> +	.rept	18
> +	std	reg, STACK_SLOT_NVGPRS + ((reg - 14) * 8)(r1)
> +	reg =3D reg + 1
> +	.endr
> +
> +	reg =3D 14
> +	.rept	18
> +	ld	reg, __VCPU_GPR(reg)(r3)
> +	reg =3D reg + 1
> +	.endr
> +
> +	mfmsr	r10
> +	std	r10, HSTATE_HOST_MSR(r13)
> +
> +	mr	r4, r3
> +	b	fast_guest_entry_c
> +guest_exit_short_path:
> +
> +	li	r0, KVM_GUEST_MODE_NONE
> +	stb	r0, HSTATE_IN_GUEST(r13)
> +
> +	reg =3D 14
> +	.rept	18
> +	std	reg, __VCPU_GPR(reg)(r9)
> +	reg =3D reg + 1
> +	.endr
> +
> +	reg =3D 14
> +	.rept	18
> +	ld	reg, STACK_SLOT_NVGPRS + ((reg - 14) * 8)(r1)
> +	reg =3D reg + 1
> +	.endr
> +
> +	lwz	r4, SFS+8(r1)
> +	mtcr	r4
> +
> +	mr	r3, r12		/* trap number */
> +
> +	addi	r1, r1, SFS
> +	ld	r0, PPC_LR_STKOFF(r1)
> +	mtlr	r0
> +
> +	/* If we are in real mode, do a rfid to get back to the caller */
> +	mfmsr	r4
> +	andi.	r5, r4, MSR_IR
> +	bnelr
> +	rldicl	r5, r4, 64 - MSR_TS_S_LG, 62	/* extract TS field */
> +	mtspr	SPRN_SRR0, r0
> +	ld	r10, HSTATE_HOST_MSR(r13)
> +	rldimi	r10, r5, MSR_TS_S_LG, 63 - MSR_TS_T_LG
> +	mtspr	SPRN_SRR1, r10
> +	RFI_TO_KERNEL
> +	b	.
> +
>  secondary_too_late:
>  	li	r12, 0
>  	stw	r12, STACK_SLOT_TRAP(r1)
> @@ -1377,6 +1461,11 @@ guest_exit_cont:		/* r9 =3D vcpu, r12 =3D trap, r1=
3 =3D paca */
>  1:
>  #endif /* CONFIG_KVM_XICS */
> =20
> +	/* If we came in through the P9 short path, go back out to C now */
> +	lwz	r0, STACK_SLOT_SHORT_PATH(r1)
> +	cmpwi	r0, 0
> +	bne	guest_exit_short_path
> +
>  	/* For hash guest, read the guest SLB and save it away */
>  	ld	r5, VCPU_KVM(r9)
>  	lbz	r0, KVM_RADIX(r5)
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xiv=
e.c
> index 30c2eb7..ad4a370 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -62,6 +62,69 @@
>  #define XIVE_Q_GAP	2
> =20
>  /*
> + * Push a vcpu's context to the XIVE on guest entry.
> + * This assumes we are in virtual mode (MMU on)
> + */
> +void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu)
> +{
> +	void __iomem *tima =3D local_paca->kvm_hstate.xive_tima_virt;
> +	u64 pq;
> +
> +	if (!tima)
> +		return;
> +	eieio();
> +	__raw_writeq(vcpu->arch.xive_saved_state.w01, tima + TM_QW1_OS);
> +	__raw_writel(vcpu->arch.xive_cam_word, tima + TM_QW1_OS + TM_WORD2);
> +	vcpu->arch.xive_pushed =3D 1;
> +	eieio();
> +
> +	/*
> +	 * We clear the irq_pending flag. There is a small chance of a
> +	 * race vs. the escalation interrupt happening on another
> +	 * processor setting it again, but the only consequence is to
> +	 * cause a spurious wakeup on the next H_CEDE, which is not an
> +	 * issue.
> +	 */
> +	vcpu->arch.irq_pending =3D 0;
> +
> +	/*
> +	 * In single escalation mode, if the escalation interrupt is
> +	 * on, we mask it.
> +	 */
> +	if (vcpu->arch.xive_esc_on) {
> +		pq =3D __raw_readq((void __iomem *)(vcpu->arch.xive_esc_vaddr +
> +						  XIVE_ESB_SET_PQ_01));
> +		mb();
> +
> +		/*
> +		 * We have a possible subtle race here: The escalation
> +		 * interrupt might have fired and be on its way to the
> +		 * host queue while we mask it, and if we unmask it
> +		 * early enough (re-cede right away), there is a
> +		 * theorical possibility that it fires again, thus
> +		 * landing in the target queue more than once which is
> +		 * a big no-no.
> +		 *
> +		 * Fortunately, solving this is rather easy. If the
> +		 * above load setting PQ to 01 returns a previous
> +		 * value where P is set, then we know the escalation
> +		 * interrupt is somewhere on its way to the host. In
> +		 * that case we simply don't clear the xive_esc_on
> +		 * flag below. It will be eventually cleared by the
> +		 * handler for the escalation interrupt.
> +		 *
> +		 * Then, when doing a cede, we check that flag again
> +		 * before re-enabling the escalation interrupt, and if
> +		 * set, we abort the cede.
> +		 */
> +		if (!(pq & XIVE_ESB_VAL_P))
> +			/* Now P is 0, we can clear the flag */
> +			vcpu->arch.xive_esc_on =3D 0;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_xive_push_vcpu);
> +
> +/*
>   * This is a simple trigger for a generic XIVE IRQ. This must
>   * only be called for interrupts that support a trigger page
>   */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aPOcx+xoD6gZZHnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu79FgACgkQbDjKyiDZ
s5JznxAAkUVsY3iwsb+CX9V8FBPKZ3ns/UaWp/3++n1QGzwmQCFpWYAOwXp2/Uvs
qNrvBvzo6AprOrXmZChlnlNZv9mk4o96J2loC0+//OtkZT3IU8d56Sl0/s9eyZCM
CCiua3dfP3lNjDmicqmeVjIZcMfFyGUmLEeOcv27O+0yFUs39xeR01LSg5AKHdkA
okzOkbuBTv3UBUyPioVO5Gpyul5uy2adDBxLJvNNFaTNjrCq6tq5Fv6fe6Vhg7Xb
hkywDxFHWDELWeWMRywLxwWIpnW26tQ1SmuUVFtLnTOEaZpY/0cJWy8Sft/svlwn
NeKc8Uptxy69eLWpDlKhOp4qT4CrD32l1PlM7Zla2sXxe94jj00XTi9LOuta5Hok
PMHPWT/XFuT7EFT20PInkApQr7xHV8oLD/y5xP4YOWYyhkFhTDQw2+BdUjwUWEes
3lauv6/ASmRdzzwbreypUJo4Hvxchcb4udpFN1+eQ93fPADHszG45g1HP3IoN+a2
wN6brBAJ57re/KFoChf7Os/++c86MedGRd8Nu8JQ0NiWh+3ykQ/xcPRMw1NNIvou
CeBlLYKPEPsZvrWnZJwYYw1zcCBDMXvE1h4xi0rK1qwOYGbRNaFb7Ar6XB6srvQ3
oAyltFcr1a8ZW+QhURfgx2gZ+z8mqyZUG3DrwKDDtAOH9+9wEOE=
=w7zK
-----END PGP SIGNATURE-----

--aPOcx+xoD6gZZHnz--
