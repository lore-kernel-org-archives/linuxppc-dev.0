Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79187C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 01:35:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF752086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 01:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TXUTo9Yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF752086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44MzKN6tN7zDqMB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 12:35:52 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44MzHd1BcvzDqGN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 12:34:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="TXUTo9Yl"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44MzHc4kCvz9s7h; Mon, 18 Mar 2019 12:34:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552872860;
 bh=YXsOP9Yns5H/sROUL/wO5KPspBjU+b7SkgSoDxF7F2c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TXUTo9YllErjXkW5YiRpvVM2VT1TaM6x7I/Z3h8c2XxCEWfmv/I14v4SQUwAr9QKU
 sRMaPsgljwLqFOrG7E4wv3AV3Tzzgcp668BbBa5NeQ9i0vn/sM+TgReOIByPIUFzcX
 pFtMDklsFLb1uC8NCcRWHp+G+u+ymI3ofT0NZtgc=
Date: Mon, 18 Mar 2019 11:19:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 03/17] KVM: PPC: Book3S HV: XIVE: introduce a new
 capability KVM_CAP_PPC_IRQ_XIVE
Message-ID: <20190318001955.GD6874@umbus.fritz.box>
References: <20190315120609.25910-1-clg@kaod.org>
 <20190315120609.25910-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline
In-Reply-To: <20190315120609.25910-4-clg@kaod.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 01:05:55PM +0100, C=E9dric Le Goater wrote:
> The user interface exposes a new capability KVM_CAP_PPC_IRQ_XIVE to
> let QEMU connect the vCPU presenters to the XIVE KVM device if
> required. The capability is not advertised for now as the full support
> for the XIVE native exploitation mode is not yet available. When this
> is case, the capability will be advertised on PowerNV Hypervisors
> only. Nested guests (pseries KVM Hypervisor) are not supported.
>=20
> Internally, the interface to the new KVM device is protected with a
> new interrupt mode: KVMPPC_IRQ_XIVE.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Though a couple of minor nits are noted below.

> ---
>=20
>  Changes since v2:
>=20
>  - made use of the xive_vp() macro to compute VP identifiers
>  - reworked locking in kvmppc_xive_native_connect_vcpu() to fix races=20
>  - stop advertising KVM_CAP_PPC_IRQ_XIVE as support is not fully
>    available yet=20
> =20
>  arch/powerpc/include/asm/kvm_host.h   |   1 +
>  arch/powerpc/include/asm/kvm_ppc.h    |  13 +++
>  arch/powerpc/kvm/book3s_xive.h        |  11 ++
>  include/uapi/linux/kvm.h              |   1 +
>  arch/powerpc/kvm/book3s_xive.c        |  88 ++++++++-------
>  arch/powerpc/kvm/book3s_xive_native.c | 150 ++++++++++++++++++++++++++
>  arch/powerpc/kvm/powerpc.c            |  36 +++++++
>  Documentation/virtual/kvm/api.txt     |   9 ++
>  8 files changed, 268 insertions(+), 41 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index 9f75a75a07f2..eb8581be0ee8 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -448,6 +448,7 @@ struct kvmppc_passthru_irqmap {
>  #define KVMPPC_IRQ_DEFAULT	0
>  #define KVMPPC_IRQ_MPIC		1
>  #define KVMPPC_IRQ_XICS		2 /* Includes a XIVE option */
> +#define KVMPPC_IRQ_XIVE		3 /* XIVE native exploitation mode */
> =20
>  #define MMIO_HPTE_CACHE_SIZE	4
> =20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index 4b72ddde7dc1..1e61877fe147 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -594,6 +594,14 @@ extern int kvmppc_xive_set_irq(struct kvm *kvm, int =
irq_source_id, u32 irq,
>  			       int level, bool line_status);
>  extern void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu);
> =20
> +static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.irq_type =3D=3D KVMPPC_IRQ_XIVE;
> +}
> +
> +extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
> +					   struct kvm_vcpu *vcpu, u32 cpu);
> +extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
>  extern void kvmppc_xive_native_init_module(void);
>  extern void kvmppc_xive_native_exit_module(void);
> =20
> @@ -621,6 +629,11 @@ static inline int kvmppc_xive_set_irq(struct kvm *kv=
m, int irq_source_id, u32 ir
>  				      int level, bool line_status) { return -ENODEV; }
>  static inline void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu) { }
> =20
> +static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
> +	{ return 0; }
> +static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
> +			  struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
> +static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu=
) { }
>  static inline void kvmppc_xive_native_init_module(void) { }
>  static inline void kvmppc_xive_native_exit_module(void) { }
> =20
> diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xiv=
e.h
> index a08ae6fd4c51..d366df69b9cb 100644
> --- a/arch/powerpc/kvm/book3s_xive.h
> +++ b/arch/powerpc/kvm/book3s_xive.h
> @@ -198,6 +198,11 @@ static inline struct kvmppc_xive_src_block *kvmppc_x=
ive_find_source(struct kvmpp
>  	return xive->src_blocks[bid];
>  }
> =20
> +static inline u32 kvmppc_xive_vp(struct kvmppc_xive *xive, u32 server)
> +{
> +	return xive->vp_base + kvmppc_pack_vcpu_id(xive->kvm, server);
> +}
> +
>  /*
>   * Mapping between guest priorities and host priorities
>   * is as follow.
> @@ -248,5 +253,11 @@ extern int (*__xive_vm_h_ipi)(struct kvm_vcpu *vcpu,=
 unsigned long server,
>  extern int (*__xive_vm_h_cppr)(struct kvm_vcpu *vcpu, unsigned long cppr=
);
>  extern int (*__xive_vm_h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr);
> =20
> +/*
> + * Common Xive routines for XICS-over-XIVE and XIVE native
> + */
> +void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu);
> +int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *v=
cpu);
> +
>  #endif /* CONFIG_KVM_XICS */
>  #endif /* _KVM_PPC_BOOK3S_XICS_H */
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index e6368163d3a0..52bf74a1616e 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -988,6 +988,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_ARM_VM_IPA_SIZE 165
>  #define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
>  #define KVM_CAP_HYPERV_CPUID 167
> +#define KVM_CAP_PPC_IRQ_XIVE 168
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xiv=
e.c
> index f78d002f0fe0..e7f1ada1c3de 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -380,11 +380,6 @@ static int xive_select_target(struct kvm *kvm, u32 *=
server, u8 prio)
>  	return -EBUSY;
>  }
> =20
> -static u32 xive_vp(struct kvmppc_xive *xive, u32 server)
> -{
> -	return xive->vp_base + kvmppc_pack_vcpu_id(xive->kvm, server);
> -}
> -
>  static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
>  			     struct kvmppc_xive_src_block *sb,
>  			     struct kvmppc_xive_irq_state *state)
> @@ -430,8 +425,8 @@ static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
>  	 */
>  	if (xd->flags & OPAL_XIVE_IRQ_MASK_VIA_FW) {
>  		xive_native_configure_irq(hw_num,
> -					  xive_vp(xive, state->act_server),
> -					  MASKED, state->number);
> +				kvmppc_xive_vp(xive, state->act_server),
> +				MASKED, state->number);
>  		/* set old_p so we can track if an H_EOI was done */
>  		state->old_p =3D true;
>  		state->old_q =3D false;
> @@ -486,8 +481,8 @@ static void xive_finish_unmask(struct kvmppc_xive *xi=
ve,
>  	 */
>  	if (xd->flags & OPAL_XIVE_IRQ_MASK_VIA_FW) {
>  		xive_native_configure_irq(hw_num,
> -					  xive_vp(xive, state->act_server),
> -					  state->act_priority, state->number);
> +				kvmppc_xive_vp(xive, state->act_server),
> +				state->act_priority, state->number);
>  		/* If an EOI is needed, do it here */
>  		if (!state->old_p)
>  			xive_vm_source_eoi(hw_num, xd);
> @@ -563,7 +558,7 @@ static int xive_target_interrupt(struct kvm *kvm,
>  	kvmppc_xive_select_irq(state, &hw_num, NULL);
> =20
>  	return xive_native_configure_irq(hw_num,
> -					 xive_vp(xive, server),
> +					 kvmppc_xive_vp(xive, server),
>  					 prio, state->number);
>  }
> =20
> @@ -951,7 +946,7 @@ int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned =
long guest_irq,
>  	 * which is fine for a never started interrupt.
>  	 */
>  	xive_native_configure_irq(hw_irq,
> -				  xive_vp(xive, state->act_server),
> +				  kvmppc_xive_vp(xive, state->act_server),
>  				  state->act_priority, state->number);
> =20
>  	/*
> @@ -1027,7 +1022,7 @@ int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigne=
d long guest_irq,
> =20
>  	/* Reconfigure the IPI */
>  	xive_native_configure_irq(state->ipi_number,
> -				  xive_vp(xive, state->act_server),
> +				  kvmppc_xive_vp(xive, state->act_server),
>  				  state->act_priority, state->number);
> =20
>  	/*
> @@ -1049,7 +1044,7 @@ int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigne=
d long guest_irq,
>  }
>  EXPORT_SYMBOL_GPL(kvmppc_xive_clr_mapped);
> =20
> -static void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
> +void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
>  {
>  	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
>  	struct kvm *kvm =3D vcpu->kvm;
> @@ -1166,7 +1161,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>  	xc->xive =3D xive;
>  	xc->vcpu =3D vcpu;
>  	xc->server_num =3D cpu;
> -	xc->vp_id =3D xive_vp(xive, cpu);
> +	xc->vp_id =3D kvmppc_xive_vp(xive, cpu);
>  	xc->mfrr =3D 0xff;
>  	xc->valid =3D true;
> =20
> @@ -1883,6 +1878,43 @@ static int kvmppc_xive_create(struct kvm_device *d=
ev, u32 type)
>  	return 0;
>  }
> =20
> +int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *v=
cpu)
> +{
> +	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
> +		struct xive_q *q =3D &xc->queues[i];
> +		u32 i0, i1, idx;
> +
> +		if (!q->qpage && !xc->esc_virq[i])
> +			continue;
> +
> +		seq_printf(m, " [q%d]: ", i);
> +
> +		if (q->qpage) {
> +			idx =3D q->idx;
> +			i0 =3D be32_to_cpup(q->qpage + idx);
> +			idx =3D (idx + 1) & q->msk;
> +			i1 =3D be32_to_cpup(q->qpage + idx);
> +			seq_printf(m, "T=3D%d %08x %08x...\n", q->toggle,
> +				   i0, i1);
> +		}
> +		if (xc->esc_virq[i]) {
> +			struct irq_data *d =3D irq_get_irq_data(xc->esc_virq[i]);
> +			struct xive_irq_data *xd =3D
> +				irq_data_get_irq_handler_data(d);
> +			u64 pq =3D xive_vm_esb_load(xd, XIVE_ESB_GET);
> +
> +			seq_printf(m, "E:%c%c I(%d:%llx:%llx)",
> +				   (pq & XIVE_ESB_VAL_P) ? 'P' : 'p',
> +				   (pq & XIVE_ESB_VAL_Q) ? 'Q' : 'q',
> +				   xc->esc_virq[i], pq, xd->eoi_page);
> +			seq_puts(m, "\n");
> +		}
> +	}
> +	return 0;
> +}
> =20
>  static int xive_debug_show(struct seq_file *m, void *private)
>  {
> @@ -1908,7 +1940,6 @@ static int xive_debug_show(struct seq_file *m, void=
 *private)
> =20
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> -		unsigned int i;
> =20
>  		if (!xc)
>  			continue;
> @@ -1918,33 +1949,8 @@ static int xive_debug_show(struct seq_file *m, voi=
d *private)
>  			   xc->server_num, xc->cppr, xc->hw_cppr,
>  			   xc->mfrr, xc->pending,
>  			   xc->stat_rm_h_xirr, xc->stat_vm_h_xirr);
> -		for (i =3D 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
> -			struct xive_q *q =3D &xc->queues[i];
> -			u32 i0, i1, idx;
> =20
> -			if (!q->qpage && !xc->esc_virq[i])
> -				continue;
> -
> -			seq_printf(m, " [q%d]: ", i);
> -
> -			if (q->qpage) {
> -				idx =3D q->idx;
> -				i0 =3D be32_to_cpup(q->qpage + idx);
> -				idx =3D (idx + 1) & q->msk;
> -				i1 =3D be32_to_cpup(q->qpage + idx);
> -				seq_printf(m, "T=3D%d %08x %08x... \n", q->toggle, i0, i1);
> -			}
> -			if (xc->esc_virq[i]) {
> -				struct irq_data *d =3D irq_get_irq_data(xc->esc_virq[i]);
> -				struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(d);
> -				u64 pq =3D xive_vm_esb_load(xd, XIVE_ESB_GET);
> -				seq_printf(m, "E:%c%c I(%d:%llx:%llx)",
> -					   (pq & XIVE_ESB_VAL_P) ? 'P' : 'p',
> -					   (pq & XIVE_ESB_VAL_Q) ? 'Q' : 'q',
> -					   xc->esc_virq[i], pq, xd->eoi_page);
> -				seq_printf(m, "\n");
> -			}
> -		}
> +		kvmppc_xive_debug_show_queues(m, vcpu);
> =20
>  		t_rm_h_xirr +=3D xc->stat_rm_h_xirr;
>  		t_rm_h_ipoll +=3D xc->stat_rm_h_ipoll;
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index 76d45bcc7060..a078f99bc156 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -31,6 +31,134 @@
> =20
>  #include "book3s_xive.h"
> =20
> +static void kvmppc_xive_native_cleanup_queue(struct kvm_vcpu *vcpu, int =
prio)
> +{
> +	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> +	struct xive_q *q =3D &xc->queues[prio];
> +
> +	xive_native_disable_queue(xc->vp_id, q, prio);
> +	if (q->qpage) {
> +		put_page(virt_to_page(q->qpage));
> +		q->qpage =3D NULL;
> +	}
> +}
> +
> +void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu)
> +{
> +	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> +	int i;
> +
> +	if (!kvmppc_xive_enabled(vcpu))
> +		return;
> +
> +	if (!xc)
> +		return;
> +
> +	pr_devel("native_cleanup_vcpu(cpu=3D%d)\n", xc->server_num);
> +
> +	/* Ensure no interrupt is still routed to that VP */
> +	xc->valid =3D false;
> +	kvmppc_xive_disable_vcpu_interrupts(vcpu);
> +
> +	/* Disable the VP */
> +	xive_native_disable_vp(xc->vp_id);
> +
> +	/* Free the queues & associated interrupts */
> +	for (i =3D 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
> +		/* Free the escalation irq */
> +		if (xc->esc_virq[i]) {
> +			free_irq(xc->esc_virq[i], vcpu);
> +			irq_dispose_mapping(xc->esc_virq[i]);
> +			kfree(xc->esc_virq_names[i]);
> +			xc->esc_virq[i] =3D 0;

Should that actually be NO_IRQ on the right (it evaluates to the same
thing).  Fine to fix that as a later followup.

> +		}
> +
> +		/* Free the queue */
> +		kvmppc_xive_native_cleanup_queue(vcpu, i);
> +	}
> +
> +	/* Free the VP */
> +	kfree(xc);
> +
> +	/* Cleanup the vcpu */
> +	vcpu->arch.irq_type =3D KVMPPC_IRQ_DEFAULT;
> +	vcpu->arch.xive_vcpu =3D NULL;
> +}
> +
> +int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
> +				    struct kvm_vcpu *vcpu, u32 server_num)
> +{
> +	struct kvmppc_xive *xive =3D dev->private;
> +	struct kvmppc_xive_vcpu *xc =3D NULL;
> +	int rc;
> +
> +	pr_devel("native_connect_vcpu(server=3D%d)\n", server_num);
> +
> +	if (dev->ops !=3D &kvm_xive_native_ops) {
> +		pr_devel("Wrong ops !\n");
> +		return -EPERM;
> +	}
> +	if (xive->kvm !=3D vcpu->kvm)
> +		return -EPERM;
> +	if (vcpu->arch.irq_type !=3D KVMPPC_IRQ_DEFAULT)
> +		return -EBUSY;
> +	if (server_num >=3D KVM_MAX_VCPUS) {
> +		pr_devel("Out of bounds !\n");
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&vcpu->kvm->lock);
> +
> +	if (kvmppc_xive_find_server(vcpu->kvm, server_num)) {
> +		pr_devel("Duplicate !\n");
> +		rc =3D -EEXIST;
> +		goto bail;
> +	}
> +
> +	xc =3D kzalloc(sizeof(*xc), GFP_KERNEL);
> +	if (!xc) {
> +		rc =3D -ENOMEM;
> +		goto bail;
> +	}
> +
> +	vcpu->arch.xive_vcpu =3D xc;
> +	xc->xive =3D xive;
> +	xc->vcpu =3D vcpu;
> +	xc->server_num =3D server_num;
> +
> +	xc->vp_id =3D kvmppc_xive_vp(xive, server_num);
> +	xc->valid =3D true;

This 'valid' field doesn't seem useful, since it's initialized to true
immediately after allocating xc and set to false moments before
free()ing it. ..and I can't see anything that tests it.

Again, ok to deal with that as a later cleanup.

> +	vcpu->arch.irq_type =3D KVMPPC_IRQ_XIVE;
> +
> +	rc =3D xive_native_get_vp_info(xc->vp_id, &xc->vp_cam, &xc->vp_chip_id);
> +	if (rc) {
> +		pr_err("Failed to get VP info from OPAL: %d\n", rc);
> +		goto bail;
> +	}
> +
> +	/*
> +	 * Enable the VP first as the single escalation mode will
> +	 * affect escalation interrupts numbering
> +	 */
> +	rc =3D xive_native_enable_vp(xc->vp_id, xive->single_escalation);
> +	if (rc) {
> +		pr_err("Failed to enable VP in OPAL: %d\n", rc);
> +		goto bail;
> +	}
> +
> +	/* Configure VCPU fields for use by assembly push/pull */
> +	vcpu->arch.xive_saved_state.w01 =3D cpu_to_be64(0xff000000);
> +	vcpu->arch.xive_cam_word =3D cpu_to_be32(xc->vp_cam | TM_QW1W2_VO);
> +
> +	/* TODO: reset all queues to a clean state ? */
> +bail:
> +	mutex_unlock(&vcpu->kvm->lock);
> +	if (rc)
> +		kvmppc_xive_native_cleanup_vcpu(vcpu);
> +
> +	return rc;
> +}
> +
>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>  				       struct kvm_device_attr *attr)
>  {
> @@ -119,10 +247,32 @@ static int xive_native_debug_show(struct seq_file *=
m, void *private)
>  {
>  	struct kvmppc_xive *xive =3D m->private;
>  	struct kvm *kvm =3D xive->kvm;
> +	struct kvm_vcpu *vcpu;
> +	unsigned int i;
> =20
>  	if (!kvm)
>  		return 0;
> =20
> +	seq_puts(m, "=3D=3D=3D=3D=3D=3D=3D=3D=3D\nVCPU state\n=3D=3D=3D=3D=3D=
=3D=3D=3D=3D\n");
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> +
> +		if (!xc)
> +			continue;
> +
> +		seq_printf(m, "cpu server %#x NSR=3D%02x CPPR=3D%02x IBP=3D%02x PIPR=
=3D%02x w01=3D%016llx w2=3D%08x\n",
> +			   xc->server_num,
> +			   vcpu->arch.xive_saved_state.nsr,
> +			   vcpu->arch.xive_saved_state.cppr,
> +			   vcpu->arch.xive_saved_state.ipb,
> +			   vcpu->arch.xive_saved_state.pipr,
> +			   vcpu->arch.xive_saved_state.w01,
> +			   (u32) vcpu->arch.xive_cam_word);
> +
> +		kvmppc_xive_debug_show_queues(m, vcpu);
> +	}
> +
>  	return 0;
>  }
> =20
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 8c69af10f91d..bb51faf29162 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -570,6 +570,15 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lo=
ng ext)
>  	case KVM_CAP_PPC_GET_CPU_CHAR:
>  		r =3D 1;
>  		break;
> +#ifdef CONFIG_KVM_XIVE
> +	case KVM_CAP_PPC_IRQ_XIVE:
> +		/*
> +		 * Return false until all the XIVE infrastructure is
> +		 * in place including support for migration.
> +		 */
> +		r =3D 0;
> +		break;
> +#endif
> =20
>  	case KVM_CAP_PPC_ALLOC_HTAB:
>  		r =3D hv_enabled;
> @@ -753,6 +762,9 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
>  		else
>  			kvmppc_xics_free_icp(vcpu);
>  		break;
> +	case KVMPPC_IRQ_XIVE:
> +		kvmppc_xive_native_cleanup_vcpu(vcpu);
> +		break;
>  	}
> =20
>  	kvmppc_core_vcpu_free(vcpu);
> @@ -1941,6 +1953,30 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vc=
pu *vcpu,
>  		break;
>  	}
>  #endif /* CONFIG_KVM_XICS */
> +#ifdef CONFIG_KVM_XIVE
> +	case KVM_CAP_PPC_IRQ_XIVE: {
> +		struct fd f;
> +		struct kvm_device *dev;
> +
> +		r =3D -EBADF;
> +		f =3D fdget(cap->args[0]);
> +		if (!f.file)
> +			break;
> +
> +		r =3D -ENXIO;
> +		if (!xive_enabled())
> +			break;
> +
> +		r =3D -EPERM;
> +		dev =3D kvm_device_from_filp(f.file);
> +		if (dev)
> +			r =3D kvmppc_xive_native_connect_vcpu(dev, vcpu,
> +							    cap->args[1]);
> +
> +		fdput(f);
> +		break;
> +	}
> +#endif /* CONFIG_KVM_XIVE */
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  	case KVM_CAP_PPC_FWNMI:
>  		r =3D -EINVAL;
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kv=
m/api.txt
> index 356156f5c52d..1db1435769b4 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4458,6 +4458,15 @@ struct kvm_sync_regs {
>          struct kvm_vcpu_events events;
>  };
> =20
> +6.75 KVM_CAP_PPC_IRQ_XIVE
> +
> +Architectures: ppc
> +Target: vcpu
> +Parameters: args[0] is the XIVE device fd
> +            args[1] is the XIVE CPU number (server ID) for this vcpu
> +
> +This capability connects the vcpu to an in-kernel XIVE device.
> +
>  7. Capabilities that can be enabled on VMs
>  ------------------------------------------
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyO5CkACgkQbDjKyiDZ
s5J4Rg//e6BUccRCY+XkZbiFfFBfl1AO7JKQ1/hkjQ7TvK5TjSQD/XIHhaxwWk9+
ot6wBX7KnZLe+3zzGKJbL5IyxO1rSvE/lM/hr7gs4ymHyJx08nbACxDeAZUhF/hW
BRxvuH6FTAzdvoLatzcJcOX4gOHpXf02OSXsaHm3DBepX9ocPXkfES4UWqobueL8
TsN8fAJ8w2kvGeRY7vMz1MtDq4UiJbQOgi0SxaiN6pSNjE0tugjfmuKByeOVjApl
dK4SruCg7P6nPw0wNDagjYrXi8C6ERohihRsBFv55HnIXgBhQnb8rnik0jdONeZD
4I270dUbYcsfd6oWroUEGm/QoZXgKDepQg+SKTIZE+Z5BQ/PYAMI0AXdnzV2vNHH
XzFAybLiJbdhDWWodvM83YUYmBzB5ugWPt6hvIlBm+B/6wbbXV8lGrrDQ5p7nRlC
Dz6iHAm1Vda6Z95qcxaOCBT6VrAevIQQwMDEOa7rNFsIYnI+fjyeVkHoP4koUe2u
0AV2YEtdG1CDDINDuYD8b6MWwcWLCT7VafS6YQ7kNlERDG1Qm5Ygkyq+zjNilIbn
C2vSe40gJ/eegT88ush7oI7fPFgieGHKTOWnO+NPMMXFwU0SaqugKpFBqvZ7nToc
msorZ7Fw4GWXp/EWVNIjXOLtZo1L58qTnQJYmoMwHbTUpSnN6Is=
=RHqe
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
