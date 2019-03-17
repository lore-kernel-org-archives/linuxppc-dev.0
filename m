Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE96C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 00:01:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E7B2086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 00:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="F4JyPwGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E7B2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44MxDP1K3HzDqL7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 11:01:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44MxBJ6jXdzDqC9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 10:59:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="F4JyPwGw"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44MxBJ4st6z9s7T; Mon, 18 Mar 2019 10:59:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552867176;
 bh=fuAuwVMQK6c/lmUDqcHX/dR4SPOpygT8+afPxeMQa9U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F4JyPwGw/nd/BofYoidicRazTZAXr/KvLBuiaBsJQxHkKugGxeihSchp/Jgpd154G
 fbj8bpCO+jFgMOzVxqUHIZmaWxdBhYo8xCF1dqsH2PZ+HftODj88TpchXraWD7XeUQ
 WyAyrenx65F2tlfVYDR1FCbKj7RYYza6FfTQp3jI=
Date: Mon, 18 Mar 2019 10:48:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 02/17] KVM: PPC: Book3S HV: add a new KVM device for
 the XIVE native exploitation mode
Message-ID: <20190317234827.GC6874@umbus.fritz.box>
References: <20190315120609.25910-1-clg@kaod.org>
 <20190315120609.25910-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
In-Reply-To: <20190315120609.25910-3-clg@kaod.org>
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


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 01:05:54PM +0100, C=E9dric Le Goater wrote:
> This is the basic framework for the new KVM device supporting the XIVE
> native exploitation mode. The user interface exposes a new KVM device
> to be created by QEMU, only available when running on a L0 hypervisor
> only. Support for nested guests is not available yet.
>=20
> The XIVE device reuses the device structure of the XICS-on-XIVE device
> as they have a lot in common. That could possibly change in the future
> if the need arise.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>  Changes since v2:
>=20
>  - removed ->q_order setting. Only useful in the XICS-on-XIVE KVM
>    device which allocates the EQs on behalf of the guest.
>  - returned -ENXIO when VP base is invalid
>=20
>  arch/powerpc/include/asm/kvm_host.h        |   1 +
>  arch/powerpc/include/asm/kvm_ppc.h         |   8 +
>  arch/powerpc/include/uapi/asm/kvm.h        |   3 +
>  include/uapi/linux/kvm.h                   |   2 +
>  arch/powerpc/kvm/book3s.c                  |   7 +-
>  arch/powerpc/kvm/book3s_xive_native.c      | 184 +++++++++++++++++++++
>  Documentation/virtual/kvm/devices/xive.txt |  19 +++
>  arch/powerpc/kvm/Makefile                  |   2 +-
>  8 files changed, 224 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/kvm/book3s_xive_native.c
>  create mode 100644 Documentation/virtual/kvm/devices/xive.txt
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index 091430339db1..9f75a75a07f2 100644
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
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index b3bf4f61b30c..4b72ddde7dc1 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -593,6 +593,10 @@ extern int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu=
, u64 icpval);
>  extern int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 i=
rq,
>  			       int level, bool line_status);
>  extern void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu);
> +
> +extern void kvmppc_xive_native_init_module(void);
> +extern void kvmppc_xive_native_exit_module(void);
> +
>  #else
>  static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 ser=
ver,
>  				       u32 priority) { return -1; }
> @@ -616,6 +620,10 @@ static inline int kvmppc_xive_set_icp(struct kvm_vcp=
u *vcpu, u64 icpval) { retur
>  static inline int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id=
, u32 irq,
>  				      int level, bool line_status) { return -ENODEV; }
>  static inline void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu) { }
> +
> +static inline void kvmppc_xive_native_init_module(void) { }
> +static inline void kvmppc_xive_native_exit_module(void) { }
> +
>  #endif /* CONFIG_KVM_XIVE */
> =20
>  #ifdef CONFIG_PPC_POWERNV
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index 8c876c166ef2..b002c0c67787 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -675,4 +675,7 @@ struct kvm_ppc_cpu_char {
>  #define  KVM_XICS_PRESENTED		(1ULL << 43)
>  #define  KVM_XICS_QUEUED		(1ULL << 44)
> =20
> +/* POWER9 XIVE Native Interrupt Controller */
> +#define KVM_DEV_XIVE_GRP_CTRL		1
> +
>  #endif /* __LINUX_KVM_POWERPC_H */
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6d4ea4b6c922..e6368163d3a0 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1211,6 +1211,8 @@ enum kvm_device_type {
>  #define KVM_DEV_TYPE_ARM_VGIC_V3	KVM_DEV_TYPE_ARM_VGIC_V3
>  	KVM_DEV_TYPE_ARM_VGIC_ITS,
>  #define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
> +	KVM_DEV_TYPE_XIVE,
> +#define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
>  	KVM_DEV_TYPE_MAX,
>  };
> =20
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 601c094f15ab..96d43f091255 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -1040,6 +1040,9 @@ static int kvmppc_book3s_init(void)
>  	if (xics_on_xive()) {
>  		kvmppc_xive_init_module();
>  		kvm_register_device_ops(&kvm_xive_ops, KVM_DEV_TYPE_XICS);
> +		kvmppc_xive_native_init_module();
> +		kvm_register_device_ops(&kvm_xive_native_ops,
> +					KVM_DEV_TYPE_XIVE);
>  	} else
>  #endif
>  		kvm_register_device_ops(&kvm_xics_ops, KVM_DEV_TYPE_XICS);
> @@ -1050,8 +1053,10 @@ static int kvmppc_book3s_init(void)
>  static void kvmppc_book3s_exit(void)
>  {
>  #ifdef CONFIG_KVM_XICS
> -	if (xics_on_xive())
> +	if (xics_on_xive()) {
>  		kvmppc_xive_exit_module();
> +		kvmppc_xive_native_exit_module();
> +	}
>  #endif
>  #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
>  	kvmppc_book3s_exit_pr();
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> new file mode 100644
> index 000000000000..76d45bcc7060
> --- /dev/null
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -0,0 +1,184 @@
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
> +static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
> +				       struct kvm_device_attr *attr)
> +{
> +	switch (attr->group) {
> +	case KVM_DEV_XIVE_GRP_CTRL:
> +		break;
> +	}
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
> +	switch (attr->group) {
> +	case KVM_DEV_XIVE_GRP_CTRL:
> +		break;
> +	}
> +	return -ENXIO;
> +}
> +
> +static void kvmppc_xive_native_free(struct kvm_device *dev)
> +{
> +	struct kvmppc_xive *xive =3D dev->private;
> +	struct kvm *kvm =3D xive->kvm;
> +
> +	debugfs_remove(xive->dentry);
> +
> +	pr_devel("Destroying xive native device\n");
> +
> +	if (kvm)
> +		kvm->arch.xive =3D NULL;
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
> +	pr_devel("Creating xive native device\n");
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
> +	/*
> +	 * Allocate a bunch of VPs. KVM_MAX_VCPUS is a large value for
> +	 * a default. Getting the max number of CPUs the VM was
> +	 * configured with would improve our usage of the XIVE VP space.
> +	 */
> +	xive->vp_base =3D xive_native_alloc_vp_block(KVM_MAX_VCPUS);
> +	pr_devel("VP_Base=3D%x\n", xive->vp_base);
> +
> +	if (xive->vp_base =3D=3D XIVE_INVALID_VP)
> +		ret =3D -ENXIO;
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
> +
> +	if (!kvm)
> +		return 0;
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
> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/v=
irtual/kvm/devices/xive.txt
> new file mode 100644
> index 000000000000..fdbd2ff92a88
> --- /dev/null
> +++ b/Documentation/virtual/kvm/devices/xive.txt
> @@ -0,0 +1,19 @@
> +POWER9 eXternal Interrupt Virtualization Engine (XIVE Gen1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Device types supported:
> +  KVM_DEV_TYPE_XIVE     POWER9 XIVE Interrupt Controller generation 1
> +
> +This device acts as a VM interrupt controller. It provides the KVM
> +interface to configure the interrupt sources of a VM in the underlying
> +POWER9 XIVE interrupt controller.
> +
> +Only one XIVE instance may be instantiated. A guest XIVE device
> +requires a POWER9 host and the guest OS should have support for the
> +XIVE native exploitation interrupt mode. If not, it should run using
> +the legacy interrupt mode, referred as XICS (POWER7/8).
> +
> +* Groups:
> +
> +  1. KVM_DEV_XIVE_GRP_CTRL
> +  Provides global controls on the device
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

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyO3MgACgkQbDjKyiDZ
s5JgJhAAy9OS/TY9vYmQYVqr8RkSNRe2ALmR3mJu+gcIVz6Y3E3fdg1o2Ztp9btq
BbC4XeYupuif6CmLFCQi1+hAABxtGxTMrs9U9IPYOufmKQHasuE1S341qWRVkjSC
tGv07SRgyOtGET0LFefvbKarvb4rrDK/0n4iToq59gn8euue46Nttx2iRNinIiB/
jn9BDeMGM6rhRyMqlhPnKSXrwX28egKBJS3MMpQrbLY/iGzMNofAnrC1PzLu7vZB
T4wR7yf/jDMRSypv78gwL3W/f8BPpspGIdcV2J1lE3fycKK9yuqDjrESI3EopUgr
llzXPeDfwqR97efeLkQaVpnrlatFvCYQE/RDeFd+ZHDMvVTrxeV6Wv4NeZBXlRVw
YZ4iki+VdHhPZn1DJeBlsmMbXM7Bw2yZ19QYtIxZZE0JKyn3cBuPcZAt3P1lEkmF
IhO/CU8uAdJBzr72Dvtitw+7dGIC2Z4WpAovYTXjw8LxNrLU09H3czsRNDhkGDSH
BfIqXJwMdZCynRQWEgg/c9vtNAcX0wPqB9xwjM4I4BDwY7RIqHEvW86ygP7mN98t
q87NrVo4stMzE/o6oQFQIjrjL9S1QDYzChA/6STvXaKFN1fx6/KE8pD8XfIhia0x
vLqqaen44UMBQzmDRDAlxMPi2uT3pklVTfG+3zhYybnHP01+jmM=
=F6a+
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
