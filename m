Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3EAC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:23:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D34420834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="X84jLyw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D34420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RJ873mkPzF3LT
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:23:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="X84jLyw9";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RGjX5lJJzF3Fc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:19:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="X84jLyw9"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42RGjX55BLz9sBk; Fri,  5 Oct 2018 14:19:12 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42RGjX3Pg3z9s7W; Fri,  5 Oct 2018 14:19:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538713152;
 bh=9pyt0QSPzuf6T+xI/njALan9TTmc/gNZKpi7kHDRIVs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X84jLyw9ReikZPQlqJhj0nKtaq7EbPHZxD2wFQOLqsX+j+diKCqYWCE8qchtxIVzi
 uTLyAb38AEEkYDXqUjGNiSzyGHPgTUP013TVTzrx3kHqpGQpAJXdG1jAlnx2YReIcY
 XZ9ayfEPzS9PpFFQPwrxqNNtPlB9BgV7upDGr1ik=
Date: Fri, 5 Oct 2018 14:09:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v4 25/32] KVM: PPC: Book3S HV: Invalidate TLB when nested
 vcpu moves physical cpu
Message-ID: <20181005040908.GK7004@umbus.fritz.box>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
 <1538654169-15602-26-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sdEQJo40s7ofW8iR"
Content-Disposition: inline
In-Reply-To: <1538654169-15602-26-git-send-email-paulus@ozlabs.org>
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


--sdEQJo40s7ofW8iR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2018 at 09:56:02PM +1000, Paul Mackerras wrote:
> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20
> This is only done at level 0, since only level 0 knows which physical
> CPU a vcpu is running on.  This does for nested guests what L0 already
> did for its own guests, which is to flush the TLB on a pCPU when it
> goes to run a vCPU there, and there is another vCPU in the same VM
> which previously ran on this pCPU and has now started to run on another
> pCPU.  This is to handle the situation where the other vCPU touched
> a mapping, moved to another pCPU and did a tlbiel (local-only tlbie)
> on that new pCPU and thus left behind a stale TLB entry on this pCPU.
>=20
> This introduces a limit on the the vcpu_token values used in the
> H_ENTER_NESTED hcall -- they must now be less than NR_CPUS.

This does make the vcpu tokens no longer entirely opaque to the L0.
It works for now, because the only L1 is Linux and we know basically
how it allocates those tokens.  Eventually we probably want some way
to either remove this restriction or to advertise the limit to the L1.

> [paulus@ozlabs.org - made prev_cpu array be unsigned short[] to reduce
>  memory consumption.]
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/kvm_book3s_64.h |   3 +
>  arch/powerpc/kvm/book3s_hv.c             | 101 +++++++++++++++++++------=
------
>  arch/powerpc/kvm/book3s_hv_nested.c      |   5 ++
>  3 files changed, 71 insertions(+), 38 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/incl=
ude/asm/kvm_book3s_64.h
> index aa5bf85..1e96027 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> @@ -52,6 +52,9 @@ struct kvm_nested_guest {
>  	long refcnt;			/* number of pointers to this struct */
>  	struct mutex tlb_lock;		/* serialize page faults and tlbies */
>  	struct kvm_nested_guest *next;
> +	cpumask_t need_tlb_flush;
> +	cpumask_t cpu_in_guest;
> +	unsigned short prev_cpu[NR_CPUS];
>  };
> =20
>  /*
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index ba58883..53a967ea 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -2397,10 +2397,18 @@ static void kvmppc_release_hwthread(int cpu)
> =20
>  static void radix_flush_cpu(struct kvm *kvm, int cpu, struct kvm_vcpu *v=
cpu)
>  {
> +	struct kvm_nested_guest *nested =3D vcpu->arch.nested;
> +	cpumask_t *cpu_in_guest;
>  	int i;
> =20
>  	cpu =3D cpu_first_thread_sibling(cpu);
> -	cpumask_set_cpu(cpu, &kvm->arch.need_tlb_flush);
> +	if (nested) {
> +		cpumask_set_cpu(cpu, &nested->need_tlb_flush);
> +		cpu_in_guest =3D &nested->cpu_in_guest;
> +	} else {
> +		cpumask_set_cpu(cpu, &kvm->arch.need_tlb_flush);
> +		cpu_in_guest =3D &kvm->arch.cpu_in_guest;
> +	}
>  	/*
>  	 * Make sure setting of bit in need_tlb_flush precedes
>  	 * testing of cpu_in_guest bits.  The matching barrier on
> @@ -2408,13 +2416,23 @@ static void radix_flush_cpu(struct kvm *kvm, int =
cpu, struct kvm_vcpu *vcpu)
>  	 */
>  	smp_mb();
>  	for (i =3D 0; i < threads_per_core; ++i)
> -		if (cpumask_test_cpu(cpu + i, &kvm->arch.cpu_in_guest))
> +		if (cpumask_test_cpu(cpu + i, cpu_in_guest))
>  			smp_call_function_single(cpu + i, do_nothing, NULL, 1);
>  }
> =20
>  static void kvmppc_prepare_radix_vcpu(struct kvm_vcpu *vcpu, int pcpu)
>  {
> +	struct kvm_nested_guest *nested =3D vcpu->arch.nested;
>  	struct kvm *kvm =3D vcpu->kvm;
> +	int prev_cpu;
> +
> +	if (!cpu_has_feature(CPU_FTR_HVMODE))
> +		return;
> +
> +	if (nested)
> +		prev_cpu =3D nested->prev_cpu[vcpu->arch.nested_vcpu_id];
> +	else
> +		prev_cpu =3D vcpu->arch.prev_cpu;
> =20
>  	/*
>  	 * With radix, the guest can do TLB invalidations itself,
> @@ -2428,12 +2446,46 @@ static void kvmppc_prepare_radix_vcpu(struct kvm_=
vcpu *vcpu, int pcpu)
>  	 * ran to flush the TLB.  The TLB is shared between threads,
>  	 * so we use a single bit in .need_tlb_flush for all 4 threads.
>  	 */
> -	if (vcpu->arch.prev_cpu !=3D pcpu) {
> -		if (vcpu->arch.prev_cpu >=3D 0 &&
> -		    cpu_first_thread_sibling(vcpu->arch.prev_cpu) !=3D
> +	if (prev_cpu !=3D pcpu) {
> +		if (prev_cpu >=3D 0 &&
> +		    cpu_first_thread_sibling(prev_cpu) !=3D
>  		    cpu_first_thread_sibling(pcpu))
> -			radix_flush_cpu(kvm, vcpu->arch.prev_cpu, vcpu);
> -		vcpu->arch.prev_cpu =3D pcpu;
> +			radix_flush_cpu(kvm, prev_cpu, vcpu);
> +		if (nested)
> +			nested->prev_cpu[vcpu->arch.nested_vcpu_id] =3D pcpu;
> +		else
> +			vcpu->arch.prev_cpu =3D pcpu;
> +	}
> +}
> +
> +static void kvmppc_radix_check_need_tlb_flush(struct kvm *kvm, int pcpu,
> +					      struct kvm_nested_guest *nested)
> +{
> +	cpumask_t *need_tlb_flush;
> +	int lpid;
> +
> +	if (!cpu_has_feature(CPU_FTR_HVMODE))
> +		return;
> +
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		pcpu &=3D ~0x3UL;
> +
> +	if (nested) {
> +		lpid =3D nested->shadow_lpid;
> +		need_tlb_flush =3D &nested->need_tlb_flush;
> +	} else {
> +		lpid =3D kvm->arch.lpid;
> +		need_tlb_flush =3D &kvm->arch.need_tlb_flush;
> +	}
> +
> +	mtspr(SPRN_LPID, lpid);
> +	isync();
> +	smp_mb();
> +
> +	if (cpumask_test_cpu(pcpu, need_tlb_flush)) {
> +		radix__local_flush_tlb_lpid_guest(lpid);
> +		/* Clear the bit after the TLB flush */
> +		cpumask_clear_cpu(pcpu, need_tlb_flush);
>  	}
>  }
> =20
> @@ -3127,8 +3179,6 @@ static noinline void kvmppc_run_core(struct kvmppc_=
vcore *vc)
>  		spin_unlock(&core_info.vc[sub]->lock);
> =20
>  	if (kvm_is_radix(vc->kvm)) {
> -		int tmp =3D pcpu;
> -
>  		/*
>  		 * Do we need to flush the process scoped TLB for the LPAR?
>  		 *
> @@ -3139,17 +3189,7 @@ static noinline void kvmppc_run_core(struct kvmppc=
_vcore *vc)
>  		 *
>  		 * Hash must be flushed in realmode in order to use tlbiel.
>  		 */
> -		mtspr(SPRN_LPID, vc->kvm->arch.lpid);
> -		isync();
> -
> -		if (cpu_has_feature(CPU_FTR_ARCH_300))
> -			tmp &=3D ~0x3UL;
> -
> -		if (cpumask_test_cpu(tmp, &vc->kvm->arch.need_tlb_flush)) {
> -			radix__local_flush_tlb_lpid_guest(vc->kvm->arch.lpid);
> -			/* Clear the bit after the TLB flush */
> -			cpumask_clear_cpu(tmp, &vc->kvm->arch.need_tlb_flush);
> -		}
> +		kvmppc_radix_check_need_tlb_flush(vc->kvm, pcpu, NULL);
>  	}
> =20
>  	/*
> @@ -3868,11 +3908,10 @@ int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
>  			  struct kvm_vcpu *vcpu, u64 time_limit,
>  			  unsigned long lpcr)
>  {
> -	int trap, r, pcpu, pcpu0;
> +	int trap, r, pcpu;
>  	int srcu_idx;
>  	struct kvmppc_vcore *vc;
>  	struct kvm_nested_guest *nested =3D vcpu->arch.nested;
> -	unsigned long lpid;
> =20
>  	trace_kvmppc_run_vcpu_enter(vcpu);
> =20
> @@ -3945,22 +3984,8 @@ int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
>  	vc->vcore_state =3D VCORE_RUNNING;
>  	trace_kvmppc_run_core(vc, 0);
> =20
> -	lpid =3D vc->kvm->arch.lpid;
> -	if (nested)
> -		lpid =3D nested->shadow_lpid;
> -	mtspr(SPRN_LPID, lpid);
> -	isync();
> -
> -	/* See comment above in kvmppc_run_core() about this */
> -	pcpu0 =3D pcpu;
> -	if (cpu_has_feature(CPU_FTR_ARCH_300))
> -		pcpu0 &=3D ~0x3UL;
> -
> -	if (cpumask_test_cpu(pcpu0, &vc->kvm->arch.need_tlb_flush)) {
> -		radix__local_flush_tlb_lpid_guest(lpid);
> -		/* Clear the bit after the TLB flush */
> -		cpumask_clear_cpu(pcpu0, &vc->kvm->arch.need_tlb_flush);
> -	}
> +	if (cpu_has_feature(CPU_FTR_HVMODE))
> +		kvmppc_radix_check_need_tlb_flush(vc->kvm, pcpu, nested);
> =20
>  	trace_hardirqs_on();
>  	guest_enter_irqoff();
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3=
s_hv_nested.c
> index 35f8111..1a8c40d 100644
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -167,6 +167,9 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
>  	if (err)
>  		return H_PARAMETER;
> =20
> +	if (l2_hv.vcpu_token >=3D NR_CPUS)
> +		return H_PARAMETER;
> +
>  	/* translate lpid */
>  	l2 =3D kvmhv_get_nested(vcpu->kvm, l2_hv.lpid, true);
>  	if (!l2)
> @@ -411,6 +414,8 @@ struct kvm_nested_guest *kvmhv_alloc_nested(struct kv=
m *kvm, unsigned int lpid)
>  		goto out_free2;
>  	gp->shadow_lpid =3D shadow_lpid;
> =20
> +	memset(gp->prev_cpu, -1, sizeof(gp->prev_cpu));
> +
>  	return gp;
> =20
>   out_free2:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sdEQJo40s7ofW8iR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu24+EACgkQbDjKyiDZ
s5I1XhAAr10Pm3cgEDm4Yr5N83SakRnlq0gTqkCfVOZ8xBzGhH0KMbTIuek3cV+F
5aBZ7LquNB+/EMz0LNdXKsNrd2vX4638bX2uRlnPPlA6OyJLQgmfyK+At3EYUMf+
QidAiFW1/MWfTrEOmmd77XeotzVL8zxoph7KtYtxy9bKcVAJyq+g7Hfya3nErweq
72knnL/O4H18m7vOtSTSBrbpccuBymSvd2sd9IHWBFPHZsrjeuqIZXizfxYtsxKK
RN1ALH8wPsRjgh2cMfLsCK0tB5jszJUas+bB3CvRPbQewEcS3c5tAqJKJsGbC78r
bW53Ut0JmNohaQV28/iKWMWSwbQ2aSAE4CdE+ZQrzhaQftIM8u5SnA+ACNzm98xn
gjkBHzPSMZ98/1ClPdRlohRvB7YcqgqMB1ELJdPscXCL1yRlxrcYiwMh4wpx3qbb
xTegPorjOFOxuXi7zrRGQ5wcO9RALkYwBqlBSEq2HwubAkPsNS2kpyn0y3Il82Lu
G+I3XyUo56Aok+jOSf17MNTa1biTvS6LHCFUrI/006kP5btu0jidre+9VLV/J563
CokYPCGHBv+coz8ISa3httYv8TXCSw6XxxgBxsa3GAf975nZR6mc6q3TD0bRGMeG
tRqSfsg5iNd2eoSbYDzjJC/Aeze0GGOUL77+qsVjy0n/mhMHh+0=
=gTQn
-----END PGP SIGNATURE-----

--sdEQJo40s7ofW8iR--
