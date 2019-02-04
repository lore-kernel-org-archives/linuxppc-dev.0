Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01779C282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:17:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672AA2083B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gbODeuh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672AA2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tHYz3V3bzDqGW
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 17:17:43 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tHSK020RzDqGX
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 17:12:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="gbODeuh4"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43tHSJ5TJGz9sDL; Mon,  4 Feb 2019 17:12:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549260768;
 bh=pEUuN+XN6gIfHFtMOBMxqw1ZaW4TviR1w1KMND5mdaA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gbODeuh4jhtWwYkyzoHKXLAKt+/1Jt+RX9M0Na4sBx2CCoVW6t54aSyHUn2djURcn
 iVDdtAqDZSYwMM9pIGOuA0fx+skCt+pcyfqgm1tElEn0Th6c2R7al5QC6pFzPAhDwO
 HWZT/WZbvqIA6Vgo89n+Jth99leteambZnHUD+20=
Date: Mon, 4 Feb 2019 15:57:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 09/19] KVM: PPC: Book3S HV: add a SET_SOURCE control to
 the XIVE native device
Message-ID: <20190204045751.GD1927@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-10-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Content-Disposition: inline
In-Reply-To: <20190107184331.8429-10-clg@kaod.org>
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


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:43:21PM +0100, C=E9dric Le Goater wrote:
> Interrupt sources are simply created at the OPAL level and then
> MASKED. KVM only needs to know about their type: LSI or MSI.

This commit message isn't very illuminating.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h           |  5 +
>  arch/powerpc/kvm/book3s_xive_native.c         | 98 +++++++++++++++++++
>  .../powerpc/kvm/book3s_xive_native_template.c | 27 +++++
>  3 files changed, 130 insertions(+)
>  create mode 100644 arch/powerpc/kvm/book3s_xive_native_template.c
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index 8b78b12aa118..6fc9660c5aec 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -680,5 +680,10 @@ struct kvm_ppc_cpu_char {
>  #define   KVM_DEV_XIVE_GET_ESB_FD	1
>  #define   KVM_DEV_XIVE_GET_TIMA_FD	2
>  #define   KVM_DEV_XIVE_VC_BASE		3
> +#define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes */
> +
> +/* Layout of 64-bit XIVE source attribute values */
> +#define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
> +#define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
> =20
>  #endif /* __LINUX_KVM_POWERPC_H */
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index 29a62914de55..2518640d4a58 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -31,6 +31,24 @@
> =20
>  #include "book3s_xive.h"
> =20
> +/*
> + * We still instantiate them here because we use some of the
> + * generated utility functions as well in this file.

And this comment is downright cryptic.

> + */
> +#define XIVE_RUNTIME_CHECKS
> +#define X_PFX xive_vm_
> +#define X_STATIC static
> +#define X_STAT_PFX stat_vm_
> +#define __x_tima		xive_tima
> +#define __x_eoi_page(xd)	((void __iomem *)((xd)->eoi_mmio))
> +#define __x_trig_page(xd)	((void __iomem *)((xd)->trig_mmio))
> +#define __x_writeb	__raw_writeb
> +#define __x_readw	__raw_readw
> +#define __x_readq	__raw_readq
> +#define __x_writeq	__raw_writeq
> +
> +#include "book3s_xive_native_template.c"
> +
>  static void xive_native_cleanup_queue(struct kvm_vcpu *vcpu, int prio)
>  {
>  	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> @@ -305,6 +323,78 @@ static int kvmppc_xive_native_get_tima_fd(struct kvm=
ppc_xive *xive, u64 addr)
>  	return put_user(ret, ubufp);
>  }
> =20
> +static int kvmppc_xive_native_set_source(struct kvmppc_xive *xive, long =
irq,
> +					 u64 addr)
> +{
> +	struct kvmppc_xive_src_block *sb;
> +	struct kvmppc_xive_irq_state *state;
> +	u64 __user *ubufp =3D (u64 __user *) addr;
> +	u64 val;
> +	u16 idx;
> +
> +	pr_devel("%s irq=3D0x%lx\n", __func__, irq);
> +
> +	if (irq < KVMPPC_XIVE_FIRST_IRQ || irq >=3D KVMPPC_XIVE_NR_IRQS)
> +		return -ENOENT;
> +
> +	sb =3D kvmppc_xive_find_source(xive, irq, &idx);
> +	if (!sb) {
> +		pr_debug("No source, creating source block...\n");

Doesn't this need to be protected by some lock?

> +		sb =3D kvmppc_xive_create_src_block(xive, irq);
> +		if (!sb) {
> +			pr_err("Failed to create block...\n");
> +			return -ENOMEM;
> +		}
> +	}
> +	state =3D &sb->irq_state[idx];
> +
> +	if (get_user(val, ubufp)) {
> +		pr_err("fault getting user info !\n");
> +		return -EFAULT;
> +	}
> +
> +	/*
> +	 * If the source doesn't already have an IPI, allocate
> +	 * one and get the corresponding data
> +	 */
> +	if (!state->ipi_number) {
> +		state->ipi_number =3D xive_native_alloc_irq();
> +		if (state->ipi_number =3D=3D 0) {
> +			pr_err("Failed to allocate IRQ !\n");
> +			return -ENOMEM;
> +		}

Am I right in thinking this is the point at which a specific guest irq
number gets bound to a specific host irq number?

> +		xive_native_populate_irq_data(state->ipi_number,
> +					      &state->ipi_data);
> +		pr_debug("%s allocated hw_irq=3D0x%x for irq=3D0x%lx\n", __func__,
> +			 state->ipi_number, irq);
> +	}
> +
> +	arch_spin_lock(&sb->lock);
> +
> +	/* Restore LSI state */
> +	if (val & KVM_XIVE_LEVEL_SENSITIVE) {
> +		state->lsi =3D true;
> +		if (val & KVM_XIVE_LEVEL_ASSERTED)
> +			state->asserted =3D true;
> +		pr_devel("  LSI ! Asserted=3D%d\n", state->asserted);
> +	}
> +
> +	/* Mask IRQ to start with */
> +	state->act_server =3D 0;
> +	state->act_priority =3D MASKED;
> +	xive_vm_esb_load(&state->ipi_data, XIVE_ESB_SET_PQ_01);
> +	xive_native_configure_irq(state->ipi_number, 0, MASKED, 0);
> +
> +	/* Increment the number of valid sources and mark this one valid */
> +	if (!state->valid)
> +		xive->src_count++;
> +	state->valid =3D true;
> +
> +	arch_spin_unlock(&sb->lock);
> +
> +	return 0;
> +}
> +
>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>  				       struct kvm_device_attr *attr)
>  {
> @@ -317,6 +407,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_dev=
ice *dev,
>  			return kvmppc_xive_native_set_vc_base(xive, attr->addr);
>  		}
>  		break;
> +	case KVM_DEV_XIVE_GRP_SOURCES:
> +		return kvmppc_xive_native_set_source(xive, attr->attr,
> +						     attr->addr);
>  	}
>  	return -ENXIO;
>  }
> @@ -353,6 +446,11 @@ static int kvmppc_xive_native_has_attr(struct kvm_de=
vice *dev,
>  			return 0;
>  		}
>  		break;
> +	case KVM_DEV_XIVE_GRP_SOURCES:
> +		if (attr->attr >=3D KVMPPC_XIVE_FIRST_IRQ &&
> +		    attr->attr < KVMPPC_XIVE_NR_IRQS)
> +			return 0;
> +		break;
>  	}
>  	return -ENXIO;
>  }
> diff --git a/arch/powerpc/kvm/book3s_xive_native_template.c b/arch/powerp=
c/kvm/book3s_xive_native_template.c
> new file mode 100644
> index 000000000000..e7260da4a596
> --- /dev/null
> +++ b/arch/powerpc/kvm/book3s_xive_native_template.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017-2019, IBM Corporation.
> + */
> +
> +/* File to be included by other .c files */
> +
> +#define XGLUE(a, b) a##b
> +#define GLUE(a, b) XGLUE(a, b)
> +
> +/*
> + * TODO: introduce a common template file with the XIVE native layer
> + * and the XICS-on-XIVE glue for the utility functions
> + */
> +static u8 GLUE(X_PFX, esb_load)(struct xive_irq_data *xd, u32 offset)
> +{
> +	u64 val;
> +
> +	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
> +		offset |=3D offset << 4;
> +
> +	val =3D __x_readq(__x_eoi_page(xd) + offset);
> +#ifdef __LITTLE_ENDIAN__
> +	val >>=3D 64-8;
> +#endif
> +	return (u8)val;
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxXxk8ACgkQbDjKyiDZ
s5IG/w//dScue0jdjPyTBo2lkHpnMvaJDEFxT14p9ZS9Z5DyB2EInigSEwyrTtIV
xd4TaoLDsMoDKhzkNoNCwEF1UOCuCqmFiq4WqvkuCzngvQpk29Z6RU1o775a2Gij
KBMjmxb5SA4Uzsyk4ld4X4X311yoDdajgV39tZNF+Ec3irjwFbZnfoFb33CjFH6S
FHczfg7aY0aq12mwUVvzhOeoaZGGHrcuekYTut37afsgkiO6ZfenoPg/JMgBz+uQ
YoMM2sDhhAZWoPf9gJaw/okBFdO+CXU/kxh1sloHz1AAx3mQZpxv9XMVOWIPVVeJ
HdQANUfBIaFNdBjIvWglRcG1CLgcCaE/e/r+g2abFZQH8FDlUxpfvopIb6yVWMW8
/dLkRaSuunoOGl+G8/7+HVvjojRvTXEuBdAt9hBvg7LMxKC+AgzAetGbBIUXs7Xv
oG1TFvJVn8I3GlQpyY+EZtXn42muuRqtOb63i5P/AF7wMc5UURrwKGfu3U3t/l+t
NZaHwY6ffck0tZ7JyMTvAN27dcuX5xJ6WNgRlEu/nA2dM8ub62N/0DkMJHzaBayS
b9sjaLN/+6qVh9jmww2Tv9t6sUwXi3fvh3EZog/MOnOQBKAUz7C+6pQV/bRHQz/t
MH5nGzVLjtBGe5AMIHK3uFSHYcEvgSagGt2qyZtRXKcJcQ/6UCE=
=FitJ
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--
