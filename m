Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B01C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 01:55:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40CA32085A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 01:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="n2cGOC8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CA32085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44MzlZ02nNzDqMy
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 12:55:06 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Mzjr4lRpzDqHX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 12:53:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="n2cGOC8i"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44Mzjq4B6Hz9s7T; Mon, 18 Mar 2019 12:53:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552874015;
 bh=JfMuw/fM3sp9I7nVyAcO0vrAZ/RXW/OJe6rDMVC41mU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n2cGOC8ijUYDt9GUnz7I3vNWs1ugzLbm+G3X1QdlYkitF9bdAA3KZhnhUCWp/Hx3T
 omlvbkmdbqdXEAlnqAfLAronJn+6GoonEwJY3wxDzxdF1qslhqjPaWKbx+vlbAdvNA
 Jvnxs2Ml5HmhunA5Iu4IT472zmN/gPibO2UclpmE=
Date: Mon, 18 Mar 2019 12:38:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 04/17] KVM: PPC: Book3S HV: XIVE: add a control to
 initialize a source
Message-ID: <20190318013857.GE6874@umbus.fritz.box>
References: <20190315120609.25910-1-clg@kaod.org>
 <20190315120609.25910-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
Content-Disposition: inline
In-Reply-To: <20190315120609.25910-5-clg@kaod.org>
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


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 01:05:56PM +0100, C=E9dric Le Goater wrote:
> The XIVE KVM device maintains a list of interrupt sources for the VM
> which are allocated in the pool of generic interrupts (IPIs) of the
> main XIVE IC controller. These are used for the CPU IPIs as well as
> for virtual device interrupts. The IRQ number space is defined by
> QEMU.
>=20
> The XIVE device reuses the source structures of the XICS-on-XIVE
> device for the source blocks (2-level tree) and for the source
> interrupts. Under XIVE native, the source interrupt caches mostly
> configuration information and is less used than under the XICS-on-XIVE
> device in which hcalls are still necessary at run-time.
>=20
> When a source is initialized in KVM, an IPI interrupt source is simply
> allocated at the OPAL level and then MASKED. KVM only needs to know
> about its type: LSI or MSI.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>  Changes since v2:
>=20
>  - extra documentation in commit log
>  - fixed comments on XIVE IRQ number space
>  - removed usage of the __x_* macros
>  - fixed locking on source block
>=20
>  arch/powerpc/include/uapi/asm/kvm.h        |   5 +
>  arch/powerpc/kvm/book3s_xive.h             |  10 ++
>  arch/powerpc/kvm/book3s_xive.c             |   8 +-
>  arch/powerpc/kvm/book3s_xive_native.c      | 106 +++++++++++++++++++++
>  Documentation/virtual/kvm/devices/xive.txt |  15 +++
>  5 files changed, 140 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index b002c0c67787..11985148073f 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -677,5 +677,10 @@ struct kvm_ppc_cpu_char {
> =20
>  /* POWER9 XIVE Native Interrupt Controller */
>  #define KVM_DEV_XIVE_GRP_CTRL		1
> +#define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
> +
> +/* Layout of 64-bit XIVE source attribute values */
> +#define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
> +#define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
> =20
>  #endif /* __LINUX_KVM_POWERPC_H */
> diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xiv=
e.h
> index d366df69b9cb..1be921cb5dcb 100644
> --- a/arch/powerpc/kvm/book3s_xive.h
> +++ b/arch/powerpc/kvm/book3s_xive.h
> @@ -12,6 +12,13 @@
>  #ifdef CONFIG_KVM_XICS
>  #include "book3s_xics.h"
> =20
> +/*
> + * The XIVE Interrupt source numbers are within the range 0 to
> + * KVMPPC_XICS_NR_IRQS.
> + */
> +#define KVMPPC_XIVE_FIRST_IRQ	0
> +#define KVMPPC_XIVE_NR_IRQS	KVMPPC_XICS_NR_IRQS
> +
>  /*
>   * State for one guest irq source.
>   *
> @@ -258,6 +265,9 @@ extern int (*__xive_vm_h_eoi)(struct kvm_vcpu *vcpu, =
unsigned long xirr);
>   */
>  void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu);
>  int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *v=
cpu);
> +struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
> +	struct kvmppc_xive *xive, int irq);
> +void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
> =20
>  #endif /* CONFIG_KVM_XICS */
>  #endif /* _KVM_PPC_BOOK3S_XICS_H */
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xiv=
e.c
> index e7f1ada1c3de..6c9f9fd0855f 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -1480,8 +1480,8 @@ static int xive_get_source(struct kvmppc_xive *xive=
, long irq, u64 addr)
>  	return 0;
>  }
> =20
> -static struct kvmppc_xive_src_block *xive_create_src_block(struct kvmppc=
_xive *xive,
> -							   int irq)
> +struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
> +	struct kvmppc_xive *xive, int irq)
>  {
>  	struct kvm *kvm =3D xive->kvm;
>  	struct kvmppc_xive_src_block *sb;
> @@ -1560,7 +1560,7 @@ static int xive_set_source(struct kvmppc_xive *xive=
, long irq, u64 addr)
>  	sb =3D kvmppc_xive_find_source(xive, irq, &idx);
>  	if (!sb) {
>  		pr_devel("No source, creating source block...\n");
> -		sb =3D xive_create_src_block(xive, irq);
> +		sb =3D kvmppc_xive_create_src_block(xive, irq);
>  		if (!sb) {
>  			pr_devel("Failed to create block...\n");
>  			return -ENOMEM;
> @@ -1784,7 +1784,7 @@ static void kvmppc_xive_cleanup_irq(u32 hw_num, str=
uct xive_irq_data *xd)
>  	xive_cleanup_irq_data(xd);
>  }
> =20
> -static void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
> +void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
>  {
>  	int i;
> =20
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index a078f99bc156..99c04d5c5566 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -31,6 +31,17 @@
> =20
>  #include "book3s_xive.h"
> =20
> +static u8 xive_vm_esb_load(struct xive_irq_data *xd, u32 offset)
> +{
> +	u64 val;
> +
> +	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
> +		offset |=3D offset << 4;
> +
> +	val =3D in_be64(xd->eoi_mmio + offset);
> +	return (u8)val;
> +}
> +
>  static void kvmppc_xive_native_cleanup_queue(struct kvm_vcpu *vcpu, int =
prio)
>  {
>  	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> @@ -159,12 +170,94 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_devi=
ce *dev,
>  	return rc;
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
> +	int rc;
> +
> +	pr_devel("%s irq=3D0x%lx\n", __func__, irq);
> +
> +	if (irq < KVMPPC_XIVE_FIRST_IRQ || irq >=3D KVMPPC_XIVE_NR_IRQS)
> +		return -E2BIG;
> +
> +	sb =3D kvmppc_xive_find_source(xive, irq, &idx);
> +	if (!sb) {
> +		pr_debug("No source, creating source block...\n");
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
> +	arch_spin_lock(&sb->lock);
> +
> +	/*
> +	 * If the source doesn't already have an IPI, allocate
> +	 * one and get the corresponding data
> +	 */
> +	if (!state->ipi_number) {
> +		state->ipi_number =3D xive_native_alloc_irq();
> +		if (state->ipi_number =3D=3D 0) {
> +			pr_err("Failed to allocate IRQ !\n");
> +			rc =3D -ENXIO;
> +			goto unlock;
> +		}
> +		xive_native_populate_irq_data(state->ipi_number,
> +					      &state->ipi_data);
> +		pr_debug("%s allocated hw_irq=3D0x%x for irq=3D0x%lx\n", __func__,
> +			 state->ipi_number, irq);
> +	}
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
> +	rc =3D 0;
> +
> +unlock:
> +	arch_spin_unlock(&sb->lock);
> +
> +	return rc;
> +}
> +
>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>  				       struct kvm_device_attr *attr)
>  {
> +	struct kvmppc_xive *xive =3D dev->private;
> +
>  	switch (attr->group) {
>  	case KVM_DEV_XIVE_GRP_CTRL:
>  		break;
> +	case KVM_DEV_XIVE_GRP_SOURCE:
> +		return kvmppc_xive_native_set_source(xive, attr->attr,
> +						     attr->addr);
>  	}
>  	return -ENXIO;
>  }
> @@ -181,6 +274,11 @@ static int kvmppc_xive_native_has_attr(struct kvm_de=
vice *dev,
>  	switch (attr->group) {
>  	case KVM_DEV_XIVE_GRP_CTRL:
>  		break;
> +	case KVM_DEV_XIVE_GRP_SOURCE:
> +		if (attr->attr >=3D KVMPPC_XIVE_FIRST_IRQ &&
> +		    attr->attr < KVMPPC_XIVE_NR_IRQS)
> +			return 0;
> +		break;
>  	}
>  	return -ENXIO;
>  }
> @@ -189,6 +287,7 @@ static void kvmppc_xive_native_free(struct kvm_device=
 *dev)
>  {
>  	struct kvmppc_xive *xive =3D dev->private;
>  	struct kvm *kvm =3D xive->kvm;
> +	int i;
> =20
>  	debugfs_remove(xive->dentry);
> =20
> @@ -197,6 +296,13 @@ static void kvmppc_xive_native_free(struct kvm_devic=
e *dev)
>  	if (kvm)
>  		kvm->arch.xive =3D NULL;
> =20
> +	for (i =3D 0; i <=3D xive->max_sbid; i++) {
> +		if (xive->src_blocks[i])
> +			kvmppc_xive_free_sources(xive->src_blocks[i]);
> +		kfree(xive->src_blocks[i]);
> +		xive->src_blocks[i] =3D NULL;
> +	}
> +
>  	if (xive->vp_base !=3D XIVE_INVALID_VP)
>  		xive_native_free_vp_block(xive->vp_base);
> =20
> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/v=
irtual/kvm/devices/xive.txt
> index fdbd2ff92a88..cd8bfc37b72e 100644
> --- a/Documentation/virtual/kvm/devices/xive.txt
> +++ b/Documentation/virtual/kvm/devices/xive.txt
> @@ -17,3 +17,18 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
> =20
>    1. KVM_DEV_XIVE_GRP_CTRL
>    Provides global controls on the device
> +
> +  2. KVM_DEV_XIVE_GRP_SOURCE (write only)
> +  Initializes a new source in the XIVE device and mask it.
> +  Attributes:
> +    Interrupt source number  (64-bit)
> +  The kvm_device_attr.addr points to a __u64 value:
> +  bits:     | 63   ....  2 |   1   |   0
> +  values:   |    unused    | level | type
> +  - type:  0:MSI 1:LSI
> +  - level: assertion level in case of an LSI.
> +  Errors:
> +    -E2BIG:  Interrupt source number is out of range
> +    -ENOMEM: Could not create a new source block
> +    -EFAULT: Invalid user pointer for attr->addr.
> +    -ENXIO:  Could not allocate underlying HW interrupt

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyO9q8ACgkQbDjKyiDZ
s5IVZQ/+Pxk5UKq8UiAyLBzAQylCxwukK42zycr+rNPESWrirhR4zcETLGN9dpf9
3Fgz9NidOsUSK39KYtQADkVtjaHtJPqxBh0L8WV0MZBy0fN0DfJD2e4uVArhGwtW
fu6+JTpBkYim3u+Oc4XyTCa8w8A1ctTYyB7C/HDMGiqhS4vpyJDKZGIecauMdvvW
DcfUbGBD1iQRWPIRmxoLirR3BYFXuvM8M9M8S+cC1F7qUsxABgVSCZ5km/A3bVDA
anVbHfAvevToWXPghO2Ll1IhmikAjWnbZL/kcF0EjF6ayXoY4RcMoYITvyXfZDGD
BZ0QEynKdT1K0Cc5r4SWCDcJPY9Jz3fM/uVunZnMZgHoS4B2Ckj2GfQwE2Hu7Kja
3hQHTXYKJUALfrfLo2RotBOyegDtoDQinpHXs8BX2XvSHcSMayEju+Mwj7QwPxkv
ym8c0vyVjcWOjKMx0ej2JZrqo4UwUrPYBNg/FtetPB8ahGwPRYlZ/wvogh7LsZEm
w01fXDZgj4FNsqJcYYM201gMGpA5ni4jk4ohymybNM04AJkg0Ym9B5MK5v4f8X3r
+z1hL4/oGNt7szQWVEYwyH91xsx9BP0Rq+qJMFUgT+1B++8lJ6k3eyOggVT8sl3b
dksKhoLLjOb9v5NagRWYEnmHtsiS+yZ8/n0czcgORitSmoiQTIQ=
=vdYy
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
