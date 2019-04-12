Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC869C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 05:43:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D588120818
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 05:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="C9cspdux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D588120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gRcx2grMzDqTv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 15:42:57 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gRbC3qmwzDqT9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 15:41:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="C9cspdux"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44gRbB6kfTz9s4V; Fri, 12 Apr 2019 15:41:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1555047686;
 bh=37v+hbo4g2a45ABH9HMQWtoGqBIVItnynd8XcAIs5sQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C9cspduxRfrNPc2WYPpba0CywhdY+gfcdbW82W+ijXaz/CFfD0McOgpb6IvedyqBd
 xmVOQ9hFgTXX8bmcSYETqYa+3IRELXgAMt3hNMpfFfJ1ZFaDnIZWNbobJragAWZtXw
 og3gwlkROq0gE9fjOS24BWwStyBZsmHB2N/XquLk=
Date: Fri, 12 Apr 2019 15:19:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v5 06/16] KVM: PPC: Book3S HV: XIVE: add controls for the
 EQ configuration
Message-ID: <20190412051952.GA8005@umbus.fritz.box>
References: <20190410170448.3923-1-clg@kaod.org>
 <20190410170448.3923-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20190410170448.3923-7-clg@kaod.org>
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


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2019 at 07:04:38PM +0200, C=E9dric Le Goater wrote:
> These controls will be used by the H_INT_SET_QUEUE_CONFIG and
> H_INT_GET_QUEUE_CONFIG hcalls from QEMU to configure the underlying
> Event Queue in the XIVE IC. They will also be used to restore the
> configuration of the XIVE EQs and to capture the internal run-time
> state of the EQs. Both 'get' and 'set' rely on an OPAL call to access
> the EQ toggle bit and EQ index which are updated by the XIVE IC when
> event notifications are enqueued in the EQ.
>=20
> The value of the guest physical address of the event queue is saved in
> the XIVE internal xive_q structure for later use. That is when
> migration needs to mark the EQ pages dirty to capture a consistent
> memory state of the VM.
>=20
> To be noted that H_INT_SET_QUEUE_CONFIG does not require the extra
> OPAL call setting the EQ toggle bit and EQ index to configure the EQ,
> but restoring the EQ state will.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>  Changes since v4 :
>=20
>  - add check on EQ page alignment
>  - add requirement on KVM_XIVE_EQ_ALWAYS_NOTIFY
>=20
>  arch/powerpc/include/asm/xive.h            |   2 +
>  arch/powerpc/include/uapi/asm/kvm.h        |  19 ++
>  arch/powerpc/kvm/book3s_xive.h             |   2 +
>  arch/powerpc/kvm/book3s_xive.c             |  15 +-
>  arch/powerpc/kvm/book3s_xive_native.c      | 249 +++++++++++++++++++++
>  Documentation/virtual/kvm/devices/xive.txt |  34 +++
>  6 files changed, 315 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/x=
ive.h
> index b579a943407b..c4e88abd3b67 100644
> --- a/arch/powerpc/include/asm/xive.h
> +++ b/arch/powerpc/include/asm/xive.h
> @@ -73,6 +73,8 @@ struct xive_q {
>  	u32			esc_irq;
>  	atomic_t		count;
>  	atomic_t		pending_count;
> +	u64			guest_qaddr;
> +	u32			guest_qshift;
>  };
> =20
>  /* Global enable flags for the XIVE support */
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index e8161e21629b..85005400fd86 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -681,6 +681,7 @@ struct kvm_ppc_cpu_char {
>  #define KVM_DEV_XIVE_GRP_CTRL		1
>  #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
>  #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier */
> +#define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit EQ identifier */
> =20
>  /* Layout of 64-bit XIVE source attribute values */
>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
> @@ -696,4 +697,22 @@ struct kvm_ppc_cpu_char {
>  #define KVM_XIVE_SOURCE_EISN_SHIFT	33
>  #define KVM_XIVE_SOURCE_EISN_MASK	0xfffffffe00000000ULL
> =20
> +/* Layout of 64-bit EQ identifier */
> +#define KVM_XIVE_EQ_PRIORITY_SHIFT	0
> +#define KVM_XIVE_EQ_PRIORITY_MASK	0x7
> +#define KVM_XIVE_EQ_SERVER_SHIFT	3
> +#define KVM_XIVE_EQ_SERVER_MASK		0xfffffff8ULL
> +
> +/* Layout of EQ configuration values (64 bytes) */
> +struct kvm_ppc_xive_eq {
> +	__u32 flags;
> +	__u32 qshift;
> +	__u64 qaddr;
> +	__u32 qtoggle;
> +	__u32 qindex;
> +	__u8  pad[40];
> +};
> +
> +#define KVM_XIVE_EQ_ALWAYS_NOTIFY	0x00000001
> +
>  #endif /* __LINUX_KVM_POWERPC_H */
> diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xiv=
e.h
> index ae26fe653d98..622f594d93e1 100644
> --- a/arch/powerpc/kvm/book3s_xive.h
> +++ b/arch/powerpc/kvm/book3s_xive.h
> @@ -272,6 +272,8 @@ struct kvmppc_xive_src_block *kvmppc_xive_create_src_=
block(
>  	struct kvmppc_xive *xive, int irq);
>  void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
>  int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio);
> +int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio,
> +				  bool single_escalation);
> =20
>  #endif /* CONFIG_KVM_XICS */
>  #endif /* _KVM_PPC_BOOK3S_XICS_H */
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xiv=
e.c
> index e09f3addffe5..c1b7aa7dbc28 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -166,7 +166,8 @@ static irqreturn_t xive_esc_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
> =20
> -static int xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio)
> +int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio,
> +				  bool single_escalation)
>  {
>  	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
>  	struct xive_q *q =3D &xc->queues[prio];
> @@ -185,7 +186,7 @@ static int xive_attach_escalation(struct kvm_vcpu *vc=
pu, u8 prio)
>  		return -EIO;
>  	}
> =20
> -	if (xc->xive->single_escalation)
> +	if (single_escalation)
>  		name =3D kasprintf(GFP_KERNEL, "kvm-%d-%d",
>  				 vcpu->kvm->arch.lpid, xc->server_num);
>  	else
> @@ -217,7 +218,7 @@ static int xive_attach_escalation(struct kvm_vcpu *vc=
pu, u8 prio)
>  	 * interrupt, thus leaving it effectively masked after
>  	 * it fires once.
>  	 */
> -	if (xc->xive->single_escalation) {
> +	if (single_escalation) {
>  		struct irq_data *d =3D irq_get_irq_data(xc->esc_virq[prio]);
>  		struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(d);
> =20
> @@ -291,7 +292,8 @@ static int xive_check_provisioning(struct kvm *kvm, u=
8 prio)
>  			continue;
>  		rc =3D xive_provision_queue(vcpu, prio);
>  		if (rc =3D=3D 0 && !xive->single_escalation)
> -			xive_attach_escalation(vcpu, prio);
> +			kvmppc_xive_attach_escalation(vcpu, prio,
> +						      xive->single_escalation);
>  		if (rc)
>  			return rc;
>  	}
> @@ -1214,7 +1216,8 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>  		if (xive->qmap & (1 << i)) {
>  			r =3D xive_provision_queue(vcpu, i);
>  			if (r =3D=3D 0 && !xive->single_escalation)
> -				xive_attach_escalation(vcpu, i);
> +				kvmppc_xive_attach_escalation(
> +					vcpu, i, xive->single_escalation);
>  			if (r)
>  				goto bail;
>  		} else {
> @@ -1229,7 +1232,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>  	}
> =20
>  	/* If not done above, attach priority 0 escalation */
> -	r =3D xive_attach_escalation(vcpu, 0);
> +	r =3D kvmppc_xive_attach_escalation(vcpu, 0, xive->single_escalation);
>  	if (r)
>  		goto bail;
> =20
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index 492825a35958..3e7cdcacc932 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -335,6 +335,243 @@ static int kvmppc_xive_native_set_source_config(str=
uct kvmppc_xive *xive,
>  						       priority, masked, eisn);
>  }
> =20
> +static int xive_native_validate_queue_size(u32 qshift)
> +{
> +	/*
> +	 * We only support 64K pages for the moment. This is also
> +	 * advertised in the DT property "ibm,xive-eq-sizes"
> +	 */
> +	switch (qshift) {
> +	case 0: /* EQ reset */
> +	case 16:
> +		return 0;
> +	case 12:
> +	case 21:
> +	case 24:
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int kvmppc_xive_native_set_queue_config(struct kvmppc_xive *xive,
> +					       long eq_idx, u64 addr)
> +{
> +	struct kvm *kvm =3D xive->kvm;
> +	struct kvm_vcpu *vcpu;
> +	struct kvmppc_xive_vcpu *xc;
> +	void __user *ubufp =3D (void __user *) addr;
> +	u32 server;
> +	u8 priority;
> +	struct kvm_ppc_xive_eq kvm_eq;
> +	int rc;
> +	__be32 *qaddr =3D 0;
> +	struct page *page;
> +	struct xive_q *q;
> +	gfn_t gfn;
> +	unsigned long page_size;
> +
> +	/*
> +	 * Demangle priority/server tuple from the EQ identifier
> +	 */
> +	priority =3D (eq_idx & KVM_XIVE_EQ_PRIORITY_MASK) >>
> +		KVM_XIVE_EQ_PRIORITY_SHIFT;
> +	server =3D (eq_idx & KVM_XIVE_EQ_SERVER_MASK) >>
> +		KVM_XIVE_EQ_SERVER_SHIFT;
> +
> +	if (copy_from_user(&kvm_eq, ubufp, sizeof(kvm_eq)))
> +		return -EFAULT;
> +
> +	vcpu =3D kvmppc_xive_find_server(kvm, server);
> +	if (!vcpu) {
> +		pr_err("Can't find server %d\n", server);
> +		return -ENOENT;
> +	}
> +	xc =3D vcpu->arch.xive_vcpu;
> +
> +	if (priority !=3D xive_prio_from_guest(priority)) {
> +		pr_err("Trying to restore invalid queue %d for VCPU %d\n",
> +		       priority, server);
> +		return -EINVAL;
> +	}
> +	q =3D &xc->queues[priority];
> +
> +	pr_devel("%s VCPU %d priority %d fl:%x shift:%d addr:%llx g:%d idx:%d\n=
",
> +		 __func__, server, priority, kvm_eq.flags,
> +		 kvm_eq.qshift, kvm_eq.qaddr, kvm_eq.qtoggle, kvm_eq.qindex);
> +
> +	/*
> +	 * sPAPR specifies a "Unconditional Notify (n) flag" for the
> +	 * H_INT_SET_QUEUE_CONFIG hcall which forces notification
> +	 * without using the coalescing mechanisms provided by the
> +	 * XIVE END ESBs. This is required on KVM as notification
> +	 * using the END ESBs is not supported.
> +	 */
> +	if (kvm_eq.flags !=3D KVM_XIVE_EQ_ALWAYS_NOTIFY) {
> +		pr_err("invalid flags %d\n", kvm_eq.flags);
> +		return -EINVAL;
> +	}
> +
> +	rc =3D xive_native_validate_queue_size(kvm_eq.qshift);
> +	if (rc) {
> +		pr_err("invalid queue size %d\n", kvm_eq.qshift);
> +		return rc;
> +	}
> +
> +	/* reset queue and disable queueing */
> +	if (!kvm_eq.qshift) {
> +		q->guest_qaddr  =3D 0;
> +		q->guest_qshift =3D 0;
> +
> +		rc =3D xive_native_configure_queue(xc->vp_id, q, priority,
> +						 NULL, 0, true);
> +		if (rc) {
> +			pr_err("Failed to reset queue %d for VCPU %d: %d\n",
> +			       priority, xc->server_num, rc);
> +			return rc;
> +		}
> +
> +		if (q->qpage) {
> +			put_page(virt_to_page(q->qpage));
> +			q->qpage =3D NULL;
> +		}
> +
> +		return 0;
> +	}
> +
> +	if (kvm_eq.qaddr & ((1ull << kvm_eq.qshift) - 1)) {
> +		pr_err("queue page is not aligned %llx/%llx\n", kvm_eq.qaddr,
> +		       1ull << kvm_eq.qshift);
> +		return -EINVAL;
> +	}
> +
> +	gfn =3D gpa_to_gfn(kvm_eq.qaddr);
> +	page =3D gfn_to_page(kvm, gfn);
> +	if (is_error_page(page)) {
> +		pr_err("Couldn't get queue page %llx!\n", kvm_eq.qaddr);
> +		return -EINVAL;
> +	}
> +	page_size =3D kvm_host_page_size(kvm, gfn);
> +	if (1ull << kvm_eq.qshift > page_size) {
> +		pr_warn("Incompatible host page size %lx!\n", page_size);
> +		return -EINVAL;
> +	}
> +
> +	qaddr =3D page_to_virt(page) + (kvm_eq.qaddr & ~PAGE_MASK);
> +
> +	/*
> +	 * Backup the queue page guest address to the mark EQ page
> +	 * dirty for migration.
> +	 */
> +	q->guest_qaddr  =3D kvm_eq.qaddr;
> +	q->guest_qshift =3D kvm_eq.qshift;
> +
> +	 /*
> +	  * Unconditional Notification is forced by default at the
> +	  * OPAL level because the use of END ESBs is not supported by
> +	  * Linux.
> +	  */
> +	rc =3D xive_native_configure_queue(xc->vp_id, q, priority,
> +					 (__be32 *) qaddr, kvm_eq.qshift, true);
> +	if (rc) {
> +		pr_err("Failed to configure queue %d for VCPU %d: %d\n",
> +		       priority, xc->server_num, rc);
> +		put_page(page);
> +		return rc;
> +	}
> +
> +	/*
> +	 * Only restore the queue state when needed. When doing the
> +	 * H_INT_SET_SOURCE_CONFIG hcall, it should not.
> +	 */
> +	if (kvm_eq.qtoggle !=3D 1 || kvm_eq.qindex !=3D 0) {
> +		rc =3D xive_native_set_queue_state(xc->vp_id, priority,
> +						 kvm_eq.qtoggle,
> +						 kvm_eq.qindex);
> +		if (rc)
> +			goto error;
> +	}
> +
> +	rc =3D kvmppc_xive_attach_escalation(vcpu, priority,
> +					   xive->single_escalation);
> +error:
> +	if (rc)
> +		kvmppc_xive_native_cleanup_queue(vcpu, priority);
> +	return rc;
> +}
> +
> +static int kvmppc_xive_native_get_queue_config(struct kvmppc_xive *xive,
> +					       long eq_idx, u64 addr)
> +{
> +	struct kvm *kvm =3D xive->kvm;
> +	struct kvm_vcpu *vcpu;
> +	struct kvmppc_xive_vcpu *xc;
> +	struct xive_q *q;
> +	void __user *ubufp =3D (u64 __user *) addr;
> +	u32 server;
> +	u8 priority;
> +	struct kvm_ppc_xive_eq kvm_eq;
> +	u64 qaddr;
> +	u64 qshift;
> +	u64 qeoi_page;
> +	u32 escalate_irq;
> +	u64 qflags;
> +	int rc;
> +
> +	/*
> +	 * Demangle priority/server tuple from the EQ identifier
> +	 */
> +	priority =3D (eq_idx & KVM_XIVE_EQ_PRIORITY_MASK) >>
> +		KVM_XIVE_EQ_PRIORITY_SHIFT;
> +	server =3D (eq_idx & KVM_XIVE_EQ_SERVER_MASK) >>
> +		KVM_XIVE_EQ_SERVER_SHIFT;
> +
> +	vcpu =3D kvmppc_xive_find_server(kvm, server);
> +	if (!vcpu) {
> +		pr_err("Can't find server %d\n", server);
> +		return -ENOENT;
> +	}
> +	xc =3D vcpu->arch.xive_vcpu;
> +
> +	if (priority !=3D xive_prio_from_guest(priority)) {
> +		pr_err("invalid priority for queue %d for VCPU %d\n",
> +		       priority, server);
> +		return -EINVAL;
> +	}
> +	q =3D &xc->queues[priority];
> +
> +	memset(&kvm_eq, 0, sizeof(kvm_eq));
> +
> +	if (!q->qpage)
> +		return 0;
> +
> +	rc =3D xive_native_get_queue_info(xc->vp_id, priority, &qaddr, &qshift,
> +					&qeoi_page, &escalate_irq, &qflags);
> +	if (rc)
> +		return rc;
> +
> +	kvm_eq.flags =3D 0;
> +	if (qflags & OPAL_XIVE_EQ_ALWAYS_NOTIFY)
> +		kvm_eq.flags |=3D KVM_XIVE_EQ_ALWAYS_NOTIFY;
> +
> +	kvm_eq.qshift =3D q->guest_qshift;
> +	kvm_eq.qaddr  =3D q->guest_qaddr;
> +
> +	rc =3D xive_native_get_queue_state(xc->vp_id, priority, &kvm_eq.qtoggle,
> +					 &kvm_eq.qindex);
> +	if (rc)
> +		return rc;
> +
> +	pr_devel("%s VCPU %d priority %d fl:%x shift:%d addr:%llx g:%d idx:%d\n=
",
> +		 __func__, server, priority, kvm_eq.flags,
> +		 kvm_eq.qshift, kvm_eq.qaddr, kvm_eq.qtoggle, kvm_eq.qindex);
> +
> +	if (copy_to_user(ubufp, &kvm_eq, sizeof(kvm_eq)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>  				       struct kvm_device_attr *attr)
>  {
> @@ -349,6 +586,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_dev=
ice *dev,
>  	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
>  		return kvmppc_xive_native_set_source_config(xive, attr->attr,
>  							    attr->addr);
> +	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
> +		return kvmppc_xive_native_set_queue_config(xive, attr->attr,
> +							   attr->addr);
>  	}
>  	return -ENXIO;
>  }
> @@ -356,6 +596,13 @@ static int kvmppc_xive_native_set_attr(struct kvm_de=
vice *dev,
>  static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
>  				       struct kvm_device_attr *attr)
>  {
> +	struct kvmppc_xive *xive =3D dev->private;
> +
> +	switch (attr->group) {
> +	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
> +		return kvmppc_xive_native_get_queue_config(xive, attr->attr,
> +							   attr->addr);
> +	}
>  	return -ENXIO;
>  }
> =20
> @@ -371,6 +618,8 @@ static int kvmppc_xive_native_has_attr(struct kvm_dev=
ice *dev,
>  		    attr->attr < KVMPPC_XIVE_NR_IRQS)
>  			return 0;
>  		break;
> +	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
> +		return 0;
>  	}
>  	return -ENXIO;
>  }
> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/v=
irtual/kvm/devices/xive.txt
> index 33c64b2cdbe8..cc13bfd5cf53 100644
> --- a/Documentation/virtual/kvm/devices/xive.txt
> +++ b/Documentation/virtual/kvm/devices/xive.txt
> @@ -53,3 +53,37 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
>      -ENXIO:  CPU event queues not configured or configuration of the
>               underlying HW interrupt failed
>      -EBUSY:  No CPU available to serve interrupt
> +
> +  4. KVM_DEV_XIVE_GRP_EQ_CONFIG (read-write)
> +  Configures an event queue of a CPU
> +  Attributes:
> +    EQ descriptor identifier (64-bit)
> +  The EQ descriptor identifier is a tuple (server, priority) :
> +  bits:     | 63   ....  32 | 31 .. 3 |  2 .. 0
> +  values:   |    unused     |  server | priority
> +  The kvm_device_attr.addr points to :
> +    struct kvm_ppc_xive_eq {
> +	__u32 flags;
> +	__u32 qshift;
> +	__u64 qaddr;
> +	__u32 qtoggle;
> +	__u32 qindex;
> +	__u8  pad[40];
> +    };
> +  - flags: queue flags
> +    KVM_XIVE_EQ_ALWAYS_NOTIFY (required)
> +	forces notification without using the coalescing mechanism
> +	provided by the XIVE END ESBs.
> +  - qshift: queue size (power of 2)
> +  - qaddr: real address of queue
> +  - qtoggle: current queue toggle bit
> +  - qindex: current queue index
> +  - pad: reserved for future use
> +  Errors:
> +    -ENOENT: Invalid CPU number
> +    -EINVAL: Invalid priority
> +    -EINVAL: Invalid flags
> +    -EINVAL: Invalid queue size
> +    -EINVAL: Invalid queue address
> +    -EFAULT: Invalid user pointer for attr->addr.
> +    -EIO:    Configuration of the underlying HW failed

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlywH/UACgkQbDjKyiDZ
s5JmGRAAr9RGtQNKP4p/yvOg9pBRO10u+QWx/naTV//49fKIa51H6chgy/6wJW28
YIb/wH+ULzzWB6GoW8R9S+YCOmSmE2JRauPCfA2fxttLcy9OjoXOAFCufKzsiY6w
BBY17PBBscSu9JTN6ShDO07mngpA5gXeo0ssIw1MrxDC8AR971Pjls1Ni52nx3TK
pe1TYbStl07t3SUn9q/eyYYMOm+QpkUxaFcUFy9XJdPTXA8VyMieCtpsEEfp31et
mHfigtDgzwD/YJQWzopelXKiDqcGO1W3T7QyWqpQ3WRIln9IzuIzj03DSVNKCD8P
fwLsU3O3mo5LbgDPI3pWbRWaZVizgnA6VgZ0gBzVOL3Dm2yWAwVIqWhRjewMBg6N
tn3o0wyLDTlep4/QLHeOzaVUnhB9jjBDXcJOfL8M3zAitdcSOaJrUsPYySXJmzoA
yemwZIvsUAU+NI/YbNPEZjIGYok/J4iw1OwC1I88WF3o7OK0BMG6nBZZMOTgQNw7
F9lYNwpuUKDkde0jibNT1ZMNuV6U5Vz5HKBngiHTk2Pi3l9b1/avUo7/AvFEJ/c1
jddtgIyITGD7L1D4WwjA+AO0glVpaT/0MAHit+5AcNvoPlIVFYjsO7ASGB9Y15Jz
RxlvIlS9v+LsgPK36GvCKp/PsQfJFRc831b/iXUYxQeJpIIVOuo=
=gxMX
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
