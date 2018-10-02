Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF51C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 07:02:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45E8206B2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 07:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qQuVeiKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45E8206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PVTY36LvzF3Dk
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 17:02:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qQuVeiKE";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PVQh3BD3zDr43
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 17:00:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="qQuVeiKE"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PVQh24vnz9shx; Tue,  2 Oct 2018 17:00:12 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42PVQh1XWPz9sj0; Tue,  2 Oct 2018 17:00:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538463612;
 bh=Bjvx2m3VJpIpJmGU84yGCPkQ+IvvLfZYYZBYQuSlVoQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qQuVeiKEmUTcXDwBeI/krmHPrfGc/oWizq8QLsq7FWTMdr1Kiyp9tvDiAdh4oWT+s
 G13Acu9s6uoDzSVby6gfirLzGWV888Jm5473XQUgPzJpWMhXUiIHE9Cyh8KrwAfEKL
 KWd5icjNNPhNaxKgzbAi4CysPW7/1zKMSyZm+B68=
Date: Tue, 2 Oct 2018 17:00:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v2 19/33] KVM: PPC: Book3S HV: Nested guest entry via
 hypercall
Message-ID: <20181002070009.GJ1886@umbus.fritz.box>
References: <1538127963-15645-1-git-send-email-paulus@ozlabs.org>
 <1538127963-15645-20-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iRjOs3ViPWHdlw/I"
Content-Disposition: inline
In-Reply-To: <1538127963-15645-20-git-send-email-paulus@ozlabs.org>
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


--iRjOs3ViPWHdlw/I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 07:45:49PM +1000, Paul Mackerras wrote:
> This adds a new hypercall, H_ENTER_NESTED, which is used by a nested
> hypervisor to enter one of its nested guests.  The hypercall supplies
> register values in two structs.  Those values are copied by the level 0
> (L0) hypervisor (the one which is running in hypervisor mode) into the
> vcpu struct of the L1 guest, and then the guest is run until an
> interrupt or error occurs which needs to be reported to L1 via the
> hypercall return value.
>=20
> Currently this assumes that the L0 and L1 hypervisors are the same
> endianness, and the structs passed as arguments are in native
> endianness.  If they are of different endianness, the version number
> check will fail and the hcall will be rejected.
>=20
> Nested hypervisors do not support indep_threads_mode=3DN, so this adds
> code to print a warning message if the administrator has set
> indep_threads_mode=3DN, and treat it as Y.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

[snip]
> +/* Register state for entering a nested guest with H_ENTER_NESTED */
> +struct hv_guest_state {
> +	u64 version;		/* version of this structure layout */
> +	u32 lpid;
> +	u32 vcpu_token;
> +	/* These registers are hypervisor privileged (at least for writing) */
> +	u64 lpcr;
> +	u64 pcr;
> +	u64 amor;
> +	u64 dpdes;
> +	u64 hfscr;
> +	s64 tb_offset;
> +	u64 dawr0;
> +	u64 dawrx0;
> +	u64 ciabr;
> +	u64 hdec_expiry;
> +	u64 purr;
> +	u64 spurr;
> +	u64 ic;
> +	u64 vtb;
> +	u64 hdar;
> +	u64 hdsisr;
> +	u64 heir;
> +	u64 asdr;
> +	/* These are OS privileged but need to be set late in guest entry */
> +	u64 srr0;
> +	u64 srr1;
> +	u64 sprg[4];
> +	u64 pidr;
> +	u64 cfar;
> +	u64 ppr;
> +};

I'm guessing the implication here is that most supervisor privileged
registers need to be set by the L1 to the L2 values, before making the
H_ENTER_NESTED call.  Is that right?

[snip]
> +static int kvmppc_handle_nested_exit(struct kvm_vcpu *vcpu)
> +{
> +	int r;
> +	int srcu_idx;
> +
> +	vcpu->stat.sum_exits++;
> +
> +	/*
> +	 * This can happen if an interrupt occurs in the last stages
> +	 * of guest entry or the first stages of guest exit (i.e. after
> +	 * setting paca->kvm_hstate.in_guest to KVM_GUEST_MODE_GUEST_HV
> +	 * and before setting it to KVM_GUEST_MODE_HOST_HV).
> +	 * That can happen due to a bug, or due to a machine check
> +	 * occurring at just the wrong time.
> +	 */
> +	if (vcpu->arch.shregs.msr & MSR_HV) {
> +		pr_emerg("KVM trap in HV mode while nested!\n");
> +		pr_emerg("trap=3D0x%x | pc=3D0x%lx | msr=3D0x%llx\n",
> +			 vcpu->arch.trap, kvmppc_get_pc(vcpu),
> +			 vcpu->arch.shregs.msr);
> +		kvmppc_dump_regs(vcpu);
> +		return RESUME_HOST;

To make sure I'm understanding right here, RESUME_HOST will
effectively mean resume the L0, and RESUME_GUEST (without additional
processing) will mean resume the L2, right?

> +	}
> +	switch (vcpu->arch.trap) {
> +	/* We're good on these - the host merely wanted to get our attention */
> +	case BOOK3S_INTERRUPT_HV_DECREMENTER:
> +		vcpu->stat.dec_exits++;
> +		r =3D RESUME_GUEST;
> +		break;
> +	case BOOK3S_INTERRUPT_EXTERNAL:
> +		vcpu->stat.ext_intr_exits++;
> +		r =3D RESUME_HOST;
> +		break;
> +	case BOOK3S_INTERRUPT_H_DOORBELL:
> +	case BOOK3S_INTERRUPT_H_VIRT:
> +		vcpu->stat.ext_intr_exits++;
> +		r =3D RESUME_GUEST;
> +		break;
> +	/* SR/HMI/PMI are HV interrupts that host has handled. Resume guest.*/
> +	case BOOK3S_INTERRUPT_HMI:
> +	case BOOK3S_INTERRUPT_PERFMON:
> +	case BOOK3S_INTERRUPT_SYSTEM_RESET:
> +		r =3D RESUME_GUEST;
> +		break;
> +	case BOOK3S_INTERRUPT_MACHINE_CHECK:
> +		/* Pass the machine check to the L1 guest */
> +		r =3D RESUME_HOST;
> +		/* Print the MCE event to host console. */
> +		machine_check_print_event_info(&vcpu->arch.mce_evt, false);
> +		break;
> +	/*
> +	 * We get these next two if the guest accesses a page which it thinks
> +	 * it has mapped but which is not actually present, either because
> +	 * it is for an emulated I/O device or because the corresonding
> +	 * host page has been paged out.
> +	 */
> +	case BOOK3S_INTERRUPT_H_DATA_STORAGE:
> +		srcu_idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> +		r =3D kvmhv_nested_page_fault(vcpu);
> +		srcu_read_unlock(&vcpu->kvm->srcu, srcu_idx);
> +		break;
> +	case BOOK3S_INTERRUPT_H_INST_STORAGE:
> +		vcpu->arch.fault_dar =3D kvmppc_get_pc(vcpu);
> +		vcpu->arch.fault_dsisr =3D kvmppc_get_msr(vcpu) &
> +					 DSISR_SRR1_MATCH_64S;
> +		if (vcpu->arch.shregs.msr & HSRR1_HISI_WRITE)
> +			vcpu->arch.fault_dsisr |=3D DSISR_ISSTORE;
> +		srcu_idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> +		r =3D kvmhv_nested_page_fault(vcpu);
> +		srcu_read_unlock(&vcpu->kvm->srcu, srcu_idx);
> +		break;
> +
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	case BOOK3S_INTERRUPT_HV_SOFTPATCH:
> +		/*
> +		 * This occurs for various TM-related instructions that
> +		 * we need to emulate on POWER9 DD2.2.  We have already
> +		 * handled the cases where the guest was in real-suspend
> +		 * mode and was transitioning to transactional state.
> +		 */
> +		r =3D kvmhv_p9_tm_emulation(vcpu);
> +		break;
> +#endif
> +
> +	case BOOK3S_INTERRUPT_HV_RM_HARD:
> +		vcpu->arch.trap =3D 0;
> +		r =3D RESUME_GUEST;
> +		if (!xive_enabled())
> +			kvmppc_xics_rm_complete(vcpu, 0);
> +		break;
> +	default:
> +		r =3D RESUME_HOST;
> +		break;
> +	}
> +
> +	return r;
> +}
> +
>  static int kvm_arch_vcpu_ioctl_get_sregs_hv(struct kvm_vcpu *vcpu,
>  					    struct kvm_sregs *sregs)
>  {
> @@ -3098,7 +3203,8 @@ static noinline void kvmppc_run_core(struct kvmppc_=
vcore *vc)
>  /*
>   * Load up hypervisor-mode registers on P9.
>   */
> -static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_lim=
it)
> +static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_lim=
it,
> +				     unsigned long lpcr)

I don't understand this change: you've added a parameter, but there's
no change to the body of the function, so you're not actually using
the new parameter.

[snip]
> +/*
> + * This never fails for a radix guest, as none of the operations it does
> + * for a radix guest can fail or have a way to report failure.
> + * kvmhv_run_single_vcpu() relies on this fact.
> + */
>  static int kvmhv_setup_mmu(struct kvm_vcpu *vcpu)
>  {
>  	int r =3D 0;
> @@ -3684,12 +3814,15 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_ru=
n, struct kvm_vcpu *vcpu)
>  	return vcpu->arch.ret;
>  }
> =20
> -static int kvmppc_run_single_vcpu(struct kvm_run *kvm_run,
> -				  struct kvm_vcpu *vcpu, u64 time_limit)
> +int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
> +			  struct kvm_vcpu *vcpu, u64 time_limit,
> +			  unsigned long lpcr)

IIRC this is the streamlined entry path introduced earlier in the
series, yes?  Making the name change where it was introduced would
avoid the extra churn here.

It'd be nice to have something here to make it more obvious that this
path is only for radix guests, but I'm not really sure how to
accomplish that.

>  {
>  	int trap, r, pcpu, pcpu0;
>  	int srcu_idx;
>  	struct kvmppc_vcore *vc;
> +	struct kvm_nested_guest *nested =3D vcpu->arch.nested;
> +	unsigned long lpid;
> =20
>  	trace_kvmppc_run_vcpu_enter(vcpu);
> =20
> @@ -3710,16 +3843,8 @@ static int kvmppc_run_single_vcpu(struct kvm_run *=
kvm_run,
>  	vc->runner =3D vcpu;
> =20
>  	/* See if the MMU is ready to go */
> -	if (!vcpu->kvm->arch.mmu_ready) {
> -		r =3D kvmhv_setup_mmu(vcpu);
> -		if (r) {
> -			kvm_run->exit_reason =3D KVM_EXIT_FAIL_ENTRY;
> -			kvm_run->fail_entry.
> -				hardware_entry_failure_reason =3D 0;
> -			vcpu->arch.ret =3D r;
> -			goto out;
> -		}
> -	}
> +	if (!vcpu->kvm->arch.mmu_ready)
> +		kvmhv_setup_mmu(vcpu);
> =20
>  	if (need_resched())
>  		cond_resched();
> @@ -3741,7 +3866,22 @@ static int kvmppc_run_single_vcpu(struct kvm_run *=
kvm_run,
>  	if (lazy_irq_pending() || need_resched() || !vcpu->kvm->arch.mmu_ready)
>  		goto out;
> =20
> -	kvmppc_core_prepare_to_enter(vcpu);
> +	if (!nested) {
> +		kvmppc_core_prepare_to_enter(vcpu);
> +		if (vcpu->arch.doorbell_request) {
> +			vc->dpdes =3D 1;
> +			smp_wmb();
> +			vcpu->arch.doorbell_request =3D 0;
> +		}
> +		if (test_bit(BOOK3S_IRQPRIO_EXTERNAL,
> +			     &vcpu->arch.pending_exceptions))
> +			lpcr |=3D LPCR_MER;
> +	} else if (vcpu->arch.pending_exceptions ||
> +		   vcpu->arch.doorbell_request ||
> +		   xive_interrupt_pending(vcpu)) {
> +		vcpu->arch.ret =3D RESUME_HOST;
> +		goto out;
> +	}
> =20
--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iRjOs3ViPWHdlw/I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluzF3YACgkQbDjKyiDZ
s5KXIhAA0a9Ax4qw2/IrvBeUB+OYtwCDeCBYmPerjNmg7RWSX0fbcAEyldzzaqMp
63WYDsLr7jC/5V1tyhj9PP8oi+mPUm56W+HGIMWvyY2EZT8AVfnvu4SYHgzyBvUU
DpdSiaHOwAMntH2+baR/Y21TiR/aNu4U5TG8POUi+vPOWzuZLDQzf2SRPVzwg2t6
IiWZAxhQgaPSvI1T6epwTq5kDG68Z3DgXHPV68x7hmy2ZMNCZCFR2iuAYPD8oC+w
kzKxDtyE8q1dm+fSJHPf1YA3s9dooyb2q5spPaQ2O1LGx1JZlic1NqlSyP7XwJrt
906o4sdYn5Us1HBxLI3lxa0xwCnvSx6PEeeLWDnP62fm/FoDef3YTMJC3s2XWicX
zPI/bxHZzC3fMTvlX8E+9vRZGW5SXu1aW/pdzLLwW1YQxHGLu52cYGWWzMCNUa67
16dnO+CuYLHUhTlj7nHto6LtL4/WRxzNwrAO1o1yzYBnImXRZaL2NiZoBjHYAYxE
+RJNDJr9R0+/FyPM819oLOXsvpr+Um++KxFDukgUgw0wcjNEeDdoqcbVNeQQornC
kvLoX6msVXXW4+aVE4rgUbAg2CtiSgyxG61UpcaitucfAm5EUm/8SsxwudWfPS75
bcYgWlT+E7fnJFz1gTv+wYSsHSvg4AnuEvGgTqh6FfAUKHb6mts=
=jypm
-----END PGP SIGNATURE-----

--iRjOs3ViPWHdlw/I--
