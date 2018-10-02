Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F2EC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 06:12:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA4AD20878
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 06:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EseNXcaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4AD20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PTN55qc8zF3D0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 16:12:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EseNXcaO";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PT7W0nL1zF38F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 16:01:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="EseNXcaO"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PT7V74Q0z9sj6; Tue,  2 Oct 2018 16:01:58 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42PT7V6Mxbz9shw; Tue,  2 Oct 2018 16:01:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538460118;
 bh=qu4PLBh3rxKKkLrfGWsxEqrom2K+MoVBWwzVTo02hAc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EseNXcaO/hwDAYPGokVD/jYPHlPP0xhB4w5qhi7oWBHB7s8evcQ1ZMnWO0Sc0kpik
 ch/raFSXaJZ97BpLOXNMkcolR8EPqnuuJYvEJR9f+sRypg2VFYgfYV0jfRT13t+xfc
 ySRUyStv845p6v0dMIPBXAE4gAbZBN5VrJtZoVek=
Date: Tue, 2 Oct 2018 15:15:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v2 06/33] KVM: PPC: Book3S: Rework TM save/restore code
 and make it C-callable
Message-ID: <20181002051541.GH1886@umbus.fritz.box>
References: <1538127963-15645-1-git-send-email-paulus@ozlabs.org>
 <1538127963-15645-7-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dDnEQgWzhgf+8aPe"
Content-Disposition: inline
In-Reply-To: <1538127963-15645-7-git-send-email-paulus@ozlabs.org>
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


--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 07:45:36PM +1000, Paul Mackerras wrote:
> This adds a parameter to __kvmppc_save_tm and __kvmppc_restore_tm
> which allows the caller to indicate whether it wants the nonvolatile
> register state to be preserved across the call, as required by the C
> calling conventions.  This parameter being non-zero also causes the
> MSR bits that enable TM, FP, VMX and VSX to be preserved.  The
> condition register and DSCR are now always preserved.
>=20
> With this, kvmppc_save_tm_hv and kvmppc_restore_tm_hv can be called
> from C code provided the 3rd parameter is non-zero.  So that these
> functions can be called from modules, they now include code to set
> the TOC pointer (r2) on entry, as they can call other built-in C
> functions which will assume the TOC to have been set.
>=20
> Also, the fake suspend code in kvmppc_save_tm_hv is modified here to
> assume that treclaim in fake-suspend state does not modify any registers,
> which is the case on POWER9.  This enables the code to be simplified
> quite a bit.
>=20
> _kvmppc_save_tm_pr and _kvmppc_restore_tm_pr become much simpler with
> this change, since they now only need to save and restore TAR and pass
> 1 for the 3rd argument to __kvmppc_{save,restore}_tm.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/asm-prototypes.h |  10 ++
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  49 +++---
>  arch/powerpc/kvm/tm.S                     | 250 ++++++++++++++++--------=
------
>  3 files changed, 169 insertions(+), 140 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/inc=
lude/asm/asm-prototypes.h
> index 024e8fc..0c1a2b0 100644
> --- a/arch/powerpc/include/asm/asm-prototypes.h
> +++ b/arch/powerpc/include/asm/asm-prototypes.h
> @@ -150,6 +150,16 @@ extern s32 patch__memset_nocache, patch__memcpy_noca=
che;
> =20
>  extern long flush_count_cache;
> =20
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +void kvmppc_save_tm_hv(struct kvm_vcpu *vcpu, u64 msr, bool preserve_nv);
> +void kvmppc_restore_tm_hv(struct kvm_vcpu *vcpu, u64 msr, bool preserve_=
nv);
> +#else
> +static inline void kvmppc_save_tm_hv(struct kvm_vcpu *vcpu, u64 msr,
> +				     bool preserve_nv) { }
> +static inline void kvmppc_restore_tm_hv(struct kvm_vcpu *vcpu, u64 msr,
> +					bool preserve_nv) { }
> +#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> +
>  void kvmhv_save_host_pmu(void);
>  void kvmhv_load_host_pmu(void);
>  void kvmhv_save_guest_pmu(struct kvm_vcpu *vcpu, bool pmu_in_use);
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/b=
ook3s_hv_rmhandlers.S
> index 772740d..67a847f 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -759,11 +759,13 @@ BEGIN_FTR_SECTION
>  	b	91f
>  END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
>  	/*
> -	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
> +	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS (but not CR)
>  	 */
>  	mr      r3, r4
>  	ld      r4, VCPU_MSR(r3)
> +	li	r5, 0			/* don't preserve non-vol regs */
>  	bl	kvmppc_restore_tm_hv
> +	nop
>  	ld	r4, HSTATE_KVM_VCPU(r13)
>  91:
>  #endif
> @@ -1603,11 +1605,13 @@ BEGIN_FTR_SECTION
>  	b	91f
>  END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
>  	/*
> -	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
> +	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS (but not CR)
>  	 */
>  	mr      r3, r9
>  	ld      r4, VCPU_MSR(r3)
> +	li	r5, 0			/* don't preserve non-vol regs */
>  	bl	kvmppc_save_tm_hv
> +	nop
>  	ld	r9, HSTATE_KVM_VCPU(r13)
>  91:
>  #endif
> @@ -2486,11 +2490,13 @@ BEGIN_FTR_SECTION
>  	b	91f
>  END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
>  	/*
> -	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
> +	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS (but not CR)
>  	 */
>  	ld	r3, HSTATE_KVM_VCPU(r13)
>  	ld      r4, VCPU_MSR(r3)
> +	li	r5, 0			/* don't preserve non-vol regs */
>  	bl	kvmppc_save_tm_hv
> +	nop
>  91:
>  #endif
> =20
> @@ -2606,11 +2612,13 @@ BEGIN_FTR_SECTION
>  	b	91f
>  END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
>  	/*
> -	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
> +	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS (but not CR)
>  	 */
>  	mr      r3, r4
>  	ld      r4, VCPU_MSR(r3)
> +	li	r5, 0			/* don't preserve non-vol regs */
>  	bl	kvmppc_restore_tm_hv
> +	nop
>  	ld	r4, HSTATE_KVM_VCPU(r13)
>  91:
>  #endif
> @@ -2943,10 +2951,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
>   * Save transactional state and TM-related registers.
>   * Called with r3 pointing to the vcpu struct and r4 containing
>   * the guest MSR value.
> - * This can modify all checkpointed registers, but
> + * r5 is non-zero iff non-volatile register state needs to be maintained.
> + * If r5 =3D=3D 0, this can modify all checkpointed registers, but
>   * restores r1 and r2 before exit.
>   */
> -kvmppc_save_tm_hv:
> +_GLOBAL_TOC(kvmppc_save_tm_hv)
> +EXPORT_SYMBOL_GPL(kvmppc_save_tm_hv)
>  	/* See if we need to handle fake suspend mode */
>  BEGIN_FTR_SECTION
>  	b	__kvmppc_save_tm
> @@ -2974,12 +2984,6 @@ BEGIN_FTR_SECTION
>  END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_XER_SO_BUG)
>  	nop
> =20
> -	std	r1, HSTATE_HOST_R1(r13)
> -
> -	/* Clear the MSR RI since r1, r13 may be foobar. */
> -	li	r5, 0
> -	mtmsrd	r5, 1
> -
>  	/* We have to treclaim here because that's the only way to do S->N */
>  	li	r3, TM_CAUSE_KVM_RESCHED
>  	TRECLAIM(R3)
> @@ -2988,22 +2992,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_XER_SO_BUG)
>  	 * We were in fake suspend, so we are not going to save the
>  	 * register state as the guest checkpointed state (since
>  	 * we already have it), therefore we can now use any volatile GPR.
> +	 * In fact treclaim in fake suspend state doesn't modify
> +	 * any registers.
>  	 */
> -	/* Reload PACA pointer, stack pointer and TOC. */
> -	GET_PACA(r13)
> -	ld	r1, HSTATE_HOST_R1(r13)
> -	ld	r2, PACATOC(r13)
> =20
> -	/* Set MSR RI now we have r1 and r13 back. */
> -	li	r5, MSR_RI
> -	mtmsrd	r5, 1
> -
> -	HMT_MEDIUM
> -	ld	r6, HSTATE_DSCR(r13)
> -	mtspr	SPRN_DSCR, r6
> -BEGIN_FTR_SECTION_NESTED(96)
> +BEGIN_FTR_SECTION
>  	bl	pnv_power9_force_smt4_release
> -END_FTR_SECTION_NESTED(CPU_FTR_P9_TM_XER_SO_BUG, CPU_FTR_P9_TM_XER_SO_BU=
G, 96)
> +END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_XER_SO_BUG)
>  	nop
> =20
>  4:
> @@ -3029,10 +3024,12 @@ END_FTR_SECTION_NESTED(CPU_FTR_P9_TM_XER_SO_BUG, =
CPU_FTR_P9_TM_XER_SO_BUG, 96)
>   * Restore transactional state and TM-related registers.
>   * Called with r3 pointing to the vcpu struct
>   * and r4 containing the guest MSR value.
> + * r5 is non-zero iff non-volatile register state needs to be maintained.
>   * This potentially modifies all checkpointed registers.
>   * It restores r1 and r2 from the PACA.
>   */
> -kvmppc_restore_tm_hv:
> +_GLOBAL_TOC(kvmppc_restore_tm_hv)
> +EXPORT_SYMBOL_GPL(kvmppc_restore_tm_hv)
>  	/*
>  	 * If we are doing TM emulation for the guest on a POWER9 DD2,
>  	 * then we don't actually do a trechkpt -- we either set up
> diff --git a/arch/powerpc/kvm/tm.S b/arch/powerpc/kvm/tm.S
> index 90e330f..0531a14 100644
> --- a/arch/powerpc/kvm/tm.S
> +++ b/arch/powerpc/kvm/tm.S
> @@ -28,17 +28,25 @@
>   * Save transactional state and TM-related registers.
>   * Called with:
>   * - r3 pointing to the vcpu struct
> - * - r4 points to the MSR with current TS bits:
> + * - r4 containing the MSR with current TS bits:
>   * 	(For HV KVM, it is VCPU_MSR ; For PR KVM, it is host MSR).
> - * This can modify all checkpointed registers, but
> - * restores r1, r2 before exit.
> + * - r5 containing a flag indicating that non-volatile registers
> + *	must be preserved.
> + * If r5 =3D=3D 0, this can modify all checkpointed registers, but
> + * restores r1, r2 before exit.  If r5 !=3D 0, this restores the
> + * MSR TM/FP/VEC/VSX bits to their state on entry.
>   */
>  _GLOBAL(__kvmppc_save_tm)
>  	mflr	r0
>  	std	r0, PPC_LR_STKOFF(r1)
> +	stdu    r1, -SWITCH_FRAME_SIZE(r1)
> +
> +	mr	r9, r3
> +	cmpdi	cr7, r5, 0
> =20
>  	/* Turn on TM. */
>  	mfmsr	r8
> +	mr	r10, r8
>  	li	r0, 1
>  	rldimi	r8, r0, MSR_TM_LG, 63-MSR_TM_LG
>  	ori     r8, r8, MSR_FP
> @@ -51,6 +59,27 @@ _GLOBAL(__kvmppc_save_tm)
>  	std	r1, HSTATE_SCRATCH2(r13)
>  	std	r3, HSTATE_SCRATCH1(r13)
> =20
> +	/* Save CR on the stack - even if r5 =3D=3D 0 we need to get cr7 back. =
*/
> +	mfcr	r6
> +	SAVE_GPR(6, r1)
> +
> +	/* Save DSCR so we can restore it to avoid running with user value */
> +	mfspr	r7, SPRN_DSCR
> +	SAVE_GPR(7, r1)
> +
> +	/*
> +	 * We are going to do treclaim., which will modify all checkpointed
> +	 * registers.  Save the non-volatile registers on the stack if
> +	 * preservation of non-volatile state has been requested.
> +	 */
> +	beq	cr7, 3f
> +	SAVE_NVGPRS(r1)
> +
> +	/* MSR[TS] will be 0 (non-transactional) once we do treclaim. */
> +	li	r0, 0
> +	rldimi	r10, r0, MSR_TS_S_LG, 63 - MSR_TS_T_LG
> +	SAVE_GPR(10, r1)	/* final MSR value */
> +3:
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  BEGIN_FTR_SECTION
>  	/* Emulation of the treclaim instruction needs TEXASR before treclaim */
> @@ -74,22 +103,25 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
>  	std	r9, PACATMSCRATCH(r13)
>  	ld	r9, HSTATE_SCRATCH1(r13)
> =20
> -	/* Get a few more GPRs free. */
> -	std	r29, VCPU_GPRS_TM(29)(r9)
> -	std	r30, VCPU_GPRS_TM(30)(r9)
> -	std	r31, VCPU_GPRS_TM(31)(r9)
> -
> -	/* Save away PPR and DSCR soon so don't run with user values. */
> -	mfspr	r31, SPRN_PPR
> +	/* Save away PPR soon so we don't run with user value. */
> +	std	r0, VCPU_GPRS_TM(0)(r9)
> +	mfspr	r0, SPRN_PPR
>  	HMT_MEDIUM
> -	mfspr	r30, SPRN_DSCR
> -#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> -	ld	r29, HSTATE_DSCR(r13)
> -	mtspr	SPRN_DSCR, r29
> -#endif
> =20
> -	/* Save all but r9, r13 & r29-r31 */
> -	reg =3D 0
> +	/* Reload stack pointer. */
> +	std	r1, VCPU_GPRS_TM(1)(r9)
> +	ld	r1, HSTATE_SCRATCH2(r13)
> +
> +	/* Set MSR RI now we have r1 and r13 back. */
> +	std	r2, VCPU_GPRS_TM(2)(r9)
> +	li	r2, MSR_RI
> +	mtmsrd	r2, 1
> +
> +	/* Reload TOC pointer. */
> +	ld	r2, PACATOC(r13)
> +
> +	/* Save all but r0-r2, r9 & r13 */
> +	reg =3D 3
>  	.rept	29
>  	.if (reg !=3D 9) && (reg !=3D 13)
>  	std	reg, VCPU_GPRS_TM(reg)(r9)
> @@ -103,33 +135,29 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
>  	ld	r4, PACATMSCRATCH(r13)
>  	std	r4, VCPU_GPRS_TM(9)(r9)
> =20
> -	/* Reload stack pointer and TOC. */
> -	ld	r1, HSTATE_SCRATCH2(r13)
> -	ld	r2, PACATOC(r13)
> -
> -	/* Set MSR RI now we have r1 and r13 back. */
> -	li	r5, MSR_RI
> -	mtmsrd	r5, 1
> +	/* Restore host DSCR and CR values, after saving guest values */
> +	mfcr	r6
> +	mfspr	r7, SPRN_DSCR
> +	stw	r6, VCPU_CR_TM(r9)
> +	std	r7, VCPU_DSCR_TM(r9)
> +	REST_GPR(6, r1)
> +	REST_GPR(7, r1)
> +	mtcr	r6
> +	mtspr	SPRN_DSCR, r7
> =20
> -	/* Save away checkpinted SPRs. */
> -	std	r31, VCPU_PPR_TM(r9)
> -	std	r30, VCPU_DSCR_TM(r9)
> +	/* Save away checkpointed SPRs. */
> +	std	r0, VCPU_PPR_TM(r9)
>  	mflr	r5
> -	mfcr	r6
>  	mfctr	r7
>  	mfspr	r8, SPRN_AMR
>  	mfspr	r10, SPRN_TAR
>  	mfxer	r11
>  	std	r5, VCPU_LR_TM(r9)
> -	stw	r6, VCPU_CR_TM(r9)
>  	std	r7, VCPU_CTR_TM(r9)
>  	std	r8, VCPU_AMR_TM(r9)
>  	std	r10, VCPU_TAR_TM(r9)
>  	std	r11, VCPU_XER_TM(r9)
> =20
> -	/* Restore r12 as trap number. */
> -	lwz	r12, VCPU_TRAP(r9)
> -
>  	/* Save FP/VSX. */
>  	addi	r3, r9, VCPU_FPRS_TM
>  	bl	store_fp_state
> @@ -137,6 +165,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
>  	bl	store_vr_state
>  	mfspr	r6, SPRN_VRSAVE
>  	stw	r6, VCPU_VRSAVE_TM(r9)
> +
> +	/* Restore non-volatile registers if requested to */
> +	beq	cr7, 1f
> +	REST_NVGPRS(r1)
> +	REST_GPR(10, r1)
>  1:
>  	/*
>  	 * We need to save these SPRs after the treclaim so that the software
> @@ -146,12 +179,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
>  	 */
>  	mfspr	r7, SPRN_TEXASR
>  	std	r7, VCPU_TEXASR(r9)
> -11:
>  	mfspr	r5, SPRN_TFHAR
>  	mfspr	r6, SPRN_TFIAR
>  	std	r5, VCPU_TFHAR(r9)
>  	std	r6, VCPU_TFIAR(r9)
> =20
> +	/* Restore MSR state if requested */
> +	beq	cr7, 2f
> +	mtmsrd	r10, 0
> +2:
> +	addi	r1, r1, SWITCH_FRAME_SIZE
>  	ld	r0, PPC_LR_STKOFF(r1)
>  	mtlr	r0
>  	blr
> @@ -161,49 +198,22 @@ END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
>   * be invoked from C function by PR KVM only.
>   */
>  _GLOBAL(_kvmppc_save_tm_pr)
> -	mflr	r5
> -	std	r5, PPC_LR_STKOFF(r1)
> -	stdu    r1, -SWITCH_FRAME_SIZE(r1)
> -	SAVE_NVGPRS(r1)
> -
> -	/* save MSR since TM/math bits might be impacted
> -	 * by __kvmppc_save_tm().
> -	 */
> -	mfmsr	r5
> -	SAVE_GPR(5, r1)
> -
> -	/* also save DSCR/CR/TAR so that it can be recovered later */
> -	mfspr   r6, SPRN_DSCR
> -	SAVE_GPR(6, r1)
> -
> -	mfcr    r7
> -	stw     r7, _CCR(r1)
> +	mflr	r0
> +	std	r0, PPC_LR_STKOFF(r1)
> +	stdu    r1, -PPC_MIN_STKFRM(r1)
> =20
>  	mfspr   r8, SPRN_TAR
> -	SAVE_GPR(8, r1)
> +	std	r8, PPC_MIN_STKFRM-8(r1)
> =20
> +	li	r5, 1		/* preserve non-volatile registers */
>  	bl	__kvmppc_save_tm
> =20
> -	REST_GPR(8, r1)
> +	ld	r8, PPC_MIN_STKFRM-8(r1)
>  	mtspr   SPRN_TAR, r8
> =20
> -	ld      r7, _CCR(r1)
> -	mtcr	r7
> -
> -	REST_GPR(6, r1)
> -	mtspr   SPRN_DSCR, r6
> -
> -	/* need preserve current MSR's MSR_TS bits */
> -	REST_GPR(5, r1)
> -	mfmsr   r6
> -	rldicl  r6, r6, 64 - MSR_TS_S_LG, 62
> -	rldimi  r5, r6, MSR_TS_S_LG, 63 - MSR_TS_T_LG
> -	mtmsrd  r5
> -
> -	REST_NVGPRS(r1)
> -	addi    r1, r1, SWITCH_FRAME_SIZE
> -	ld	r5, PPC_LR_STKOFF(r1)
> -	mtlr	r5
> +	addi    r1, r1, PPC_MIN_STKFRM
> +	ld	r0, PPC_LR_STKOFF(r1)
> +	mtlr	r0
>  	blr
> =20
>  EXPORT_SYMBOL_GPL(_kvmppc_save_tm_pr);
> @@ -215,15 +225,21 @@ EXPORT_SYMBOL_GPL(_kvmppc_save_tm_pr);
>   *  - r4 is the guest MSR with desired TS bits:
>   * 	For HV KVM, it is VCPU_MSR
>   * 	For PR KVM, it is provided by caller
> - * This potentially modifies all checkpointed registers.
> - * It restores r1, r2 from the PACA.
> + * - r5 containing a flag indicating that non-volatile registers
> + *	must be preserved.
> + * If r5 =3D=3D 0, this potentially modifies all checkpointed registers,=
 but
> + * restores r1, r2 from the PACA before exit.
> + * If r5 !=3D 0, this restores the MSR TM/FP/VEC/VSX bits to their state=
 on entry.
>   */
>  _GLOBAL(__kvmppc_restore_tm)
>  	mflr	r0
>  	std	r0, PPC_LR_STKOFF(r1)
> =20
> +	cmpdi	cr7, r5, 0
> +
>  	/* Turn on TM/FP/VSX/VMX so we can restore them. */
>  	mfmsr	r5
> +	mr	r10, r5
>  	li	r6, MSR_TM >> 32
>  	sldi	r6, r6, 32
>  	or	r5, r5, r6
> @@ -244,8 +260,7 @@ _GLOBAL(__kvmppc_restore_tm)
> =20
>  	mr	r5, r4
>  	rldicl. r5, r5, 64 - MSR_TS_S_LG, 62
> -	beqlr		/* TM not active in guest */
> -	std	r1, HSTATE_SCRATCH2(r13)
> +	beq	9f		/* TM not active in guest */
> =20
>  	/* Make sure the failure summary is set, otherwise we'll program check
>  	 * when we trechkpt.  It's possible that this might have been not set
> @@ -256,6 +271,26 @@ _GLOBAL(__kvmppc_restore_tm)
>  	mtspr	SPRN_TEXASR, r7
> =20
>  	/*
> +	 * Make a stack frame and save non-volatile registers if requested.
> +	 */
> +	stdu	r1, -SWITCH_FRAME_SIZE(r1)
> +	std	r1, HSTATE_SCRATCH2(r13)
> +
> +	mfcr	r6
> +	mfspr	r7, SPRN_DSCR
> +	SAVE_GPR(2, r1)
> +	SAVE_GPR(6, r1)
> +	SAVE_GPR(7, r1)
> +
> +	beq	cr7, 4f
> +	SAVE_NVGPRS(r1)
> +
> +	/* MSR[TS] will be 1 (suspended) once we do trechkpt */
> +	li	r0, 1
> +	rldimi	r10, r0, MSR_TS_S_LG, 63 - MSR_TS_T_LG
> +	SAVE_GPR(10, r1)	/* final MSR value */
> +4:
> +	/*
>  	 * We need to load up the checkpointed state for the guest.
>  	 * We need to do this early as it will blow away any GPRs, VSRs and
>  	 * some SPRs.
> @@ -291,8 +326,6 @@ _GLOBAL(__kvmppc_restore_tm)
>  	ld	r29, VCPU_DSCR_TM(r3)
>  	ld	r30, VCPU_PPR_TM(r3)
> =20
> -	std	r2, PACATMSCRATCH(r13) /* Save TOC */
> -
>  	/* Clear the MSR RI since r1, r13 are all going to be foobar. */
>  	li	r5, 0
>  	mtmsrd	r5, 1
> @@ -318,18 +351,31 @@ _GLOBAL(__kvmppc_restore_tm)
>  	/* Now let's get back the state we need. */
>  	HMT_MEDIUM
>  	GET_PACA(r13)
> -#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> -	ld	r29, HSTATE_DSCR(r13)
> -	mtspr	SPRN_DSCR, r29
> -#endif
>  	ld	r1, HSTATE_SCRATCH2(r13)
> -	ld	r2, PACATMSCRATCH(r13)
> +	REST_GPR(7, r1)
> +	mtspr	SPRN_DSCR, r7
> =20
>  	/* Set the MSR RI since we have our registers back. */
>  	li	r5, MSR_RI
>  	mtmsrd	r5, 1
> +
> +	/* Restore TOC pointer and CR */
> +	REST_GPR(2, r1)
> +	REST_GPR(6, r1)
> +	mtcr	r6
> +
> +	/* Restore non-volatile registers if requested to. */
> +	beq	cr7, 5f
> +	REST_GPR(10, r1)
> +	REST_NVGPRS(r1)
> +
> +5:	addi	r1, r1, SWITCH_FRAME_SIZE
>  	ld	r0, PPC_LR_STKOFF(r1)
>  	mtlr	r0
> +
> +9:	/* Restore MSR bits if requested */
> +	beqlr	cr7
> +	mtmsrd	r10, 0
>  	blr
> =20
>  /*
> @@ -337,47 +383,23 @@ _GLOBAL(__kvmppc_restore_tm)
>   * can be invoked from C function by PR KVM only.
>   */
>  _GLOBAL(_kvmppc_restore_tm_pr)
> -	mflr	r5
> -	std	r5, PPC_LR_STKOFF(r1)
> -	stdu    r1, -SWITCH_FRAME_SIZE(r1)
> -	SAVE_NVGPRS(r1)
> -
> -	/* save MSR to avoid TM/math bits change */
> -	mfmsr	r5
> -	SAVE_GPR(5, r1)
> -
> -	/* also save DSCR/CR/TAR so that it can be recovered later */
> -	mfspr   r6, SPRN_DSCR
> -	SAVE_GPR(6, r1)
> -
> -	mfcr    r7
> -	stw     r7, _CCR(r1)
> +	mflr	r0
> +	std	r0, PPC_LR_STKOFF(r1)
> +	stdu    r1, -PPC_MIN_STKFRM(r1)
> =20
> +	/* save TAR so that it can be recovered later */
>  	mfspr   r8, SPRN_TAR
> -	SAVE_GPR(8, r1)
> +	std	r8, PPC_MIN_STKFRM-8(r1)
> =20
> +	li	r5, 1
>  	bl	__kvmppc_restore_tm
> =20
> -	REST_GPR(8, r1)
> +	ld	r8, PPC_MIN_STKFRM-8(r1)
>  	mtspr   SPRN_TAR, r8
> =20
> -	ld      r7, _CCR(r1)
> -	mtcr	r7
> -
> -	REST_GPR(6, r1)
> -	mtspr   SPRN_DSCR, r6
> -
> -	/* need preserve current MSR's MSR_TS bits */
> -	REST_GPR(5, r1)
> -	mfmsr   r6
> -	rldicl  r6, r6, 64 - MSR_TS_S_LG, 62
> -	rldimi  r5, r6, MSR_TS_S_LG, 63 - MSR_TS_T_LG
> -	mtmsrd  r5
> -
> -	REST_NVGPRS(r1)
> -	addi    r1, r1, SWITCH_FRAME_SIZE
> -	ld	r5, PPC_LR_STKOFF(r1)
> -	mtlr	r5
> +	addi    r1, r1, PPC_MIN_STKFRM
> +	ld	r0, PPC_LR_STKOFF(r1)
> +	mtlr	r0
>  	blr
> =20
>  EXPORT_SYMBOL_GPL(_kvmppc_restore_tm_pr);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dDnEQgWzhgf+8aPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluy/vsACgkQbDjKyiDZ
s5LRGw//RXRALNBccmYE++WsE07ikqqGWePp9gY3nL7R15Jnoyu63PBnLCBjMiR9
CnoglkgnMXlXg83LMLs2tvHSciJ9cMFLs4XrrYGjZcPa6hYvUTVM1ZVRerrF2SQl
HWVHtm+trjOwa8MaJpGcs981a01im/w3l8gn5MLuXjMPEGJQyhutPNA+x3ErzucE
1TmCsQiNXN0oWOFREFH56mmNDx/uZE6WFc66wdKY/wOuE6FB2VepdOIsnIw3I1sz
l/gZWhUV95rykfdW7JVH47LagifiikQIq5gwkUnGJLXFCaEHJL+FggFQL0kK0mUp
vWKj3JiLlI6xt5HH256zlIJAFaghtNpI0FcRrBbRfv2E9dzTWYX7sVjFpFWbshzD
Upt1vV5izZvKAvjyqs//yUPnkLgfRt3nyXNRLrnczjq1buq66wEeC8d1/1g+7vRp
ZNRbV7JYYWrTLeL0AUiWzUVQFANe0W5GnQ8D/ZAaPHJIH29uWJdLjY+OLHjdvfRs
G4TXy32priQEKnOk99J3oeodQRY5TeHfmggQWofgvyAw8llErG41vZCFw1dBY6hq
aDVY/AnU177EbuVu3rxxY7TWiVjy3N8ZWzBSlp8HH1CeTOE9LjscGs5yxsjyZrYH
hcO/k0B07IaZn27IR0XdyRq8PLONbht4VmPuXyU+KrKVvS5GwRw=
=PYyj
-----END PGP SIGNATURE-----

--dDnEQgWzhgf+8aPe--
