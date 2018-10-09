Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D661C67879
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 01:13:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4493E2075C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 01:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="navOPcKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4493E2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TfPG09B3zF3Fm
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 12:13:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="navOPcKl";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tf204LjmzF3C4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 11:56:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="navOPcKl"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Tf201cvzzB4MZ; Tue,  9 Oct 2018 11:56:40 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Tf200vVDzB4N2; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1539046600;
 bh=E+yFElIla7ei5C5KQZgMyK2rh08Ucr/9I9FU3t/5m28=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=navOPcKl65mZHBtgvjAFODQbORZTUrZ39MVJxeylqPmh5MhKvoZKq2tY5fyTUTQ+B
 fsbKHfBVEvkRGMefxIgV43pD5jzuKBEU+RePZ2CZ2DjygU2hs+1abhhzftxEkJyPon
 ZyieWoDLu3gwE51xN6uvzrrRws01nq80RmlQdsE0=
Date: Tue, 9 Oct 2018 11:05:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v5 06/33] KVM: PPC: Book3S HV: Simplify real-mode
 interrupt handling
Message-ID: <20181009000544.GE7004@umbus.fritz.box>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
 <1538976679-1363-7-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DHdTHwZuIuFUI+Ax"
Content-Disposition: inline
In-Reply-To: <1538976679-1363-7-git-send-email-paulus@ozlabs.org>
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


--DHdTHwZuIuFUI+Ax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 04:30:52PM +1100, Paul Mackerras wrote:
> This streamlines the first part of the code that handles a hypervisor
> interrupt that occurred in the guest.  With this, all of the real-mode
> handling that occurs is done before the "guest_exit_cont" label; once
> we get to that label we are committed to exiting to host virtual mode.
> Thus the machine check and HMI real-mode handling is moved before that
> label.
>=20
> Also, the code to handle external interrupts is moved out of line, as
> is the code that calls kvmppc_realmode_hmi_handler().
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_hv_ras.c        |   8 ++
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 220 ++++++++++++++++----------=
------
>  2 files changed, 119 insertions(+), 109 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_h=
v_ras.c
> index b11043b..ee564b6 100644
> --- a/arch/powerpc/kvm/book3s_hv_ras.c
> +++ b/arch/powerpc/kvm/book3s_hv_ras.c
> @@ -331,5 +331,13 @@ long kvmppc_realmode_hmi_handler(void)
>  	} else {
>  		wait_for_tb_resync();
>  	}
> +
> +	/*
> +	 * Reset tb_offset_applied so the guest exit code won't try
> +	 * to subtract the previous timebase offset from the timebase.
> +	 */
> +	if (local_paca->kvm_hstate.kvm_vcore)
> +		local_paca->kvm_hstate.kvm_vcore->tb_offset_applied =3D 0;
> +
>  	return 0;
>  }
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/b=
ook3s_hv_rmhandlers.S
> index 5b2ae34..fc360b5 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1018,8 +1018,7 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
>  no_xive:
>  #endif /* CONFIG_KVM_XICS */
> =20
> -deliver_guest_interrupt:
> -kvmppc_cede_reentry:		/* r4 =3D vcpu, r13 =3D paca */
> +deliver_guest_interrupt:	/* r4 =3D vcpu, r13 =3D paca */
>  	/* Check if we can deliver an external or decrementer interrupt now */
>  	ld	r0, VCPU_PENDING_EXC(r4)
>  BEGIN_FTR_SECTION
> @@ -1269,18 +1268,26 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  	std	r3, VCPU_CTR(r9)
>  	std	r4, VCPU_XER(r9)
> =20
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -	/* For softpatch interrupt, go off and do TM instruction emulation */
> -	cmpwi	r12, BOOK3S_INTERRUPT_HV_SOFTPATCH
> -	beq	kvmppc_tm_emul
> -#endif
> +	/* Save more register state  */
> +	mfdar	r3
> +	mfdsisr	r4
> +	std	r3, VCPU_DAR(r9)
> +	stw	r4, VCPU_DSISR(r9)
> =20
>  	/* If this is a page table miss then see if it's theirs or ours */
>  	cmpwi	r12, BOOK3S_INTERRUPT_H_DATA_STORAGE
>  	beq	kvmppc_hdsi
> +	std	r3, VCPU_FAULT_DAR(r9)
> +	stw	r4, VCPU_FAULT_DSISR(r9)
>  	cmpwi	r12, BOOK3S_INTERRUPT_H_INST_STORAGE
>  	beq	kvmppc_hisi
> =20
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	/* For softpatch interrupt, go off and do TM instruction emulation */
> +	cmpwi	r12, BOOK3S_INTERRUPT_HV_SOFTPATCH
> +	beq	kvmppc_tm_emul
> +#endif
> +
>  	/* See if this is a leftover HDEC interrupt */
>  	cmpwi	r12,BOOK3S_INTERRUPT_HV_DECREMENTER
>  	bne	2f
> @@ -1303,7 +1310,7 @@ BEGIN_FTR_SECTION
>  END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  	lbz	r0, HSTATE_HOST_IPI(r13)
>  	cmpwi	r0, 0
> -	beq	4f
> +	beq	maybe_reenter_guest
>  	b	guest_exit_cont
>  3:
>  	/* If it's a hypervisor facility unavailable interrupt, save HFSCR */
> @@ -1315,82 +1322,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  14:
>  	/* External interrupt ? */
>  	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
> -	bne+	guest_exit_cont
> -
> -	/* External interrupt, first check for host_ipi. If this is
> -	 * set, we know the host wants us out so let's do it now
> -	 */
> -	bl	kvmppc_read_intr
> -
> -	/*
> -	 * Restore the active volatile registers after returning from
> -	 * a C function.
> -	 */
> -	ld	r9, HSTATE_KVM_VCPU(r13)
> -	li	r12, BOOK3S_INTERRUPT_EXTERNAL
> -
> -	/*
> -	 * kvmppc_read_intr return codes:
> -	 *
> -	 * Exit to host (r3 > 0)
> -	 *   1 An interrupt is pending that needs to be handled by the host
> -	 *     Exit guest and return to host by branching to guest_exit_cont
> -	 *
> -	 *   2 Passthrough that needs completion in the host
> -	 *     Exit guest and return to host by branching to guest_exit_cont
> -	 *     However, we also set r12 to BOOK3S_INTERRUPT_HV_RM_HARD
> -	 *     to indicate to the host to complete handling the interrupt
> -	 *
> -	 * Before returning to guest, we check if any CPU is heading out
> -	 * to the host and if so, we head out also. If no CPUs are heading
> -	 * check return values <=3D 0.
> -	 *
> -	 * Return to guest (r3 <=3D 0)
> -	 *  0 No external interrupt is pending
> -	 * -1 A guest wakeup IPI (which has now been cleared)
> -	 *    In either case, we return to guest to deliver any pending
> -	 *    guest interrupts.
> -	 *
> -	 * -2 A PCI passthrough external interrupt was handled
> -	 *    (interrupt was delivered directly to guest)
> -	 *    Return to guest to deliver any pending guest interrupts.
> -	 */
> -
> -	cmpdi	r3, 1
> -	ble	1f
> -
> -	/* Return code =3D 2 */
> -	li	r12, BOOK3S_INTERRUPT_HV_RM_HARD
> -	stw	r12, VCPU_TRAP(r9)
> -	b	guest_exit_cont
> -
> -1:	/* Return code <=3D 1 */
> -	cmpdi	r3, 0
> -	bgt	guest_exit_cont
> -
> -	/* Return code <=3D 0 */
> -4:	ld	r5, HSTATE_KVM_VCORE(r13)
> -	lwz	r0, VCORE_ENTRY_EXIT(r5)
> -	cmpwi	r0, 0x100
> -	mr	r4, r9
> -	blt	deliver_guest_interrupt
> -
> -guest_exit_cont:		/* r9 =3D vcpu, r12 =3D trap, r13 =3D paca */
> -	/* Save more register state  */
> -	mfdar	r6
> -	mfdsisr	r7
> -	std	r6, VCPU_DAR(r9)
> -	stw	r7, VCPU_DSISR(r9)
> -	/* don't overwrite fault_dar/fault_dsisr if HDSI */
> -	cmpwi	r12,BOOK3S_INTERRUPT_H_DATA_STORAGE
> -	beq	mc_cont
> -	std	r6, VCPU_FAULT_DAR(r9)
> -	stw	r7, VCPU_FAULT_DSISR(r9)
> -
> +	beq	kvmppc_guest_external
>  	/* See if it is a machine check */
>  	cmpwi	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
>  	beq	machine_check_realmode
> -mc_cont:
> +	/* Or a hypervisor maintenance interrupt */
> +	cmpwi	r12, BOOK3S_INTERRUPT_HMI
> +	beq	hmi_realmode
> +
> +guest_exit_cont:		/* r9 =3D vcpu, r12 =3D trap, r13 =3D paca */
> +
>  #ifdef CONFIG_KVM_BOOK3S_HV_EXIT_TIMING
>  	addi	r3, r9, VCPU_TB_RMEXIT
>  	mr	r4, r9
> @@ -1821,24 +1762,6 @@ BEGIN_FTR_SECTION
>  	mtspr	SPRN_DPDES, r8
>  END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> =20
> -	/* If HMI, call kvmppc_realmode_hmi_handler() */
> -	lwz	r12, STACK_SLOT_TRAP(r1)
> -	cmpwi	r12, BOOK3S_INTERRUPT_HMI
> -	bne	27f
> -	bl	kvmppc_realmode_hmi_handler
> -	nop
> -	cmpdi	r3, 0
> -	/*
> -	 * At this point kvmppc_realmode_hmi_handler may have resync-ed
> -	 * the TB, and if it has, we must not subtract the guest timebase
> -	 * offset from the timebase. So, skip it.
> -	 *
> -	 * Also, do not call kvmppc_subcore_exit_guest() because it has
> -	 * been invoked as part of kvmppc_realmode_hmi_handler().
> -	 */
> -	beq	30f
> -
> -27:
>  	/* Subtract timebase offset from timebase */
>  	ld	r8, VCORE_TB_OFFSET_APPL(r5)
>  	cmpdi	r8,0
> @@ -1856,7 +1779,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	addis	r8,r8,0x100		/* if so, increment upper 40 bits */
>  	mtspr	SPRN_TBU40,r8
> =20
> -17:	bl	kvmppc_subcore_exit_guest
> +17:
> +	/*
> +	 * If this is an HMI, we called kvmppc_realmode_hmi_handler
> +	 * above, which may or may not have already called
> +	 * kvmppc_subcore_exit_guest.  Fortunately, all that
> +	 * kvmppc_subcore_exit_guest does is clear a flag, so calling
> +	 * it again here is benign even if kvmppc_realmode_hmi_handler
> +	 * has already called it.
> +	 */
> +	bl	kvmppc_subcore_exit_guest
>  	nop
>  30:	ld	r5,HSTATE_KVM_VCORE(r13)
>  	ld	r4,VCORE_KVM(r5)	/* pointer to struct kvm */
> @@ -1910,6 +1842,67 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  	mtlr	r0
>  	blr
> =20
> +kvmppc_guest_external:
> +	/* External interrupt, first check for host_ipi. If this is
> +	 * set, we know the host wants us out so let's do it now
> +	 */
> +	bl	kvmppc_read_intr
> +
> +	/*
> +	 * Restore the active volatile registers after returning from
> +	 * a C function.
> +	 */
> +	ld	r9, HSTATE_KVM_VCPU(r13)
> +	li	r12, BOOK3S_INTERRUPT_EXTERNAL
> +
> +	/*
> +	 * kvmppc_read_intr return codes:
> +	 *
> +	 * Exit to host (r3 > 0)
> +	 *   1 An interrupt is pending that needs to be handled by the host
> +	 *     Exit guest and return to host by branching to guest_exit_cont
> +	 *
> +	 *   2 Passthrough that needs completion in the host
> +	 *     Exit guest and return to host by branching to guest_exit_cont
> +	 *     However, we also set r12 to BOOK3S_INTERRUPT_HV_RM_HARD
> +	 *     to indicate to the host to complete handling the interrupt
> +	 *
> +	 * Before returning to guest, we check if any CPU is heading out
> +	 * to the host and if so, we head out also. If no CPUs are heading
> +	 * check return values <=3D 0.
> +	 *
> +	 * Return to guest (r3 <=3D 0)
> +	 *  0 No external interrupt is pending
> +	 * -1 A guest wakeup IPI (which has now been cleared)
> +	 *    In either case, we return to guest to deliver any pending
> +	 *    guest interrupts.
> +	 *
> +	 * -2 A PCI passthrough external interrupt was handled
> +	 *    (interrupt was delivered directly to guest)
> +	 *    Return to guest to deliver any pending guest interrupts.
> +	 */
> +
> +	cmpdi	r3, 1
> +	ble	1f
> +
> +	/* Return code =3D 2 */
> +	li	r12, BOOK3S_INTERRUPT_HV_RM_HARD
> +	stw	r12, VCPU_TRAP(r9)
> +	b	guest_exit_cont
> +
> +1:	/* Return code <=3D 1 */
> +	cmpdi	r3, 0
> +	bgt	guest_exit_cont
> +
> +	/* Return code <=3D 0 */
> +maybe_reenter_guest:
> +	ld	r5, HSTATE_KVM_VCORE(r13)
> +	lwz	r0, VCORE_ENTRY_EXIT(r5)
> +	cmpwi	r0, 0x100
> +	mr	r4, r9
> +	blt	deliver_guest_interrupt
> +	b	guest_exit_cont
> +
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  /*
>   * Softpatch interrupt for transactional memory emulation cases
> @@ -2685,13 +2678,7 @@ END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSI=
ST, 0)
>  	mr	r9, r4
>  	cmpdi	r3, 0
>  	bgt	guest_exit_cont
> -
> -	/* see if any other thread is already exiting */
> -	lwz	r0,VCORE_ENTRY_EXIT(r5)
> -	cmpwi	r0,0x100
> -	bge	guest_exit_cont
> -
> -	b	kvmppc_cede_reentry	/* if not go back to guest */
> +	b	maybe_reenter_guest
> =20
>  	/* cede when already previously prodded case */
>  kvm_cede_prodded:
> @@ -2758,12 +2745,12 @@ machine_check_realmode:
>  	 */
>  	ld	r11, VCPU_MSR(r9)
>  	rldicl.	r0, r11, 64-MSR_HV_LG, 63 /* check if it happened in HV mode */
> -	bne	mc_cont			/* if so, exit to host */
> +	bne	guest_exit_cont		/* if so, exit to host */
>  	/* Check if guest is capable of handling NMI exit */
>  	ld	r10, VCPU_KVM(r9)
>  	lbz	r10, KVM_FWNMI(r10)
>  	cmpdi	r10, 1			/* FWNMI capable? */
> -	beq	mc_cont			/* if so, exit with KVM_EXIT_NMI. */
> +	beq	guest_exit_cont		/* if so, exit with KVM_EXIT_NMI. */
> =20
>  	/* if not, fall through for backward compatibility. */
>  	andi.	r10, r11, MSR_RI	/* check for unrecoverable exception */
> @@ -2777,6 +2764,21 @@ machine_check_realmode:
>  2:	b	fast_interrupt_c_return
> =20
>  /*
> + * Call C code to handle a HMI in real mode.
> + * Only the primary thread does the call, secondary threads are handled
> + * by calling hmi_exception_realmode() after kvmppc_hv_entry returns.
> + * r9 points to the vcpu on entry
> + */
> +hmi_realmode:
> +	lbz	r0, HSTATE_PTID(r13)
> +	cmpwi	r0, 0
> +	bne	guest_exit_cont
> +	bl	kvmppc_realmode_hmi_handler
> +	ld	r9, HSTATE_KVM_VCPU(r13)
> +	li	r12, BOOK3S_INTERRUPT_HMI
> +	b	guest_exit_cont
> +
> +/*
>   * Check the reason we woke from nap, and take appropriate action.
>   * Returns (in r3):
>   *	0 if nothing needs to be done

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DHdTHwZuIuFUI+Ax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu78NUACgkQbDjKyiDZ
s5IjKg/+L2x2J2vhZY6UudAd6DuG8oym53Pl1CUaHUaqdPMok92l8tkRVoG5a+eF
1GZ026tNT2FnzsiZokNSdCjOBBzQu4Nms5D+4X+r4Qi0YpzpxtG/gXLLQNhQQsdb
yxujzPBLujWGzcjWcoGWP/q42q0Z3U/mUxgAFYpqyfZewbqM+1Kb8CW2phBE2QIy
D0UdXfPKT3NMCu6izrZi/GkClZlFhOap0AmOtrQOmr5u9DFLHaFRKZXm/x4Rf2Wb
E7ECkDP4fdFku5pVSFxm2BFyAbTqGSp8wl6jlz6mAYeIohBCO+M8g4AmT0GK28sn
ne9F+kUAd9psSfpRQAydmdOa4clezP0Pq3fx9HK1MKxY01n+inXh7Sz1PFHJSfmn
hTP/nJeJBcUGwhGGKogqlBuYnP+BTF1CT/irppjcex4EX46uCmD74fwmy6yK8wrC
YUSROfJiTlBftXpGnp09PXLjaV2FBtf7BFkZbJl5AYAZ4t5IV+8kOu4fUAuQ9ZQM
4KdNzcfWYRXpmMq15RxiVrxd1MI0wORETdCtpJXQADAJKmJc9cUAUQxZrcLqgP2e
Gfp0AFEW6klEjH/yafsOdk9LjReGpvALgLQBRkk/OFZ+3nEhBpHB3lnL6nS+k5T1
EJYfp0XtI1zFHco0xIzLu+RGONnVRr8Rx4ja0ymXgs/Llpplnk0=
=PaCt
-----END PGP SIGNATURE-----

--DHdTHwZuIuFUI+Ax--
