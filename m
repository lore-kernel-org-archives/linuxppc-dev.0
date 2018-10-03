Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FABC00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:20:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F95206B2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ppp9CjdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F95206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q49T3VPfzF3Cf
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 15:20:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ppp9CjdK";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q43m4PqXzF37K
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 15:15:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="ppp9CjdK"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Q43m3jYjz9sBk; Wed,  3 Oct 2018 15:15:48 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Q43m2wc2z9s9m; Wed,  3 Oct 2018 15:15:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538543748;
 bh=VnkkjMC95YYN5ZfZ8b3p+CT6qLIGOQ1c4+0YaxpInr4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ppp9CjdKynfChimaCGW+Pe6L9iYCGNEMDNfffCYBRLzu1OffA5lNKC71ALs1zMf5f
 Sa+QiChBJ4BAAncO6/jN9Hlu6meN6cGY7nNaB2y7NbfjR2wUO1dj6U/aKTnZoip8vB
 ri71kaioFU8bDo7AuWcb9ixOjGHHLTwJp009U+0M=
Date: Wed, 3 Oct 2018 15:13:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 21/33] KVM: PPC: Book3S HV: Framework to handle HV
 Emulation Assist Interrupt
Message-ID: <20181003051301.GO1886@umbus.fritz.box>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-22-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NKtYx2Ppz7d1tORf"
Content-Disposition: inline
In-Reply-To: <1538479892-14835-22-git-send-email-paulus@ozlabs.org>
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


--NKtYx2Ppz7d1tORf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2018 at 09:31:20PM +1000, Paul Mackerras wrote:
> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20
> A HEAI (hypervisor emulation assistance interrupt) occurs when a
> hypervisor resource or instruction is used in a privileged but
> non-hypervisor state and the LPCR_EVIRT bit is set in LPCR.  When
> this occurs bit 45 is set in HSRR1.  Detect the occurrence of this,
> and if userspace has enabled the nested virtualization capability
> on the VM, then call the code to handle it accordingly.
>=20
> With LPCR[EVIRT] set, we also get HEAI (without bit 45 set) for
> mfspr or mtspr to unimplemented SPR numbers.  For these accesses,
> we emulate the EVIRT=3D0 behaviour, which is to make the access
> a no-op for privileged software unless it is accessing SPR 0,
> 4, 5 or 6.  Problem-state accesses and accesses to SPR 0, 4, 5
> or 6 generate an illegal-instruction type program interrupt.
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Do we still need this if we're moving to paravirt tlbie?

> ---
>  arch/powerpc/include/asm/kvm_book3s.h |  2 +
>  arch/powerpc/include/asm/reg.h        |  1 +
>  arch/powerpc/kvm/book3s_hv.c          | 87 ++++++++++++++++++++++-------=
------
>  arch/powerpc/kvm/book3s_hv_nested.c   | 55 ++++++++++++++++++++++
>  4 files changed, 113 insertions(+), 32 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include=
/asm/kvm_book3s.h
> index 093fd70..0a97446 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -287,6 +287,8 @@ void kvmhv_save_hv_regs(struct kvm_vcpu *vcpu, struct=
 hv_guest_state *hr);
>  void kvmhv_restore_hv_return_state(struct kvm_vcpu *vcpu,
>  				   struct hv_guest_state *hr);
>  long int kvmhv_nested_page_fault(struct kvm_vcpu *vcpu);
> +int kvmhv_emulate_priv(struct kvm_run *run, struct kvm_vcpu *vcpu,
> +			unsigned int instr);
> =20
>  void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac);
> =20
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/re=
g.h
> index 6fda746..9c42abf 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -456,6 +456,7 @@
>  #define   LPCR_HVICE		ASM_CONST(0x0000000000000002)      /* P9: HV inter=
rupt enable */
>  #define   LPCR_HDICE		ASM_CONST(0x0000000000000001)      /* Hyp Decr ena=
ble (HV,PR,EE) */
>  #define   LPCR_UPRT		ASM_CONST(0x0000000000400000)      /* Use Process T=
able (ISA 3) */
> +#define   LPCR_EVIRT		ASM_CONST(0x0000000000200000)      /* Enhanced Vir=
tualisation */
>  #define   LPCR_HR		ASM_CONST(0x0000000000100000)
>  #ifndef SPRN_LPID
>  #define SPRN_LPID	0x13F	/* Logical Partition Identifier */
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 134d7c7..b975683 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1027,30 +1027,6 @@ static int kvmppc_hcall_impl_hv(unsigned long cmd)
>  	return kvmppc_hcall_impl_hv_realmode(cmd);
>  }
> =20
> -static int kvmppc_emulate_debug_inst(struct kvm_run *run,
> -					struct kvm_vcpu *vcpu)
> -{
> -	u32 last_inst;
> -
> -	if (kvmppc_get_last_inst(vcpu, INST_GENERIC, &last_inst) !=3D
> -					EMULATE_DONE) {
> -		/*
> -		 * Fetch failed, so return to guest and
> -		 * try executing it again.
> -		 */
> -		return RESUME_GUEST;
> -	}
> -
> -	if (last_inst =3D=3D KVMPPC_INST_SW_BREAKPOINT) {
> -		run->exit_reason =3D KVM_EXIT_DEBUG;
> -		run->debug.arch.address =3D kvmppc_get_pc(vcpu);
> -		return RESUME_HOST;
> -	} else {
> -		kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
> -		return RESUME_GUEST;
> -	}
> -}
> -
>  static void do_nothing(void *x)
>  {
>  }
> @@ -1144,6 +1120,23 @@ static int kvmppc_emulate_doorbell_instr(struct kv=
m_vcpu *vcpu)
>  	return RESUME_GUEST;
>  }
> =20
> +static int kvmhv_emulate_unknown_spr(struct kvm_vcpu *vcpu, u32 instr)
> +{
> +	u32 spr =3D get_sprn(instr);
> +
> +	/*
> +	 * In privileged state, access to unimplemented SPRs is a no-op
> +	 * except for SPR 0, 4, 5 and 6.  All other accesses get turned
> +	 * into illegal-instruction program interrupts.
> +	 */
> +	if ((vcpu->arch.shregs.msr & MSR_PR) ||
> +	    spr =3D=3D 0 || (4 <=3D spr && spr <=3D 6))
> +		return EMULATE_FAIL;
> +
> +	kvmppc_set_pc(vcpu, kvmppc_get_pc(vcpu) + 4);
> +	return RESUME_GUEST;
> +}
> +
>  static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *v=
cpu,
>  				 struct task_struct *tsk)
>  {
> @@ -1260,19 +1253,49 @@ static int kvmppc_handle_exit_hv(struct kvm_run *=
run, struct kvm_vcpu *vcpu,
>  	 * to the guest. If guest debug is enabled, we need to check
>  	 * whether the instruction is a software breakpoint instruction.
>  	 * Accordingly return to Guest or Host.
> +	 * With LPCR[EVIRT] set, we also get these for accesses to
> +	 * unknown SPRs and for guests executing hypervisor privileged
> +	 * instructions.
>  	 */
>  	case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
> -		if (vcpu->arch.emul_inst !=3D KVM_INST_FETCH_FAILED)
> -			vcpu->arch.last_inst =3D kvmppc_need_byteswap(vcpu) ?
> -				swab32(vcpu->arch.emul_inst) :
> -				vcpu->arch.emul_inst;
> -		if (vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP) {
> -			r =3D kvmppc_emulate_debug_inst(run, vcpu);
> +	{
> +		u32 instr =3D vcpu->arch.emul_inst;
> +		unsigned long srr1_bit =3D SRR1_PROGILL;
> +
> +		vcpu->arch.last_inst =3D kvmppc_need_byteswap(vcpu) ?
> +			swab32(instr) : instr;
> +
> +		r =3D EMULATE_FAIL;
> +		if (vcpu->arch.shregs.msr & SRR1_PROGPRIV) {
> +			/*
> +			 * Tried to execute hypervisor privileged instruction
> +			 * or mtspr/mfspr on a hypervisor privileged SPR while
> +			 * MSR(HV | PR) =3D=3D 0b00 -> Privileged but !HV state
> +			 */
> +			srr1_bit =3D SRR1_PROGPRIV;
> +			if (vcpu->kvm->arch.nested_enable)
> +				r =3D kvmhv_emulate_priv(run, vcpu, instr);
>  		} else {
> -			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
> +			/* Illegal instruction or unknown SPR access */
> +			if (instr =3D=3D KVMPPC_INST_SW_BREAKPOINT &&
> +			    (vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP)) {
> +				run->exit_reason =3D KVM_EXIT_DEBUG;
> +				run->debug.arch.address =3D kvmppc_get_pc(vcpu);
> +				r =3D RESUME_HOST;
> +				break;
> +			}
> +			if ((instr & 0xfc0006fe) =3D=3D PPC_INST_MFSPR)
> +				/* mfspr or mtspr to unknown SPR, may be noop */
> +				r =3D kvmhv_emulate_unknown_spr(vcpu, instr);
> +		}
> +		if (r =3D=3D EMULATE_FAIL) {
> +			pr_debug("KVM: Couldn't emulate instruction 0x%.8x\n",
> +				 instr);
> +			kvmppc_core_queue_program(vcpu, srr1_bit);
>  			r =3D RESUME_GUEST;
>  		}
>  		break;
> +	}
>  	/*
>  	 * This occurs if the guest (kernel or userspace), does something that
>  	 * is prohibited by HFSCR.
> @@ -4612,7 +4635,7 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
>  	 */
>  	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
>  		lpcr &=3D ~LPCR_VPM0;
> -		lpcr |=3D LPCR_HVICE | LPCR_HEIC;
> +		lpcr |=3D LPCR_HVICE | LPCR_HEIC | LPCR_EVIRT;
> =20
>  		/*
>  		 * If xive is enabled, we route 0x500 interrupts directly
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3=
s_hv_nested.c
> index 4a381b4..f8f9fab 100644
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -15,6 +15,7 @@
>  #include <asm/mmu.h>
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> +#include <asm/disassemble.h>
> =20
>  static struct patb_entry *pseries_partition_tb;
> =20
> @@ -515,3 +516,57 @@ long kvmhv_nested_page_fault(struct kvm_vcpu *vcpu)
>  {
>  	return RESUME_HOST;
>  }
> +
> +static int kvmhv_emulate_priv_mtspr(struct kvm_run *run, struct kvm_vcpu=
 *vcpu,
> +				    unsigned int instr)
> +{
> +	return EMULATE_FAIL;
> +}
> +
> +static int kvmhv_emulate_priv_mfspr(struct kvm_run *run, struct kvm_vcpu=
 *vcpu,
> +				    unsigned int instr)
> +{
> +	return EMULATE_FAIL;
> +}
> +
> +static int kvmhv_emulate_priv_op_31(struct kvm_run *run, struct kvm_vcpu=
 *vcpu,
> +				    unsigned int instr)
> +{
> +	return EMULATE_FAIL;
> +}
> +
> +static int kvmhv_emulate_priv_op(struct kvm_run *run, struct kvm_vcpu *v=
cpu,
> +				  unsigned int instr)
> +{
> +	return EMULATE_FAIL;
> +}
> +
> +int kvmhv_emulate_priv(struct kvm_run *run, struct kvm_vcpu *vcpu,
> +			unsigned int instr)
> +{
> +	int rc =3D EMULATE_FAIL;
> +
> +	switch (get_op(instr)) {
> +	case 31:
> +		switch (get_xop(instr)) {
> +		case OP_31_XOP_MTSPR:
> +			rc =3D kvmhv_emulate_priv_mtspr(run, vcpu, instr);
> +			break;
> +		case OP_31_XOP_MFSPR:
> +			rc =3D kvmhv_emulate_priv_mfspr(run, vcpu, instr);
> +			break;
> +		default:
> +			rc =3D kvmhv_emulate_priv_op_31(run, vcpu, instr);
> +			break;
> +		}
> +
> +		if (rc =3D=3D EMULATE_DONE)
> +			kvmppc_set_pc(vcpu, kvmppc_get_pc(vcpu) + 4);
> +		break;
> +	default:
> +		rc =3D kvmhv_emulate_priv_op(run, vcpu, instr);
> +		break;
> +	}
> +
> +	return rc;
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NKtYx2Ppz7d1tORf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu0T9wACgkQbDjKyiDZ
s5JZixAAyWZvk07ErYYCj5T67EIs7SqnZaXplCKqf/MOdlV49Q7/kTRiINIpcwny
11SAxEpv8cf0nyjnTstuPy2RLkxAFmxp2RdtSCeKZc360sL3Cc2kPcGaUOwArYQh
6F4vVOD9rKptlbPzvSllHchszivpKyYb9t3QLwMQiBUaxx35Bx94koMqtXkknPo1
9cusG73rZcIiBpoMr6YIxvzxfKqVbos1pjZkG6NjwZTCCaW1McaFW7NUGfl6PgVe
HC/h9/piH5OQ/TjEkppgW9Myq0GT9CDDSRgrzDVPMK5dIyLUAZX33G+XrzK0u2Gc
PbGJL6GRPt/lVdGkQG9/8UFKq2D4iR/CLaRaxjb3pFbzY2hkKtTkop1/YM+1E4aS
fivU2Y95l37SNp6THcnBFq54zAXaAAEmbwPnWU9yGle3I8VmQqTpXxMxNvbqcapA
MO3FgzQg+UpaeoMpPktZF1WpyaXxIytxPCqzueCa2+e4lWl/fPB+Ok1DEZ3BBFjX
NEJ5pBePyoJUiJZhuY2b5/DJmCKMrCtMQrmfgccUmRudlVfYCssTaeMhYhHPQwIq
+AeRibjjGZ2myAqFqw9SEdmMadLpoTeXBJUX7TYsYOrwYhzY8X83KQluLZwHbIP2
jVVvGl/7P7btAiULlxXdwjqgZYDpElOPTjlkTT8PEudBYkA66ow=
=1O7I
-----END PGP SIGNATURE-----

--NKtYx2Ppz7d1tORf--
