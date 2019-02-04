Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDA1C282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:14:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67837218A6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="edXs3+nK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67837218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tHVg2VlyzDqHL
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 17:14:51 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tHSJ49c7zDqGQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 17:12:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="edXs3+nK"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43tHSJ29b9z9sCh; Mon,  4 Feb 2019 17:12:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549260768;
 bh=jhS0Be5J823oblzhUn4C/cA4V39BwDYElmOiwftX5X8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=edXs3+nK9XjL+qSGzY/kee8FoO1jvV9bmUrPBdAoEw8TI4Gtf9vb4BflXVKRtunIJ
 rhKMY9N8ig+hXr10UFeCF4TGa1efTddHr4aGk/XHGthwtOXqxnDZLcDRxnqyMfLoG+
 n3MU8fEiUOqzZ3QUq38i4zY6SlAqcA7IRoDO/cP4=
Date: Mon, 4 Feb 2019 15:25:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 05/19] KVM: PPC: Book3S HV: add a new KVM device for the
 XIVE native exploitation mode
Message-ID: <20190204042559.GA1927@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20190107184331.8429-6-clg@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:43:17PM +0100, C=E9dric Le Goater wrote:
> This is the basic framework for the new KVM device supporting the XIVE
> native exploitation mode. The user interface exposes a new capability
> and a new KVM device to be used by QEMU.
>=20
> Internally, the interface to the new KVM device is protected with a
> new interrupt mode: KVMPPC_IRQ_XIVE.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/asm/kvm_host.h   |   2 +
>  arch/powerpc/include/asm/kvm_ppc.h    |  21 ++
>  arch/powerpc/kvm/book3s_xive.h        |   3 +
>  include/uapi/linux/kvm.h              |   3 +
>  arch/powerpc/kvm/book3s.c             |   7 +-
>  arch/powerpc/kvm/book3s_xive_native.c | 332 ++++++++++++++++++++++++++
>  arch/powerpc/kvm/powerpc.c            |  30 +++
>  arch/powerpc/kvm/Makefile             |   2 +-
>  8 files changed, 398 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/kvm/book3s_xive_native.c
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index 0f98f00da2ea..c522e8274ad9 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -220,6 +220,7 @@ extern struct kvm_device_ops kvm_xics_ops;
>  struct kvmppc_xive;
>  struct kvmppc_xive_vcpu;
>  extern struct kvm_device_ops kvm_xive_ops;
> +extern struct kvm_device_ops kvm_xive_native_ops;
> =20
>  struct kvmppc_passthru_irqmap;
> =20
> @@ -446,6 +447,7 @@ struct kvmppc_passthru_irqmap {
>  #define KVMPPC_IRQ_DEFAULT	0
>  #define KVMPPC_IRQ_MPIC		1
>  #define KVMPPC_IRQ_XICS		2 /* Includes a XIVE option */
> +#define KVMPPC_IRQ_XIVE		3 /* XIVE native exploitation mode */
> =20
>  #define MMIO_HPTE_CACHE_SIZE	4
> =20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index eb0d79f0ca45..1bb313f238fe 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -591,6 +591,18 @@ extern int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu=
, u64 icpval);
>  extern int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 i=
rq,
>  			       int level, bool line_status);
>  extern void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu);
> +
> +static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.irq_type =3D=3D KVMPPC_IRQ_XIVE;
> +}
> +
> +extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
> +				    struct kvm_vcpu *vcpu, u32 cpu);
> +extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
> +extern void kvmppc_xive_native_init_module(void);
> +extern void kvmppc_xive_native_exit_module(void);
> +
>  #else
>  static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 ser=
ver,
>  				       u32 priority) { return -1; }
> @@ -614,6 +626,15 @@ static inline int kvmppc_xive_set_icp(struct kvm_vcp=
u *vcpu, u64 icpval) { retur
>  static inline int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id=
, u32 irq,
>  				      int level, bool line_status) { return -ENODEV; }
>  static inline void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu) { }
> +
> +static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
> +	{ return 0; }
> +static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
> +						  struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
> +static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu=
) { }
> +static inline void kvmppc_xive_native_init_module(void) { }
> +static inline void kvmppc_xive_native_exit_module(void) { }
> +
>  #endif /* CONFIG_KVM_XIVE */
> =20
>  /*
> diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xiv=
e.h
> index 10c4aa5cd010..5f22415520b4 100644
> --- a/arch/powerpc/kvm/book3s_xive.h
> +++ b/arch/powerpc/kvm/book3s_xive.h
> @@ -12,6 +12,9 @@
>  #ifdef CONFIG_KVM_XICS
>  #include "book3s_xics.h"
> =20
> +#define KVMPPC_XIVE_FIRST_IRQ	0
> +#define KVMPPC_XIVE_NR_IRQS	KVMPPC_XICS_NR_IRQS
> +
>  /*
>   * State for one guest irq source.
>   *
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6d4ea4b6c922..52bf74a1616e 100644
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
> @@ -1211,6 +1212,8 @@ enum kvm_device_type {
>  #define KVM_DEV_TYPE_ARM_VGIC_V3	KVM_DEV_TYPE_ARM_VGIC_V3
>  	KVM_DEV_TYPE_ARM_VGIC_ITS,
>  #define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
> +	KVM_DEV_TYPE_XIVE,
> +#define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
>  	KVM_DEV_TYPE_MAX,
>  };
> =20
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index bd1a677dd9e4..de7eed191107 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -1039,7 +1039,10 @@ static int kvmppc_book3s_init(void)
>  #ifdef CONFIG_KVM_XIVE
>  	if (xive_enabled()) {
>  		kvmppc_xive_init_module();
> +		kvmppc_xive_native_init_module();
>  		kvm_register_device_ops(&kvm_xive_ops, KVM_DEV_TYPE_XICS);
> +		kvm_register_device_ops(&kvm_xive_native_ops,
> +					KVM_DEV_TYPE_XIVE);
>  	} else
>  #endif
>  		kvm_register_device_ops(&kvm_xics_ops, KVM_DEV_TYPE_XICS);
> @@ -1050,8 +1053,10 @@ static int kvmppc_book3s_init(void)
>  static void kvmppc_book3s_exit(void)
>  {
>  #ifdef CONFIG_KVM_XICS
> -	if (xive_enabled())
> +	if (xive_enabled()) {
>  		kvmppc_xive_exit_module();
> +		kvmppc_xive_native_exit_module();
> +	}
>  #endif
>  #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
>  	kvmppc_book3s_exit_pr();
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> new file mode 100644
> index 000000000000..115143e76c45
> --- /dev/null
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017-2019, IBM Corporation.
> + */
> +
> +#define pr_fmt(fmt) "xive-kvm: " fmt
> +
> +#include <linux/anon_inodes.h>
> +#include <linux/kernel.h>
> +#include <linux/kvm_host.h>
> +#include <linux/err.h>
> +#include <linux/gfp.h>
> +#include <linux/spinlock.h>
> +#include <linux/delay.h>
> +#include <linux/percpu.h>
> +#include <linux/cpumask.h>
> +#include <asm/uaccess.h>
> +#include <asm/kvm_book3s.h>
> +#include <asm/kvm_ppc.h>
> +#include <asm/hvcall.h>
> +#include <asm/xics.h>
> +#include <asm/xive.h>
> +#include <asm/xive-regs.h>
> +#include <asm/debug.h>
> +#include <asm/debugfs.h>
> +#include <asm/time.h>
> +#include <asm/opal.h>
> +
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +
> +#include "book3s_xive.h"
> +
> +static void xive_native_cleanup_queue(struct kvm_vcpu *vcpu, int prio)
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
> +		}
> +
> +		/* Free the queue */
> +		xive_native_cleanup_queue(vcpu, i);
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
> +				    struct kvm_vcpu *vcpu, u32 cpu)

Why do we need both a *vcpu and a cpu number as an integer?

> +{
> +	struct kvmppc_xive *xive =3D dev->private;
> +	struct kvmppc_xive_vcpu *xc;
> +	int rc;
> +
> +	pr_devel("native_connect_vcpu(cpu=3D%d)\n", cpu);
> +
> +	if (dev->ops !=3D &kvm_xive_native_ops) {
> +		pr_devel("Wrong ops !\n");
> +		return -EPERM;
> +	}
> +	if (xive->kvm !=3D vcpu->kvm)
> +		return -EPERM;
> +	if (vcpu->arch.irq_type)

Please use an explicit =3D=3D / !=3D here so we don't have to remember which
symbolic value corresponds to 0.

> +		return -EBUSY;
> +	if (kvmppc_xive_find_server(vcpu->kvm, cpu)) {
> +		pr_devel("Duplicate !\n");
> +		return -EEXIST;
> +	}
> +	if (cpu >=3D KVM_MAX_VCPUS) {
> +		pr_devel("Out of bounds !\n");
> +		return -EINVAL;
> +	}
> +	xc =3D kzalloc(sizeof(*xc), GFP_KERNEL);
> +	if (!xc)
> +		return -ENOMEM;
> +
> +	mutex_lock(&vcpu->kvm->lock);
> +	vcpu->arch.xive_vcpu =3D xc;
> +	xc->xive =3D xive;
> +	xc->vcpu =3D vcpu;
> +	xc->server_num =3D cpu;
> +	xc->vp_id =3D xive->vp_base + cpu;
> +	xc->valid =3D true;
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
> +	/* TODO: initialize queues ? */
> +
> +bail:
> +	vcpu->arch.irq_type =3D KVMPPC_IRQ_XIVE;
> +	mutex_unlock(&vcpu->kvm->lock);
> +	if (rc)
> +		kvmppc_xive_native_cleanup_vcpu(vcpu);
> +
> +	return rc;
> +}
> +
> +static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
> +				       struct kvm_device_attr *attr)
> +{
> +	return -ENXIO;
> +}
> +
> +static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
> +				       struct kvm_device_attr *attr)
> +{
> +	return -ENXIO;
> +}
> +
> +static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
> +				       struct kvm_device_attr *attr)
> +{
> +	return -ENXIO;
> +}
> +
> +static void kvmppc_xive_native_free(struct kvm_device *dev)
> +{
> +	struct kvmppc_xive *xive =3D dev->private;
> +	struct kvm *kvm =3D xive->kvm;
> +	int i;
> +
> +	debugfs_remove(xive->dentry);
> +
> +	pr_devel("Destroying xive native for partition\n");
> +
> +	if (kvm)
> +		kvm->arch.xive =3D NULL;
> +
> +	/* Mask and free interrupts */
> +	for (i =3D 0; i <=3D xive->max_sbid; i++) {
> +		if (xive->src_blocks[i])
> +			kvmppc_xive_free_sources(xive->src_blocks[i]);
> +		kfree(xive->src_blocks[i]);
> +		xive->src_blocks[i] =3D NULL;
> +	}
> +
> +	if (xive->vp_base !=3D XIVE_INVALID_VP)
> +		xive_native_free_vp_block(xive->vp_base);
> +
> +	kfree(xive);
> +	kfree(dev);
> +}
> +
> +static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
> +{
> +	struct kvmppc_xive *xive;
> +	struct kvm *kvm =3D dev->kvm;
> +	int ret =3D 0;
> +
> +	pr_devel("Creating xive native for partition\n");
> +
> +	if (kvm->arch.xive)
> +		return -EEXIST;
> +
> +	xive =3D kzalloc(sizeof(*xive), GFP_KERNEL);
> +	if (!xive)
> +		return -ENOMEM;
> +
> +	dev->private =3D xive;
> +	xive->dev =3D dev;
> +	xive->kvm =3D kvm;
> +	kvm->arch.xive =3D xive;
> +
> +	/* We use the default queue size set by the host */
> +	xive->q_order =3D xive_native_default_eq_shift();
> +	if (xive->q_order < PAGE_SHIFT)
> +		xive->q_page_order =3D 0;
> +	else
> +		xive->q_page_order =3D xive->q_order - PAGE_SHIFT;
> +
> +	/* Allocate a bunch of VPs */
> +	xive->vp_base =3D xive_native_alloc_vp_block(KVM_MAX_VCPUS);
> +	pr_devel("VP_Base=3D%x\n", xive->vp_base);
> +
> +	if (xive->vp_base =3D=3D XIVE_INVALID_VP)
> +		ret =3D -ENOMEM;
> +
> +	xive->single_escalation =3D xive_native_has_single_escalation();
> +
> +	if (ret)
> +		kfree(xive);
> +
> +	return ret;
> +}
> +
> +static int xive_native_debug_show(struct seq_file *m, void *private)
> +{
> +	struct kvmppc_xive *xive =3D m->private;
> +	struct kvm *kvm =3D xive->kvm;
> +	struct kvm_vcpu *vcpu;
> +	unsigned int i;
> +
> +	if (!kvm)
> +		return 0;
> +
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
> +	return 0;
> +}
> +
> +static int xive_native_debug_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, xive_native_debug_show, inode->i_private);
> +}
> +
> +static const struct file_operations xive_native_debug_fops =3D {
> +	.open =3D xive_native_debug_open,
> +	.read =3D seq_read,
> +	.llseek =3D seq_lseek,
> +	.release =3D single_release,
> +};
> +
> +static void xive_native_debugfs_init(struct kvmppc_xive *xive)
> +{
> +	char *name;
> +
> +	name =3D kasprintf(GFP_KERNEL, "kvm-xive-%p", xive);
> +	if (!name) {
> +		pr_err("%s: no memory for name\n", __func__);
> +		return;
> +	}
> +
> +	xive->dentry =3D debugfs_create_file(name, 0444, powerpc_debugfs_root,
> +					   xive, &xive_native_debug_fops);
> +
> +	pr_debug("%s: created %s\n", __func__, name);
> +	kfree(name);
> +}
> +
> +static void kvmppc_xive_native_init(struct kvm_device *dev)
> +{
> +	struct kvmppc_xive *xive =3D (struct kvmppc_xive *)dev->private;
> +
> +	/* Register some debug interfaces */
> +	xive_native_debugfs_init(xive);
> +}
> +
> +struct kvm_device_ops kvm_xive_native_ops =3D {
> +	.name =3D "kvm-xive-native",
> +	.create =3D kvmppc_xive_native_create,
> +	.init =3D kvmppc_xive_native_init,
> +	.destroy =3D kvmppc_xive_native_free,
> +	.set_attr =3D kvmppc_xive_native_set_attr,
> +	.get_attr =3D kvmppc_xive_native_get_attr,
> +	.has_attr =3D kvmppc_xive_native_has_attr,
> +};
> +
> +void kvmppc_xive_native_init_module(void)
> +{
> +	;
> +}
> +
> +void kvmppc_xive_native_exit_module(void)
> +{
> +	;
> +}
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index b90a7d154180..01d526e15e9d 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -566,6 +566,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>  	case KVM_CAP_PPC_ENABLE_HCALL:
>  #ifdef CONFIG_KVM_XICS
>  	case KVM_CAP_IRQ_XICS:
> +#endif
> +#ifdef CONFIG_KVM_XIVE
> +	case KVM_CAP_PPC_IRQ_XIVE:
>  #endif
>  	case KVM_CAP_PPC_GET_CPU_CHAR:
>  		r =3D 1;
> @@ -753,6 +756,9 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
>  		else
>  			kvmppc_xics_free_icp(vcpu);
>  		break;
> +	case KVMPPC_IRQ_XIVE:
> +		kvmppc_xive_native_cleanup_vcpu(vcpu);
> +		break;
>  	}
> =20
>  	kvmppc_core_vcpu_free(vcpu);
> @@ -1941,6 +1947,30 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vc=
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
> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> index 64f1135e7732..806cbe488410 100644
> --- a/arch/powerpc/kvm/Makefile
> +++ b/arch/powerpc/kvm/Makefile
> @@ -99,7 +99,7 @@ endif
>  kvm-book3s_64-objs-$(CONFIG_KVM_XICS) +=3D \
>  	book3s_xics.o
> =20
> -kvm-book3s_64-objs-$(CONFIG_KVM_XIVE) +=3D book3s_xive.o
> +kvm-book3s_64-objs-$(CONFIG_KVM_XIVE) +=3D book3s_xive.o book3s_xive_nat=
ive.o
>  kvm-book3s_64-objs-$(CONFIG_SPAPR_TCE_IOMMU) +=3D book3s_64_vio.o
> =20
>  kvm-book3s_64-module-objs :=3D \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxXvtUACgkQbDjKyiDZ
s5IZOg//bqzcEvmzM02AcVf7056V19uyrkK4xrUUVyOd0OASYzVAnxSqKo77Siwb
8i5qyofEBOD80LWE5zISaiUWIkRIdTvqxKGtzz9zbAfu9l5eBc9bK3A2eDcRpNpw
CjSRlVKqn342loUelj+DiVGRLl9DC0JlZi7Z1rDjQyTG9Rjn5mKXTvD9PyEcQ03k
8M162HyPhcFHBP1VV94l5Dyx7hQt0GGs2p81l5yCFUFu4Teq+mlI8m9/xGyNa1L/
sj6+cknBGP4b9H9sYdBP/TsUNJs7BnWKwrOSqlbcSVctQLy0EthmBZ3WY3t70OoG
gHOWHhFRAjmyluVIqVQVOLbBK/71LTqaK71U6fU6Laf/mTqLD3ls0j6GNLvrhFS6
5BtaXzFhtLqE2VagpgLmlMj+DwAI1l8pGQreP2p7StQP+nIAIddDT/bW1VdGxC2o
FzuwrmYWKnmDxPbBjc/hGG9M6534E75dSBOUgM9s9DJMbqW552YQhG69oxMqcYYs
6YL2mzt6Zrvv0nXqu9tmTNYuLUojhapIzSwxT3QYWIq1HQ9YlLw5bB/qU/7261e2
DwdFUE906H9kxPznb6pIeaR7VXbaDpnMd84VfBppfmHuv9di9kAFVw5mR5XzFezC
giydt7Uvci85F8Ka7t8++XTD9c34Y8jIoYumQI3h/tm8dwKweS0=
=0OMm
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
