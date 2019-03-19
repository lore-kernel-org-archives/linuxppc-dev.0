Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B113C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 05:42:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0909420872
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 05:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nYmamnrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0909420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Nhlc6hjczDqH3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 16:42:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Nhf308QpzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 16:37:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="nYmamnrK"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44Nhf232Pdz9s9T; Tue, 19 Mar 2019 16:37:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552973866;
 bh=jZ2XSvR31eEbe1YAivACp2OfRDdplFrUqN5Ws8l1byI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nYmamnrKjbbYQq/vHw5u5Hn93ny1HbrSBLvEoRNyzGzRIMb2eFZzqpkFAbzOQ1dD2
 y1vNlsiIYM3tgwDvxby1Bbwj76h6HBFsuzrKl0untrl/Jnei3JarrLhucv/YVwdHKr
 aTxQyZztFvuZdizE3vUs4jRPBe/3juVfW7uibKsU=
Date: Tue, 19 Mar 2019 15:54:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 06/17] KVM: PPC: Book3S HV: XIVE: add controls for the
 EQ configuration
Message-ID: <20190319045455.GB31018@umbus.fritz.box>
References: <20190315120609.25910-1-clg@kaod.org>
 <20190315120609.25910-7-clg@kaod.org>
 <20190318032348.GH6874@umbus.fritz.box>
 <8b3caeef-8750-b8db-d516-c722bc08c535@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <8b3caeef-8750-b8db-d516-c722bc08c535@kaod.org>
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


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 03:12:10PM +0100, C=E9dric Le Goater wrote:
> On 3/18/19 4:23 AM, David Gibson wrote:
> > On Fri, Mar 15, 2019 at 01:05:58PM +0100, C=E9dric Le Goater wrote:
> >> These controls will be used by the H_INT_SET_QUEUE_CONFIG and
> >> H_INT_GET_QUEUE_CONFIG hcalls from QEMU to configure the underlying
> >> Event Queue in the XIVE IC. They will also be used to restore the
> >> configuration of the XIVE EQs and to capture the internal run-time
> >> state of the EQs. Both 'get' and 'set' rely on an OPAL call to access
> >> the EQ toggle bit and EQ index which are updated by the XIVE IC when
> >> event notifications are enqueued in the EQ.
> >>
> >> The value of the guest physical address of the event queue is saved in
> >> the XIVE internal xive_q structure for later use. That is when
> >> migration needs to mark the EQ pages dirty to capture a consistent
> >> memory state of the VM.
> >>
> >> To be noted that H_INT_SET_QUEUE_CONFIG does not require the extra
> >> OPAL call setting the EQ toggle bit and EQ index to configure the EQ,
> >> but restoring the EQ state will.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>
> >>  Changes since v2 :
> >> =20
> >>  - fixed comments on the KVM device attribute definitions
> >>  - fixed check on supported EQ size to restrict to 64K pages
> >>  - checked kvm_eq.flags that need to be zero
> >>  - removed the OPAL call when EQ qtoggle bit and index are zero.=20
> >>
> >>  arch/powerpc/include/asm/xive.h            |   2 +
> >>  arch/powerpc/include/uapi/asm/kvm.h        |  21 ++
> >>  arch/powerpc/kvm/book3s_xive.h             |   2 +
> >>  arch/powerpc/kvm/book3s_xive.c             |  15 +-
> >>  arch/powerpc/kvm/book3s_xive_native.c      | 232 +++++++++++++++++++++
> >>  Documentation/virtual/kvm/devices/xive.txt |  31 +++
> >>  6 files changed, 297 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/as=
m/xive.h
> >> index b579a943407b..46891f321606 100644
> >> --- a/arch/powerpc/include/asm/xive.h
> >> +++ b/arch/powerpc/include/asm/xive.h
> >> @@ -73,6 +73,8 @@ struct xive_q {
> >>  	u32			esc_irq;
> >>  	atomic_t		count;
> >>  	atomic_t		pending_count;
> >> +	u64			guest_qpage;
> >> +	u32			guest_qsize;
> >>  };
> >> =20
> >>  /* Global enable flags for the XIVE support */
> >> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/includ=
e/uapi/asm/kvm.h
> >> index 12bb01baf0ae..1cd728c87d7c 100644
> >> --- a/arch/powerpc/include/uapi/asm/kvm.h
> >> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> >> @@ -679,6 +679,7 @@ struct kvm_ppc_cpu_char {
> >>  #define KVM_DEV_XIVE_GRP_CTRL		1
> >>  #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
> >>  #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier =
*/
> >> +#define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit EQ identifier */
> >> =20
> >>  /* Layout of 64-bit XIVE source attribute values */
> >>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
> >> @@ -694,4 +695,24 @@ struct kvm_ppc_cpu_char {
> >>  #define KVM_XIVE_SOURCE_EISN_SHIFT	33
> >>  #define KVM_XIVE_SOURCE_EISN_MASK	0xfffffffe00000000ULL
> >> =20
> >> +/* Layout of 64-bit EQ identifier */
> >> +#define KVM_XIVE_EQ_PRIORITY_SHIFT	0
> >> +#define KVM_XIVE_EQ_PRIORITY_MASK	0x7
> >> +#define KVM_XIVE_EQ_SERVER_SHIFT	3
> >> +#define KVM_XIVE_EQ_SERVER_MASK		0xfffffff8ULL
> >> +
> >> +/* Layout of EQ configuration values (64 bytes) */
> >> +struct kvm_ppc_xive_eq {
> >> +	__u32 flags;
> >> +	__u32 qsize;
> >> +	__u64 qpage;
> >> +	__u32 qtoggle;
> >> +	__u32 qindex;
> >> +	__u8  pad[40];
> >> +};
> >> +
> >> +#define KVM_XIVE_EQ_FLAG_ENABLED	0x00000001
> >> +#define KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY	0x00000002
> >> +#define KVM_XIVE_EQ_FLAG_ESCALATE	0x00000004
> >> +
> >>  #endif /* __LINUX_KVM_POWERPC_H */
> >> diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_=
xive.h
> >> index ae26fe653d98..622f594d93e1 100644
> >> --- a/arch/powerpc/kvm/book3s_xive.h
> >> +++ b/arch/powerpc/kvm/book3s_xive.h
> >> @@ -272,6 +272,8 @@ struct kvmppc_xive_src_block *kvmppc_xive_create_s=
rc_block(
> >>  	struct kvmppc_xive *xive, int irq);
> >>  void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
> >>  int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio);
> >> +int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio,
> >> +				  bool single_escalation);
> >> =20
> >>  #endif /* CONFIG_KVM_XICS */
> >>  #endif /* _KVM_PPC_BOOK3S_XICS_H */
> >> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_=
xive.c
> >> index e09f3addffe5..c1b7aa7dbc28 100644
> >> --- a/arch/powerpc/kvm/book3s_xive.c
> >> +++ b/arch/powerpc/kvm/book3s_xive.c
> >> @@ -166,7 +166,8 @@ static irqreturn_t xive_esc_irq(int irq, void *dat=
a)
> >>  	return IRQ_HANDLED;
> >>  }
> >> =20
> >> -static int xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio)
> >> +int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio,
> >> +				  bool single_escalation)
> >>  {
> >>  	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> >>  	struct xive_q *q =3D &xc->queues[prio];
> >> @@ -185,7 +186,7 @@ static int xive_attach_escalation(struct kvm_vcpu =
*vcpu, u8 prio)
> >>  		return -EIO;
> >>  	}
> >> =20
> >> -	if (xc->xive->single_escalation)
> >> +	if (single_escalation)
> >>  		name =3D kasprintf(GFP_KERNEL, "kvm-%d-%d",
> >>  				 vcpu->kvm->arch.lpid, xc->server_num);
> >>  	else
> >> @@ -217,7 +218,7 @@ static int xive_attach_escalation(struct kvm_vcpu =
*vcpu, u8 prio)
> >>  	 * interrupt, thus leaving it effectively masked after
> >>  	 * it fires once.
> >>  	 */
> >> -	if (xc->xive->single_escalation) {
> >> +	if (single_escalation) {
> >>  		struct irq_data *d =3D irq_get_irq_data(xc->esc_virq[prio]);
> >>  		struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(d);
> >> =20
> >> @@ -291,7 +292,8 @@ static int xive_check_provisioning(struct kvm *kvm=
, u8 prio)
> >>  			continue;
> >>  		rc =3D xive_provision_queue(vcpu, prio);
> >>  		if (rc =3D=3D 0 && !xive->single_escalation)
> >> -			xive_attach_escalation(vcpu, prio);
> >> +			kvmppc_xive_attach_escalation(vcpu, prio,
> >> +						      xive->single_escalation);
> >>  		if (rc)
> >>  			return rc;
> >>  	}
> >> @@ -1214,7 +1216,8 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *=
dev,
> >>  		if (xive->qmap & (1 << i)) {
> >>  			r =3D xive_provision_queue(vcpu, i);
> >>  			if (r =3D=3D 0 && !xive->single_escalation)
> >> -				xive_attach_escalation(vcpu, i);
> >> +				kvmppc_xive_attach_escalation(
> >> +					vcpu, i, xive->single_escalation);
> >>  			if (r)
> >>  				goto bail;
> >>  		} else {
> >> @@ -1229,7 +1232,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *=
dev,
> >>  	}
> >> =20
> >>  	/* If not done above, attach priority 0 escalation */
> >> -	r =3D xive_attach_escalation(vcpu, 0);
> >> +	r =3D kvmppc_xive_attach_escalation(vcpu, 0, xive->single_escalation=
);
> >>  	if (r)
> >>  		goto bail;
> >> =20
> >> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/=
book3s_xive_native.c
> >> index b841d339f674..42e824658a30 100644
> >> --- a/arch/powerpc/kvm/book3s_xive_native.c
> >> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> >> @@ -340,6 +340,226 @@ static int kvmppc_xive_native_set_source_config(=
struct kvmppc_xive *xive,
> >>  						       priority, masked, eisn);
> >>  }
> >> =20
> >> +static int xive_native_validate_queue_size(u32 qsize)
> >> +{
> >> +	/*
> >> +	 * We only support 64K pages for the moment. This is also
> >> +	 * advertised in the DT property "ibm,xive-eq-sizes"
> >=20
> > IIUC, that won't work properly if you had a guest using 4kiB pages.
>=20
> > That's fine, but do we have somewhere that checks for that case and
> > throws a suitable error?
>=20
> Not in the device.=20
>=20
> So, we should check the current page_size of the guest ? Is there a way=
=20
> to do that simply from KVM ?

Not really.  But I think I know where to make the necessary test, see
comment below..

> >> +	 */
> >> +	switch (qsize) {
> >> +	case 0: /* EQ reset */
> >> +	case 16:
> >> +		return 0;
> >> +	case 12:
> >> +	case 21:
> >> +	case 24:
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +}
> >> +
> >> +static int kvmppc_xive_native_set_queue_config(struct kvmppc_xive *xi=
ve,
> >> +					       long eq_idx, u64 addr)
> >> +{
> >> +	struct kvm *kvm =3D xive->kvm;
> >> +	struct kvm_vcpu *vcpu;
> >> +	struct kvmppc_xive_vcpu *xc;
> >> +	void __user *ubufp =3D (u64 __user *) addr;
> >=20
> > Nit: that should be (void __user *) on the right, shouldn't it?
>=20
> yes.
>=20
> >=20
> >> +	u32 server;
> >> +	u8 priority;
> >> +	struct kvm_ppc_xive_eq kvm_eq;
> >> +	int rc;
> >> +	__be32 *qaddr =3D 0;
> >> +	struct page *page;
> >> +	struct xive_q *q;
> >> +
> >> +	/*
> >> +	 * Demangle priority/server tuple from the EQ identifier
> >> +	 */
> >> +	priority =3D (eq_idx & KVM_XIVE_EQ_PRIORITY_MASK) >>
> >> +		KVM_XIVE_EQ_PRIORITY_SHIFT;
> >> +	server =3D (eq_idx & KVM_XIVE_EQ_SERVER_MASK) >>
> >> +		KVM_XIVE_EQ_SERVER_SHIFT;
> >> +
> >> +	if (copy_from_user(&kvm_eq, ubufp, sizeof(kvm_eq)))
> >> +		return -EFAULT;
> >> +
> >> +	vcpu =3D kvmppc_xive_find_server(kvm, server);
> >> +	if (!vcpu) {
> >> +		pr_err("Can't find server %d\n", server);
> >> +		return -ENOENT;
> >> +	}
> >> +	xc =3D vcpu->arch.xive_vcpu;
> >> +
> >> +	if (priority !=3D xive_prio_from_guest(priority)) {
> >> +		pr_err("Trying to restore invalid queue %d for VCPU %d\n",
> >> +		       priority, server);
> >> +		return -EINVAL;
> >> +	}
> >> +	q =3D &xc->queues[priority];
> >> +
> >> +	pr_devel("%s VCPU %d priority %d fl:%x sz:%d addr:%llx g:%d idx:%d\n=
",
> >> +		 __func__, server, priority, kvm_eq.flags,
> >> +		 kvm_eq.qsize, kvm_eq.qpage, kvm_eq.qtoggle, kvm_eq.qindex);
> >> +
> >> +	/*
> >> +	 * We can not tune the EQ configuration from user space. All
> >> +	 * is done in OPAL.
> >> +	 */
> >> +	if (kvm_eq.flags !=3D 0) {
> >> +		pr_err("invalid flags %d\n", kvm_eq.flags);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	rc =3D xive_native_validate_queue_size(kvm_eq.qsize);
> >> +	if (rc) {
> >> +		pr_err("invalid queue size %d\n", kvm_eq.qsize);
> >> +		return rc;
> >> +	}
> >> +
> >> +	/* reset queue and disable queueing */
> >> +	if (!kvm_eq.qsize) {
> >> +		q->guest_qpage =3D 0;
> >> +		q->guest_qsize =3D 0;
> >> +
> >> +		rc =3D xive_native_configure_queue(xc->vp_id, q, priority,
> >> +						 NULL, 0, true);
> >> +		if (rc) {
> >> +			pr_err("Failed to reset queue %d for VCPU %d: %d\n",
> >> +			       priority, xc->server_num, rc);
> >> +			return rc;
> >> +		}
> >> +
> >> +		if (q->qpage) {
> >> +			put_page(virt_to_page(q->qpage));
> >> +			q->qpage =3D NULL;
> >> +		}
> >> +
> >> +		return 0;
> >> +	}
> >> +
> >> +
> >> +	page =3D gfn_to_page(kvm, gpa_to_gfn(kvm_eq.qpage));
> >> +	if (is_error_page(page)) {
> >> +		pr_warn("Couldn't get guest page for %llx!\n", kvm_eq.qpage);
> >> +		return -EINVAL;
> >> +	}
> >=20
> > Yeah.. for the case of a 4kiB page host (these days weird, but not
> > actually prohibited, AFAIK) you need to check that the qsize selected
> > actually fits within the page.
>=20
> Ah yes. sure.

I think the pagesize test belongs here.  Rather than thinking about
the pagesize of the guest overall, you can check that this specific
page (possibly compound) is large enough to take the requested queue
size.

That should be enough to protect the host - it ensures that userspace
owns a suitable contiguous chunk of memory for the XIVE to write the
queue into.

It's possible there are weirder edge cases with a large page that's
not fully mapped into the guest - if necessary we can add tests for
that on the qemu side.

Oh.. it occurs to me that we might need to pin the queue page to make
sure it doesn't get swapped out or page-migrated while the XIVE holds
a pointer to it

> >> +	qaddr =3D page_to_virt(page) + (kvm_eq.qpage & ~PAGE_MASK);
> >> +
> >> +	/* Backup queue page guest address for migration */
> >=20
> > Hm.. KVM itself shouldn't generally need to know about migration.
> > IIUC these values won't change from what qemu set them to be, so it
> > should be able to store and migrate them without have to get them back
> > from the kernel.
>=20
> Euh. You are completely right. I don't know why I kept those around.=20
> >> +	q->guest_qpage =3D kvm_eq.qpage;
> >> +	q->guest_qsize =3D kvm_eq.qsize;
> >> +
> >> +	rc =3D xive_native_configure_queue(xc->vp_id, q, priority,
> >> +					 (__be32 *) qaddr, kvm_eq.qsize, true);
> >> +	if (rc) {
> >> +		pr_err("Failed to configure queue %d for VCPU %d: %d\n",
> >> +		       priority, xc->server_num, rc);
> >> +		put_page(page);
> >> +		return rc;
> >> +	}
> >> +
> >> +	/*
> >> +	 * Only restore the queue state when needed. When doing the
> >> +	 * H_INT_SET_SOURCE_CONFIG hcall, it should not.
> >> +	 */
> >> +	if (kvm_eq.qtoggle !=3D 0 || kvm_eq.qindex !=3D 0) {
> >> +		rc =3D xive_native_set_queue_state(xc->vp_id, priority,
> >> +						 kvm_eq.qtoggle,
> >> +						 kvm_eq.qindex);
> >> +		if (rc)
> >> +			goto error;
> >> +	}
> >> +
> >> +	rc =3D kvmppc_xive_attach_escalation(vcpu, priority,
> >> +					   xive->single_escalation);
> >> +error:
> >> +	if (rc)
> >> +		kvmppc_xive_native_cleanup_queue(vcpu, priority);
> >> +	return rc;
> >> +}
> >> +
> >> +static int kvmppc_xive_native_get_queue_config(struct kvmppc_xive *xi=
ve,
> >> +					       long eq_idx, u64 addr)
> >> +{
> >> +	struct kvm *kvm =3D xive->kvm;
> >> +	struct kvm_vcpu *vcpu;
> >> +	struct kvmppc_xive_vcpu *xc;
> >> +	struct xive_q *q;
> >> +	void __user *ubufp =3D (u64 __user *) addr;
> >> +	u32 server;
> >> +	u8 priority;
> >> +	struct kvm_ppc_xive_eq kvm_eq;
> >> +	u64 qpage;
> >> +	u64 qsize;
> >> +	u64 qeoi_page;
> >> +	u32 escalate_irq;
> >> +	u64 qflags;
> >> +	int rc;
> >> +
> >> +	/*
> >> +	 * Demangle priority/server tuple from the EQ identifier
> >> +	 */
> >> +	priority =3D (eq_idx & KVM_XIVE_EQ_PRIORITY_MASK) >>
> >> +		KVM_XIVE_EQ_PRIORITY_SHIFT;
> >> +	server =3D (eq_idx & KVM_XIVE_EQ_SERVER_MASK) >>
> >> +		KVM_XIVE_EQ_SERVER_SHIFT;
> >> +
> >> +	vcpu =3D kvmppc_xive_find_server(kvm, server);
> >> +	if (!vcpu) {
> >> +		pr_err("Can't find server %d\n", server);
> >> +		return -ENOENT;
> >> +	}
> >> +	xc =3D vcpu->arch.xive_vcpu;
> >> +
> >> +	if (priority !=3D xive_prio_from_guest(priority)) {
> >> +		pr_err("invalid priority for queue %d for VCPU %d\n",
> >> +		       priority, server);
> >> +		return -EINVAL;
> >> +	}
> >> +	q =3D &xc->queues[priority];
> >> +
> >> +	memset(&kvm_eq, 0, sizeof(kvm_eq));
> >> +
> >> +	if (!q->qpage)
> >> +		return 0;
> >> +
> >> +	rc =3D xive_native_get_queue_info(xc->vp_id, priority, &qpage, &qsiz=
e,
> >> +					&qeoi_page, &escalate_irq, &qflags);
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	/*
> >> +	 * Return some information on the EQ configuration in
> >> +	 * OPAL. This is purely informative for now as we can't really
> >> +	 * tune the EQ configuration from user space.
> >> +	 */
> >> +	kvm_eq.flags =3D 0;
> >> +	if (qflags & OPAL_XIVE_EQ_ENABLED)
> >> +		kvm_eq.flags |=3D KVM_XIVE_EQ_FLAG_ENABLED;
> >> +	if (qflags & OPAL_XIVE_EQ_ALWAYS_NOTIFY)
> >> +		kvm_eq.flags |=3D KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY;
> >> +	if (qflags & OPAL_XIVE_EQ_ESCALATE)
> >> +		kvm_eq.flags |=3D KVM_XIVE_EQ_FLAG_ESCALATE;
> >=20
> > If there's not really anything it can do about it, does it make sense
> > to even expose this info to userspace?
>=20
> Hmm, good question.=20
>=20
>  - KVM_XIVE_EQ_FLAG_ENABLED	=09
> 	may be uselessly obvious.

What's it controlled by?

>  - KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY =09
> 	means we do not use the END ESBs to coalesce the events at the END
> 	level. This flag is reflected by the XIVE_EQ_ALWAYS_NOTIFY option
> 	in the sPAPR specs. We don't support the END ESBs but we might one
> 	day.

Since the guest isn't currently permitted to set this, it should never
be set here either, no?

>  - KVM_XIVE_EQ_FLAG_ESCALATE
> 	means the EQ is an escalation. QEMU doesn't really care for now=20
> 	but it's an important information I think.

Likewise this one, yes?

>=20
> I tried not to add too many of the END flags, only the relevant ones which
> could have an impact in the future modeling. =20
>=20
> I think KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY is important. I was setting it from
> QEMU in the hcall but as OPAL does the same blindly I removed it in
> v3.

So, I might have misinterpreted this a bit the first time around.  Am
I correct in thinking that these bits all correspond to defined
options in the PAPR hcall - but that for now we don't allow guests to
set them (because we haven't implemented support so far).

>=20
> >> +	kvm_eq.qsize =3D q->guest_qsize;
> >> +	kvm_eq.qpage =3D q->guest_qpage;
> >=20
> >> +	rc =3D xive_native_get_queue_state(xc->vp_id, priority, &kvm_eq.qtog=
gle,
> >> +					 &kvm_eq.qindex);
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	pr_devel("%s VCPU %d priority %d fl:%x sz:%d addr:%llx g:%d idx:%d\n=
",
> >> +		 __func__, server, priority, kvm_eq.flags,
> >> +		 kvm_eq.qsize, kvm_eq.qpage, kvm_eq.qtoggle, kvm_eq.qindex);
> >> +
> >> +	if (copy_to_user(ubufp, &kvm_eq, sizeof(kvm_eq)))
> >> +		return -EFAULT;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
> >>  				       struct kvm_device_attr *attr)
> >>  {
> >> @@ -354,6 +574,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_=
device *dev,
> >>  	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
> >>  		return kvmppc_xive_native_set_source_config(xive, attr->attr,
> >>  							    attr->addr);
> >> +	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
> >> +		return kvmppc_xive_native_set_queue_config(xive, attr->attr,
> >> +							   attr->addr);
> >>  	}
> >>  	return -ENXIO;
> >>  }
> >> @@ -361,6 +584,13 @@ static int kvmppc_xive_native_set_attr(struct kvm=
_device *dev,
> >>  static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
> >>  				       struct kvm_device_attr *attr)
> >>  {
> >> +	struct kvmppc_xive *xive =3D dev->private;
> >> +
> >> +	switch (attr->group) {
> >> +	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
> >> +		return kvmppc_xive_native_get_queue_config(xive, attr->attr,
> >> +							   attr->addr);
> >> +	}
> >>  	return -ENXIO;
> >>  }
> >> =20
> >> @@ -376,6 +606,8 @@ static int kvmppc_xive_native_has_attr(struct kvm_=
device *dev,
> >>  		    attr->attr < KVMPPC_XIVE_NR_IRQS)
> >>  			return 0;
> >>  		break;
> >> +	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
> >> +		return 0;
> >>  	}
> >>  	return -ENXIO;
> >>  }
> >> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentatio=
n/virtual/kvm/devices/xive.txt
> >> index 33c64b2cdbe8..a4de64f6e79c 100644
> >> --- a/Documentation/virtual/kvm/devices/xive.txt
> >> +++ b/Documentation/virtual/kvm/devices/xive.txt
> >> @@ -53,3 +53,34 @@ the legacy interrupt mode, referred as XICS (POWER7=
/8).
> >>      -ENXIO:  CPU event queues not configured or configuration of the
> >>               underlying HW interrupt failed
> >>      -EBUSY:  No CPU available to serve interrupt
> >> +
> >> +  4. KVM_DEV_XIVE_GRP_EQ_CONFIG (read-write)
> >> +  Configures an event queue of a CPU
> >> +  Attributes:
> >> +    EQ descriptor identifier (64-bit)
> >> +  The EQ descriptor identifier is a tuple (server, priority) :
> >> +  bits:     | 63   ....  32 | 31 .. 3 |  2 .. 0
> >> +  values:   |    unused     |  server | priority
> >> +  The kvm_device_attr.addr points to :
> >> +    struct kvm_ppc_xive_eq {
> >> +	__u32 flags;
> >> +	__u32 qsize;
> >> +	__u64 qpage;
> >> +	__u32 qtoggle;
> >> +	__u32 qindex;
> >> +	__u8  pad[40];
> >> +    };
> >> +  - flags: queue flags
> >> +  - qsize: queue size (power of 2)
> >> +  - qpage: real address of queue
> >> +  - qtoggle: current queue toggle bit
> >> +  - qindex: current queue index
> >> +  - pad: reserved for future use
> >> +  Errors:
> >> +    -ENOENT: Invalid CPU number
> >> +    -EINVAL: Invalid priority
> >> +    -EINVAL: Invalid flags
> >> +    -EINVAL: Invalid queue size
> >> +    -EINVAL: Invalid queue address
> >> +    -EFAULT: Invalid user pointer for attr->addr.
> >> +    -EIO:    Configuration of the underlying HW failed
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyQdhwACgkQbDjKyiDZ
s5L4ZQ//Uq+QPT5mY/8hPxCSoUSddcyLOaZHsZ3XvEs6KeQ6pO0yS90liFCDJI76
tcKeYiF9dHFIokFq8hvp8uFmPCfQqOhqWJLRU+BtI9IZGdp4ykgn2+7lkBbRIde5
a2mWKpU5J1j5dWKBJ6Ki72Z8xR8Crz6BxUXOhO5Mf3NYZXw3rCHBbB8+NKw+bEiW
VQV8P5NtBpcJZW/VQrCIphHS9sop1LHj3lJRw8J/zlRlPfxutVWfoeAyp++6S3am
rQxoOeYHOuq48V+TuXIsqv9yTZDLQLBthNaUxHM0XmWBmDXnAXrmBX+tWj++EJ5m
I7OA64i91s9wb0x4FcRFLBa873/a/ZV0QY6aGd+7H+vDp6Yg3qkouru2/LK/qFyf
h20s9YThYCGKwbrjzPKXgVU0KfP0jCg3dVFO3g7pl5nkhwhSj3T3bY54TTyJsnQP
R0fG3fZP1iOC6GIm+C79iRzI6tVs+JB8f25+D0J5MalaHDHAZCnG6mWJ9sn+KUBT
sy43xqXlZszICk8fmSPhzW/PTq2GEBO2xxTSXDvKSsvoM736EHF/aPXo4DlPAMiv
1XsfqzmrE5dauBR5w7/2X5XYzLkfm9/kaj29T/NCOJ6Cl41v4rsYGaEVLzJQDWqK
5MOmu0/p8JZuHkQtoyi7bfNqYCk+yrrn0lOQ1IFCu2oF/xxLZVM=
=PS1m
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
